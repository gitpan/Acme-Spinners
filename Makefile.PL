use 5.008008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Acme::Spinners',
    VERSION_FROM      => 'lib/Acme/Spinners.pm', # finds $VERSION
    PREREQ_PM         => {
    	Carp => 0,
    	Time::HiRes => 0,
    	Touch => 0,
    	Test::More => 0,
    	Test::POD => 0,
    }, # e.g., Module::Name => 1.1
    LICENSE => "bsd",
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Acme/Spinners.pm', # retrieve abstract from module
       AUTHOR         => 'Noah Rankins <cpan.20.kscript@spamgourmet.com>') : ()),
);
