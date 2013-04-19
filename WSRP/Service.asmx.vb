Imports System
Imports System.Data
Imports System.Web
Imports System.Configuration
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Collections
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel
Imports System.Xml
Imports WSRP.WSRPSpec
Imports WSRP.Common
Imports WSRP.Common.Markup
Imports WSRP.Common.Managers
Imports System.Reflection
Imports System.IO
Namespace WSRP
    <WebService([Description]:="Returns the HTML markup from a Web User Control Web Part", [Namespace]:="urn:oasis:names:tc:wsrp:v1:bind")> _
    <WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1, Name:="WSRP_v1_Binding_SOAP", [Namespace]:="urn:oasis:names:tc:wsrp:v1:bind")> _
    <ToolboxItem(False)> _
    Public Class Service
        Inherits System.Web.Services.WebService

        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:getServiceDescription", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
    <WebMethod()> _
        Public Function getServiceDescription(<System.Xml.Serialization.XmlElementAttribute("getServiceDescription", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> ByVal gsd As getServiceDescription) As <System.Xml.Serialization.XmlElementAttribute("getServiceDescriptionResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> Common.WSRPSpec.ServiceDescription
            Return Common.ServiceDescription.ProcessGetServiceDescription(gsd)
        End Function

        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:getMarkup", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function getMarkup(<System.Xml.Serialization.XmlElementAttribute("getMarkup", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> ByVal gm As getMarkup) As <System.Xml.Serialization.XmlElementAttribute("getMarkupResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> MarkupResponse
            Try
                Dim Portlet As String = gm.portletContext.portletHandle
                Dim mr As New MarkupResponse()
                Dim Params As New Hashtable
                Params.Add("SyStudentID", GetParamValue(gm.markupParams.extensions, WSRPMarkupParams.STUDENT_ID))
                Params.Add("StuNum", GetParamValue(gm.markupParams.extensions, WSRPMarkupParams.STUDENT_NUMBER))
                Params.Add("SyStaffID", GetParamValue(gm.markupParams.extensions, WSRPMarkupParams.STAFF_ID))
                Params.Add("UserCode", GetParamValue(gm.markupParams.extensions, WSRPMarkupParams.USER_CODE))
                mr.markupContext = New MarkupContext()
                mr.markupContext.markupString = ContentManager.ParseString("<!--StartControl-->", "<!--EndControl-->", ContentManager.RenderUserControl("/WSRP/WebParts/" & Portlet & ".ascx", Params), False, False)(0)
                Return mr
            Catch ex As Exception
                Dim mr As New MarkupResponse()
                mr.markupContext.markupString = "Error: " & ex.ToString()
                Return mr
            End Try
        End Function

        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:modifyRegistration", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function modifyRegistration(ByVal modifyRegistration1 As modifyRegistration) As <System.Xml.Serialization.XmlElementAttribute("modifyRegistrationResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> RegistrationState
            Return Nothing
        End Function
        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:deregister", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function deregister(ByVal deregister1 As RegistrationContext) As <System.Xml.Serialization.XmlArrayAttribute("deregisterResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> <System.Xml.Serialization.XmlArrayItemAttribute("extensions", IsNullable:=False)> System.Xml.XmlElement()
            Return Nothing
        End Function

        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:register", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function register(ByVal register1 As RegistrationData) As <System.Xml.Serialization.XmlElementAttribute("registerResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> RegistrationContext
            Return Nothing
        End Function

        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:getPortletPropertyDescription", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function getPortletPropertyDescription(ByVal getPortletPropertyDescription1 As getPortletPropertyDescription) As <System.Xml.Serialization.XmlElementAttribute("getPortletPropertyDescriptionResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> PortletPropertyDescriptionResponse
            Return Nothing
        End Function

        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:getPortletProperties", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function getPortletProperties(ByVal getPortletProperties1 As getPortletProperties) As <System.Xml.Serialization.XmlElementAttribute("getPortletPropertiesResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> PropertyList
            Return Nothing
        End Function

        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:setPortletProperties", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function setPortletProperties(ByVal setPortletProperties1 As setPortletProperties) As <System.Xml.Serialization.XmlElementAttribute("setPortletPropertiesResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> PortletContext
            Return Nothing
        End Function

        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:destroyPortlets", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function destroyPortlets(ByVal destroyPortlets1 As destroyPortlets) As <System.Xml.Serialization.XmlElementAttribute("destroyPortletsResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> DestroyPortletsResponse
            Return Nothing
        End Function

        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:clonePortlet", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function clonePortlet(ByVal clonePortlet1 As clonePortlet) As <System.Xml.Serialization.XmlElementAttribute("clonePortletResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> PortletContext
            Return Nothing
        End Function

        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:getPortletDescription", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function getPortletDescription(ByVal getPortletDescription1 As getPortletDescription) As <System.Xml.Serialization.XmlElementAttribute("getPortletDescriptionResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> PortletDescriptionResponse
            Return Nothing
        End Function


        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:initCookie", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function initCookie(ByVal initCookie1 As initCookie) As <System.Xml.Serialization.XmlArrayAttribute("initCookieResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> <System.Xml.Serialization.XmlArrayItemAttribute("extensions", IsNullable:=False)> System.Xml.XmlElement()
            Return Nothing
        End Function

        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:releaseSessions", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function releaseSessions(ByVal releaseSessions1 As releaseSessions) As <System.Xml.Serialization.XmlArrayAttribute("releaseSessionsResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> <System.Xml.Serialization.XmlArrayItemAttribute("extensions", IsNullable:=False)> System.Xml.XmlElement()
            Return Nothing
        End Function

        <WebMethod()> _
        <SoapDocumentMethod(Action:="urn:oasis:names:tc:wsrp:v1:performBlockingInteraction", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=SoapParameterStyle.Bare)> _
        Public Function performBlockingInteraction(<System.Xml.Serialization.XmlElementAttribute("performBlockingInteraction", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> ByVal performBlockingInteraction1 As performBlockingInteraction) As <System.Xml.Serialization.XmlElementAttribute("performBlockingInteractionResponse", [Namespace]:="urn:oasis:names:tc:wsrp:v1:types")> BlockingInteractionResponse
            Return Nothing
        End Function

    End Class
End Namespace