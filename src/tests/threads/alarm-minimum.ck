# -*- perl -*-
use strict;
use warnings;
use tests::tests;
our $test;
my @output = read_text_file ("$test.output");
common_checks ("run", @output);
grep (/^\(alarm-minimum\) PASS$/, @output)
  or fail ("A espera minima nao foi respeitada.");
pass;
