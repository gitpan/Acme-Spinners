package Acme::Spinners::Blades;

sub new {
	bless {}, $_[0];	
}

sub frames{	
return (
	"| |",
	"\\ /",
	"- -",
	"/ \\"),
}

sub speed {
	return 0.1;	
}

1;