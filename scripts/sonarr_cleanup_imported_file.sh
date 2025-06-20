#!/bin/bash

echo "[Torrent Cleanup] Executing clean up of ${sonarr_episodefile_sourcepath}."

# Simple script to delete imported tv episodes

if ! [[ -f "${sonarr_episodefile_sourcepath}" ]]; then
  echo "[Torrent Cleanup] File ${sonarr_episodefile_sourcepath} does not exist, exiting."
  exit
fi

rm "${sonarr_episodefile_sourcepath}"

echo "[Torrent Cleanup] Imported file ${sonarr_episodefile_sourcepath} removed from file system."
