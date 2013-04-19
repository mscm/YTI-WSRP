Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Namespace Common.Data
    Public Class DataAccess
        Private conn As New SqlConnection
        Public Sub New(ByVal ConnectionStringName As String)
            conn.ConnectionString = GetConnectionString(ConnectionStringName)
        End Sub
        Public Function ExecuteSQLStatement(ByVal SQL As String) As Integer
            Dim command As New SqlCommand
            Try
                command.CommandType = CommandType.Text
                command.CommandTimeout = 60
                command.CommandText = SQL
                command.Connection = conn
                If conn.State = ConnectionState.Closed Then
                    conn.Open()
                End If
                command.ExecuteNonQuery()
            Catch ex As Exception
                Throw ex
            Finally
                command = Nothing
                If conn.State <> ConnectionState.Closed Then
                    conn.Close()
                End If
            End Try
        End Function

        Public Function ExecuteSPROCStatement(ByVal SprocName As String, ByVal Parameters As List(Of SqlParameter)) As Integer
            Dim command As New SqlCommand
            Try
                command.CommandType = CommandType.StoredProcedure
                command.CommandTimeout = 60
                command.CommandText = SprocName
                command.Connection = conn
                If Not Parameters Is Nothing Then
                    For Each Parameter As SqlParameter In Parameters
                        command.Parameters.Add(Parameter)
                    Next
                End If
                If conn.State = ConnectionState.Closed Then
                    conn.Open()
                End If
                command.ExecuteNonQuery()
            Catch ex As Exception
                Throw ex
            Finally
                command = Nothing
                If conn.State <> ConnectionState.Closed Then
                    conn.Close()
                End If
            End Try
        End Function

        Public Function ExecuteSPROCandReturnReader(ByVal SprocName As String, ByVal Parameters As List(Of SqlParameter)) As SqlDataReader
            Dim command As New SqlCommand
            Dim reader As SqlDataReader
            Try
                command.CommandType = CommandType.StoredProcedure
                command.CommandTimeout = 60
                command.CommandText = SprocName
                command.Connection = conn
                If Not Parameters Is Nothing Then
                    For Each Parameter As SqlParameter In Parameters
                        command.Parameters.Add(Parameter)
                    Next
                End If
                If conn.State = ConnectionState.Closed Then
                    conn.Open()
                End If
                reader = command.ExecuteReader(CommandBehavior.CloseConnection)
                Return reader
            Catch ex As Exception
                Throw ex
            Finally
                command = Nothing
                reader = Nothing
            End Try
        End Function

        Public Function ExecuteSPROCandReturnDataTable(ByVal SprocName As String, ByVal Parameters As List(Of SqlParameter)) As DataTable
            Dim command As New SqlCommand
            Dim adapter As SqlDataAdapter
            Dim dt As New DataTable
            Try
                command.CommandType = CommandType.StoredProcedure
                command.CommandTimeout = 60
                command.CommandText = SprocName
                command.Connection = conn
                If Not Parameters Is Nothing Then
                    For Each Parameter As SqlParameter In Parameters
                        command.Parameters.Add(Parameter)
                    Next
                End If
                If conn.State = ConnectionState.Closed Then
                    conn.Open()
                End If
                adapter = New SqlDataAdapter(command)
                adapter.Fill(dt)
                Return dt
            Catch ex As Exception
                Throw ex
            Finally
                command = Nothing
                dt = Nothing
                adapter = Nothing
                If conn.State <> ConnectionState.Closed Then
                    conn.Close()
                End If
            End Try
        End Function

        Public Function ExecuteQueryandReturnReader(ByVal SQL As String) As SqlDataReader
            Dim command As New SqlCommand
            Dim reader As SqlDataReader
            Try
                command.CommandType = CommandType.Text
                command.CommandTimeout = 60
                command.CommandText = SQL
                command.Connection = conn
                If conn.State = ConnectionState.Closed Then
                    conn.Open()
                End If
                reader = command.ExecuteReader(CommandBehavior.CloseConnection)
                Return reader
            Catch ex As Exception
                Throw ex
            Finally
                command = Nothing
                reader = Nothing
            End Try
        End Function

        Public Function ExecuteQueryandReturnDataTable(ByVal SQL As String) As DataTable
            Dim command As New SqlCommand
            Dim adapter As SqlDataAdapter
            Dim dt As New DataTable
            Try
                command.CommandType = CommandType.Text
                command.CommandTimeout = 60
                command.CommandText = SQL
                command.Connection = conn
                If conn.State = ConnectionState.Closed Then
                    conn.Open()
                End If
                adapter = New SqlDataAdapter(command)
                adapter.Fill(dt)
                Return dt
            Catch sqlex As SqlException
                Throw sqlex
            Catch ex As Exception
                Throw ex
            Finally
                command = Nothing
                dt = Nothing
                adapter = Nothing
                If conn.State <> ConnectionState.Closed Then
                    conn.Close()
                End If
            End Try
        End Function

        Private Function GetConnectionString(ByVal ConnectionStringName As String) As String
            Try
                If Not ConnectionStringName Is Nothing Then
                    Return ConfigurationManager.ConnectionStrings(ConnectionStringName).ConnectionString
                Else
                    Throw New Exception("Connection String is Empty")
                End If
            Catch ex As Exception
                Throw ex
            End Try
        End Function
    End Class
End Namespace


