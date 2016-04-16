#
#	Makefile
#

PREFIX?= /usr/local

BINDIR=$(PREFIX)/sbin
#FILESDIR=$(PREFIX)/lib/chyves
RCDIR=$(PREFIX)/etc/rc.d
MANDIR=$(PREFIX)/man/man8
MKDIR=mkdir

SCRIPTS=chyves
SCRIPTSDIR=${PREFIX}/BINDIR
MAN=	$(SCRIPTS).8

${SCRIPTS}:
	@echo Nothing needs to be done for chyves.

install:: all
	$(MKDIR) -p $(BINDIR)
	$(MKDIR) -p $(RCDIR)
#	$(MKDIR) -p $(FILESDIR)
	$(INSTALL) -c -m $(BINMODE) ${.OBJDIR}/sbin/$(SCRIPTS) $(BINDIR)/
#	$(INSTALL) -c ${.OBJDIR}/lib/* $(FILESDIR)/
	$(INSTALL) -c ${.OBJDIR}/rc.d/* $(RCDIR)/
	$(INSTALL) -c man/$(MAN).gz $(MANDIR)/

.include <bsd.prog.mk>
