Imports System.Configuration
Imports System.Web
Imports System.Web.Caching
Imports System.Xml
Imports System.Collections
Imports System.IO
Imports WSRP.WSRPSpec

Namespace Common.CacheManager
    Public Class CacheData
        Public Shared Sub RefreshPortletList(ByVal c As Cache)
            Try
                Dim sFilePath As String = HttpRuntime.AppDomainAppPath & "WSRP\PortletList.xml"
                If Not File.Exists(sFilePath) Then
                    Throw New Exception("File Doesn't Exist:" & sFilePath)
                End If

                Dim doc As New XmlDocument()
                doc.Load(sFilePath)
                Dim xnl As XmlNodeList = doc.SelectNodes("//Portlets/Portlet")
                If xnl.Count = 0 Then
                    Exit Sub
                End If

                Dim al As New ArrayList()


                For i As Integer = 0 To xnl.Count - 1

                    Dim xn As XmlNode = xnl(i)
                    Dim sName As String = xn("Name").InnerText
                    Dim sHandle As String = xn("Handle").InnerText
                    Dim sTitle As String = sName
                    If xn("Title") IsNot Nothing Then
                        sTitle = xn("Title").InnerText
                    End If
                    Dim sDesc As String = sName
                    If xn("Description") IsNot Nothing Then
                        sDesc = xn("Description").InnerText
                    End If


                    Dim pe As New PortletDescription()

                    Dim lsDisplay As New LocalizedString()
                    lsDisplay.value = sName
                    pe.displayName = lsDisplay
                    pe.title = GetLocalString(sTitle)
                    pe.description = GetLocalString(sDesc)

                    pe.portletHandle = sHandle
                    al.Add(pe)
                Next

                Dim peList As PortletDescription() = DirectCast(al.ToArray(GetType(PortletDescription)), PortletDescription())

                c(CacheConstants.PORTLET_LIST) = peList
            Catch ex As Exception
                Throw ex
            End Try
        End Sub
        Private Shared Function GetLocalString(ByVal sValue As String) As LocalizedString
            Dim ls As New LocalizedString()
            ls.value = sValue
            Return ls
        End Function
    End Class
End Namespace

