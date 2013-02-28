
SHELL = /bin/sh
.SUFFIXES:
.SILENT:

# If you want more output, change this.
REDIRECT = > /dev/null
SHEETMUSICDIR = SheetMusicSource
SHEETMUSIC = $(wildcard $(SHEETMUSICDIR)/*.lytex)

PDFFILES = $(SHEETMUSIC:$(SHEETMUSICDIR)/%.lytex=%.pdf)
MIDIFILES = $(SHEETMUSIC:$(SHEETMUSICDIR)/%.lytex=%.midi)
FLACFILES = $(SHEETMUSIC:$(SHEETMUSICDIR)/%.lytex=%.flac)
OUTDIRS = $(SHEETMUSIC:$(SHEETMUSICDIR)/%.lytex=%/)

help:
	@echo 'Eurydice makefile targets:'
	@echo ' '
	@echo '                  help  -  (this message)'
	@echo '                 music  -  compile all sheet music'
	@echo '                  flac  -  convert all midi to flac'
	@echo '                 clean  -  remove generated files'
	@echo '                <song>  -  compile a single song'
	@echo '           <song>.flac  -  compile and convert midi to flac'
	@echo '    Songs:  $(SHEETMUSIC:$(SHEETMUSICDIR)/%.lytex=%)'

music: $(PDFFILES)
midi: $(MIDIFILES)
flac: $(FLACFILES)

.PHONY: timidity
timidity:
	@command -v timidity $(REDIRECT) 2>&1 || { \
		echo >&2 "Timidity is not installed. No flac file will be generated."; \
		exit 1; \
	}

%.flac: timidity %.midi
	timidity -OF $(word 2,$^) $(REDIRECT)


.PHONY: clean
clean:
	@$(RM) -rf -- $(PDFFILES) $(MIDIFILES) $(FLACFILES) $(OUTDIRS)

%.midi: %.pdf
	@echo ""

%.pdf: $(SHEETMUSICDIR)/%.lytex
	lytex $<

%: %.pdf
	@echo ""
