'# by usptactical
'# usage:
'#   Put titles.txt (from wiitdb.com) and this script in your /wbfs dir and run (double-click) it.
'#
'#   This script will rename all folders named id* and *[id]* (e.g. 'id_title', '[id] title', 'xxx[id] yy')
'#   to 'title [id]'.  The title is taken from the titles.txt file, based on the 6-digit game id.  The
'#   script will also move any wbfs files from the root /wbfs folder into their own folders (auto-created
'#   if needed).

strInputFile = "titles1000.txt"
strExtensions = "wbfs,wbf1,wbf2,wbf3,wbf4"


Function ReadTextFileU8(strInputFile)
  Set fso1 = CreateObject("Scripting.FileSystemObject")
  If Not fso1.FileExists(strInputFile) Then
    WScript.Echo strInputFile & " not found!  Make sure you place it in THIS folder!!!"
    WScript.Quit(1)
  End If
  Set fso1 = nothing
  Set oStream = CreateObject("ADODB.Stream")
    oStream.Open
    oStream.Type = 2  'Set type to text
    oStream.CharSet = "utf-8"
    oStream.LoadFromFile(strInputFile)
    s = oStream.ReadText
    oStream.Close
  Set oStream = nothing  
  arrLines = Split(s, vbCrLf)
  ReadTextFileU8 = arrLines
End Function


Function CleanFolderName(strTitle)
  Set regEx = New RegExp
  regEx.IgnoreCase = True
  regEx.Global     = True
  'regEx.Pattern    =  "[&]"
  'strTitle = regEx.Replace(strTitle,"and")
  regEx.Pattern    =  "[/\\:]"
  strTitle = regEx.Replace(strTitle,"-")
  regEx.Pattern    =  "[*?""<>|]"
  CleanFolderName = regEx.Replace(strTitle," ")
End Function


Function getFolderName(arrTitles, f, parentFolder)
  strFname = f.name  'added by wiiwu for speed optmization
  strFgid_1 = left(strFname,6)
  strFgid_2 = mid(strFname,(instr(strFname,"["))+1,6)
  newFolderName = ""
  For Each strTitle in arrTitles
    If (len(strTitle) > 6) Then
		strGID = left(strTitle,6)
		If ( (strGID = strFgid_1) OR (strGID = strFgid_2) ) Then
			'WScript.Echo "Raw: " & strTitle
			strCleaned = CleanFolderName(strTitle)
			'WScript.Echo "Cleaned folder name: " & strCleaned
			newFolderName = parentFolder & "\" & mid(strCleaned, 10, len(strCleaned)) & " [" & strGID & "]"
			'WScript.Echo "New Folder full path: " & newFolderName
			Exit For
		End If
	End If
  Next
  getFolderName = newFolderName
End Function


'################################################

WScript.Echo "This can take some time to run so be patient and wait for the Done message!"
arrTitles = ReadTextFileU8(strInputFile)
count = 0
filecount = 0
Set fso = CreateObject("Scripting.FileSystemObject")
Set titles = fso.GetFile(strInputFile)
strParentFolder = titles.ParentFolder

Set f = fso.GetFolder(strParentFolder)
Set sf = f.SubFolders
For Each folder in sf
  if (len(folder.name) >= 6) Then
    strNewFolderName = getFolderName(arrTitles, folder, strParentFolder)
    if (len(strNewFolderName) > 0) Then
      Call fso.MoveFolder(folder.Path, strNewFolderName)
	  count = count + 1
	End If
  End If
Next

Set files = f.Files
For Each file in files
  if (len(file.Name) > 10) Then
    For Each strExt in split(ucase(strExtensions), ",")
      if (right(ucase(file.Path), len(strExt)+1) = "." & strExt) Then
        'wscript.echo "Creating folder name for file: " & file.Path
        strNewFolderName = getFolderName(arrTitles, file, strParentFolder)
        'wscript.echo "strNewFolderName: " & strNewFolderName
        if (len(strNewFolderName) > 0) Then
          if (fso.FolderExists(strNewFolderName) = false) Then
            Call fso.CreateFolder(strNewFolderName)
            'wscript.echo "Created folder: " & strNewFolderName
          End If
          'wscript.echo "Moving file '" & file.Path & "' to '" & strNewFolderName & "\" & file.Name & "'"
		  if (fso.FileExists(strNewFolderName & "\" & file.Name) = false) Then
		    Call fso.MoveFile(file.Path, strNewFolderName & "\" & file.Name)
            filecount = filecount + 1
          End If
        End If
        Exit For
      End If
    Next
  End If
Next

set files = nothing
set f = nothing
set sf = nothing
Set titles = nothing
Set fso = nothing
WScript.Echo "Done!  Renamed " & count & " folders and moved " & filecount & " files."
