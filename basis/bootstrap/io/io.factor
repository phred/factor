USING: system vocabs vocabs.loader kernel combinators
namespaces sequences io.backend accessors command-line ;
IN: bootstrap.io

"bootstrap.compiler" require
"bootstrap.threads" require

"io.backend." {
    { [ "io-backend" get-flag ] [ "io-backend" get-flag ] }
    { [ os unix? ] [ "unix." os name>> append ] }
    { [ os windows? ] [ "windows" ] }
} cond append require
