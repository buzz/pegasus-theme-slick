function restoreOptions() {
  let sortIndexCollections = api.memory.get("sortIndexCollections");
  let sortIndexGamelist = api.memory.get("sortIndexGamelist");

  if (typeof sortIndexCollections !== "number" || sortIndexCollections < 0) {
    sortIndexCollections = 0;
  }
  if (typeof sortIndexGamelist !== "number" || sortIndexGamelist < 0) {
    sortIndexGamelist = 0;
  }

  return {
    sortIndexCollections,
    sortIndexGamelist,
  };
}

function saveOptions(opts) {
  api.memory.set("sortIndexCollections", opts.sortIndexCollections);
  api.memory.set("sortIndexGamelist", opts.sortIndexGamelist);
}

function restoreCollection() {
  const shortName = api.memory.get("collectionShortName");
  if (typeof shortName === "string" && shortName.length) return shortName;
  return "";
}

function saveCollection() {
  const collection = collectionSearchFilter.get(currentCollectionIndex);
  if (collection && collection.shortName)
    api.memory.set("collectionShortName", collection.shortName);
}

function restoreGame() {
  const collection = collectionSearchFilter.get(currentCollectionIndex);
  if (collection && collection.shortName) {
    const gamePath = api.memory.get(`${collection.shortName}GamePath`);
    if (typeof gamePath === "string" && gamePath.length > 0) return gamePath;
  }
  return "";
}

function saveGame() {
  const collection = collectionSearchFilter.get(currentCollectionIndex);
  if (
    collection &&
    typeof collection.shortName === "string" &&
    collection.shortName.length > 0 &&
    typeof currentGameIndex === "number" &&
    currentGameIndex >= 0
  ) {
    const game = gamelistSearchFilter.get(currentGameIndex);
    if (game && game.files && game.files.count)
      api.memory.set(`${collection.shortName}GamePath`, game.files.get(0).path);
  }
}

function isGameLaunch() {
  if (api.memory.has("gameLaunch")) {
    api.memory.unset("gameLaunch");
    return true;
  }
  return false;
}

function saveGameLaunch() {
  api.memory.set("gameLaunch", true);
}
