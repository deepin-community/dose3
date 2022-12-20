PODA = $(wildcard *.rst)
# pod files per section
POD5 = apt-cudf.conf.rst
POD8 = apt-cudf-get.rst
POD1 = $(filter-out $(POD5) $(POD8),$(PODA))

# manpages to be generated
MAN1 = $(patsubst %.rst,%.1,$(POD1))
MAN5 = $(patsubst %.rst,%.5,$(POD5))
MAN8 = $(patsubst %.rst,%.8,$(POD8))
MANA = $(MAN1) $(MAN5) $(MAN8)

# manpages in HTML to be generated
HTMLA = $(patsubst %.rst,%.html,$(PODA))

all: man html

man: $(MANA)

html: $(HTMLA)

%.1: %.rst
	pandoc -s -t man $*.rst -o $@

%.5: %.rst
	pandoc -s -t man $*.rst -o $@

%.8: %.rst
	pandoc -s -t man $*.rst -o $@

%.html: %.rst
	pandoc -s -t html $*.rst -o $@

distclean clean:
	rm -f $(MANA) $(HTMLA)

.PHONY: clean distclean man html all


