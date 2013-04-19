Imports WSRP.Common
Imports WSRP.Common.Managers

Namespace WebParts
    Partial Public Class MyGrades
        Inherits System.Web.UI.UserControl
        Private ExceptionMan As New ExceptionManager
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                grdStudentTermGrades.DataSource = AcademicsManager.GetStudentTermGrades(_SyStudentID)
                grdStudentTermGrades.DataBind()
            Catch ex As Exception
                lblerror.Text = ExceptionManager.FormatError(ex)
                lblerror.Visible = True
                grdStudentTermGrades.Visible = False
            End Try
        End Sub

        Private Sub grdStudentTermGrades_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdStudentTermGrades.RowDataBound
            If e.Row.RowType = DataControlRowType.DataRow Then
                Dim gvStudentCourseGrades As GridView = CType(e.Row.FindControl("grdStudentCourseGrades"), GridView)
                gvStudentCourseGrades.DataSource = AcademicsManager.GetStudentCourseGrades(grdStudentTermGrades.DataKeys(e.Row.RowIndex).Value)
                gvStudentCourseGrades.DataBind()
                For Each row As GridViewRow In gvStudentCourseGrades.Rows
                    If row.RowType = DataControlRowType.DataRow Then
                        Dim gvStudentCourseLessonGrades As GridView = CType(row.FindControl("grdStudentCourseLessonGrades"), GridView)
                        gvStudentCourseLessonGrades.DataSource = AcademicsManager.GetStudentCourseLessonGrades(gvStudentCourseGrades.DataKeys(row.RowIndex).Value)
                        gvStudentCourseLessonGrades.DataBind()
                    End If
                Next
            End If
        End Sub

#Region "Properties"
        Private _SyStaffID As String
        Public Property SyStaffID() As String
            Get
                Return _SyStaffID
            End Get
            Set(ByVal value As String)
                _SyStaffID = value
            End Set
        End Property

        Private _SyStudentID As String
        Public Property SyStudentID() As String
            Get
                Return _SyStudentID
            End Get
            Set(ByVal value As String)
                _SyStudentID = value
            End Set
        End Property

        Private _StuNum As String
        Public Property StuNum() As String
            Get
                Return _StuNum
            End Get
            Set(ByVal value As String)
                _StuNum = value
            End Set
        End Property

        Private _UserCode As String
        Public Property UserCode() As String
            Get
                Return _UserCode
            End Get
            Set(ByVal value As String)
                _UserCode = value
            End Set
        End Property
#End Region

    End Class
End Namespace