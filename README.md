[![Actions Status](https://github.com/raku-community-modules/Terminal-Width/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/Terminal-Width/actions) [![Actions Status](https://github.com/raku-community-modules/Terminal-Width/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/Terminal-Width/actions) [![Actions Status](https://github.com/raku-community-modules/Terminal-Width/actions/workflows/windows.yml/badge.svg)](https://github.com/raku-community-modules/Terminal-Width/actions)

NAME
====

Terminal::Width - Get the current width of the terminal

SYNOPSIS
========

```raku
use Terminal::Width;

# Default to 80 characters if we fail to get actual width:
my $width = terminal-width;

# Default to 100 characters if we fail to get actual width:
$width = terminal-width :default<100>;

# return a Failure if we fail to get actual width:
$width = terminal-width :default<0>;
```

DESCRIPTION
===========

This module tries to figure out the current width of the terminal the program is running in. The module is known to work on Windows 10 command prompt and Debian flavours of Linux as well as MacOS.

EXPORTED SUBROUTINES
====================

terminal-width
--------------

```raku
terminal-width (Int :$default = 80 --> Int|Failure)
```

Returns and `Int` representing the character width of the terminal. Takes one optional named argument `default` that specifies the width to use if we fail to determine the actual width (defaults to `80`). If `:default` is set to `0` the subroutine will return a `Failure` if it can't determine the width.

⚠ SECURITY NOTE
===============

On Windows, this module attempts to run program `mode` and on all other systems it attempts to run `tput`. A clever attacker can manipulate what the actual executed program is, resulting in it being executed with the privileges of your script's user.

AUTHOR
======

Zoffix Znet

COPYRIGHT AND LICENSE
=====================

Copyright 2016 - 2017 Zoffix Znet

Copyright 2020 - 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

