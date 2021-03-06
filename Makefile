SRC = $(shell find src/ -type f -name '*.sh')
OUTFILE = bashacks.sh
STLANGUAGE = $(shell echo $LANG | cut -d \. -f1) 
MANDIR = /usr/share/man/man1
BASHRCFILE = /etc/profile.d/bashacks_init.sh

OS = $(shell uname -s)
ifeq ($(OS), Darwin)
	BASHRCFILE = /etc/bashrc
endif

all:
	for file in $(SRC); do \
		cat $$file >> $(OUTFILE); \
		echo >> $(OUTFILE); \
	done

install:

ifeq ("$(wildcard $(OUTFILE))","")
	$(error $(OUTFILE) not found. Try: make)
endif	

ifeq ($(STLANGUAGE), pt_BR)
	install doc/man/pt_BR/bashacks.1 $(MANDIR)
else
	install doc/man/en/bashacks.1 $(MANDIR)
endif

	echo 'source $(shell pwd)/$(OUTFILE)' >> $(BASHRCFILE)
	
clean:
	rm -f bashacks.sh

uninstall:
	rm -f /usr/share/man/man1/bashacks.1
	sed -i .bak '/bashacks/d' $(BASHRCFILE)
