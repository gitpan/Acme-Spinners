package Acme::Spinners::80Shooter;

use strict;
use warnings;

my @frames = generate();

sub new {
	bless {}, $_[0];	
}

sub frames {
	return @frames;	
}

sub speed {
	return 0.02;	
}


sub generate {
	#	"12345678901234567890123456789012345678901234567890123456789012345678901234567890"
	my @slides;
	for (0..74) {
		my $buffer = "[-";
		$buffer .= " " x $_;
		$buffer .= ">";
		$buffer .= " " x (74 - $_);
		$buffer .= "-]";
		push @slides, $buffer;
	}
	for (local $_ = 74; $_ >= 0; $_--) { # why doesn't .. make backwards lists?
		my $buffer = "[-";
		$buffer .= " " x $_;
		$buffer .= "<";
		$buffer .= " " x (74 - $_);
		$buffer .= "-]";
		push @slides, $buffer;
	}
	return @slides;
}

1;