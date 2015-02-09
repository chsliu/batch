Set updateSession = CreateObject("Microsoft.Update.Session")
updateSession.ClientApplicationID = "MSDN Sample Script"

Set updateSearcher = updateSession.CreateUpdateSearcher()

WScript.Echo "Searching for updates..."

Set searchResult = _
updateSearcher.Search("IsInstalled=0 and Type='Software' and IsHidden=0")

'WScript.Echo "List of applicable items on the machine:"
'
'For I = 0 To searchResult.Updates.Count-1
'    Set update = searchResult.Updates.Item(I)
'    WScript.Echo I + 1 & "> " & update.Title
'Next

If searchResult.Updates.Count = 0 Then
    WScript.Echo "There are no applicable updates."
	'Pause
    WScript.Quit
End If

WScript.Echo vbCRLF & "Creating collection of updates to download:"

Set updatesToDownload = CreateObject("Microsoft.Update.UpdateColl")

For I = 0 to searchResult.Updates.Count-1
    Set update = searchResult.Updates.Item(I)
    addThisUpdate = false
    If update.InstallationBehavior.CanRequestUserInput = true Then
        WScript.Echo I + 1 & "> skipping: " & update.Title & _
        " because it requires user input"
    Else
        If update.EulaAccepted = false Then
            WScript.Echo I + 1 & "> note: " & update.Title & _
            " has a license agreement that must be accepted:"
            WScript.Echo update.EulaText
            WScript.Echo "Do you accept this license agreement? (Y/N)"
            strInput = WScript.StdIn.Readline
            WScript.Echo 
            If (strInput = "Y" or strInput = "y") Then
                update.AcceptEula()
                addThisUpdate = true
            Else
                WScript.Echo I + 1 & "> skipping: " & update.Title & _
                " because the license agreement was declined"
            End If
        Else
            addThisUpdate = true
        End If
    End If
    If addThisUpdate = true Then
        'WScript.Echo I + 1 & "> adding: " & update.Title 
        updatesToDownload.Add(update)
    End If
Next

If updatesToDownload.Count = 0 Then
    WScript.Echo "All applicable updates were skipped."
	'Pause
    WScript.Quit
End If
    
WScript.Echo vbCRLF & "Downloading updates..."

Set downloader = updateSession.CreateUpdateDownloader() 
'downloader.Updates = updatesToDownload
'downloader.Download()
Dim failCount
failCount = 0
For I = 0 To updatesToDownload.Count-1
	WScript.StdOut.Write "[" & I + 1 & "/" & updatesToDownload.Count & "] " & updatesToDownload(I).Title & " -> "
	Set list = CreateObject("Microsoft.Update.UpdateColl")
	list.Add(updatesToDownload(I))
	downloader.Updates = list
	Set downloadResult = downloader.Download()
	ResultPrint(downloadResult.ResultCode)
	WScript.Echo "" 'downloadResult.ResultCode
	If downloadResult.ResultCode = 4 Then
	  failCount = failCount + 1
	End If
Next
If failCount > 0 Then
	WScript.Echo vbCRLF & "!!! Download failed count: " & failCount & " !!!"
End If	

Set updatesToInstall = CreateObject("Microsoft.Update.UpdateColl")

rebootMayBeRequired = false

'WScript.Echo vbCRLF & "Successfully downloaded updates:"

For I = 0 To searchResult.Updates.Count-1
    set update = searchResult.Updates.Item(I)
    If update.IsDownloaded = true Then
        'WScript.Echo I + 1 & "> " & update.Title 
        updatesToInstall.Add(update) 
        If update.InstallationBehavior.RebootBehavior > 0 Then
            rebootMayBeRequired = true
        End If
    End If
Next

If updatesToInstall.Count = 0 Then
    WScript.Echo "No updates were successfully downloaded."
	'Pause
    WScript.Quit
End If

If rebootMayBeRequired = true Then
    WScript.Echo vbCRLF & "!!! These updates may require a reboot. !!!"
End If

'WScript.Echo  vbCRLF & "Would you like to install updates now? (Y/N)"
'strInput = WScript.StdIn.Readline
'WScript.Echo 
strInput = "y"

If (strInput = "Y" or strInput = "y") Then
    WScript.Echo vbCRLF & "Installing updates..."
    Set installer = updateSession.CreateUpdateInstaller()
    'installer.Updates = updatesToInstall
    'Set installationResult = installer.Install()
	failCount = 0
	For I = 0 To updatesToInstall.Count-1
		WScript.StdOut.Write "[" & I + 1 & "/" & updatesToDownload.Count & "] " & updatesToInstall(I).Title & " -> "
		Set list = CreateObject("Microsoft.Update.UpdateColl")
		list.Add(updatesToInstall(I))
		installer.Updates = list
		Set installationResult = installer.Install()
		'WScript.StdOut.Write " Result: " '& installationResult.ResultCode 
		ResultPrint(installationResult.ResultCode)
		If installationResult.RebootRequired Then
			WScript.Echo ", Reboot Required"
		Else
			WScript.Echo ""
		End If
		If installationResult.ResultCode = 4 Then
			failCount = failCount + 1
		End If
	Next
	If failCount > 0 Then
		WScript.Echo vbCRLF & "!!! Installation failed count: " & failCount & " !!!"
	End If	
 
    'Output results of install
    'WScript.Echo "Installation Result: " & _
    'installationResult.ResultCode 
    'WScript.Echo "Reboot Required: " & _ 
    'installationResult.RebootRequired & vbCRLF 
    'WScript.Echo "Listing of updates installed " & _
    '"and individual installation results:" 
 
    'For I = 0 to updatesToInstall.Count - 1
    '    WScript.Echo I + 1 & "> " & _
    '    updatesToInstall.Item(i).Title & _
    '    ": " & installationResult.GetUpdateResult(i).ResultCode   
    'Next
End If

'Pause

Sub ResultPrint(r)
  Select Case r
    Case 0
	  WScript.StdOut.Write "Not Started"
    Case 1
	  WScript.StdOut.Write "InProgress"
    Case 2
	  WScript.StdOut.Write "Succeeded"
    Case 3
	  WScript.StdOut.Write "Succeeded With Errors"
    Case 4
	  WScript.StdOut.Write "Failed"
    Case 5
	  WScript.StdOut.Write "Aborted"
  End Select
End Sub

Sub Pause()
	WScript.StdOut.Write "Press ENTER to continue . . ."
	WScript.StdIn.Readline
End Sub
