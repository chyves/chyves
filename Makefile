#
# chyves Makefile
#
# Usage:
#  make install             Installs chyves
#  make deinstall           Remove chyves from system
#  make rcremove            Remove chyves_enable and chyves_flags from /etc/rc.conf
#  make buildman            Builds man page (chyves.8) for developers after changes are made to chyves.8.txt
#  make clean               Cleans local folder for GitHub submissions

# Variables
PREFIX=/usr/local
PROJECT_NAME=chyves
SCRIPT_NAME=$(PROJECT_NAME)
BIN_DIR=sbin
LIB_DIR=lib/$(PROJECT_NAME)
RC_DIR=etc/rc.d
MAN_DIR=man/man8
MAN_FILE=$(SCRIPT_NAME).8
COMPILER_TYPE="clang"        # Kind of arbitrary as a compiler is not used but is needed on FreeNAS 9.10.1 to run 'make install'

# Commands
MKDIR=mkdir
RM=rm
CAT=cat
RONN=ronn
TXT2MAN=txt2man

# Developer use:
clean:
	$(RM) -f $(.OBJDIR)/man/$(MAN_FILE).gz

# Builds man page file and html file from chyves.8.ronn file using ronn
docs:
	$(RONN) --manual="FreeBSD System Manager's Manual" --date=`date +%Y-%m-%d` --organization="$(PROJECT_NAME)" --style=toc $(.OBJDIR)/man/$(MAN_FILE).ronn

# General use:
install:
	@echo Building man gzip file
	gzip -cn $(.OBJDIR)/man/$(MAN_FILE) > man/$(MAN_FILE).gz
	@echo Done.
	$(MKDIR) -p $(PREFIX)/$(BIN_DIR)
	$(MKDIR) -p $(PREFIX)/$(RC_DIR)
	$(MKDIR) -p $(PREFIX)/$(LIB_DIR)
	$(INSTALL) -c -m $(BINMODE) $(.OBJDIR)/sbin/$(SCRIPT_NAME) $(PREFIX)/$(BIN_DIR)/
	$(INSTALL) -c -m $(BINMODE) $(.OBJDIR)/rc.d/* $(PREFIX)/$(RC_DIR)/
	$(INSTALL) -c -m $(BINMODE) $(.OBJDIR)/lib/* $(PREFIX)/$(LIB_DIR)/
	$(INSTALL) -c $(.OBJDIR)/man/$(MAN_FILE).gz $(PREFIX)/$(MAN_DIR)/

# General use:
installrc:
	@echo Enabling chyves on boot
	-/usr/sbin/sysrc -q $(PROJECT_NAME)_enable=YES

deinstall:
	$(RM) -f $(PREFIX)/$(BIN_DIR)/$(SCRIPT_NAME)
	$(RM) -f $(PREFIX)/$(RC_DIR)/$(SCRIPT_NAME)
	$(RM) -rf $(PREFIX)/$(LIB_DIR)
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

what:
	@echo "make directives for $(PROJECT_NAME):"
	@echo "make clean      - Removes $(MAN_FILE).gz file for developers using git"
	@echo "make docs       - Runs the '$(RONN)' command to build the roff and html document files. Requires Ruby gem '$(RONN)'"
	@echo "make install    - Installs $(PROJECT_NAME) to '$(PREFIX)'."
	@echo "make installrc  - Enables '$(PROJECT_NAME)_enable=YES' in '/etc/rc.conf' using 'sysrc'."
	@echo "make deinstall  - Remove $(PROJECT_NAME) from '$(PREFIX)'."
	@echo "make rcremove   - Removes '$(PROJECT_NAME)_enable=YES' from '/etc/rc.conf' using 'sysrc'."
	@echo "make what       - Prints this."

.include <bsd.prog.mk>
