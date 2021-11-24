const years = {
  amiga: "1985",
  amigacd32: "1993",
  amstradcpc: "1984",
  atari7800: "1986",
  atarilynx: "1989",
  c64: "1982",
  dreamcast: "1998",
  famicom: "1983",
  fds: "1986",
  gamegear: "1990",
  gb: "1989",
  gba: "2001",
  gbc: "1998",
  mastersystem: "1985",
  megadrive: "1989",
  n64: "1996",
  naomi: "1998",
  neogeo: "1990",
  nes: "1983",
  ngpc: "1999",
  pc: "1981",
  pcengine: "1987",
  pcenginecd: "1988",
  ps2: "2000",
  ps3: "2006",
  psx: "1994",
  saturn: "1994",
  sega32x: "1994",
  segacd: "1991",
  sfc: "1990",
  "sg-1000": "1983",
  snes: "1990",
  switch: "2017",
  vectrex: "1982",
  x68000: "1987",
};

const shortDescriptions = {
  amiga: "16/32-bit computer",
  amigacd32: "32-bit console",
  amstradcpc: "8-bit computer",
  atari7800: "8-bit console",
  atarilynx: "16-bit console",
  c64: "8-bit computer",
  dreamcast: "32-bit console",
  famicom: "8-bit console",
  fds: "8-bit console add-on",
  gamegear: "8-bit handheld console",
  gb: "8-bit handheld console",
  gba: "32-bit handheld console",
  gbc: "8-bit handheld console",
  mastersystem: "8-bit console",
  megadrive: "16-bit console",
  n64: "64-bit console",
  naomi: "32-bit arcade board",
  neogeo: "16/32-bit console",
  nes: "8-bit console",
  ngpc: "16-bit handheld console",
  pc: "operating system",
  pcengine: "16-bit console",
  pcenginecd: "console add-on",
  ps2: "6th gen console",
  ps3: "7th gen console",
  psx: "32-bit console",
  saturn: "32-bit console",
  sega32x: "32-bit add-on",
  segacd: "16-bit console add-on",
  sfc: "16-bit console",
  "sg-1000": "8-bit console",
  snes: "16-bit console",
  switch: "8th gen console",
  vectrex: "8-bit console",
  x68000: "16/32-bit computer",
};

