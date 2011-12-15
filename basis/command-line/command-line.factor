! Copyright (C) 2003, 2009 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors alien.strings assocs continuations fry init
io.encodings.utf8 io.files io.pathnames kernel kernel.private
namespaces parser parser.notes sequences source-files
source-files.errors splitting system vocabs.loader ;
IN: command-line

SYMBOL: user-init-errors
SYMBOL: +user-init-error+

TUPLE: user-init-error error file line# asset ;

: <user-init-error> ( error -- error' )
    [ ] [ error-file ] [ error-line ] tri
    f user-init-error boa ; inline
M: user-init-error error-file file>> ;
M: user-init-error error-line line#>> ;
M: user-init-error error-type drop +user-init-error+ ;

SYMBOL: script
SYMBOL: command-line
SYMBOL: flags

<PRIVATE

: set-flag ( value name -- ) flags get-global set-at ; inline

PRIVATE>

: get-flag ( name -- value ) flags get-global at ; inline

: (command-line) ( -- args )
    OBJ-ARGS special-object sift [ alien>native-string ] map ;

: rc-path ( name -- path )
    home prepend-path ;

: try-user-init ( file -- )
    "user-init" get-flag swap '[
        _ [ ?run-file ] [
            <user-init-error>
            swap user-init-errors get set-at
            notify-error-observers
        ] recover
    ] when ;

: run-bootstrap-init ( -- )
    ".factor-boot-rc" rc-path try-user-init ;

: run-user-init ( -- )
    ".factor-rc" rc-path try-user-init ;

: load-vocab-roots ( -- )
    "user-init" get-flag [
        ".factor-roots" rc-path dup exists? [
            utf8 file-lines harvest [ add-vocab-root ] each
        ] [ drop ] if
    ] when ;

: var-param ( name value -- ) swap set-flag ;

: bool-param ( name -- ) "no-" ?head not var-param ;

: param ( param -- )
    "=" split1 [ var-param ] [ bool-param ] if* ;

: run-script ( file -- )
    t parser-quiet? [
        [ run-file ]
        [ source-file main>> [ execute( -- ) ] when* ] bi
    ] with-variable ;

: set-resource-path ( -- )
    "resource-path" get-flag [ "resource-path" set-global ] when* ;

: parse-command-line ( args -- )
    [ command-line off script off ] [
        unclip "-" ?head
        [ param parse-command-line ]
        [ script set command-line set ] if
        set-resource-path
    ] if-empty ;

SYMBOL: main-vocab-hook

: main-vocab ( -- vocab )
    embedded? [
        "alien.remote-control"
    ] [
        main-vocab-hook get [ call( -- vocab ) ] [ "listener" ] if*
    ] if ;

: default-cli-args ( -- )
    f "e" set-flag
    t "user-init" set-flag
    main-vocab "run" set-flag ;

[
    H{ } user-init-errors set-global
    H{ } flags set-global
    default-cli-args
] "command-line" add-startup-hook

{ "debugger" "command-line" } "command-line.debugger" require-when
