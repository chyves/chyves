#
# chyves Makefile
#
# Usage:
#  make install		Installs chyves
#  make deinstall	Remove chyves from system
#  make rcremove	Remove chyves_enable and chyves_flags from /etc/rc.conf
#  make buildman	Builds man page (chyves.8) for developers after changes are made to chyves.8.txt
#  make clean		Cleans local folder for GitHub submissions

# Variables
PREFIX=/usr/local
PROJECT_NAME=chyves
SCRIPT_NAME=$(PROJECT_NAME)
BIN_DIR=sbin
#LIB_DIR=lib/$(PROJECT_NAME)
RC_DIR=etc/rc.d
MAN_DIR=man/man8
MAN_FILE=$(SCRIPT_NAME).8

# Commands
MKDIR=mkdir
RM=rm
CAT=cat
TXT2MAN=txt2man

# Developer use:
clean:
	$(RM) -f $(.OBJDIR)/man/$(MAN_FILE).gz

buildman:
	$(CAT) $(.OBJDIR)/man/$(MAN_FILE).txt | $(TXT2MAN) -t $(PROJECT_NAME) -s 8 -v "FreeBSD System Manager's Manual" > $(.OBJDIR)/man/$(MAN_FILE)

# General use:
install:
	@echo Building man gzip file
	gzip -cn $(.OBJDIR)/man/$(MAN_FILE) > man/$(MAN_FILE).gz
	@echo Done.
	$(MKDIR) -p $(PREFIX)/$(BIN_DIR)
	$(MKDIR) -p $(PREFIX)/$(RC_DIR)
#	$(MKDIR) -p $(PREFIX)/$(LIB_DIR)
	$(INSTALL) -c -m $(BINMODE) $(.OBJDIR)/sbin/$(SCRIPT_NAME) $(PREFIX)/$(BIN_DIR)/
	$(INSTALL) -c $(.OBJDIR)/rc.d/* $(PREFIX)/$(RC_DIR)/
#	$(INSTALL) -c $(.OBJDIR)/lib/* $(PREFIX)/$(LIB_DIR)/
	$(INSTALL) -c $(.OBJDIR)/man/$(MAN_FILE).gz $(PREFIX)/$(MAN_DIR)/

deinstall:
	$(RM) -f $(PREFIX)/$(BIN_DIR)/$(SCRIPT_NAME)
	$(RM) -f $(PREFIX)/$(RC_DIR)/$(SCRIPT_NAME)
#	$(RM) -rf $(PREFIX)/$(LIB_DIR)
	$(RM) -f $(PREFIX)/$(MAN_DIR)/$(MAN_FILE).gz
	@echo $(PROJECT_NAME)\'s ZFS dataset\(s\) remain untouched.
	@echo $(PROJECT_NAME)_enable directives in /etc/rc.conf can be removed with \"make rcremove\"
	@echo $(PROJECT_NAME) removed from system.

rcremove:
	@echo Removing $(PROJECT_NAME)_enable and $(PROJECT_NAME)_flags directives from /etc/rc.conf
	@echo Printing a copy of those settings for your records \(Error can be ignored\):
	-/usr/sbin/sysrc -q $(PROJECT_NAME)_enable
	-/usr/sbin/sysrc -q $(PROJECT_NAME)_flags
	-/usr/sbin/sysrc -q -x $(PROJECT_NAME)_enable
	-/usr/sbin/sysrc -q -x $(PROJECT_NAME)_flags

.include <bsd.prog.mk>
