# Copyright 2012-2019 Tail-f Systems AB
#
# See the file "LICENSE" for information on usage and redistribution
# of this file, and for a DISCLAIMER OF ALL WARRANTIES.

include ./include.mk

ifdef LUX_SELF_TEST
LUX_EXTRAS += test
endif

SUBDIRS = src $(C_SRC_TARGET) $(LUX_EXTRAS)

all debug install clean:
	@for d in $(SUBDIRS); do         \
	   if test ! -d $$d ; then        \
	       echo "=== Skipping subdir $$d" ; \
	   else                   \
	      (cd $$d && $(MAKE) $@) ; \
	   fi ;                        \
	done

xref:
	bin/lux --xref

.PHONY: test
test:
	cd test && $(MAKE) all

test_clean:
	cd test && $(MAKE) clean

config_clean:
	$(MAKE) clean
	-rm -rf configure include.mk autom4te.cache config.status config.log *~

info:
	@echo "PREFIX=$(PREFIX)"
	@echo "EXEC_PREFIX=$(EXEC_PREFIX)"
	@echo "BINDIR=$(BINDIR)"
	@echo "SYSCONFDIR=$(SYSCONFDIR)"
	@echo "DESTDIR=$(DESTDIR)"
	@echo "TARGETDIR=$(TARGETDIR)"
	@echo
	@echo "LUX_SELF_TEST=$(LUX_SELF_TEST)"
	@echo "LUX_EXTRAS=$(LUX_EXTRAS)"
	@echo "SUBDIRS=$(SUBDIRS)"
