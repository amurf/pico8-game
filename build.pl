#!/usr/bin/env perl

use v5.16;
use Template;


my $tt = Template->new();

my $code;

for my $file (<src/lua/*.lua>) {
    local $/ = undef;
    open my $fh, '<', $file;

    $code .= "\n";
    $code .= <$fh>;
}
my $vars = {
    code => $code,
};

$tt->process('src/thisisnotlinear.p8', $vars, 'thisisnotlinear.p8');
