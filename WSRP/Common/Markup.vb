Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Xml
Imports WSRP.WSRPSpec

Namespace Common
    Public Class Markup
        Public Shared Function GetParamValue(ByVal xeList As XmlElement(), ByVal sName As String) As String
            For i As Integer = 0 To xeList.Length - 1
                If xeList(i).Name.ToLower() = sName.ToLower() Then
                    Return xeList(i).InnerText
                End If
            Next
            Return ""
        End Function
    End Class
End Namespace

