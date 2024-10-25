# SPDX-FileCopyrightText: © 2022 Uri Shaked <uri@wokwi.com>
# SPDX-License-Identifier: MIT

SOURCES = gps-neo6m.chip.c
TARGET  = dist/gps-neo6m.chip.wasm

.PHONY: all
all: $(TARGET) dist/chip.json

.PHONY: clean
clean:
		rm -rf dist

dist:
		mkdir -p dist

$(TARGET): dist $(SOURCES) wokwi-api.h
	  clang --target=wasm32-unknown-wasi --sysroot /opt/wasi-libc -nostartfiles -Wl,--import-memory -Wl,--export-table -Wl,--no-entry -Werror -o $(TARGET) $(SOURCES)

dist/chip.json: dist gps-neo6m.chip.json
	  cp gps-neo6m.chip.json dist