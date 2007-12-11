package Acme::Spinners::Dynamic;

my @frames = (
"/ / /",
"- - -",
"\\ \\ \\",
"| | |",
);
my $counter = 0;

my $speed = 0.2;
my $flag = 0;

sub new {
	bless {}, $_[0];	
}

sub dynamic {
	return 1;	
}

sub frames{
	return;	
}

sub get_next_frame {
	my $frame = $frames[$counter]; #cache
	$counter++;
	$counter = 0 if ($counter > 3);
	return $frame;
}

sub speed {
	if (! $flag) {
		$speed -= 0.005;
		$flag = 1 if ($speed < 0.005);	
	}
	else {
		$speed += 0.01;
		$flag = 0 if ($speed > 0.2); 
	}
	return $speed;
}

1;