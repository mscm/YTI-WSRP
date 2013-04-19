Imports System.Data
Imports System.Data.SqlClient
Imports System.ComponentModel
Imports WSRP.Common.Data

Namespace Common.Managers
    <DataObject(True)> _
    Public Class AcademicsManager
        Private Shared c2kDS As New DataAccess("c2k")

        <DataObjectMethod(DataObjectMethodType.Select)> _
        Public Shared Function GetStudentAttendanceTerm(ByVal syStudentID As Integer) As DataTable
            Dim params As New List(Of SqlParameter)
            Try
                params.Add(New SqlParameter("SyStudentID", syStudentID))
                Return c2kDS.ExecuteSPROCandReturnDataTable("WSRP_GetStudentAttendanceTerm", params)
            Catch ex As Exception
                Throw New Exception("Error Getting Student Attendance By Term", ex)
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Select)> _
        Public Shared Function GetStudentAttendanceTermCourse(ByVal adEnrollTermId As Integer) As DataTable
            Dim params As New List(Of SqlParameter)
            Try
                params.Add(New SqlParameter("AdEnrollTermId", adEnrollTermId))
                Return c2kDS.ExecuteSPROCandReturnDataTable("WSRP_GetStudentAttendanceTermCourse", params)
            Catch ex As Exception
                Throw New Exception("Error Getting Student Attendance By Term By Course", ex)
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Select)> _
        Public Shared Function GetStudentAttendanceTermCourseDay(ByVal adEnrollSchedId As Integer) As DataTable
            Dim params As New List(Of SqlParameter)
            Try
                params.Add(New SqlParameter("AdEnrollSchedId", adEnrollSchedId))
                Return c2kDS.ExecuteSPROCandReturnDataTable("WSRP_GetStudentAttendanceTermCourseDay", params)
            Catch ex As Exception
                Throw New Exception("Error Getting Student Attendance By Term By Course By Day", ex)
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Select)> _
        Public Shared Function GetStudentAttendanceTermDay(ByVal adEnrollTermId As Integer) As DataTable
            Dim params As New List(Of SqlParameter)
            Try
                params.Add(New SqlParameter("AdEnrollTermId", adEnrollTermId))
                Return c2kDS.ExecuteSPROCandReturnDataTable("WSRP_GetStudentAttendanceTermDay", params)
            Catch ex As Exception
                Throw New Exception("Error Getting Student Attendance By Term By Day", ex)
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Select)> _
        Public Shared Function GetStudentAttendanceTermDayCourse(ByVal adEnrollTermId As Integer, ByVal Day As Date) As DataTable
            Dim params As New List(Of SqlParameter)
            Try
                params.Add(New SqlParameter("AdEnrollTermId", adEnrollTermId))
                params.Add(New SqlParameter("Date", Day))
                Return c2kDS.ExecuteSPROCandReturnDataTable("WSRP_GetStudentAttendanceTermDayCourse", params)
            Catch ex As Exception
                Throw New Exception("Error Getting Student Attendance By Term By Day By Course", ex)
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Select)> _
        Public Shared Function GetStudentTermGrades(ByVal SyStudentId As Integer) As DataTable
            Dim params As New List(Of SqlParameter)
            Try
                params.Add(New SqlParameter("SyStudentID", SyStudentId))
                Return c2kDS.ExecuteSPROCandReturnDataTable("WSRP_GetStudentTermGrades", params)
            Catch ex As Exception
                Throw New Exception("Error Getting Student Term Grades", ex)
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Select)> _
        Public Shared Function GetStudentCourseGrades(ByVal AdEnrollTermId As Integer) As DataTable
            Dim params As New List(Of SqlParameter)
            Try
                params.Add(New SqlParameter("AdEnrollTermId", AdEnrollTermId))
                Return c2kDS.ExecuteSPROCandReturnDataTable("WSRP_GetStudentCourseGrades", params)
            Catch ex As Exception
                Throw New Exception("Error Getting Student Course Grades", ex)
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Select)> _
        Public Shared Function GetStudentCourseLessonGrades(ByVal AdEnrollSchedId As Integer) As DataTable
            Dim params As New List(Of SqlParameter)
            Try
                params.Add(New SqlParameter("AdEnrollSchedId", AdEnrollSchedId))
                Return c2kDS.ExecuteSPROCandReturnDataTable("WSRP_GetStudentCourseLessonGrades", params)
            Catch ex As Exception
                Throw New Exception("Error Getting Student Course Lesson Grades", ex)
            End Try
        End Function
    End Class
End Namespace


