#!/bin/bash

output="output.txt"
echo "Text from insert_to_output.txt" > insert_to_output.txt

cat << 'EOF' > $output
line1
line2
line3
vim editor
EOF

vim -E -s $output << 'EOF'
"1 - insert 
0i
insert text
.
"2 - append
$ a
append text
.
"3 - delete line 2
2d

"4 - write output of running a command with vim
:r insert_to_output.txt

"5 - write and quit
wq
EOF


