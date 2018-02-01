# Nix compatible make file for ATS programs

ATSCC=patscc
ATSOPT=patsopt
ATSCCFLAGS=
RMF=rm -f
EXE=hello
PREFIX=

build:
	$(ATSCC) $(ATSCCFLAGS) -o $(EXE) hello.dats

check:

install:
	install -D -m555 -T $(EXE) $(PREFIX)/bin/$(EXE)

clean:
	$(RMF) *_?ats.o
	$(RMF) *_?ats.c
	$(RMF) hello