const descriptions = {
  amiga: `Family of personal computers featuring mouse-based GUI. Famous for a wide range of games and creative software.
CPU: Motorola 680x0 @≈7+ MHz
Memory: 256KB-9MB RAM, floppy disks, HDD
Graphics: Custom chips (up to 1440×580, 4096-16.7 mil. colors)
Audio: Custom chip "Paula", 4×8-bit channels PCM
Release date NL: Apr '87 NA: Oct '87`,
  amigacd32: `Amiga-based home console, code-named "Spellbound"
CPU: Motorola 68EC020 @14.18MHz (PAL), 14.32MHz (NTSC)
Memory: 2MB RAM, 2x-speed CD drive
Audio: Custom chip "Paula", 4×8-bit channels PCM
Release date EU: 17 Sep '93`,
  amstradcpc: `Amstrad CPC (short for Colour Personal Computer)
CPU: Zilog Z80 @4MHz
Memory: 64K
Audio: General Instruments AY-3-8912
Release date: 12 Apr '84`,
  arcade: `Coin-operated entertainment machines.
The golden age is defined as a period between the late 1970s and ending in the mid-1980s.`,
  atari7800: `Backward-compatible to Atari 2600
CPU: Atari SALLY @1.19-1.79MHz
Memory: 4KB RAM, 4KB ROM, 48KB Cartridge ROM
Graphics: MARIA custom GPU 7.15MHz (up to 320×240, 256 colors)
Audio: TIA custom chip
Release date NA: May '86 PAL: '87.`,
  atarilynx: `The world's first handheld electronic game with a color LCD.
CPU: WDC 8-bit 65SC02 @4Mhz
Memory: 64KB RAM, 128KB-1MB cartridge ROM
Display: Color LCD 160×102
Graphics: "Suzy" 16-bit custom CMOS @16MHz (4096 colors)
Audio: 8-bit DAC, 4 channels
Release date: 01 Sep '89`,
  c64: `The highest-selling single computer model
CPU: MOS Technology 6510/8500 @1.023MHz (NTSC) @0.985MHz (PAL)
Memory: 64KB RAM + 20KB ROM
Graphics: Graph VIC-II (320×200, 16 colors)
Audio: SID 6581/8580
Release date: Aug '82`,
  dreamcast: `Sega's final home console.
CPU Hitachi SH-4 32-bit RISC @200MHz
Memory: 16MB RAM, 8MB VRAM, 2MB audio SRAM, 128KB VMU
Graphics: PowerVR2 @100MHz (640x480, 16,7 mil. colors)
Audio: 67MHz Yamaha AICA 32-bit ARM7 RISC CPU core, 64 ch.
Release date JP: 27 Nov '98 NA: 09 Sep '99 EU: 14 Oct '99 AU: 30 Nov '99`,
  famicom: `The Family Computer (Famicom) was the Japanese version of the Nintendo Entertainment System
CPU: Ricoh 2A03 8-bit processor (MOS Technology 6502 core) @1.79Mhz
Memory: 2KB + potential cartridge RAM, 2KB VRAM, cartridge 8KB-1MB ROM
Graphics: Ricoh "Picture Processing Unit" (256x240, 25 colors)
Audio: 5 channels, potential additional chips on cartridge
Release date JP: 15 Jul '83 NA: 18 Oct '85 EU: 01 Sep '86 EU/AU: '87`,
  fds: `The Famicom Disk System a peripheral for the Famicom home video game console and was only released in Japan.
CPU: Ricoh 2A03
Memory: 32 KB disk cache, 9KB game RAM, 112 KB floppy disks
Audio: 1 extra channel of wavetable synth
Release date JP: 21 Feb '86`,
  gamegear: `It is able to play it's own titles as well as the Master Systems.
CPU: Zilog Z80 @3.5 MHz
Memory: 8kB RAM, 16kB VRAM, ROM cartridge
Display: 3.2" backlit color (160×144, 4096 colors, 32 on-screen)
Audio: TI SN76489
Release date JP: 06 Oct '90 NA/EU: Apr '91 AU: '92`,
  gb: `Third best-selling game console of all time. Competed with Game Gear and Lynx.
CPU: Sharp LR35902 core @4.19 MHz
Memory: 8KB RAM + up to 128KB cartridge RAM, 8KB VRAM, 32KB-8MB cartridge ROM
Display: LCD 160x144 (4 colors)
Audio: Custom chip (4 channels)
Release date JP: 21 Apr '89 NA: 31 Jul '89 EU: 28 Sep '90 RUS: '95 FRY: '96`,
  gba: `Competed with NGP Color, Wonder Swan
CPU: ARM7TDMI @16.78MHz, Zilog Z80 @8/4MHz (backward compatibility)
Memory: 32KB RAM + 96KB VRAM (internal), 256KB RAM (external to CPU)
Display: TFT LCD 240×160
Audio: Dual 8-bit DAC + legacy Game Boy channels
Release date JP: 21 Mar '01 NA: 11 Jun '01 PAL: 22 Jun '01 CN: 08 Jun '04`,
  gbc: `Updated version of the original Game Boy
CPU: Sharp LR35902 core @4.19/8.38MHz
Memory: 32KB RAM + up to 128KB cartridge RAM, 16KB VRAM, up to 8MB cartridge ROM
Display: Color TFT LCD 160x144px
Audio: Custom chip (4 channels)
Release date JP: 21 Oct '98 NA: 18 Nov '98 PAL: 23 Nov '98 AU: 27 Nov '98`,
  mastersystem: `Sucessor and compatible to the SG-1000.
CPU: Zilog Z80A @4MHz
Memory: 8KB RAM, 16KB VRAM, 8KB ROM
Graphics: Yamaha YM2602B (256×192, 32 colors)
Audio: Yamaha PSG(SN76489), Yamaha YM2413 (JP)
Released NA: Sep,'86, JP: Oct,'87, EU:'87`,
  megadrive: `Successor to the Master System
CPU: Motorola 68000 @7.6MHz Zilog Z80 @3.58MHz
Memory: 64KB RAM, 64KB VRAM, 8KB audio RAM
Graphics: Yamaha YM7101 (320x224/320x240, 512 colors, 61 on-screen)
Audio: Yamaha YM2612 TI SN76489
Release date JP: 29 Oct '88 NA: 14 Aug '89 KOR: Aug '90 PAL: Sep '90 BRA: 01 Sep '90`,
  n64: `The Nintendo 64 was critically acclaimed upon release and remains one of the most recognized video game consoles.
CPU: 64-bit NEC VR4300 @93.75MHz
Memory: 4MB (8MB expansion pack) RAM, cartridge 4-64MB
Graphics: Reality Coprocessor @62.5MHz (up to 480i/576i, 16.7 mil. colors)
Audio: CPU/Reality Coprocessor, (16-bit, 48/44.1kHz)
Release date JP: 23 Jun '96 NA: 29 Sep '96 EU/AU: 01 Mar '97`,
  nes: `The best selling gaming console of its time
CPU: Ricoh 2A03 8-bit processor (MOS Technology 6502 core) @1.79Mhz
Memory: 2KB + potential cartridge RAM, 2KB VRAM, cartridge 8KB-1MB ROM
Graphics: Ricoh "Picture Processing Unit" (256x240, 25 colors)
Audio: 5 channels, potential additional chips on cartridge
Release date JP: 15 Jul '83 NA: 18 Oct '85 EU: 01 Sep '86 AU: '87`,
  naomi: `The NAOMI (New Arcade Operation Machine Idea) was designed as a successor to Sega Model 3 hardware and shares the architecture with the Sega Dreamcast.
CPU: Hitachi SH-4 32-bit RISC @200MHz
Memory: 32MB RAM, 16MB VRAM, 8MB audio RAM
Graphics: PowerVR2 @100MHz (640x480, 16,7 mi colors)
Audio: 45MHz Yamaha AICA 32-BIT ARM7 RISC CPU core, 64 ch
Release date: '98`,
  neogeo: `Released as arcade system and home console.
CPU: Motorola 68000 @12MHz + Zilog Z80 @4MHz
Memory: 214KB SRAM, 512KB ROM
Graphics: SNK custom video chipset (320×224, 65k colors)
Audio: Yamaha YM2610
Release date JP: 26 Apr '90 NA: 22 Aug '90 EU: '91`,
  ngpc: `Successor and compatible to Neo Geo Pocket
CPU: Toshiba TLCS900H @6.144MHz
Memory: 12KB RAM for 900H, 4KB RAM (Z80), 4KB tilemap RAM, 8KB character RAM, 64KB ROM
Display: 2.7" 160x152, 4096 colors
Audio: Zilog Z80 @3.072MHz, TI SN76489
Released JP: 16 Mar '99 NA: 06 Aug '99 EU: 01 Oct '99`,
  pc: `MS-DOS is an operating system for x86-based personal computers mostly developed by Microsoft.
Initial release 12 Aug '81`,
  pcengine: `TurboGrafx-16 Entertainment SuperSystem, known as PC Engine in JP/FR
CPU: Hudson Soft HuC6280 @7.16Mhz 8-bit
Memory: 8KB RAM, 64KB VRAM, cartridge
Graphics: 16-bit (up to 565×242, 482 colors)
Audio: 6 channel programmable sound generator
Release date JP: 30 Oct '87 NA: 29 Aug '89 FRA: 22 Nov '89 UK/SP: '90`,
  pcenginecd: `Add-on that allows the TurboGrafx-16 to play games in CD-ROM format
CPU: Hudson Soft HuC6280 @7.16Mhz 8-bit
Memory: 8KB RAM, 64KB VRAM, CD
Graphics: 16-bit (up to 565×242, 482 colors)
Audio: 6 channel programmable sound generator
Release date JP: 04 Dec '88 NA: Nov '89`,
  ps2: `The best-selling video game console of all time (155+ mil. units)
CPU: "Emotion Engine" @300MHz
Memory: 32MB RAM, 4MB VRAM, 40GB HDD, DVD drive
Graphics: Sony 150MHz "Graphics Synthesizer" (up to 1080i)
Audio: Various multi-channel formats
Release date JP: 04 Mar '00 NA: 26 Oct '00 EU: 24 Nov '00 AU: 30 Nov '00`,
  ps3: `7th generation console to compete against Microsoft's Xbox 360 and Nintendo's Wii
CPU: Cell Broadband Engine @3.2GHz
Memory: 256MB RAM, 256 MB VRAM, 20-500GB HDD, Blu-ray drive
Graphics: 550MHz "RSX Reality Synthesizer" (up to 1080p)
Audio: Various multi-channel formats
Release date JP: 11 Nov '06 NA: 17 Nov '06 EU: 23 Mar '07`,
  psx: `Created to compete with the N64 and the Sega Saturn.
CPU: R3000 @33.8688MHz
Memory: 2MB RAM, 1MB VRAM
Graphics: custom Toshiba rasterization chip (up to 640×480, 16.7 mil. colors)
Audio: 16-bit, 24 channels ADPCM
Release date JP: 03 Dec '94 NA: 09 Sep '95 EU: 29 Sep '95 AU: 15 Nov '95`,
  saturn: `Successor to the Genesis
CPU: 2×Hitachi SH-2 @28.6MHz
Memory: 2MB RAM, 1.5MB VRAM, 512KB audio RAM
Graphics: VDP1/VDP2 (up to 704×512, 16.7 mil. colors)
Audio: Motorola 68EC000, Yamaha YMF292
Release date JP: 22 Nov '94 NA: 11 May '95 EU: 18 Jul '95`,
  sega32x: `Add-on to expand the power of the Genesis until the release of the Sega Saturn
CPU: 2×Hitachi SH-2 32-bit RISC @23MHz
Memory: 256KB RAM, 256KB VRAM
Graphics: 320×240, 32,768 colors
Release date NA: 21 Nov '94 JP: 03 Dec '94 EU: Jan '95`,
  segacd: `CD-ROM add-on to the Megadrive, featuring full-motion video
CPU: Motorola 68000 @12.5MHz
Memory: 64kbit int. RAM, 1x-speed CD drive
Graphics: Custom chip
Audio: Ricoh RF5C164
Release date JP: 12 Dec '91 NA: 15 Oct '92 UK: 2 Apr '93 EU: '93`,
  sfc: `Successor to the Famicom
CPU: Ricoh 5A22 @3.58MHz
Memory: 128KB RAM, 64KB VRAM, 64KB audio RAM
Graphics: "Picture Processing Unit" custom chipset (up to 512×478, 256 colors)
Audio: "S-SMP" 8-bit CPU, 16-bit DSP
Release date JP: 21 Nov '90 KOR: 25 Nov '90 NA: 23 Aug '91 UK: 11 Apr '92 IRL: 10 Apr '92 EU: Jun '92 AU: 03 Jul '92 BR: Sep '92`,
  "sg-1000": `Sega's first entry into the home video game hardware business provided the basis for the more successful Master System.
CPU: 	Zilog Z80 @3.58 MHz
Memory: 1KB RAM, 16KB VRAM
Graphics: TI TMS9918A (256×192, 16 colors)
Audio: TI SN76489
Release date JP: 21 Nov '90 KOR: 25 Nov '90 NA: 23 Aug '91 UK: 11 Apr '92 IRL: 10 Apr '92 EU: Jun '92 AU: 03 Jul '92 BR: Sep '92`,
  snes: `Successor to the NES
CPU: Ricoh 5A22 @3.58MHz
Memory: 128KB RAM, 64KB VRAM, 64KB audio RAM
Graphics: "Picture Processing Unit" custom chipset (up to 512×478, 256 colors)
Audio: "S-SMP" 8-bit CPU, 16-bit DSP
Release date JP: 21 Nov '90 KOR: 25 Nov '90 NA: 23 Aug '91 UK: 11 Apr '92 IRL: 10 Apr '92 EU: Jun '92 AU: 03 Jul '92 BR: Sep '92`,
  switch: `Home and portable hybrid console
CPU: 64-bit ARM @1.02GHz
Memory: 4GB RAM, 32-64GB eMMC, up to 2TB ext. SD card
Graphics: Nvidia (Maxwell, 256 cores @307.2–768MHz)
Audio: PCM 5.1/2.0
Release date: 3 Mar '17`,
  vectrex: `A vector display-based home video game console, the only one ever designed and released for the home market.
CPU: Motorola MC68A09 @1.5MHz
Memory: 1KB RAM, 8KB ROM, 32KB Cartridge ROM
Display: 9" CRT
Graphics: all-analog vector generator
Audio: AY-3-8912
Release date NA: Nov, '82 EU: May '83 JP: Jun '83`,
  x68000: `The X68000 is a home computer, sold only in Japan. HW was very similar to arcade machines of the time
CPU: Motorola 68000 family @10-25Mhz
Memory: 1-8MB RAM, 20-80MB HDD
Graphics: Sharp-Hudson Custom Chipset
Audio: Yamaha YM2151 FM synthesizer, OKI MSM6258 PCM
OS: Human68k, NetBSD, OS-9
Release date: Mar '87`,
};
