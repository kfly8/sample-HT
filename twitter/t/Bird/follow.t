use strict;
use warnings;
use utf8;
use Test::More;
use Test::Exception;

use Bird;

subtest 'follow & followers' => sub {

    my $bird1 = Bird->new(name => 'kfly8');
    my $bird2 = Bird->new(name => 'huili');
    my $bird3 = Bird->new(name => 'likk');

    lives_ok {
        $bird1->follow($bird2);
        $bird1->follow($bird3);
    };

    {
        my $followers = $bird1->followers;
        is scalar @$followers, 2;
        isa_ok $_, 'Bird' for @$followers;

        is $followers->[0]->name, 'huili';
        is $followers->[1]->name, 'likk';
    }

    lives_ok {
        $bird2->follow($bird1);
    };
    
    {
        my $followers = $bird2->followers;
        is scalar @$followers, 1;
        isa_ok $_, 'Bird' for @$followers;
        is $followers->[0]->name, 'kfly8';
    }
};

done_testing;
