# This Makefile is for the Net::DNS extension to perl.
#
# It was generated automatically by MakeMaker version
# 7.64 (Revision: 76400) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: (q[INSTALLDIRS=site])
#

#   MakeMaker Parameters:

#     ABSTRACT_FROM => q[lib/Net/DNS.pm]
#     AUTHOR => [q[Dick Franks], q[Olaf Kolkman], q[Michael Fuhr]]
#     BUILD_REQUIRES => {  }
#     CONFIGURE_REQUIRES => { ExtUtils::MakeMaker=>q[6.48], Getopt::Long=>q[2.43], IO::File=>q[1.14], IO::Socket::IP=>q[0.38] }
#     LICENSE => q[mit]
#     META_MERGE => { recommends=>{ Digest::BubbleBabble=>q[0.02], Net::LibIDN2=>q[1] } }
#     MIN_PERL_VERSION => q[5.008009]
#     NAME => q[Net::DNS]
#     PREREQ_PM => { Carp=>q[1.1], Digest::HMAC=>q[1.03], Digest::MD5=>q[2.13], Digest::SHA=>q[5.23], Encode=>q[2.26], Exporter=>q[5.63], ExtUtils::MakeMaker=>q[0], File::Find=>q[1.13], File::Spec=>q[3.29], IO::File=>q[1.14], IO::Select=>q[1.17], IO::Socket=>q[1.3], IO::Socket::IP=>q[0.38], MIME::Base64=>q[2.13], PerlIO=>q[1.05], Scalar::Util=>q[1.19], Test::Builder=>q[0.8], Test::More=>q[0.8], Time::Local=>q[1.19] }
#     TEST_REQUIRES => { ExtUtils::MakeMaker=>q[0], File::Find=>q[1.13], File::Spec=>q[3.29], IO::File=>q[1.14], Test::Builder=>q[0.8], Test::More=>q[0.8] }
#     VERSION_FROM => q[lib/Net/DNS.pm]
#     clean => { FILES=>q[.resolv.conf *.lock t/online.enabled t/IPv6.enabled t/online.nonfatal] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/lib/x86_64-linux-gnu/perl-base/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = x86_64-linux-gnu-gcc
CCCDLFLAGS = -fPIC
CCDLFLAGS = -Wl,-E
CPPRUN = x86_64-linux-gnu-gcc  -E
DLEXT = so
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = x86_64-linux-gnu-gcc
LDDLFLAGS = -shared -L/usr/local/lib -fstack-protector-strong
LDFLAGS =  -fstack-protector-strong -L/usr/local/lib
LIBC = /lib/x86_64-linux-gnu/libc.so.6
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = linux
OSVERS = 4.19.0
RANLIB = :
SITELIBEXP = /usr/local/share/perl/5.36.0
SITEARCHEXP = /usr/local/lib/x86_64-linux-gnu/perl/5.36.0
SO = so
VENDORARCHEXP = /usr/lib/x86_64-linux-gnu/perl5/5.36
VENDORLIBEXP = /usr/share/perl5


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = Net::DNS
NAME_SYM = Net_DNS
VERSION = 1.38
VERSION_MACRO = VERSION
VERSION_SYM = 1_38
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 1.38
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1p
MAN3EXT = 3pm
MAN1SECTION = 1
MAN3SECTION = 3
INSTALLDIRS = site
INSTALL_BASE = /home/kali/perl5
DESTDIR = 
PREFIX = $(INSTALL_BASE)
INSTALLPRIVLIB = $(INSTALL_BASE)/lib/perl5
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = $(INSTALL_BASE)/lib/perl5
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = $(INSTALL_BASE)/lib/perl5
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = $(INSTALL_BASE)/lib/perl5/x86_64-linux-gnu-thread-multi
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = $(INSTALL_BASE)/lib/perl5/x86_64-linux-gnu-thread-multi
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = $(INSTALL_BASE)/lib/perl5/x86_64-linux-gnu-thread-multi
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = $(INSTALL_BASE)/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = $(INSTALL_BASE)/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = $(INSTALL_BASE)/bin
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = $(INSTALL_BASE)/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = $(INSTALL_BASE)/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = $(INSTALL_BASE)/bin
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = $(INSTALL_BASE)/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = $(INSTALL_BASE)/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = $(INSTALL_BASE)/man/man1
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = $(INSTALL_BASE)/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = $(INSTALL_BASE)/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = $(INSTALL_BASE)/man/man3
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB = /usr/share/perl/5.36
PERL_ARCHLIB = /usr/lib/x86_64-linux-gnu/perl/5.36
PERL_ARCHLIBDEP = /usr/lib/x86_64-linux-gnu/perl/5.36
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/lib/x86_64-linux-gnu/perl/5.36/CORE
PERL_INCDEP = /usr/lib/x86_64-linux-gnu/perl/5.36/CORE
PERL = "/usr/bin/perl"
FULLPERL = "/usr/bin/perl"
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_DIR = 755
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /usr/share/perl/5.36/ExtUtils/MakeMaker.pm
MM_VERSION  = 7.64
MM_REVISION = 76400

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = Net/DNS
BASEEXT = DNS
PARENT_NAME = Net
DLBASE = $(BASEEXT)
VERSION_FROM = lib/Net/DNS.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = 
MAN3PODS = lib/Net/DNS.pm \
	lib/Net/DNS/Domain.pm \
	lib/Net/DNS/DomainName.pm \
	lib/Net/DNS/FAQ.pod \
	lib/Net/DNS/Header.pm \
	lib/Net/DNS/Mailbox.pm \
	lib/Net/DNS/Nameserver.pm \
	lib/Net/DNS/Packet.pm \
	lib/Net/DNS/Parameters.pm \
	lib/Net/DNS/Question.pm \
	lib/Net/DNS/RR.pm \
	lib/Net/DNS/RR/A.pm \
	lib/Net/DNS/RR/AAAA.pm \
	lib/Net/DNS/RR/AFSDB.pm \
	lib/Net/DNS/RR/AMTRELAY.pm \
	lib/Net/DNS/RR/APL.pm \
	lib/Net/DNS/RR/CAA.pm \
	lib/Net/DNS/RR/CDNSKEY.pm \
	lib/Net/DNS/RR/CDS.pm \
	lib/Net/DNS/RR/CERT.pm \
	lib/Net/DNS/RR/CNAME.pm \
	lib/Net/DNS/RR/CSYNC.pm \
	lib/Net/DNS/RR/DHCID.pm \
	lib/Net/DNS/RR/DNAME.pm \
	lib/Net/DNS/RR/DNSKEY.pm \
	lib/Net/DNS/RR/DS.pm \
	lib/Net/DNS/RR/EUI48.pm \
	lib/Net/DNS/RR/EUI64.pm \
	lib/Net/DNS/RR/GPOS.pm \
	lib/Net/DNS/RR/HINFO.pm \
	lib/Net/DNS/RR/HIP.pm \
	lib/Net/DNS/RR/HTTPS.pm \
	lib/Net/DNS/RR/IPSECKEY.pm \
	lib/Net/DNS/RR/ISDN.pm \
	lib/Net/DNS/RR/KEY.pm \
	lib/Net/DNS/RR/KX.pm \
	lib/Net/DNS/RR/L32.pm \
	lib/Net/DNS/RR/L64.pm \
	lib/Net/DNS/RR/LOC.pm \
	lib/Net/DNS/RR/LP.pm \
	lib/Net/DNS/RR/MB.pm \
	lib/Net/DNS/RR/MG.pm \
	lib/Net/DNS/RR/MINFO.pm \
	lib/Net/DNS/RR/MR.pm \
	lib/Net/DNS/RR/MX.pm \
	lib/Net/DNS/RR/NAPTR.pm \
	lib/Net/DNS/RR/NID.pm \
	lib/Net/DNS/RR/NS.pm \
	lib/Net/DNS/RR/NSEC.pm \
	lib/Net/DNS/RR/NSEC3.pm \
	lib/Net/DNS/RR/NSEC3PARAM.pm \
	lib/Net/DNS/RR/NULL.pm \
	lib/Net/DNS/RR/OPENPGPKEY.pm \
	lib/Net/DNS/RR/OPT.pm \
	lib/Net/DNS/RR/PTR.pm \
	lib/Net/DNS/RR/PX.pm \
	lib/Net/DNS/RR/RP.pm \
	lib/Net/DNS/RR/RRSIG.pm \
	lib/Net/DNS/RR/RT.pm \
	lib/Net/DNS/RR/SIG.pm \
	lib/Net/DNS/RR/SMIMEA.pm \
	lib/Net/DNS/RR/SOA.pm \
	lib/Net/DNS/RR/SPF.pm \
	lib/Net/DNS/RR/SRV.pm \
	lib/Net/DNS/RR/SSHFP.pm \
	lib/Net/DNS/RR/SVCB.pm \
	lib/Net/DNS/RR/TKEY.pm \
	lib/Net/DNS/RR/TLSA.pm \
	lib/Net/DNS/RR/TSIG.pm \
	lib/Net/DNS/RR/TXT.pm \
	lib/Net/DNS/RR/URI.pm \
	lib/Net/DNS/RR/X25.pm \
	lib/Net/DNS/RR/ZONEMD.pm \
	lib/Net/DNS/Resolver.pm \
	lib/Net/DNS/Resolver/Base.pm \
	lib/Net/DNS/Resolver/MSWin32.pm \
	lib/Net/DNS/Resolver/Recurse.pm \
	lib/Net/DNS/Resolver/UNIX.pm \
	lib/Net/DNS/Resolver/android.pm \
	lib/Net/DNS/Resolver/cygwin.pm \
	lib/Net/DNS/Resolver/os2.pm \
	lib/Net/DNS/Resolver/os390.pm \
	lib/Net/DNS/Text.pm \
	lib/Net/DNS/Update.pm \
	lib/Net/DNS/ZoneFile.pm

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIBDEP)$(DFSEP)Config.pm $(PERL_INCDEP)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)/Net
INST_ARCHLIBDIR  = $(INST_ARCHLIB)/Net

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVEDEP    = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = lib/Net/DNS.pm \
	lib/Net/DNS/Domain.pm \
	lib/Net/DNS/DomainName.pm \
	lib/Net/DNS/FAQ.pod \
	lib/Net/DNS/Header.pm \
	lib/Net/DNS/Mailbox.pm \
	lib/Net/DNS/Nameserver.pm \
	lib/Net/DNS/Packet.pm \
	lib/Net/DNS/Parameters.pm \
	lib/Net/DNS/Question.pm \
	lib/Net/DNS/RR.pm \
	lib/Net/DNS/RR/A.pm \
	lib/Net/DNS/RR/AAAA.pm \
	lib/Net/DNS/RR/AFSDB.pm \
	lib/Net/DNS/RR/AMTRELAY.pm \
	lib/Net/DNS/RR/APL.pm \
	lib/Net/DNS/RR/CAA.pm \
	lib/Net/DNS/RR/CDNSKEY.pm \
	lib/Net/DNS/RR/CDS.pm \
	lib/Net/DNS/RR/CERT.pm \
	lib/Net/DNS/RR/CNAME.pm \
	lib/Net/DNS/RR/CSYNC.pm \
	lib/Net/DNS/RR/DHCID.pm \
	lib/Net/DNS/RR/DNAME.pm \
	lib/Net/DNS/RR/DNSKEY.pm \
	lib/Net/DNS/RR/DS.pm \
	lib/Net/DNS/RR/EUI48.pm \
	lib/Net/DNS/RR/EUI64.pm \
	lib/Net/DNS/RR/GPOS.pm \
	lib/Net/DNS/RR/HINFO.pm \
	lib/Net/DNS/RR/HIP.pm \
	lib/Net/DNS/RR/HTTPS.pm \
	lib/Net/DNS/RR/IPSECKEY.pm \
	lib/Net/DNS/RR/ISDN.pm \
	lib/Net/DNS/RR/KEY.pm \
	lib/Net/DNS/RR/KX.pm \
	lib/Net/DNS/RR/L32.pm \
	lib/Net/DNS/RR/L64.pm \
	lib/Net/DNS/RR/LOC.pm \
	lib/Net/DNS/RR/LP.pm \
	lib/Net/DNS/RR/MB.pm \
	lib/Net/DNS/RR/MG.pm \
	lib/Net/DNS/RR/MINFO.pm \
	lib/Net/DNS/RR/MR.pm \
	lib/Net/DNS/RR/MX.pm \
	lib/Net/DNS/RR/NAPTR.pm \
	lib/Net/DNS/RR/NID.pm \
	lib/Net/DNS/RR/NS.pm \
	lib/Net/DNS/RR/NSEC.pm \
	lib/Net/DNS/RR/NSEC3.pm \
	lib/Net/DNS/RR/NSEC3PARAM.pm \
	lib/Net/DNS/RR/NULL.pm \
	lib/Net/DNS/RR/OPENPGPKEY.pm \
	lib/Net/DNS/RR/OPT.pm \
	lib/Net/DNS/RR/PTR.pm \
	lib/Net/DNS/RR/PX.pm \
	lib/Net/DNS/RR/RP.pm \
	lib/Net/DNS/RR/RRSIG.pm \
	lib/Net/DNS/RR/RT.pm \
	lib/Net/DNS/RR/SIG.pm \
	lib/Net/DNS/RR/SMIMEA.pm \
	lib/Net/DNS/RR/SOA.pm \
	lib/Net/DNS/RR/SPF.pm \
	lib/Net/DNS/RR/SRV.pm \
	lib/Net/DNS/RR/SSHFP.pm \
	lib/Net/DNS/RR/SVCB.pm \
	lib/Net/DNS/RR/TKEY.pm \
	lib/Net/DNS/RR/TLSA.pm \
	lib/Net/DNS/RR/TSIG.pm \
	lib/Net/DNS/RR/TXT.pm \
	lib/Net/DNS/RR/URI.pm \
	lib/Net/DNS/RR/X25.pm \
	lib/Net/DNS/RR/ZONEMD.pm \
	lib/Net/DNS/Resolver.pm \
	lib/Net/DNS/Resolver/Base.pm \
	lib/Net/DNS/Resolver/MSWin32.pm \
	lib/Net/DNS/Resolver/Recurse.pm \
	lib/Net/DNS/Resolver/UNIX.pm \
	lib/Net/DNS/Resolver/android.pm \
	lib/Net/DNS/Resolver/cygwin.pm \
	lib/Net/DNS/Resolver/os2.pm \
	lib/Net/DNS/Resolver/os390.pm \
	lib/Net/DNS/Text.pm \
	lib/Net/DNS/Update.pm \
	lib/Net/DNS/ZoneFile.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 7.64
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$$$ARGV[0], $$$$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(TRUE)
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(ABSPERLRUN) -MExtUtils::Command -e 'mkpath' --
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) -MExtUtils::Command -e 'eqtime' --
FALSE = false
TRUE = true
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e 'install([ from_to => {@ARGV}, verbose => '\''$(VERBINST)'\'', uninstall_shadows => '\''$(UNINST)'\'', dir_mode => '\''$(PERM_DIR)'\'' ]);' --
DOC_INSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'perllocal_install' --
UNINSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'uninstall' --
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'warn_if_old_packlist' --
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = $(ABSPERLRUN) -MExtUtils::MY -e 'MY->fixin(shift)' --
CP_NONEMPTY = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'cp_nonempty' --


