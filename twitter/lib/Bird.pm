package Bird;

use strict;
use warnings;
use utf8;

use Tweet;

use Class::Accessor::Lite (
    new => 1,
    ro  => [qw/name/],
);

my @TIMELINE;
my %FOLLOWERS;

sub tweet {
    my ($self, $message) = @_;
    
    unshift @TIMELINE => Tweet->new(
        name    => $self->name,
        message => $message,
    );
}

sub timeline {
    my ($self) = @_;
    $self->{__timeline} //= [ grep { $self->name eq $_->name } @TIMELINE ];
}

sub follow {
    my ($self, $bird) = @_;
    push @{$FOLLOWERS{$self->name}} => $bird;
}

sub followers {
    my ($self) = @_;
    $FOLLOWERS{$self->name};
}

sub friends_timeline {
    my ($self) = @_;

    $self->{__friend_timeline} //= do {
        my %follow_fg = map { $_->name => 1 } @{$self->followers};
        [ grep { $follow_fg{$_->name} } @TIMELINE ];
    };
}

1;
