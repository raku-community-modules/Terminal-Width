use lib 'lib';
use Test;
use-ok 'Terminal::Width';

is terminal-width, Int, 'terminal-width returned a number';

done-testing;
