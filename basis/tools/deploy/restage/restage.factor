IN: tools.deploy.restage
USING: bootstrap.stage2 command-line namespaces memory ;

: restage ( -- )
    get-component-flags
    load-components
    "output-image" get-flag save-image-and-exit ;

MAIN: restage