# --- MakeMaker makemakerdflt section:
makemakerdflt : all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip --best
SUFFIX = .gz
SHAR = shar
PREOP = $(NOECHO) $(NOOP)
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = $(NOECHO) $(NOOP)
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist
DISTNAME = Net-DNS
DISTVNAME = Net-DNS-1.38

# $(PERM_RWX) raises security issues downstream
PREOP = $(CHMOD) $(PERM_RW) $(DISTVNAME)$(DFSEP)contrib$(DFSEP)* $(DISTVNAME)$(DFSEP)demo$(DFSEP)*


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	LD="$(LD)"\
	PREFIX="$(PREFIX)"\
	INSTALL_BASE="$(INSTALL_BASE)"\
	PASTHRU_DEFINE='$(DEFINE) $(PASTHRU_DEFINE)'\
	PASTHRU_INC='$(INC) $(PASTHRU_INC)'


# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir pure_all subdirs clean_subdirs makemakerdflt manifypods realclean_subdirs subdirs_dynamic subdirs_pure_nolink subdirs_static subdirs-test_dynamic subdirs-test_static test_dynamic test_static



# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)

pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

help :
	perldoc ExtUtils::MakeMaker


# --- MakeMaker blibdirs section:
blibdirs : $(INST_LIBDIR)$(DFSEP).exists $(INST_ARCHLIB)$(DFSEP).exists $(INST_AUTODIR)$(DFSEP).exists $(INST_ARCHAUTODIR)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists $(INST_SCRIPT)$(DFSEP).exists $(INST_MAN1DIR)$(DFSEP).exists $(INST_MAN3DIR)$(DFSEP).exists
	$(NOECHO) $(NOOP)

