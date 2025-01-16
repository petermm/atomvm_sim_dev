# AtomvmSimDev

This Project demonstrates running the Wokwi ESP32 simulator for local development of AtomVM.
It's configured with SPI SD card, a potentiometer for ADC, and a custom gps for UART.

## Installation

Use in VS code or Cursor with wokwi extension installed.

Assumes Elixir is installed.

Clone this repo into the same directory as your AtomVM directory.
Otherwise change the paths in flasher_args.json to match your setup (eg relative path to local AtomVM - leave "../atomvm_sim_dev.avm" as is).

Make sure you've built AtomVM and esp32 platform with the correct target "esp32" (esp32 default in diagram.json)

Use filewatcher below to reflash simulator on save or use plain 'mix atomvm.packbeam && touch ./atomvm_wokwi_bins/flasher_args.json'

## Running

Press F1 and select 'Wokwi: Start simulator'

## VS code extensions
https://marketplace.visualstudio.com/items?itemName=Wokwi.wokwi-vscode

(optional - for reflash on save) https://marketplace.visualstudio.com/items?itemName=appulate.filewatcher

(optional for manual task runner) https://marketplace.visualstudio.com/items?itemName=SanaAjani.taskrunnercode or https://marketplace.visualstudio.com/items?itemName=seunlanlege.action-buttons

## Custom chip
