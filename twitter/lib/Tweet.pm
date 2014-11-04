package Tweet;

use strict;
use warnings;
use utf8;

use Class::Accessor::Lite (
    new => 1,
    ro  => [qw/name message/],
);


1;
