Set oFSO = CreateObject("Scripting.FileSystemObject")

Call doReplace("C:\xampp\htdocs\api\doc\html\geo__lookup_8php.html" , ".php File", " Method")
Call doReplace("C:\xampp\htdocs\api\doc\html\show__all_8php.html"   , ".php File", " Method")
Call doReplace("C:\xampp\htdocs\api\doc\html\geo__lookup_8php.html" , ">File"    , ">Method")
Call doReplace("C:\xampp\htdocs\api\doc\html\show__all_8php.html"   , ">File"    , ">Method")
Call doReplace("C:\xampp\htdocs\api\doc\html\globals_func.html"     , ">File"    , ">Method")
Call doReplace("C:\xampp\htdocs\api\doc\html\globals.html"          , ">File"    , ">Method")
Call doReplace("C:\xampp\htdocs\api\doc\html\index.html"            , ">File"    , ">Method")
Call doReplace("C:\xampp\htdocs\api\doc\html\files.html"            , ">File"    , ">Method")
Call doReplace("C:\xampp\htdocs\api\doc\html\globals_func.html"     , ".php"     , "")
Call doReplace("C:\xampp\htdocs\api\doc\html\globals.html"          , ".php"     , "")
Call doReplace("C:\xampp\htdocs\api\doc\html\files.html"            , ".php"     , "")





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
