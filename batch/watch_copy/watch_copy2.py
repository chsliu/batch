import os

import win32file
import win32con

ACTIONS = {
  1 : "Created",
  2 : "Deleted",
  3 : "Updated",
  4 : "Renamed from something",
  5 : "Renamed to something"
}
# Thanks to Claudio Grondi for the correct set of numbers
FILE_LIST_DIRECTORY = 0x0001

#path_to_watch = "."
path_to_watch = "Z:\\"

print "Watching " + path_to_watch + " ..."

hDir = win32file.CreateFile (
  path_to_watch,
  FILE_LIST_DIRECTORY,
  win32con.FILE_SHARE_READ | win32con.FILE_SHARE_WRITE,
  None,
  win32con.OPEN_EXISTING,
  win32con.FILE_FLAG_BACKUP_SEMANTICS,
  None
)
while 1:
  #
  # ReadDirectoryChangesW takes a previously-created
  #  handle to a directory, a buffer size for results,
  #  a flag to indicate whether to watch subtrees and
  #  a filter of what changes to notify.
  #
  # NB Tim Juchcinski reports that he needed to up
  #  the buffer size to be sure of picking up all
  #  events when a large number of files were
  #  deleted at once.
  #
  results = win32file.ReadDirectoryChangesW (
    hDir,
    1024,
    True,
    win32con.FILE_NOTIFY_CHANGE_FILE_NAME |
     win32con.FILE_NOTIFY_CHANGE_DIR_NAME |
     win32con.FILE_NOTIFY_CHANGE_ATTRIBUTES |
     win32con.FILE_NOTIFY_CHANGE_SIZE |
     win32con.FILE_NOTIFY_CHANGE_LAST_WRITE |
     win32con.FILE_NOTIFY_CHANGE_SECURITY,
    None,
    None
  )
  for action, file in results:
    full_filename = os.path.join (path_to_watch, file)
    print full_filename, ACTIONS.get (action, "Unknown")
