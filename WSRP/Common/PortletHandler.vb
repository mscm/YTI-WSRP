Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports WSRP.WSRPSpec

Namespace Common
    Public Class PortletHandler
        Public Shared Function GetPortletList() As PortletDescription()
            Return AppCache.GetPortletList()
        End Function
        Public Shared Function IsValidPortlet(ByVal sHandle As String) As Boolean
            Dim pdList As PortletDescription() = GetPortletList()
            For i As Integer = 0 To pdList.Length - 1
                Dim pd As PortletDescription = pdList(i)
                If pd.portletHandle.Trim() = sHandle.Trim() Then
                    Return True
                End If
            Next
            Return False
        End Function
    End Class
End Namespace

