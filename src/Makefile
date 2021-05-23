#-------------------------------------------------------------------------------
# User-defined part start
#

# BIN_LIB is the destination library
BIN_LIB=STOMP

TGTRLS=*CURRENT

TGTCCSID=273

INCDIR=/usr/local/include
#
# User-defined part end
#-------------------------------------------------------------------------------

SOURCE_CCSID=850
CFLAGS=OUTPUT(*NONE) OPTIMIZE(10) ENUM(*INT) TERASPACE(*YES) STGMDL(*INHERIT) SYSIFCOPT(*IFSIO) DBGVIEW(*LIST) TGTRLS($(TGTRLS)) TGTCCSID($(TGTCCSID))
RCFLAGS=OPTION(*NOUNREF) OPTIMIZE(*FULL) DBGVIEW(*LIST) INCDIR('../include/' '$(INCDIR)') TGTRLS($(TGTRLS)) STGMDL(*INHERIT) TGTCCSID($(TGTCCSID))
BINDFLAGS=BNDSRVPGM(LLIST LIBTREE MESSAGE) STGMDL(*INHERIT) OPTION(*DUPPROC) TGTRLS($(TGTRLS))

.SUFFIXES: .c .cpp .rpgle .rpgmod .sql .sqlrpgle .sqlrpgmod

# suffix rules
.c:
	system -i "CHGATR OBJ('$<') ATR(*CCSID) VALUE($(SOURCE_CCSID))"
	system "CRTCMOD $(BIN_LIB)/$@ SRCSTMF('$<') $(CFLAGS)"

.cpp:
	system -i "CHGATR OBJ('$<') ATR(*CCSID) VALUE($(SOURCE_CCSID))"
	system "CRTCPPMOD $(BIN_LIB)/$@ SRCSTMF('$<') $(CFLAGS)"

.rpgmod:
	system -i "CHGATR OBJ('$<') ATR(*CCSID) VALUE($(SOURCE_CCSID))"
	system -iK "CRTRPGMOD $(BIN_LIB)/$@ SRCSTMF('$<') $(RCFLAGS)"                    

.rpgle:
	system -i "CHGATR OBJ('$<') ATR(*CCSID) VALUE($(SOURCE_CCSID))"
	system -iK "CRTBNDRPG $(BIN_LIB)/$@ SRCSTMF('$<') DFTACTGRP(*NO) ACTGRP(*CALLER) $(RCFLAGS)"


OBJECTS = stompinit stomp stompcmd stompext stompframe stompparse stomputil stomplog string mimetype

all: compile bind clean

compile: $(OBJECTS)

bind:
	-system "DLTF $(BIN_LIB)/STOMPSRV"
	-system "CRTSRCPF $(BIN_LIB)/STOMPSRV RCDLEN(200)"
	-system "CPYFRMIMPF FROMSTMF('stomp.bnd') TOFILE($(BIN_LIB)/STOMPSRV STOMP) RCDDLM(*ALL) STRDLM(*NONE) RPLNULLVAL(*FLDDFT)"
	system -i "CRTSRVPGM SRVPGM($(BIN_LIB)/stomp) MODULE($(BIN_LIB)/*ALL) EXPORT(*SRCFILE) SRCFILE($(BIN_LIB)/STOMPSRV) SRCMBR(STOMP) ACTGRP(*CALLER) $(BINDFLAGS)"
	-system "DLTF $(BIN_LIB)/STOMPSRV"

clean:
	-system -i "DLTOBJ $(BIN_LIB)/stomp OBJTYPE(*MODULE) RMVMSG(*YES)"
	-system -i "DLTOBJ $(BIN_LIB)/stomputil OBJTYPE(*MODULE) RMVMSG(*YES)"
	-system -i "DLTOBJ $(BIN_LIB)/stompinit OBJTYPE(*MODULE) RMVMSG(*YES)"
	-system -i "DLTOBJ $(BIN_LIB)/stompcmd OBJTYPE(*MODULE) RMVMSG(*YES)"
	-system -i "DLTOBJ $(BIN_LIB)/stompext OBJTYPE(*MODULE) RMVMSG(*YES)"
	-system -i "DLTOBJ $(BIN_LIB)/stompframe OBJTYPE(*MODULE) RMVMSG(*YES)"
	-system -i "DLTOBJ $(BIN_LIB)/stomplog OBJTYPE(*MODULE) RMVMSG(*YES)"
	-system -i "DLTOBJ $(BIN_LIB)/stompparse OBJTYPE(*MODULE) RMVMSG(*YES)"
	-system -i "DLTOBJ $(BIN_LIB)/string OBJTYPE(*MODULE) RMVMSG(*YES)"
	-system -i "DLTOBJ $(BIN_LIB)/mimetype OBJTYPE(*MODULE) RMVMSG(*YES)"

purge: clean
	-system -i "DLTOBJ $(BIN_LIB)/stomp OBJTYPE(*SRVPGM) RMVMSG(*YES)"

.PHONY:
