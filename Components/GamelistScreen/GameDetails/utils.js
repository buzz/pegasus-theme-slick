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
  if (elapsedHours < 24 && now.getDate() === lastPlayed.getDate()) return "today";

  var elapsedDays = Math.round(elapsedHours / 24);
  if (elapsedDays <= 1) return "yesterday";

  return `${elapsedDays} days ago`;
}

// Display the play time (provided in seconds) with text.
// Based on the code of the default Pegasus theme.
// Note to self: I should probably move this into the API.
function formatPlayTime(playTime) {
  var minutes = Math.ceil(playTime / 60);
  if (minutes <= 90) return `${Math.round(minutes)} Mins`;

  return `${parseFloat((minutes / 60).toFixed(1))}  Hours`;
}