# Backwards compat with 6.18 through 6.25
blibdirs.ts : blibdirs
	$(NOECHO) $(NOOP)

$(INST_LIBDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN3DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN3DIR)$(DFSEP).exists



# --- MakeMaker linkext section:

linkext :: dynamic
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) config $(INST_BOOT) $(INST_DYNAMIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all config  \
	lib/Net/DNS.pm \
	lib/Net/DNS/Domain.pm \
	lib/Net/DNS/DomainName.pm \
	lib/Net/DNS/FAQ.pod \
	lib/Net/DNS/Header.pm \
	lib/Net/DNS/Mailbox.pm \
	lib/Net/DNS/Nameserver.pm \
	lib/Net/DNS/Packet.pm \
	lib/Net/DNS/Parameters.pm \
	lib/Net/DNS/Question.pm \
	lib/Net/DNS/RR.pm \
	lib/Net/DNS/RR/A.pm \
	lib/Net/DNS/RR/AAAA.pm \
	lib/Net/DNS/RR/AFSDB.pm \
	lib/Net/DNS/RR/AMTRELAY.pm \
	lib/Net/DNS/RR/APL.pm \
	lib/Net/DNS/RR/CAA.pm \
	lib/Net/DNS/RR/CDNSKEY.pm \
	lib/Net/DNS/RR/CDS.pm \
	lib/Net/DNS/RR/CERT.pm \
	lib/Net/DNS/RR/CNAME.pm \
	lib/Net/DNS/RR/CSYNC.pm \
	lib/Net/DNS/RR/DHCID.pm \
	lib/Net/DNS/RR/DNAME.pm \
	lib/Net/DNS/RR/DNSKEY.pm \
	lib/Net/DNS/RR/DS.pm \
	lib/Net/DNS/RR/EUI48.pm \
	lib/Net/DNS/RR/EUI64.pm \
	lib/Net/DNS/RR/GPOS.pm \
	lib/Net/DNS/RR/HINFO.pm \
	lib/Net/DNS/RR/HIP.pm \
	lib/Net/DNS/RR/HTTPS.pm \
	lib/Net/DNS/RR/IPSECKEY.pm \
	lib/Net/DNS/RR/ISDN.pm \
	lib/Net/DNS/RR/KEY.pm \
	lib/Net/DNS/RR/KX.pm \
	lib/Net/DNS/RR/L32.pm \
	lib/Net/DNS/RR/L64.pm \
	lib/Net/DNS/RR/LOC.pm \
	lib/Net/DNS/RR/LP.pm \
	lib/Net/DNS/RR/MB.pm \
	lib/Net/DNS/RR/MG.pm \
	lib/Net/DNS/RR/MINFO.pm \
	lib/Net/DNS/RR/MR.pm \
	lib/Net/DNS/RR/MX.pm \
	lib/Net/DNS/RR/NAPTR.pm \
	lib/Net/DNS/RR/NID.pm \
	lib/Net/DNS/RR/NS.pm \
	lib/Net/DNS/RR/NSEC.pm \
	lib/Net/DNS/RR/NSEC3.pm \
	lib/Net/DNS/RR/NSEC3PARAM.pm \
	lib/Net/DNS/RR/NULL.pm \
	lib/Net/DNS/RR/OPENPGPKEY.pm \
	lib/Net/DNS/RR/OPT.pm \
	lib/Net/DNS/RR/PTR.pm \
	lib/Net/DNS/RR/PX.pm \
	lib/Net/DNS/RR/RP.pm \
	lib/Net/DNS/RR/RRSIG.pm \
	lib/Net/DNS/RR/RT.pm \
	lib/Net/DNS/RR/SIG.pm \
	lib/Net/DNS/RR/SMIMEA.pm \
	lib/Net/DNS/RR/SOA.pm \
	lib/Net/DNS/RR/SPF.pm \
	lib/Net/DNS/RR/SRV.pm \
	lib/Net/DNS/RR/SSHFP.pm \
	lib/Net/DNS/RR/SVCB.pm \
	lib/Net/DNS/RR/TKEY.pm \
	lib/Net/DNS/RR/TLSA.pm \
	lib/Net/DNS/RR/TSIG.pm \
	lib/Net/DNS/RR/TXT.pm \
	lib/Net/DNS/RR/URI.pm \
	lib/Net/DNS/RR/X25.pm \
	lib/Net/DNS/RR/ZONEMD.pm \
	lib/Net/DNS/Resolver.pm \
	lib/Net/DNS/Resolver/Base.pm \
	lib/Net/DNS/Resolver/MSWin32.pm \
	lib/Net/DNS/Resolver/Recurse.pm \
	lib/Net/DNS/Resolver/UNIX.pm \
	lib/Net/DNS/Resolver/android.pm \
	lib/Net/DNS/Resolver/cygwin.pm \
	lib/Net/DNS/Resolver/os2.pm \
	lib/Net/DNS/Resolver/os390.pm \
	lib/Net/DNS/Text.pm \
	lib/Net/DNS/Update.pm \
	lib/Net/DNS/ZoneFile.pm
	$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) -u \
	  lib/Net/DNS.pm $(INST_MAN3DIR)/Net::DNS.$(MAN3EXT) \
	  lib/Net/DNS/Domain.pm $(INST_MAN3DIR)/Net::DNS::Domain.$(MAN3EXT) \
	  lib/Net/DNS/DomainName.pm $(INST_MAN3DIR)/Net::DNS::DomainName.$(MAN3EXT) \
	  lib/Net/DNS/FAQ.pod $(INST_MAN3DIR)/Net::DNS::FAQ.$(MAN3EXT) \
	  lib/Net/DNS/Header.pm $(INST_MAN3DIR)/Net::DNS::Header.$(MAN3EXT) \
	  lib/Net/DNS/Mailbox.pm $(INST_MAN3DIR)/Net::DNS::Mailbox.$(MAN3EXT) \
	  lib/Net/DNS/Nameserver.pm $(INST_MAN3DIR)/Net::DNS::Nameserver.$(MAN3EXT) \
	  lib/Net/DNS/Packet.pm $(INST_MAN3DIR)/Net::DNS::Packet.$(MAN3EXT) \
	  lib/Net/DNS/Parameters.pm $(INST_MAN3DIR)/Net::DNS::Parameters.$(MAN3EXT) \
	  lib/Net/DNS/Question.pm $(INST_MAN3DIR)/Net::DNS::Question.$(MAN3EXT) \
	  lib/Net/DNS/RR.pm $(INST_MAN3DIR)/Net::DNS::RR.$(MAN3EXT) \
	  lib/Net/DNS/RR/A.pm $(INST_MAN3DIR)/Net::DNS::RR::A.$(MAN3EXT) \
	  lib/Net/DNS/RR/AAAA.pm $(INST_MAN3DIR)/Net::DNS::RR::AAAA.$(MAN3EXT) \
	  lib/Net/DNS/RR/AFSDB.pm $(INST_MAN3DIR)/Net::DNS::RR::AFSDB.$(MAN3EXT) \
	  lib/Net/DNS/RR/AMTRELAY.pm $(INST_MAN3DIR)/Net::DNS::RR::AMTRELAY.$(MAN3EXT) \
	  lib/Net/DNS/RR/APL.pm $(INST_MAN3DIR)/Net::DNS::RR::APL.$(MAN3EXT) \
	  lib/Net/DNS/RR/CAA.pm $(INST_MAN3DIR)/Net::DNS::RR::CAA.$(MAN3EXT) \
	  lib/Net/DNS/RR/CDNSKEY.pm $(INST_MAN3DIR)/Net::DNS::RR::CDNSKEY.$(MAN3EXT) \
	  lib/Net/DNS/RR/CDS.pm $(INST_MAN3DIR)/Net::DNS::RR::CDS.$(MAN3EXT) \
	  lib/Net/DNS/RR/CERT.pm $(INST_MAN3DIR)/Net::DNS::RR::CERT.$(MAN3EXT) \
	  lib/Net/DNS/RR/CNAME.pm $(INST_MAN3DIR)/Net::DNS::RR::CNAME.$(MAN3EXT) \
	  lib/Net/DNS/RR/CSYNC.pm $(INST_MAN3DIR)/Net::DNS::RR::CSYNC.$(MAN3EXT) \
	  lib/Net/DNS/RR/DHCID.pm $(INST_MAN3DIR)/Net::DNS::RR::DHCID.$(MAN3EXT) \
	  lib/Net/DNS/RR/DNAME.pm $(INST_MAN3DIR)/Net::DNS::RR::DNAME.$(MAN3EXT) \
	  lib/Net/DNS/RR/DNSKEY.pm $(INST_MAN3DIR)/Net::DNS::RR::DNSKEY.$(MAN3EXT) \
	  lib/Net/DNS/RR/DS.pm $(INST_MAN3DIR)/Net::DNS::RR::DS.$(MAN3EXT) \
	  lib/Net/DNS/RR/EUI48.pm $(INST_MAN3DIR)/Net::DNS::RR::EUI48.$(MAN3EXT) \
	  lib/Net/DNS/RR/EUI64.pm $(INST_MAN3DIR)/Net::DNS::RR::EUI64.$(MAN3EXT) \
	  lib/Net/DNS/RR/GPOS.pm $(INST_MAN3DIR)/Net::DNS::RR::GPOS.$(MAN3EXT) \
	  lib/Net/DNS/RR/HINFO.pm $(INST_MAN3DIR)/Net::DNS::RR::HINFO.$(MAN3EXT) \
	  lib/Net/DNS/RR/HIP.pm $(INST_MAN3DIR)/Net::DNS::RR::HIP.$(MAN3EXT) \
	  lib/Net/DNS/RR/HTTPS.pm $(INST_MAN3DIR)/Net::DNS::RR::HTTPS.$(MAN3EXT) \
	  lib/Net/DNS/RR/IPSECKEY.pm $(INST_MAN3DIR)/Net::DNS::RR::IPSECKEY.$(MAN3EXT) \
	  lib/Net/DNS/RR/ISDN.pm $(INST_MAN3DIR)/Net::DNS::RR::ISDN.$(MAN3EXT) \
	  lib/Net/DNS/RR/KEY.pm $(INST_MAN3DIR)/Net::DNS::RR::KEY.$(MAN3EXT) \
	  lib/Net/DNS/RR/KX.pm $(INST_MAN3DIR)/Net::DNS::RR::KX.$(MAN3EXT) \
	  lib/Net/DNS/RR/L32.pm $(INST_MAN3DIR)/Net::DNS::RR::L32.$(MAN3EXT) \
	  lib/Net/DNS/RR/L64.pm $(INST_MAN3DIR)/Net::DNS::RR::L64.$(MAN3EXT) 
	$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) -u \
	  lib/Net/DNS/RR/LOC.pm $(INST_MAN3DIR)/Net::DNS::RR::LOC.$(MAN3EXT) \
	  lib/Net/DNS/RR/LP.pm $(INST_MAN3DIR)/Net::DNS::RR::LP.$(MAN3EXT) \
	  lib/Net/DNS/RR/MB.pm $(INST_MAN3DIR)/Net::DNS::RR::MB.$(MAN3EXT) \
	  lib/Net/DNS/RR/MG.pm $(INST_MAN3DIR)/Net::DNS::RR::MG.$(MAN3EXT) \
	  lib/Net/DNS/RR/MINFO.pm $(INST_MAN3DIR)/Net::DNS::RR::MINFO.$(MAN3EXT) \
	  lib/Net/DNS/RR/MR.pm $(INST_MAN3DIR)/Net::DNS::RR::MR.$(MAN3EXT) \
	  lib/Net/DNS/RR/MX.pm $(INST_MAN3DIR)/Net::DNS::RR::MX.$(MAN3EXT) \
	  lib/Net/DNS/RR/NAPTR.pm $(INST_MAN3DIR)/Net::DNS::RR::NAPTR.$(MAN3EXT) \
	  lib/Net/DNS/RR/NID.pm $(INST_MAN3DIR)/Net::DNS::RR::NID.$(MAN3EXT) \
	  lib/Net/DNS/RR/NS.pm $(INST_MAN3DIR)/Net::DNS::RR::NS.$(MAN3EXT) \
	  lib/Net/DNS/RR/NSEC.pm $(INST_MAN3DIR)/Net::DNS::RR::NSEC.$(MAN3EXT) \
	  lib/Net/DNS/RR/NSEC3.pm $(INST_MAN3DIR)/Net::DNS::RR::NSEC3.$(MAN3EXT) \
	  lib/Net/DNS/RR/NSEC3PARAM.pm $(INST_MAN3DIR)/Net::DNS::RR::NSEC3PARAM.$(MAN3EXT) \
	  lib/Net/DNS/RR/NULL.pm $(INST_MAN3DIR)/Net::DNS::RR::NULL.$(MAN3EXT) \
	  lib/Net/DNS/RR/OPENPGPKEY.pm $(INST_MAN3DIR)/Net::DNS::RR::OPENPGPKEY.$(MAN3EXT) \
	  lib/Net/DNS/RR/OPT.pm $(INST_MAN3DIR)/Net::DNS::RR::OPT.$(MAN3EXT) \
	  lib/Net/DNS/RR/PTR.pm $(INST_MAN3DIR)/Net::DNS::RR::PTR.$(MAN3EXT) \
	  lib/Net/DNS/RR/PX.pm $(INST_MAN3DIR)/Net::DNS::RR::PX.$(MAN3EXT) \
	  lib/Net/DNS/RR/RP.pm $(INST_MAN3DIR)/Net::DNS::RR::RP.$(MAN3EXT) \
	  lib/Net/DNS/RR/RRSIG.pm $(INST_MAN3DIR)/Net::DNS::RR::RRSIG.$(MAN3EXT) \
	  lib/Net/DNS/RR/RT.pm $(INST_MAN3DIR)/Net::DNS::RR::RT.$(MAN3EXT) \
	  lib/Net/DNS/RR/SIG.pm $(INST_MAN3DIR)/Net::DNS::RR::SIG.$(MAN3EXT) \
	  lib/Net/DNS/RR/SMIMEA.pm $(INST_MAN3DIR)/Net::DNS::RR::SMIMEA.$(MAN3EXT) \
	  lib/Net/DNS/RR/SOA.pm $(INST_MAN3DIR)/Net::DNS::RR::SOA.$(MAN3EXT) \
	  lib/Net/DNS/RR/SPF.pm $(INST_MAN3DIR)/Net::DNS::RR::SPF.$(MAN3EXT) \
	  lib/Net/DNS/RR/SRV.pm $(INST_MAN3DIR)/Net::DNS::RR::SRV.$(MAN3EXT) \
	  lib/Net/DNS/RR/SSHFP.pm $(INST_MAN3DIR)/Net::DNS::RR::SSHFP.$(MAN3EXT) \
	  lib/Net/DNS/RR/SVCB.pm $(INST_MAN3DIR)/Net::DNS::RR::SVCB.$(MAN3EXT) \
	  lib/Net/DNS/RR/TKEY.pm $(INST_MAN3DIR)/Net::DNS::RR::TKEY.$(MAN3EXT) \
	  lib/Net/DNS/RR/TLSA.pm $(INST_MAN3DIR)/Net::DNS::RR::TLSA.$(MAN3EXT) \
	  lib/Net/DNS/RR/TSIG.pm $(INST_MAN3DIR)/Net::DNS::RR::TSIG.$(MAN3EXT) \
	  lib/Net/DNS/RR/TXT.pm $(INST_MAN3DIR)/Net::DNS::RR::TXT.$(MAN3EXT) \
	  lib/Net/DNS/RR/URI.pm $(INST_MAN3DIR)/Net::DNS::RR::URI.$(MAN3EXT) \
	  lib/Net/DNS/RR/X25.pm $(INST_MAN3DIR)/Net::DNS::RR::X25.$(MAN3EXT) \
	  lib/Net/DNS/RR/ZONEMD.pm $(INST_MAN3DIR)/Net::DNS::RR::ZONEMD.$(MAN3EXT) \
	  lib/Net/DNS/Resolver.pm $(INST_MAN3DIR)/Net::DNS::Resolver.$(MAN3EXT) \
	  lib/Net/DNS/Resolver/Base.pm $(INST_MAN3DIR)/Net::DNS::Resolver::Base.$(MAN3EXT) \
	  lib/Net/DNS/Resolver/MSWin32.pm $(INST_MAN3DIR)/Net::DNS::Resolver::MSWin32.$(MAN3EXT) 
	$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) -u \
	  lib/Net/DNS/Resolver/Recurse.pm $(INST_MAN3DIR)/Net::DNS::Resolver::Recurse.$(MAN3EXT) \
	  lib/Net/DNS/Resolver/UNIX.pm $(INST_MAN3DIR)/Net::DNS::Resolver::UNIX.$(MAN3EXT) \
	  lib/Net/DNS/Resolver/android.pm $(INST_MAN3DIR)/Net::DNS::Resolver::android.$(MAN3EXT) \
	  lib/Net/DNS/Resolver/cygwin.pm $(INST_MAN3DIR)/Net::DNS::Resolver::cygwin.$(MAN3EXT) \
	  lib/Net/DNS/Resolver/os2.pm $(INST_MAN3DIR)/Net::DNS::Resolver::os2.$(MAN3EXT) \
	  lib/Net/DNS/Resolver/os390.pm $(INST_MAN3DIR)/Net::DNS::Resolver::os390.$(MAN3EXT) \
	  lib/Net/DNS/Text.pm $(INST_MAN3DIR)/Net::DNS::Text.$(MAN3EXT) \
	  lib/Net/DNS/Update.pm $(INST_MAN3DIR)/Net::DNS::Update.$(MAN3EXT) \
	  lib/Net/DNS/ZoneFile.pm $(INST_MAN3DIR)/Net::DNS::ZoneFile.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:


# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  $(BASEEXT).bso $(BASEEXT).def \
	  $(BASEEXT).exp $(BASEEXT).x \
	  $(BOOTSTRAP) $(INST_ARCHAUTODIR)/extralibs.all \
	  $(INST_ARCHAUTODIR)/extralibs.ld $(MAKE_APERL_FILE) \
	  *$(LIB_EXT) *$(OBJ_EXT) \
	  *perl.core MYMETA.json \
	  MYMETA.yml blibdirs.ts \
	  core core.*perl.*.? \
	  core.[0-9] core.[0-9][0-9] \
	  core.[0-9][0-9][0-9] core.[0-9][0-9][0-9][0-9] \
	  core.[0-9][0-9][0-9][0-9][0-9] lib$(BASEEXT).def \
	  mon.out perl \
	  perl$(EXE_EXT) perl.exe \
	  perlmain.c pm_to_blib \
	  pm_to_blib.ts so_locations \
	  tmon.out 
	- $(RM_RF) \
	  *.lock .resolv.conf \
	  blib t/IPv6.enabled \
	  t/online.enabled t/online.nonfatal 
	  $(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
# so clean is forced to complete before realclean_subdirs runs
realclean_subdirs : clean
	$(NOECHO) $(NOOP)


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge :: realclean_subdirs
	- $(RM_F) \
	  $(FIRST_MAKEFILE) $(MAKEFILE_OLD) 
	- $(RM_RF) \
	  $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile : create_distdir
	$(NOECHO) $(ECHO) Generating META.yml
	$(NOECHO) $(ECHO) '---' > META_new.yml
	$(NOECHO) $(ECHO) 'abstract: '\''Perl Interface to the Domain Name System'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'author:' >> META_new.yml
	$(NOECHO) $(ECHO) '  - '\''Dick Franks'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  - '\''Olaf Kolkman'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  - '\''Michael Fuhr'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'build_requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '  ExtUtils::MakeMaker: '\''0'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  File::Find: '\''1.13'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  File::Spec: '\''3.29'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  IO::File: '\''1.14'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  Test::Builder: '\''0.8'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  Test::More: '\''0.8'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'configure_requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '  ExtUtils::MakeMaker: '\''6.48'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  Getopt::Long: '\''2.43'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  IO::File: '\''1.14'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  IO::Socket::IP: '\''0.38'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'dynamic_config: 1' >> META_new.yml
	$(NOECHO) $(ECHO) 'generated_by: '\''ExtUtils::MakeMaker version 7.64, CPAN::Meta::Converter version 2.150010'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'license: mit' >> META_new.yml
	$(NOECHO) $(ECHO) 'meta-spec:' >> META_new.yml
	$(NOECHO) $(ECHO) '  url: http://module-build.sourceforge.net/META-spec-v1.4.html' >> META_new.yml
	$(NOECHO) $(ECHO) '  version: '\''1.4'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'name: Net-DNS' >> META_new.yml
	$(NOECHO) $(ECHO) 'no_index:' >> META_new.yml
	$(NOECHO) $(ECHO) '  directory:' >> META_new.yml
	$(NOECHO) $(ECHO) '    - t' >> META_new.yml
	$(NOECHO) $(ECHO) '    - inc' >> META_new.yml
	$(NOECHO) $(ECHO) 'recommends:' >> META_new.yml
	$(NOECHO) $(ECHO) '  Digest::BubbleBabble: '\''0.02'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  Net::LibIDN2: '\''1'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '  Carp: '\''1.1'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  Digest::HMAC: '\''1.03'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  Digest::MD5: '\''2.13'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  Digest::SHA: '\''5.23'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  Encode: '\''2.26'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  Exporter: '\''5.63'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  File::Spec: '\''3.29'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  IO::File: '\''1.14'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  IO::Select: '\''1.17'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  IO::Socket: '\''1.3'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  IO::Socket::IP: '\''0.38'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  MIME::Base64: '\''2.13'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  PerlIO: '\''1.05'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  Scalar::Util: '\''1.19'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  Time::Local: '\''1.19'\''' >> META_new.yml
	$(NOECHO) $(ECHO) '  perl: '\''5.008009'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'version: '\''1.38'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'x_serialization_backend: '\''CPAN::Meta::YAML version 0.018'\''' >> META_new.yml
	-$(NOECHO) $(MV) META_new.yml $(DISTVNAME)/META.yml
	$(NOECHO) $(ECHO) Generating META.json
	$(NOECHO) $(ECHO) '{' > META_new.json
	$(NOECHO) $(ECHO) '   "abstract" : "Perl Interface to the Domain Name System",' >> META_new.json
	$(NOECHO) $(ECHO) '   "author" : [' >> META_new.json
	$(NOECHO) $(ECHO) '      "Dick Franks",' >> META_new.json
	$(NOECHO) $(ECHO) '      "Olaf Kolkman",' >> META_new.json
	$(NOECHO) $(ECHO) '      "Michael Fuhr"' >> META_new.json
	$(NOECHO) $(ECHO) '   ],' >> META_new.json
	$(NOECHO) $(ECHO) '   "dynamic_config" : 1,' >> META_new.json
	$(NOECHO) $(ECHO) '   "generated_by" : "ExtUtils::MakeMaker version 7.64, CPAN::Meta::Converter version 2.150010",' >> META_new.json
	$(NOECHO) $(ECHO) '   "license" : [' >> META_new.json
	$(NOECHO) $(ECHO) '      "mit"' >> META_new.json
	$(NOECHO) $(ECHO) '   ],' >> META_new.json
	$(NOECHO) $(ECHO) '   "meta-spec" : {' >> META_new.json
	$(NOECHO) $(ECHO) '      "url" : "http://search.cpan.org/perldoc?CPAN::Meta::Spec",' >> META_new.json
	$(NOECHO) $(ECHO) '      "version" : 2' >> META_new.json
	$(NOECHO) $(ECHO) '   },' >> META_new.json
	$(NOECHO) $(ECHO) '   "name" : "Net-DNS",' >> META_new.json
	$(NOECHO) $(ECHO) '   "no_index" : {' >> META_new.json
	$(NOECHO) $(ECHO) '      "directory" : [' >> META_new.json
	$(NOECHO) $(ECHO) '         "t",' >> META_new.json
	$(NOECHO) $(ECHO) '         "inc"' >> META_new.json
	$(NOECHO) $(ECHO) '      ]' >> META_new.json
	$(NOECHO) $(ECHO) '   },' >> META_new.json
	$(NOECHO) $(ECHO) '   "prereqs" : {' >> META_new.json
	$(NOECHO) $(ECHO) '      "build" : {' >> META_new.json
	$(NOECHO) $(ECHO) '         "requires" : {' >> META_new.json
	$(NOECHO) $(ECHO) '            "ExtUtils::MakeMaker" : "0"' >> META_new.json
	$(NOECHO) $(ECHO) '         }' >> META_new.json
	$(NOECHO) $(ECHO) '      },' >> META_new.json
	$(NOECHO) $(ECHO) '      "configure" : {' >> META_new.json
	$(NOECHO) $(ECHO) '         "requires" : {' >> META_new.json
	$(NOECHO) $(ECHO) '            "ExtUtils::MakeMaker" : "6.48",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Getopt::Long" : "2.43",' >> META_new.json
	$(NOECHO) $(ECHO) '            "IO::File" : "1.14",' >> META_new.json
	$(NOECHO) $(ECHO) '            "IO::Socket::IP" : "0.38"' >> META_new.json
	$(NOECHO) $(ECHO) '         }' >> META_new.json
	$(NOECHO) $(ECHO) '      },' >> META_new.json
	$(NOECHO) $(ECHO) '      "runtime" : {' >> META_new.json
	$(NOECHO) $(ECHO) '         "recommends" : {' >> META_new.json
	$(NOECHO) $(ECHO) '            "Digest::BubbleBabble" : "0.02",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Net::LibIDN2" : "1"' >> META_new.json
	$(NOECHO) $(ECHO) '         },' >> META_new.json
	$(NOECHO) $(ECHO) '         "requires" : {' >> META_new.json
	$(NOECHO) $(ECHO) '            "Carp" : "1.1",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Digest::HMAC" : "1.03",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Digest::MD5" : "2.13",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Digest::SHA" : "5.23",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Encode" : "2.26",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Exporter" : "5.63",' >> META_new.json
	$(NOECHO) $(ECHO) '            "File::Spec" : "3.29",' >> META_new.json
	$(NOECHO) $(ECHO) '            "IO::File" : "1.14",' >> META_new.json
	$(NOECHO) $(ECHO) '            "IO::Select" : "1.17",' >> META_new.json
	$(NOECHO) $(ECHO) '            "IO::Socket" : "1.3",' >> META_new.json
	$(NOECHO) $(ECHO) '            "IO::Socket::IP" : "0.38",' >> META_new.json
	$(NOECHO) $(ECHO) '            "MIME::Base64" : "2.13",' >> META_new.json
	$(NOECHO) $(ECHO) '            "PerlIO" : "1.05",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Scalar::Util" : "1.19",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Time::Local" : "1.19",' >> META_new.json
	$(NOECHO) $(ECHO) '            "perl" : "5.008009"' >> META_new.json
	$(NOECHO) $(ECHO) '         }' >> META_new.json
	$(NOECHO) $(ECHO) '      },' >> META_new.json
	$(NOECHO) $(ECHO) '      "test" : {' >> META_new.json
	$(NOECHO) $(ECHO) '         "requires" : {' >> META_new.json
	$(NOECHO) $(ECHO) '            "ExtUtils::MakeMaker" : "0",' >> META_new.json
	$(NOECHO) $(ECHO) '            "File::Find" : "1.13",' >> META_new.json
	$(NOECHO) $(ECHO) '            "File::Spec" : "3.29",' >> META_new.json
	$(NOECHO) $(ECHO) '            "IO::File" : "1.14",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Test::Builder" : "0.8",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Test::More" : "0.8"' >> META_new.json
	$(NOECHO) $(ECHO) '         }' >> META_new.json
	$(NOECHO) $(ECHO) '      }' >> META_new.json
	$(NOECHO) $(ECHO) '   },' >> META_new.json
	$(NOECHO) $(ECHO) '   "release_status" : "stable",' >> META_new.json
	$(NOECHO) $(ECHO) '   "version" : "1.38",' >> META_new.json
	$(NOECHO) $(ECHO) '   "x_serialization_backend" : "JSON::PP version 4.07"' >> META_new.json
	$(NOECHO) $(ECHO) '}' >> META_new.json
	-$(NOECHO) $(MV) META_new.json $(DISTVNAME)/META.json


# --- MakeMaker signature section:
signature :
	cpansign -s


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ */*~ *.orig */*.orig *.bak */*.bak *.old */*.old



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(ABSPERLRUN) -l -e 'print '\''Warning: Makefile possibly out of date with $(VERSION_FROM)'\''' \
	  -e '    if -e '\''$(VERSION_FROM)'\'' and -M '\''$(VERSION_FROM)'\'' < -M '\''$(FIRST_MAKEFILE)'\'';' --

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).tar$(SUFFIX)_uu'

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).tar$(SUFFIX)'
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).zip'
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).shar'
	$(POSTOP)


