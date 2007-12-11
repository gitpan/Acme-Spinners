package Acme::Spinners::Loading;

use strict;
use warnings;

sub new {
	my ($class, $title) = @_;
	$title ||= "Loading";
	my @frames;
	push @frames, "$title...", "$title....", "$title.....", "$title     ", "$title.", "$title..";
	bless {frames => \@frames}, $class;
}

sub speed {
	return 0.5;	
}

sub frames {
	my $self = shift;
	return @{$self->{frames}};
}

1;