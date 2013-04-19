Imports WSRP.Common
Imports WSRP.Common.Managers

Namespace WebParts
    Partial Public Class MyAttendance
        Inherits System.Web.UI.UserControl
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Try
                grdStudentAttendanceTerm.DataSource = AcademicsManager.GetStudentAttendanceTerm(_SyStudentID)
                grdStudentAttendanceTerm2.DataSource = AcademicsManager.GetStudentAttendanceTerm(_SyStudentID)
                grdStudentAttendanceTerm.DataBind()
                grdStudentAttendanceTerm2.DataBind()
            Catch ex As Exception
                lblerror.Text = ExceptionManager.FormatError(ex)
                lblerror.Visible = True
                grdStudentAttendanceTerm.Visible = False
                grdStudentAttendanceTerm2.Visible = False
            End Try
        End Sub

        Private Sub grdAttendance_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdStudentAttendanceTerm.RowDataBound
            Try
                If e.Row.RowType = DataControlRowType.Header Then
                    Dim row As New GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal)
                    Dim cell As New TableCell
                    cell.ColumnSpan = 6
                    cell.HorizontalAlign = HorizontalAlign.Center
                    row.Cells.Add(cell)
                    cell = New TableCell
                    cell.ColumnSpan = 2
                    cell.HorizontalAlign = HorizontalAlign.Center
                    cell.Text = "Attendance"
                    row.Cells.Add(cell)
                    cell = New TableCell
                    cell.ColumnSpan = 3
                    cell.HorizontalAlign = HorizontalAlign.Center
                    cell.Text = "Tardy"
                    row.Cells.Add(cell)
                    cell = New TableCell
                    cell.ColumnSpan = 3
                    cell.HorizontalAlign = HorizontalAlign.Center
                    cell.Text = "Left Class Early"
                    row.Cells.Add(cell)
                    grdStudentAttendanceTerm.Controls(0).Controls.AddAt(0, row)
                ElseIf e.Row.RowType = DataControlRowType.DataRow Then
                    Dim Total As Decimal = DataBinder.Eval(e.Row.DataItem, "Attend") + DataBinder.Eval(e.Row.DataItem, "Absent")
                    Dim HoursMissed As Decimal = DataBinder.Eval(e.Row.DataItem, "Absent")
                    If Total <> 0.0 Or HoursMissed <> 0.0 Then
                        If (HoursMissed / Total) >= 0.08 And (HoursMissed / Total) < 0.1 Then
                            CType(e.Row.FindControl("imgStatus"), Image).ImageUrl = "/Public/global/images/icons/yellow_light.gif"
                        ElseIf (HoursMissed / Total) >= 0.1 Then
                            CType(e.Row.FindControl("imgStatus"), Image).ImageUrl = "/Public/global/images/icons/red_light.gif"
                        End If
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "AttendanceWarning") = 0 Then
                        CType(e.Row.FindControl("imgAttendanceWarning"), Image).Visible = False
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "AttendanceProbation") = 0 Then
                        CType(e.Row.FindControl("imgAttendanceProbation"), Image).Visible = False
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "TardyWarning") = 0 Then
                        CType(e.Row.FindControl("imgTardyWarning"), Image).Visible = False
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "TardyProbation") = 0 Then
                        CType(e.Row.FindControl("imgTardyProbation"), Image).Visible = False
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "LeftClassEarlyWarning") = 0 Then
                        CType(e.Row.FindControl("imgLeftClassEarlyWarning"), Image).Visible = False
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "LeftClassEarlyProbation") = 0 Then
                        CType(e.Row.FindControl("imgLeftClassEarlyProbation"), Image).Visible = False
                    End If
                    Dim gvStudentAttendanceTermCourse As GridView = CType(e.Row.FindControl("grdStudentAttendanceTermCourse"), GridView)
                    gvStudentAttendanceTermCourse.DataSource = AcademicsManager.GetStudentAttendanceTermCourse(grdStudentAttendanceTerm.DataKeys(e.Row.RowIndex).Value)
                    gvStudentAttendanceTermCourse.DataBind()
                    For Each row As GridViewRow In gvStudentAttendanceTermCourse.Rows
                        If row.RowType = DataControlRowType.DataRow Then
                            Dim gvStudentAttendanceTermCourseDay As GridView = CType(row.FindControl("grdStudentAttendanceTermCourseDay"), GridView)
                            gvStudentAttendanceTermCourseDay.DataSource = AcademicsManager.GetStudentAttendanceTermCourseDay(gvStudentAttendanceTermCourse.DataKeys(row.RowIndex).Value)
                            gvStudentAttendanceTermCourseDay.DataBind()
                        End If
                    Next
                End If
            Catch ex As Exception
                lblerror.Text = ExceptionManager.FormatError(ex)
                lblerror.Visible = True
                grdStudentAttendanceTerm.Visible = False
                grdStudentAttendanceTerm2.Visible = False
            End Try
        End Sub

        Private Sub grdStudentAttendanceTerm2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdStudentAttendanceTerm2.RowDataBound
            Try
                If e.Row.RowType = DataControlRowType.Header Then
                    Dim row As New GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal)
                    Dim cell As New TableCell
                    cell.ColumnSpan = 6
                    cell.HorizontalAlign = HorizontalAlign.Center
                    row.Cells.Add(cell)
                    cell = New TableCell
                    cell.ColumnSpan = 2
                    cell.HorizontalAlign = HorizontalAlign.Center
                    cell.Text = "Attendance"
                    row.Cells.Add(cell)
                    cell = New TableCell
                    cell.ColumnSpan = 3
                    cell.HorizontalAlign = HorizontalAlign.Center
                    cell.Text = "Tardy"
                    row.Cells.Add(cell)
                    cell = New TableCell
                    cell.ColumnSpan = 3
                    cell.HorizontalAlign = HorizontalAlign.Center
                    cell.Text = "Left Class Early"
                    row.Cells.Add(cell)
                    grdStudentAttendanceTerm2.Controls(0).Controls.AddAt(0, row)
                ElseIf e.Row.RowType = DataControlRowType.DataRow Then
                    Dim Total As Decimal = DataBinder.Eval(e.Row.DataItem, "Attend") + DataBinder.Eval(e.Row.DataItem, "Absent")
                    Dim HoursMissed As Decimal = DataBinder.Eval(e.Row.DataItem, "Absent")
                    If Total <> 0.0 Or HoursMissed <> 0.0 Then
                        If (HoursMissed / Total) >= 0.08 And (HoursMissed / Total) < 0.1 Then
                            CType(e.Row.FindControl("imgStatus"), Image).ImageUrl = "/Public/global/images/icons/yellow_light.gif"
                        ElseIf (HoursMissed / Total) >= 0.1 Then
                            CType(e.Row.FindControl("imgStatus"), Image).ImageUrl = "/Public/global/images/icons/red_light.gif"
                        End If
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "AttendanceWarning") = 0 Then
                        CType(e.Row.FindControl("imgAttendanceWarning"), Image).Visible = False
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "AttendanceProbation") = 0 Then
                        CType(e.Row.FindControl("imgAttendanceProbation"), Image).Visible = False
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "TardyWarning") = 0 Then
                        CType(e.Row.FindControl("imgTardyWarning"), Image).Visible = False
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "TardyProbation") = 0 Then
                        CType(e.Row.FindControl("imgTardyProbation"), Image).Visible = False
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "LeftClassEarlyWarning") = 0 Then
                        CType(e.Row.FindControl("imgLeftClassEarlyWarning"), Image).Visible = False
                    End If
                    If DataBinder.Eval(e.Row.DataItem, "LeftClassEarlyProbation") = 0 Then
                        CType(e.Row.FindControl("imgLeftClassEarlyProbation"), Image).Visible = False
                    End If
                    Dim gvStudentAttendanceTermDay As GridView = CType(e.Row.FindControl("grdStudentAttendanceTermDay"), GridView)
                    gvStudentAttendanceTermDay.DataSource = AcademicsManager.GetStudentAttendanceTermDay(grdStudentAttendanceTerm2.DataKeys(e.Row.RowIndex).Value)
                    gvStudentAttendanceTermDay.DataBind()
                    For Each row As GridViewRow In gvStudentAttendanceTermDay.Rows
                        If row.RowType = DataControlRowType.DataRow Then
                            Dim gvStudentAttendanceTermDayCourse As GridView = CType(row.FindControl("grdStudentAttendanceTermDayCourse"), GridView)
                            gvStudentAttendanceTermDayCourse.DataSource = AcademicsManager.GetStudentAttendanceTermDayCourse(grdStudentAttendanceTerm2.DataKeys(e.Row.RowIndex).Value, gvStudentAttendanceTermDay.DataKeys(row.RowIndex).Value)
                            gvStudentAttendanceTermDayCourse.DataBind()
                        End If
                    Next
                End If
            Catch ex As Exception
                lblerror.Text = ExceptionManager.FormatError(ex)
                lblerror.Visible = True
                grdStudentAttendanceTerm.Visible = False
                grdStudentAttendanceTerm2.Visible = False
            End Try
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