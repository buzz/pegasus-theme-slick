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

function restoreCollectionIndex() {
  const idx = api.memory.get("collectionIndex");
  if (typeof idx === "number" && idx >= 0) return idx;
  return 0;
}

function saveCollectionIndex() {
  api.memory.set("collectionIndex", currentCollectionIndex);
}

function restoreGameIndex() {
  const collection = collectionSearchFilter.get(currentCollectionIndex);
  if (collection && collection.shortName) {
    const idx = api.memory.get(`${collection.shortName}GameIndex`);
    if (typeof idx === "number" && idx >= 0) return idx;
  }
  return 0;
}

function saveGameIndex() {
  const collection = collectionSearchFilter.get(currentCollectionIndex);
  if (
    collection &&
    typeof collection.shortName === "string" &&
    collection.shortName.length > 0 &&
    typeof currentGameIndex === "number" &&
    currentGameIndex >= 0
  )
    api.memory.set(`${collection.shortName}GameIndex`, currentGameIndex);
}
