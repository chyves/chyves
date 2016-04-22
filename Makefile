#
#	Makefile
#

PREFIX?= /usr/local

BINDIR=$(PREFIX)/sbin
#FILESDIR=$(PREFIX)/lib/chyves
RCDIR=$(PREFIX)/etc/rc.d
MANDIR=$(PREFIX)/man/man8

# Commands
MKDIR=mkdir
RM=rm

SCRIPTS=chyves
SCRIPTSDIR=${PREFIX}/BINDIR
MAN=	man/$(SCRIPTS).8

${SCRIPTS}:
	@echo Nothing needs to be done for chyves.

clean:
	$(RM) -f ${.OBJDIR}/chyves.8.gz

# Internal use:
buildman:
	cat $(MAN).txt | txt2man -t $(SCRIPTS) -s 8 -v "FreeBSD System Manager's Manual" > $(MAN)

install:: all
	$(MKDIR) -p $(BINDIR)
	$(MKDIR) -p $(RCDIR)
#	$(MKDIR) -p $(FILESDIR)
	$(INSTALL) -c -m $(BINMODE) ${.OBJDIR}/sbin/$(SCRIPTS) $(BINDIR)/
#	$(INSTALL) -c ${.OBJDIR}/lib/* $(FILESDIR)/
	$(INSTALL) -c ${.OBJDIR}/rc.d/* $(RCDIR)/
	$(INSTALL) -c ${.OBJDIR}/$(SCRIPTS).8.gz $(MANDIR)/

.include <bsd.prog.mk>
