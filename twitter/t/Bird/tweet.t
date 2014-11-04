use strict;
use warnings;
use utf8;
use Test::More;
use Test::Exception;

use Bird;

subtest 'tweet & timeline' => sub {

    my $bird = Bird->new(name => 'kfly8');
    isa_ok $bird, 'Bird';
    
    ok $bird->can('tweet');

    lives_ok {
        $bird->tweet('hello1');
        $bird->tweet('hello2');
        $bird->tweet('hello3');
    };

    my $timeline = $bird->timeline;
    is scalar @$timeline, 3;
    isa_ok $_, 'Tweet' for @$timeline;

    is $timeline->[0]->message, 'hello3';
    is $timeline->[1]->message, 'hello2';
    is $timeline->[2]->message, 'hello1';

    is $timeline->[0]->name, 'kfly8';
    is $timeline->[1]->name, 'kfly8';
    is $timeline->[2]->name, 'kfly8';

};

done_testing;