# --- MakeMaker distdir section:
create_distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

distdir : create_distdir distmeta 
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL "INSTALLDIRS=site"
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)



# --- MakeMaker dist_ci section:
ci :
	$(ABSPERLRUN) -MExtUtils::Manifest=maniread -e '@all = sort keys %{ maniread() };' \
	  -e 'print(qq{Executing $(CI) @all\n});' \
	  -e 'system(qq{$(CI) @all}) == 0 or die $$!;' \
	  -e 'print(qq{Executing $(RCS_LABEL) ...\n});' \
	  -e 'system(qq{$(RCS_LABEL) @all}) == 0 or die $$!;' --


# --- MakeMaker distmeta section:
distmeta : create_distdir metafile
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -e q{META.yml};' \
	  -e 'eval { maniadd({q{META.yml} => q{Module YAML meta-data (added by MakeMaker)}}) }' \
	  -e '    or die "Could not add META.yml to MANIFEST: $${'\''@'\''}"' --
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -f q{META.json};' \
	  -e 'eval { maniadd({q{META.json} => q{Module JSON meta-data (added by MakeMaker)}}) }' \
	  -e '    or die "Could not add META.json to MANIFEST: $${'\''@'\''}"' --



# --- MakeMaker distsignature section:
distsignature : distmeta
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{SIGNATURE} => q{Public-key signature (added by MakeMaker)}}) }' \
	  -e '    or die "Could not add SIGNATURE to MANIFEST: $${'\''@'\''}"' --
	$(NOECHO) cd $(DISTVNAME) && $(TOUCH) SIGNATURE
	cd $(DISTVNAME) && cpansign -s



