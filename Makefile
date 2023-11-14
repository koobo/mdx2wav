# Cross-compile to Amiga

VBCC ?= /opt/amiga
GCC ?= $(VBCC)/bin/m68k-amigaos-gcc
GPP ?= $(VBCC)/bin/m68k-amigaos-g++
STRIP ?= $(VBCC)/bin/m68k-amigaos-strip
OBJCOPY ?= $(VBCC)/bin/m68k-amigaos-objcopy
CFLAGS :=  -O2 -m68060 -mhard-float -noixemul -fomit-frame-pointer -mno-bitfield

TARGET := mdx2wav

SRC := src/mdx2wav.cpp \
	gamdx/downsample/downsample.cpp \
	gamdx/fmgen/fmgen.cpp  \
	gamdx/fmgen/fmtimer.cpp  \
	gamdx/fmgen/opm.cpp \
	gamdx/mxdrvg/so.cpp \
	gamdx/mxdrvg/opm_delegate.cpp \
	gamdx/pcm8/pcm8.cpp \
	gamdx/pcm8/x68pcm8.cpp \
	gamdx/mame/ym2151.c 

all: $(TARGET)

clean:
	rm $(TARGET) $(TARGET).sym
	
$(TARGET).sym: $(SRC)
	$(GPP) $(CFLAGS) -Wl,-Map,$(TARGET).map,--cref $^ -o $@

$(TARGET): $(TARGET).sym
	$(STRIP) $^ -o $@
