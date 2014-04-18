Set oFSO = CreateObject("Scripting.FileSystemObject")
htmlPath = "C:\xampp\htdocs\api\doc\html"
Set Fldr = oFSO.GetFolder(htmlPath)
For Each File In Fldr.Files
	If LCase(Right(File,5))= ".html"  Then
		Call doReplace(File , ">File"    , ">Method")		
		If LCase(Right(File,8))= "php.html"  Then
			Call doReplace(File , ".php File", " Method")
		End If
		Call doReplace(File, ".php", "")
		Call doReplace(File, "documented files", "methods")
	End If
Next

WScript.Echo "ALL DONE!"


Sub doReplace(strFile, strSearch, strReplace)
    If Not oFSO.FileExists(strFile) Then
        WScript.Echo "Specified file does not exist: " & strFile
    Else
        Set oFile = oFSO.OpenTextFile(strFile, 1)
        strText = oFile.ReadAll
        oFile.Close
        strText = Replace(strText, strSearch, strReplace, 1, -1, 1)
        Set oFile = oFSO.OpenTextFile(strFile, 2)
        oFile.WriteLine strText
        oFile.Close
    End If
End Sub