# --- MakeMaker install section:

install :: pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		"$(INST_LIB)" "$(DESTINSTALLPRIVLIB)" \
		"$(INST_ARCHLIB)" "$(DESTINSTALLARCHLIB)" \
		"$(INST_BIN)" "$(DESTINSTALLBIN)" \
		"$(INST_SCRIPT)" "$(DESTINSTALLSCRIPT)" \
		"$(INST_MAN1DIR)" "$(DESTINSTALLMAN1DIR)" \
		"$(INST_MAN3DIR)" "$(DESTINSTALLMAN3DIR)"
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		"$(SITEARCHEXP)/auto/$(FULLEXT)"


pure_site_install :: all
	$(NOECHO) umask 02; $(MOD_INSTALL) \
		read "$(SITEARCHEXP)/auto/$(FULLEXT)/.packlist" \
		write "$(DESTINSTALLSITEARCH)/auto/$(FULLEXT)/.packlist" \
		"$(INST_LIB)" "$(DESTINSTALLSITELIB)" \
		"$(INST_ARCHLIB)" "$(DESTINSTALLSITEARCH)" \
		"$(INST_BIN)" "$(DESTINSTALLSITEBIN)" \
		"$(INST_SCRIPT)" "$(DESTINSTALLSITESCRIPT)" \
		"$(INST_MAN1DIR)" "$(DESTINSTALLSITEMAN1DIR)" \
		"$(INST_MAN3DIR)" "$(DESTINSTALLSITEMAN3DIR)"
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		"$(PERL_ARCHLIB)/auto/$(FULLEXT)"

