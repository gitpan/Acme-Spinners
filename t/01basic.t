# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Acme-Spinners.t'

#########################


use Test::More tests => 7;

BEGIN {
	diag ("\nUnfortunately, there is not really any way to test spinners.");
	diag ("So, let's just load them all (in this package)");
	use_ok("Acme::Spinners");
	use_ok("Acme::Spinners::Simple");
	use_ok("Acme::Spinners::Blades");
	use_ok("Acme::Spinners::80Shooter");
	use_ok("Acme::Spinners::Dynamic");
	use_ok("Acme::Spinners::Loading");
	use_ok("Acme::Spinners::BigGuns");
};