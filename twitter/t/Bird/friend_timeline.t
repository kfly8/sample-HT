use strict;
use warnings;
use utf8;
use Test::More;
use Test::Exception;

use Bird;

subtest 'friends_timeline' => sub {

    my $bird1 = Bird->new(name => 'kfly8');
    my $bird2 = Bird->new(name => 'huili');
    my $bird3 = Bird->new(name => 'likk');

    lives_ok {
        $bird1->follow($bird2);
        $bird1->follow($bird3);
    };

    lives_ok {
        $bird2->tweet('hello1');
        $bird2->tweet('hello2');
        $bird2->tweet('hello3');

        $bird3->tweet('good1');
        $bird3->tweet('good2');
        $bird3->tweet('good3');

        $bird2->tweet('hello4');
    };

    my $timeline = $bird1->friends_timeline;

    is scalar @$timeline, 7;
    isa_ok $_, 'Tweet' for @$timeline;

    is $timeline->[0]->message, 'hello4';
    is $timeline->[1]->message, 'good3';
    is $timeline->[2]->message, 'good2';
    is $timeline->[3]->message, 'good1';
    is $timeline->[4]->message, 'hello3';
    is $timeline->[5]->message, 'hello2';
    is $timeline->[6]->message, 'hello1';

    is $timeline->[0]->name, 'huili';
    is $timeline->[1]->name, 'likk';
    is $timeline->[2]->name, 'likk';
    is $timeline->[3]->name, 'likk';
    is $timeline->[4]->name, 'huili';
    is $timeline->[5]->name, 'huili';
    is $timeline->[6]->name, 'huili';

};

done_testing;
