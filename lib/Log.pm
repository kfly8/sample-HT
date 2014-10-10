package Log;
use strict;
use warnings;
use utf8;

use DateTime;

sub new {
    my ($class, %args) = @_;
    
    bless \%args, $class;
}

our $AUTOLOAD;
sub AUTOLOAD {
    if ($AUTOLOAD =~ m/::(\w+)$/) {
        shift->{$1}
    }
    else {
        die sprintf('not found method: %s', $AUTOLOAD)
    }
}

sub _req {
    my $self = shift;
    $self->{_req} //= do {
        [split ' ', $self->req]
    }
}

sub method   { shift->_req->[0] }
sub path     { shift->_req->[1] }
sub protocol { shift->_req->[2] }

sub scheme {
    my $self = shift;
    $self->{scheme} //= do {
        lc $1 if $self->protocol =~ m{^([^/]+)}
    }
}

sub uri {
    my $self = shift;
    sprintf('%s://%s%s', $self->scheme, $self->host, $self->path)
}

sub time { 
    my $self = shift;
    $self->{time} //= do {
        my $dt = DateTime->from_epoch(epoch => $self->epoch);
        $dt->strftime('%Y-%m-%dT%H:%M:%S');
    }
}

1;
