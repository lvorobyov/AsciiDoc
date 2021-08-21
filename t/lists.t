#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 5;

use_ok( 'AsciiDoc::ToLaTeX' );

my $ad = <<AD;
My list:
. item1
.. item2
... item3

AD

my $expect = <<TEX;
My list:
\\begin{enumerate}
\\item item1
\\iitem item2
\\iiitem item3
\\end{enumerate}

TEX

ok(process_ad($ad) eq $expect, 'enumerate');

$ad = <<AD;
- item1
- item2
- item3

AD

$expect = <<TEX;
\\begin{itemize}
\\item item1
\\item item2
\\item item3
\\end{itemize}

TEX

ok(process_ad($ad) eq $expect, 'itemize');

$ad = <<AD;
5. item
6. item

AD

$expect = <<TEX;
\\begin{enumerate}[start=5]
\\item item
\\item item
\\end{enumerate}

TEX

ok(process_ad($ad) eq $expect, 'enum_with_start');

$ad = <<AD;
[[AD]] AsciiDoc:: item
[[TEX]] LaTeX:: item

AD

$expect = <<TEX;
\\begin{description}
\\item [AsciiDoc\\label{AD}] item
\\item [LaTeX\\label{TEX}] item
\\end{description}

TEX

ok(process_ad($ad) eq $expect, 'description');

done_testing();

