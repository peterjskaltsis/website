#!/bin/sh

# Files to be compiled/output.
elm="src/Main.elm"
js="public/main.js"
min="public/main.min.js"

# Formatting.
color_green="\x1b[32m"
color_cyan="\x1b[36m"
color_reset="\x1b[0m"
module=">$color_green elm-build-tool$color_reset -"

# Compile elm code.
echo $module "compiling $color_cyan$elm$color_reset[0m to $color_cyan$js$color_reset ..."
elm make $elm --optimize --output=$js

# Optimise elm code.
echo $module "optimising $color_cyan$js$color_reset to $color_cyan$min$color_reset ..."
uglifyjs $js --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=$min

# Success!
echo $module "compression stats:"
echo "\tInitial size: $(cat $js | wc -c) bytes  ($js)"
echo "\tMinified size:$(cat $min | wc -c) bytes  ($min)"
echo "\tGzipped size: $(cat $min | gzip -c | wc -c) bytes"

echo $module "elm program $color_cyan$elm$color_reset successfully compiled."