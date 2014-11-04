package LogCounter;
use strict;
use warnings;
use utf8;

sub new {
    my ($class, $logs) = @_;
    bless +{
        logs => $logs
    } => $class
}

sub logs { shift->{logs} }

sub count_error {
    my $self = shift;

    my @error_logs = grep {
        $_->status >= 500 && $_->status < 600
    } @{$self->{logs}};

    scalar @error_logs
}

sub group_by_user {
    my $self = shift;

    my %ret;
    for my $log (@{$self->logs}) {
        my $key = $log->user // 'guest';
        push @{$ret{$key}} => $log;
    }
    \%ret;
}

1;
