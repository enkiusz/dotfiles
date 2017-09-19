# Setup perl local::lib
# http://cpan.uwinnipeg.ca/htdocs/local-lib/local/lib.html
readonly PERL5HOME="${LOCALROOT}/perl5"
[ -r "${PERL5HOME}/lib/perl5/local/lib.pm" ] && eval $(perl -I${PERL5HOME}/lib/perl5 -Mlocal::lib=${PERL5HOME})
