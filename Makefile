#
# STOMP 2.0
#

#-------------------------------------------------------------------------------
# User-defined part start
#

# BIN_LIB is the destination library for the program objects.
BIN_LIB=STOMP

#
# User-defined part end
#-------------------------------------------------------------------------------

SOURCE_CCSID=850


all: env compile bind clean

env:
	setccsid 850 include/*

compile:
	$(MAKE) -C src/ compile $*

bind:
	$(MAKE) -C src/ bind $*
	
clean:
	$(MAKE) -C src/ clean $*

purge:
	$(MAKE) -C src/ purge $*


release: .PHONY
	-system "DLTOBJ $(BIN_LIB)/STOMPSAVF OBJTYPE(*FILE)"
	system "CRTSAVF $(BIN_LIB)/STOMPSAVF"
	system "CHGOWN OBJ('/QSYS.LIB/$(BIN_LIB).LIB/STOMP.SRVPGM') NEWOWN(QPGMR)"
	system "SAVOBJ OBJ(STOMP) LIB($(BIN_LIB)) DEV(*SAVF) OBJTYPE(*SRVPGM) SAVF($(BIN_LIB)/STOMPSAVF) TGTRLS($(TGTRLS)) DTACPR(*YES)"

.PHONY:
