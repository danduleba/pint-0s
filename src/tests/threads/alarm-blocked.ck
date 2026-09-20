# -*- perl -*-
use strict;
use warnings;
use tests::tests;
check_expected ([<<'EOF']);
(alarm-blocked) begin
(alarm-blocked) PASS
(alarm-blocked) end
EOF
pass;
