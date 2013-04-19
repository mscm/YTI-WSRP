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
    Public Class ServiceDescription
        Public Shared Function ProcessGetServiceDescription(ByVal gsd As getServiceDescription) As WSRPSpec.ServiceDescription
            Dim sd As New WSRPSpec.ServiceDescription()
            sd.requiresRegistration = False
            sd.offeredPortlets = PortletHandler.GetPortletList()
            Return sd
        End Function
    End Class
End Namespace

