package Parser;
use strict;
use warnings;
use utf8;

use Log;

sub new {
    my ($class, %args) = @_;

    bless \%args => $class
}

sub filename { shift->{filename} }

sub parse {
    my $self = shift;

    warn $self->filename;
    open my $fh, '<', $self->filename or die $!;

    my @lines;
    while (my $line = <$fh>) {
        my %args = map {
            if (m/^([^:]+?):(.+)$/) {
                ($2 eq '-') ? () : ($1 => $2)
            }
        } split "\t", $line;

        push @lines => Log->new(%args);
    }
    close $fh;

    \@lines
}

1;
