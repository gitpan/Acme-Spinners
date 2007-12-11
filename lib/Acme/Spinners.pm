package Acme::Spinners;

use 5.006;
use strict;
use warnings;

use Carp;
use Time::HiRes;
use Touch;

our $VERSION = '0.6';

sub new {
	my ($class) = @_;
	bless {
		spinner => undef,
		done => 0,
		flag => undef,
	}, $class;
}

sub spinners {
	my $self = shift;
	return;
}

sub spinner {
		my $self = shift;
		if (@_) {
			$self->{spinner} = shift;	
		}
		return $self->{spinner};
}

sub start {
	my $self = shift;
	if (! $self->{spinner}) {
			carp "Spinner was undef (did you call the spinner() method yet?)";
			return;
	}
	my $rand = int (rand() * 1_000_000);
	$self->{flag} = "acme-spinner$rand.flag";
	touch ($self->{flag});
	if (fork == 0) {
		local $| = 1;
		my $spinner = $self->{spinner};
		my @frames = $spinner->frames;
		my $speed = $spinner->speed();
		my $dynamic = $spinner->dynamic() if $spinner->can("dynamic");
		# We assume each column is the same length
		my $num_of_frames = @frames;
		if (! $dynamic) {
			for (my $i = 0; -e $self->{flag}; $i++) {
	    		$i = 0 if ($i == $num_of_frames);
	    		print $frames [$i];
	    		Time::HiRes::sleep ($speed);
	    		my @chars = split //, $frames[$i];
				my $num_of_chars = @chars;
	    		print "\b" x $num_of_chars;
			}
		}
		else {
			while (-e $self->{flag}) {
				my $frame = $spinner->get_next_frame();
				my $speed = $spinner->speed();
				my @chars = split //, $frame;
				my $num_of_chars = @chars;
	    		print $frame;
	    		Time::HiRes::sleep ($speed);
	    		print "\b" x $num_of_chars;
			}
		}
		exit;
	}
}

sub stop {
	unlink $_[0]->{flag};
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Acme::Spinners - A fully extensible framework...for creating text spinners.

=head1 SYNOPSIS

  use strict;
  use warnings;
  
  use Acme::Spinners;
  use Acme::Spinners::Simple;	# simple clockwise rotating blade
  my $spinner = new Acme::Spinners ();
  $spinner->spinner(new Acme::Spinners::Simple());
  $spinner->start();
  sleep 5;
  $spinner->stop();
  sleep 1;

=head1 DESCRIPTION

Ever make a CLI application and needed a way to provide the user that something was going on? Want to do it with 
style? Need an entire modularized infrastructure to do it?

Acme::Spinners is your friend.

This module allows you to select from a small array of pre-defined spinners for your enjoyment. Even better, 
it allows you to make your own spinners for your enjoyment.

=head1 METHODS

=head2 new()

C<new()> just makes a new object. Simple enough. Takes no arguments 
(feel free to supply garbage ones to frighten code readers (we recommend C<<< anal => 1, explosive => "true" >>>).

=head2 spinner($spinner)

C<spinner($spinner)> sets the spinner you want to use. Takes one argument, a new instance of the spinner you want to use.

=head2 start()

C<start()> startes the fun. When called, the spinner starts. Takes no arguments.

THIS FUNCTION RETURNS IMMEDIATELY! If you call C<start> immediately followed by C<stop>, 
you will be sorely disappointed. This method allows you to return, do you business, and stop the spinner when you're done.

=head2 stop()

C<stop()> stops the spinner. Takes no arguments. See BUGS section for potential problems with this method.

=head1 API

To create your own spinners, you just need to make a class and add a few methods.

=head2 REQUIRED

=head3 new()

A simple C<bless {}, $_[0];> will suffice. If you need more than that, feel free to add more. 
Your program will be calling C<new()> to initialize your spinner.

=head3 frames()

This method should return an array of frames for your spinner. If you have a dynamic spinner (see below), just return C<undef>.

=head3 speed()

This method should return how long to wait between each frame switch. 
If you have a dynamic spinner (see below), this method will be called multiple times.

=head2 OPTIONAL

=head3 dynamic()

Implementing this function (and returning true) indicates that you have a dynamic spinner.
Dynamic spinners can change the speed that the spinner spins at between each frame, 
as well as being able to generate their frames dynamically. See the code of Acme::Spinners::Dynamic for an example.

=head3 get_next_frame()

If you implement C<dynamic()> (above), you must implement this function. 
This function is called between each spinner frame, and it should return the next spinner in the sequence.

=head1 BUGS

Hopefully, I have worked out the kinks in this module (well, the really obvious ones anyway). However, there are 
a few things you need to watch out for.

In the example code, you see how there's a small sleep after the stop. There's a reason for that. When you call 
C<stop()>, it sends a message for the child process to stop and clean up. If your program exits immediately after that, 
the child will NOT get a chance to clean up after itself, leading to a potentially garbled terminal. 
It does not have to be a C<sleep()> command, just make sure your program doesn't call C<stop()> and exit.

This module does not catch Unix signals. Care must be taken to possibly call C<stop()> (and wait to clean up).

This module forks. For the 0.01% of you without a working fork, you're on your own.

If you frequently kill your spinner applications, you will notice an accumulation of C<acme-spinner123456.flag> files. 
That is completely normal, and they can be deleted without side effects. 
(The flag files are my way of handling IPC. Feel free to propose a better one.)

I do not take responsibility for potential bugs in this module. This module has not been suitably tested for 
enterprise-level applications. Use at your own risk. 
(Heck, you shouldn't be using ANY Acme::* modules in an enterprise-level app.)

=head1 EXPORT

None by default. (OOP)

=head1 SEE ALSO

Your BIOS for an example of a simple text spinner.

This module not to be confused with L<Acme::Spinner>.

=head1 AUTHOR

Noah Rankins, E<lt>cpan.20.kscript@spamgourmet.com<gt>

=head1 COPYRIGHT AND LICENSE

 Copyright (c) 2007, Noah Rankins
 All rights reserved
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

     1. Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
     2. Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the distribution.
     3. Neither the name of Noah Rankins nor the names of its contributors may 
        be used to endorse or promote products derived from this software
        without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY NOAH RANKINS AND CONTRIBUTORS ``AS IS'' AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL NOAH RANKINS AND CONTRIBUTORS BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut
