GCC    = gcc
LIBS   = gtk+-2.0
LIBS  += webkit-1.0
LIBS  += libsoup-2.4
FLAGS  = `pkg-config --cflags --libs $(LIBS)` -Wall
SOURCE = main.c
TARGET = vimprobable
PREFIX = /usr/local

all: $(TARGET)

hintingmode.h: input_hinting_mode.js
	perl ./js-merge-helper.pl

$(TARGET): main.c config.h hintingmode.h
	$(GCC) $(FLAGS) -Wall -o $(TARGET) $(SOURCE)

clean:
	rm -f $(TARGET)

install: all uninstall
	cp $(TARGET) $(PREFIX)/bin && chmod 755 $(PREFIX)/bin/$(TARGET)
	cp vimprobable.1 $(PREFIX)/man/man1 && chmod 644 $(PREFIX)/man/man1/vimprobable.1

uninstall:
	rm -f $(PREFIX)/bin/$(TARGET)
	rm -f $(PREFIX)/man/man1/vimprobable.1