pure_vendor_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		"$(INST_LIB)" "$(DESTINSTALLVENDORLIB)" \
		"$(INST_ARCHLIB)" "$(DESTINSTALLVENDORARCH)" \
		"$(INST_BIN)" "$(DESTINSTALLVENDORBIN)" \
		"$(INST_SCRIPT)" "$(DESTINSTALLVENDORSCRIPT)" \
		"$(INST_MAN1DIR)" "$(DESTINSTALLVENDORMAN1DIR)" \
		"$(INST_MAN3DIR)" "$(DESTINSTALLVENDORMAN3DIR)"


doc_perl_install :: all

doc_site_install :: all
	$(NOECHO) $(ECHO) Appending installation info to "$(DESTINSTALLSITEARCH)/perllocal.pod"
	-$(NOECHO) umask 02; $(MKPATH) "$(DESTINSTALLSITEARCH)"
	-$(NOECHO) umask 02; $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> "$(DESTINSTALLSITEARCH)/perllocal.pod"

doc_vendor_install :: all


uninstall :: uninstall_from_$(INSTALLDIRS)dirs
	$(NOECHO) $(NOOP)

uninstall_from_perldirs ::

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) "$(SITEARCHEXP)/auto/$(FULLEXT)/.packlist"

uninstall_from_vendordirs ::


# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE :
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:
# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL "INSTALLDIRS=site"
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = "/usr/bin/perl"
MAP_PERLINC   = "-Iblib/arch" "-Iblib/lib" "-I/usr/lib/x86_64-linux-gnu/perl/5.36" "-I/usr/share/perl/5.36"

$(MAP_TARGET) :: $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : static $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR="" \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS= \
		INSTALLDIRS=site


