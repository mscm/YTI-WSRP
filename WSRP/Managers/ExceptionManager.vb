Namespace Common.Managers
    Public Class ExceptionManager
        Public Shared Function FormatError(ByVal ex As Exception) As String
            Dim ErrorHTML As String = String.Empty
            If Not ex Is Nothing Then
                ErrorHTML = "<table><tr><td align=""""center"""">There has been an error processing your request!!!</td></tr>"
                ErrorHTML &= "<tr><td align=""""left"""">Message: " & ex.Message.ToString() & "</td></tr>"
                If Not ex.InnerException Is Nothing Then
                    ErrorHTML &= "<tr><td align=""""left"""">Inner Exception Message: " & ex.InnerException.Message.ToString() & "</td></tr>"
                    ErrorHTML &= "<tr><td align=""""left"""">Inner Exception Source: " & ex.InnerException.Source.ToString() & "</td></tr>"
                    ErrorHTML &= "<tr><td align=""""left"""">Inner Exception Target: " & ex.InnerException.TargetSite.ToString() & "</td></tr>"
                    ErrorHTML &= "<tr><td align=""""left"""">Inner Exception Stack Trace: " & ex.InnerException.StackTrace.ToString() & "</td></tr>"
                End If
                ErrorHTML &= "</table>"
            End If
            Return ErrorHTML
        End Function
    End Class
End Namespace
