Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Caching
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.IO
Imports System.Reflection

Namespace Common.Managers
    Public Class ContentManager
        Public Shared Function RenderUserControl(ByVal path As String, ByVal Properties As Hashtable) As String
            Dim pageHolder As New Page()
            Dim formHolder As New HtmlForm()
            Try
                formHolder.Action = "#"
                formHolder.ID = "form1"
                Dim viewControl As UserControl = DirectCast(pageHolder.LoadControl(path), UserControl)
                For Each Prop As String In Properties.Keys
                    Dim propertyName As String = Prop
                    Dim propertyValue As Object = Properties.Item(Prop)
                    If propertyValue IsNot Nothing Then
                        Dim viewControlType As Type = viewControl.[GetType]()
                        Dim [property] As PropertyInfo = viewControlType.GetProperty(propertyName)

                        If [property] IsNot Nothing Then
                            [property].SetValue(viewControl, propertyValue, Nothing)
                        Else
                            Throw New Exception(String.Format("UserControl: {0} does not have a public {1} property.", path, propertyName))
                        End If
                    End If
                Next
                pageHolder.Controls.Add(formHolder)
                formHolder.Controls.Add(viewControl)
                Dim output As New StringWriter()
                HttpContext.Current.Server.Execute(pageHolder, output, False)
                Return output.ToString()
            Catch ex As Exception
                Throw New Exception("Error Rendering User Control", ex)
            End Try
        End Function

        Public Shared Function ParseString(ByVal BeginPhrase As String, ByVal EndPhrase As String, ByVal Source As String, ByVal includeBegin As Boolean, ByVal includeEnd As Boolean) As String()
            Dim result As String() = {"", ""}
            Dim iIndexOfBegin As Integer = Source.IndexOf(BeginPhrase)
            Try
                If iIndexOfBegin <> -1 Then
                    ' include the Begin string if desired 
                    If includeBegin Then
                        iIndexOfBegin -= BeginPhrase.Length
                    End If
                    Source = Source.Substring(iIndexOfBegin + BeginPhrase.Length)
                    Dim iEnd As Integer = Source.IndexOf(EndPhrase)
                    If iEnd <> -1 Then
                        ' include the End string if desired 
                        If includeEnd Then
                            iEnd += EndPhrase.Length
                        End If
                        result(0) = Source.Substring(0, iEnd)
                        ' advance beyond this segment 
                        If iEnd + EndPhrase.Length < Source.Length Then
                            result(1) = Source.Substring(iEnd + EndPhrase.Length)
                        End If
                    End If
                Else
                    ' stay where we are 
                    result(1) = Source
                End If
                Return result
            Catch ex As Exception
                Throw New Exception("Error Parsing String", ex)
            End Try
        End Function
    End Class
End Namespace

