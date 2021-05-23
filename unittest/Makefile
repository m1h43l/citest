#
# Build script for STOMP Unit Tests
#


#-------------------------------------------------------------------------------
# User-defined part start
#

# BIN_LIB is the destination library for the unit tests.
BIN_LIB=STOMP

# This folder contains the ASSERT copybook of the unit testing framework.
RUINCDIR=/usr/local/include/rpgunit

# Library which contains RUTESTCASE service program
RU_LIB=RPGUNIT

TGTCCSID=*JOB

#
# User-defined part end
#-------------------------------------------------------------------------------


OBJECTS = mime_ut
SRVPGMS = $(RU_LIB)/RUTESTCASE

all: clean compile

compile: $(OBJECTS)

mime_ut:
	system -i "CRTRPGMOD MODULE($(BIN_LIB)/mime_ut) SRCSTMF('mime_ut.rpgmod') INCDIR('../include' '$(RUINCDIR)') dbgview(*source) stgmdl(*SNGLVL)"
	system -i "CRTSRVPGM $(BIN_LIB)/mime_ut MODULE(($(BIN_LIB)/mime_ut) $(BIN_LIB)/MIMETYPE) STGMDL(*SNGLVL) BNDSRVPGM($(SRVPGMS)) EXPORT(*ALL) OPTION(*DUPPROC)"


clean:
	-system -i "DLTMOD $(BIN_LIB)/MIME_UT"
	-system -i "DLTSRVPGM $(BIN_LIB)/MIME_UT"
	