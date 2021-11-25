// This file contains some helper scripts for formatting data

// For multiplayer games, show the player count as '1-N'
function formatPlayers(playerCount) {
  if (playerCount === 1) return playerCount;

  return "1-" + playerCount;
}

// Show dates in Y-M-D format
function formatDate(date) {
  return Qt.formatDate(date, "yyyy");
}

// Show last played time as text. Based on the code of the default Pegasus theme.
// Note to self: I should probably move this into the API.
function formatLastPlayed(lastPlayed) {
  if (isNaN(lastPlayed)) return "never";

  var now = new Date();

  var elapsedHours = (now.getTime() - lastPlayed.getTime()) / 1000 / 60 / 60;
  if (elapsedHours < 24 && now.getDate() === lastPlayed.getDate())
    return "today";

  var elapsedDays = Math.round(elapsedHours / 24);
  if (elapsedDays <= 1) return "yesterday";

  return elapsedDays + " days ago";
}

// Display the play time (provided in seconds) with text.
// Based on the code of the default Pegasus theme.
// Note to self: I should probably move this into the API.
function formatPlayTime(playTime) {
  var minutes = Math.ceil(playTime / 60);
  if (minutes <= 90) return Math.round(minutes) + " Mins";

  return parseFloat((minutes / 60).toFixed(1)) + " Hours";
}

function systemColor(input_str) {
  var colorDict = {
    nes: "#ED1C24",
    snes: "#514689",
    n64: "#21397B",
    megadrive: "#17569B",
    mastersystem: "#17569B",
    neogeo: "#E60012",
    gba: "#14017C",
    gamecube: "#6545B2",
    n64: "#069330",
    pcengine: "#FFC001",
    gamegear: "#BD0E6D",
    fce: "#F0D878",
  };

  if (input_str in colorDict) return colorDict[input_str];

  var colors = [
    "#711521",
    "#C1121C",
    "#F7BA0B",
    "#007243",
    "#00387B",
    "#514689",
    "#17569b",
    "#00C3E3",
    "#E60012",
    "#FFC001",
  ];
  var colorCount = colors.length;

  // From: https://www.raphnet.net/design/console_colors/index.php
  // Famicom #711521
  // NES #C1121C
  // SNES RED #C1121C
  // SNES YELLOW #F7BA0B
  // SNES GREEN #007243
  // SNES BLUE #00387b
  // SNES A/B #514689
  // SNES Y/X #a7a4e0
  // SEGA BLUE: #17569b

  // SNES CONSOLE GREY #b2b4b2
  // SNES DPAD GRAY #54585a
  // SNES BUTTON ZONE GRAY #707372

  // Switch Red: #e60012
  // Switch Neon Blue: #00c3e3
  // https://www.colourlovers.com/palette/1898124/N64
  // https://www.colourlovers.com/palette/505965/gamecube
  // https://www.colourlovers.com/palette/4623974/Sega_Game_Gear
  // https://www.colourlovers.com/palette/1111121/Famicom

  var seed = input_str.charCodeAt(0) ^ input_str.charCodeAt(1);
  var moduloPosition = seed % colorCount;
  return colors[moduloPosition];
}
