use lib 'lib';
use Test;
use Terminal::Width;

say terminal-width();
ok terminal-width() ~~ Int, 'terminal-width returned a number';

done-testing;
