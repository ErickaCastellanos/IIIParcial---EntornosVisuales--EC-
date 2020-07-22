Imports System.Data.SqlClient

Public Class Conexion
    '
    Public Conexion As SqlConnection = New SqlConnection("Data Source=.;Initial Catalog=proyectoTienda;Integrated Security=True")
    'Private cmb As SqlCommandBuilder
    Public ds As DataSet = New DataSet()
    Public da As SqlDataAdapter
    Public cmb As SqlCommand
    Public dr As SqlDataReader

    Public Sub conectarBase()
        Try
            Conexion.Open()
            MessageBox.Show("Conectado")
        Catch ex As Exception
            MessageBox.Show("Error al conectar")
        Finally
            Conexion.Close()
        End Try
    End Sub

    Public Function insertarUsuario(idUsuario As Integer, nombre As String, apellido As String, userName As String,
                                    psw As String, rol As String, estado As String, correo As String)
        Try
            Conexion.Open()
            cmb = New SqlCommand("insertarUsuario", Conexion)
            cmb.CommandType = CommandType.StoredProcedure
            cmb.Parameters.AddWithValue("@idUsuario", idUsuario)
            cmb.Parameters.AddWithValue("@nombre", nombre)
            cmb.Parameters.AddWithValue("@apellido", apellido)
            cmb.Parameters.AddWithValue("@userName", userName)
            cmb.Parameters.AddWithValue("@psw", psw)
            cmb.Parameters.AddWithValue("@rol", rol)
            cmb.Parameters.AddWithValue("@estado", estado)
            cmb.Parameters.AddWithValue("@correo", correo)
            If cmb.ExecuteNonQuery Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Function

    Public Function eliminarUsuario(idUsuario As Integer, rol As String)
        Try
            Conexion.Open()
            cmb = New SqlCommand("eliminarUsuario", Conexion)
            cmb.CommandType = CommandType.StoredProcedure
            cmb.Parameters.AddWithValue("@idUsuario", idUsuario)
            cmb.Parameters.AddWithValue("@rol", rol)
            If cmb.ExecuteNonQuery <> 0 Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
            Return False
        Finally
            Conexion.Close()
        End Try
    End Function

    Public Function actualizarUsuario(idUsuario)

End Class