# --- MakeMaker test section:
TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/*.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)
	$(NOECHO) $(NOOP)

test :: $(TEST_TYPE)
	$(NOECHO) $(NOOP)

# Occasionally we may face this degenerate target:
test_ : test_dynamic
	$(NOECHO) $(NOOP)

subdirs-test_dynamic :: dynamic pure_all

test_dynamic :: subdirs-test_dynamic
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: dynamic pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

subdirs-test_static :: static pure_all

test_static :: subdirs-test_static
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_static :: static pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

# suppress parallel test execution	include test directory
TEST_DIR = t
FULLPERLRUN = HARNESS_OPTIONS=j1:c $(FULLPERL) "-I$(TEST_DIR)"


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="Net-DNS" VERSION="1.38">' > Net-DNS.ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Perl Interface to the Domain Name System</ABSTRACT>' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>Dick Franks, Olaf Kolkman, Michael Fuhr</AUTHOR>' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <PERLCORE VERSION="5,008009,0,0" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Carp::" VERSION="1.1" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Digest::HMAC" VERSION="1.03" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Digest::MD5" VERSION="2.13" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Digest::SHA" VERSION="5.23" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Encode::" VERSION="2.26" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Exporter::" VERSION="5.63" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="File::Spec" VERSION="3.29" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="IO::File" VERSION="1.14" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="IO::Select" VERSION="1.17" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="IO::Socket" VERSION="1.3" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="IO::Socket::IP" VERSION="0.38" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="MIME::Base64" VERSION="2.13" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="PerlIO::" VERSION="1.05" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Scalar::Util" VERSION="1.19" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Time::Local" VERSION="1.19" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="x86_64-linux-gnu-thread-multi-5.36" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> Net-DNS.ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> Net-DNS.ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  'lib/Net/DNS.pm' 'blib/lib/Net/DNS.pm' \
	  'lib/Net/DNS/Domain.pm' 'blib/lib/Net/DNS/Domain.pm' \
	  'lib/Net/DNS/DomainName.pm' 'blib/lib/Net/DNS/DomainName.pm' \
	  'lib/Net/DNS/FAQ.pod' 'blib/lib/Net/DNS/FAQ.pod' \
	  'lib/Net/DNS/Header.pm' 'blib/lib/Net/DNS/Header.pm' \
	  'lib/Net/DNS/Mailbox.pm' 'blib/lib/Net/DNS/Mailbox.pm' \
	  'lib/Net/DNS/Nameserver.pm' 'blib/lib/Net/DNS/Nameserver.pm' \
	  'lib/Net/DNS/Packet.pm' 'blib/lib/Net/DNS/Packet.pm' \
	  'lib/Net/DNS/Parameters.pm' 'blib/lib/Net/DNS/Parameters.pm' \
	  'lib/Net/DNS/Question.pm' 'blib/lib/Net/DNS/Question.pm' \
	  'lib/Net/DNS/RR.pm' 'blib/lib/Net/DNS/RR.pm' \
	  'lib/Net/DNS/RR/A.pm' 'blib/lib/Net/DNS/RR/A.pm' \
	  'lib/Net/DNS/RR/AAAA.pm' 'blib/lib/Net/DNS/RR/AAAA.pm' \
	  'lib/Net/DNS/RR/AFSDB.pm' 'blib/lib/Net/DNS/RR/AFSDB.pm' \
	  'lib/Net/DNS/RR/AMTRELAY.pm' 'blib/lib/Net/DNS/RR/AMTRELAY.pm' \
	  'lib/Net/DNS/RR/APL.pm' 'blib/lib/Net/DNS/RR/APL.pm' \
	  'lib/Net/DNS/RR/CAA.pm' 'blib/lib/Net/DNS/RR/CAA.pm' \
	  'lib/Net/DNS/RR/CDNSKEY.pm' 'blib/lib/Net/DNS/RR/CDNSKEY.pm' \
	  'lib/Net/DNS/RR/CDS.pm' 'blib/lib/Net/DNS/RR/CDS.pm' \
	  'lib/Net/DNS/RR/CERT.pm' 'blib/lib/Net/DNS/RR/CERT.pm' \
	  'lib/Net/DNS/RR/CNAME.pm' 'blib/lib/Net/DNS/RR/CNAME.pm' \
	  'lib/Net/DNS/RR/CSYNC.pm' 'blib/lib/Net/DNS/RR/CSYNC.pm' \
	  'lib/Net/DNS/RR/DHCID.pm' 'blib/lib/Net/DNS/RR/DHCID.pm' \
	  'lib/Net/DNS/RR/DNAME.pm' 'blib/lib/Net/DNS/RR/DNAME.pm' \
	  'lib/Net/DNS/RR/DNSKEY.pm' 'blib/lib/Net/DNS/RR/DNSKEY.pm' \
	  'lib/Net/DNS/RR/DS.pm' 'blib/lib/Net/DNS/RR/DS.pm' \
	  'lib/Net/DNS/RR/EUI48.pm' 'blib/lib/Net/DNS/RR/EUI48.pm' \
	  'lib/Net/DNS/RR/EUI64.pm' 'blib/lib/Net/DNS/RR/EUI64.pm' \
	  'lib/Net/DNS/RR/GPOS.pm' 'blib/lib/Net/DNS/RR/GPOS.pm' \
	  'lib/Net/DNS/RR/HINFO.pm' 'blib/lib/Net/DNS/RR/HINFO.pm' \
	  'lib/Net/DNS/RR/HIP.pm' 'blib/lib/Net/DNS/RR/HIP.pm' \
	  'lib/Net/DNS/RR/HTTPS.pm' 'blib/lib/Net/DNS/RR/HTTPS.pm' \
	  'lib/Net/DNS/RR/IPSECKEY.pm' 'blib/lib/Net/DNS/RR/IPSECKEY.pm' \
	  'lib/Net/DNS/RR/ISDN.pm' 'blib/lib/Net/DNS/RR/ISDN.pm' \
	  'lib/Net/DNS/RR/KEY.pm' 'blib/lib/Net/DNS/RR/KEY.pm' \
	  'lib/Net/DNS/RR/KX.pm' 'blib/lib/Net/DNS/RR/KX.pm' \
	  'lib/Net/DNS/RR/L32.pm' 'blib/lib/Net/DNS/RR/L32.pm' \
	  'lib/Net/DNS/RR/L64.pm' 'blib/lib/Net/DNS/RR/L64.pm' \
	  'lib/Net/DNS/RR/LOC.pm' 'blib/lib/Net/DNS/RR/LOC.pm' \
	  'lib/Net/DNS/RR/LP.pm' 'blib/lib/Net/DNS/RR/LP.pm' \
	  'lib/Net/DNS/RR/MB.pm' 'blib/lib/Net/DNS/RR/MB.pm' \
	  'lib/Net/DNS/RR/MG.pm' 'blib/lib/Net/DNS/RR/MG.pm' \
	  'lib/Net/DNS/RR/MINFO.pm' 'blib/lib/Net/DNS/RR/MINFO.pm' \
	  'lib/Net/DNS/RR/MR.pm' 'blib/lib/Net/DNS/RR/MR.pm' \
	  'lib/Net/DNS/RR/MX.pm' 'blib/lib/Net/DNS/RR/MX.pm' \
	  'lib/Net/DNS/RR/NAPTR.pm' 'blib/lib/Net/DNS/RR/NAPTR.pm' 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  'lib/Net/DNS/RR/NID.pm' 'blib/lib/Net/DNS/RR/NID.pm' \
	  'lib/Net/DNS/RR/NS.pm' 'blib/lib/Net/DNS/RR/NS.pm' \
	  'lib/Net/DNS/RR/NSEC.pm' 'blib/lib/Net/DNS/RR/NSEC.pm' \
	  'lib/Net/DNS/RR/NSEC3.pm' 'blib/lib/Net/DNS/RR/NSEC3.pm' \
	  'lib/Net/DNS/RR/NSEC3PARAM.pm' 'blib/lib/Net/DNS/RR/NSEC3PARAM.pm' \
	  'lib/Net/DNS/RR/NULL.pm' 'blib/lib/Net/DNS/RR/NULL.pm' \
	  'lib/Net/DNS/RR/OPENPGPKEY.pm' 'blib/lib/Net/DNS/RR/OPENPGPKEY.pm' \
	  'lib/Net/DNS/RR/OPT.pm' 'blib/lib/Net/DNS/RR/OPT.pm' \
	  'lib/Net/DNS/RR/PTR.pm' 'blib/lib/Net/DNS/RR/PTR.pm' \
	  'lib/Net/DNS/RR/PX.pm' 'blib/lib/Net/DNS/RR/PX.pm' \
	  'lib/Net/DNS/RR/RP.pm' 'blib/lib/Net/DNS/RR/RP.pm' \
	  'lib/Net/DNS/RR/RRSIG.pm' 'blib/lib/Net/DNS/RR/RRSIG.pm' \
	  'lib/Net/DNS/RR/RT.pm' 'blib/lib/Net/DNS/RR/RT.pm' \
	  'lib/Net/DNS/RR/SIG.pm' 'blib/lib/Net/DNS/RR/SIG.pm' \
	  'lib/Net/DNS/RR/SMIMEA.pm' 'blib/lib/Net/DNS/RR/SMIMEA.pm' \
	  'lib/Net/DNS/RR/SOA.pm' 'blib/lib/Net/DNS/RR/SOA.pm' \
	  'lib/Net/DNS/RR/SPF.pm' 'blib/lib/Net/DNS/RR/SPF.pm' \
	  'lib/Net/DNS/RR/SRV.pm' 'blib/lib/Net/DNS/RR/SRV.pm' \
	  'lib/Net/DNS/RR/SSHFP.pm' 'blib/lib/Net/DNS/RR/SSHFP.pm' \
	  'lib/Net/DNS/RR/SVCB.pm' 'blib/lib/Net/DNS/RR/SVCB.pm' \
	  'lib/Net/DNS/RR/TKEY.pm' 'blib/lib/Net/DNS/RR/TKEY.pm' \
	  'lib/Net/DNS/RR/TLSA.pm' 'blib/lib/Net/DNS/RR/TLSA.pm' \
	  'lib/Net/DNS/RR/TSIG.pm' 'blib/lib/Net/DNS/RR/TSIG.pm' \
	  'lib/Net/DNS/RR/TXT.pm' 'blib/lib/Net/DNS/RR/TXT.pm' \
	  'lib/Net/DNS/RR/URI.pm' 'blib/lib/Net/DNS/RR/URI.pm' \
	  'lib/Net/DNS/RR/X25.pm' 'blib/lib/Net/DNS/RR/X25.pm' \
	  'lib/Net/DNS/RR/ZONEMD.pm' 'blib/lib/Net/DNS/RR/ZONEMD.pm' \
	  'lib/Net/DNS/Resolver.pm' 'blib/lib/Net/DNS/Resolver.pm' \
	  'lib/Net/DNS/Resolver/Base.pm' 'blib/lib/Net/DNS/Resolver/Base.pm' \
	  'lib/Net/DNS/Resolver/MSWin32.pm' 'blib/lib/Net/DNS/Resolver/MSWin32.pm' \
	  'lib/Net/DNS/Resolver/Recurse.pm' 'blib/lib/Net/DNS/Resolver/Recurse.pm' \
	  'lib/Net/DNS/Resolver/UNIX.pm' 'blib/lib/Net/DNS/Resolver/UNIX.pm' \
	  'lib/Net/DNS/Resolver/android.pm' 'blib/lib/Net/DNS/Resolver/android.pm' \
	  'lib/Net/DNS/Resolver/cygwin.pm' 'blib/lib/Net/DNS/Resolver/cygwin.pm' \
	  'lib/Net/DNS/Resolver/os2.pm' 'blib/lib/Net/DNS/Resolver/os2.pm' \
	  'lib/Net/DNS/Resolver/os390.pm' 'blib/lib/Net/DNS/Resolver/os390.pm' \
	  'lib/Net/DNS/Text.pm' 'blib/lib/Net/DNS/Text.pm' \
	  'lib/Net/DNS/Update.pm' 'blib/lib/Net/DNS/Update.pm' \
	  'lib/Net/DNS/ZoneFile.pm' 'blib/lib/Net/DNS/ZoneFile.pm' 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:

# here so even if top_targets is overridden, these will still be defined
# gmake will silently still work if any are .PHONY-ed but nmake won't

static ::
	$(NOECHO) $(NOOP)

dynamic ::
	$(NOECHO) $(NOOP)

config ::
	$(NOECHO) $(NOOP)


# --- MakeMaker postamble section:
test_cover :
	cover -delete
	HARNESS_PERL_SWITCHES=-MDevel::Cover $(MAKE) test
	cover


# End.
