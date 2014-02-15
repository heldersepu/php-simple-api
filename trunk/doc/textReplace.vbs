Set oFSO = CreateObject("Scripting.FileSystemObject")
htmlPath = "C:\xampp\htdocs\api\doc\html"
Call doReplace(htmlPath & "\geo__lookup_8php.html" , ".php File", " Method")
Call doReplace(htmlPath & "\show__all_8php.html"   , ".php File", " Method")
Call doReplace(htmlPath & "\kml__update_8php.html" , ".php File", " Method")
Call doReplace(htmlPath & "\geo__lookup_8php.html" , ">File"    , ">Method")
Call doReplace(htmlPath & "\show__all_8php.html"   , ">File"    , ">Method")
Call doReplace(htmlPath & "\kml__update_8php.html" , ">File"    , ">Method")

Call doReplace(htmlPath & "\globals_func.html"     , ">File"    , ">Method")
Call doReplace(htmlPath & "\globals.html"          , ">File"    , ">Method")
Call doReplace(htmlPath & "\index.html"            , ">File"    , ">Method")
Call doReplace(htmlPath & "\files.html"            , ">File"    , ">Method")
Call doReplace(htmlPath & "\globals_func.html"     , ".php"     , "")
Call doReplace(htmlPath & "\globals.html"          , ".php"     , "")
Call doReplace(htmlPath & "\files.html"            , ".php"     , "")




Sub doReplace(strFile, strSearch, strReplace)
    If Not oFSO.FileExists(strFile) Then
        WScript.Echo "Specified file does not exist."
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
