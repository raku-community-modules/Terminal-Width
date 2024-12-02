sub terminal-width (Int :$default = 80) is export {
    my Int $width = $default;
    if $*SPEC ~~ IO::Spec::Win32 {
        # Look for CON: device; the columns are on the second info line.
        # Can't use actual words due to different languages available
        my $out = try run('mode', :out).out.slurp-rest;
        if $out {
            $out ~~ /
                'CON:' \s*\n
                '----------------------' \s*\n
                <-[:]>+ ':' \N+\n # Lines
                <-[:]>+ ':' \s* $<columns>=\d+
            /;
            $width = $<columns>.Int // $width;
        }
    } else {
        fail 'Cannot use «tput» to determine terminal widh' unless
        "/usr/bin/tput".IO.e;
        $width = try {
            run('tput', 'cols', :out).out.slurp-rest.trim.Int
        } // $width;
    }

    fail 'Could not determine terminal width' unless $width;
    $width;
}

=begin pod

=head1 NAME

Terminal::Width - Get the current width of the terminal

=head1 SYNOPSIS

=begin code :lang<raku>

use Terminal::Width;

# Default to 80 characters if we fail to get actual width:
my $width = terminal-width;

# Default to 100 characters if we fail to get actual width:
$width = terminal-width :default<100>;

# return a Failure if we fail to get actual width:
$width = terminal-width :default<0>;

=end code

=head1 DESCRIPTION

This module tries to figure out the current width of the terminal
the program is running in. The module is known to work on Windows
10 command prompt and Debian flavours of Linux as well as MacOS.

=head1 EXPORTED SUBROUTINES

=head2 terminal-width

=begin code :lang<raku>

terminal-width (Int :$default = 80 --> Int|Failure)

=end code

Returns and C<Int> representing the character width of the terminal.
Takes one optional named argument C<default> that specifies the width
to use if we fail to determine the actual width (defaults to C<80>).
If C<:default> is set to C<0> the subroutine will return a C<Failure>
if it can't determine the width.

=head1 ⚠ SECURITY NOTE

On Windows, this module attempts to run program C<mode> and on all
other systems it attempts to run C<tput>. A clever attacker can
manipulate what the actual executed program is, resulting in it
being executed with the privileges of your script's user.

=head1 AUTHOR

Zoffix Znet

=head1 COPYRIGHT AND LICENSE

Copyright 2016 - 2017 Zoffix Znet

Copyright 2020 - 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
