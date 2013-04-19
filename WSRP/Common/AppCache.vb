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
Imports WSRP.WSRPSpec


Namespace Common
    Public Class AppCache
        Shared _cache As Cache = Nothing
        Private Const CONST_REFRESH As String = "Refresh"
        Private Const DEFAULT_CACHE_EXPIRATION As Integer = 5

        Public Shared Sub InitCache(ByVal c As Cache)
            Try

                _cache = c
                If _cache(CONST_REFRESH) IsNot Nothing Then
                    _cache(CONST_REFRESH) = "0"
                    'don't refresh
                    _cache.Remove(CONST_REFRESH)
                End If


                RefreshCache()
            Catch ex As Exception
                Throw ex
            Finally
                _cache.Insert(CONST_REFRESH, "1", Nothing, DateTime.Now.AddMinutes(CacheExpirationInMinutes), Cache.NoSlidingExpiration)
            End Try
        End Sub
        Private Shared Sub RefreshCacheCallBack(ByVal Key As String, ByVal item As Object, ByVal reason As CacheItemRemovedReason)
            Try
                If _cache(CONST_REFRESH) IsNot Nothing AndAlso DirectCast(_cache(CONST_REFRESH), String) = "0" Then
                    Exit Sub
                End If

                RefreshCache()
            Catch ex As Exception
                Throw ex
            Finally
                If _cache(CONST_REFRESH) Is Nothing Then

                    _cache.Insert(CONST_REFRESH, "1", Nothing, DateTime.Now.AddMinutes(CacheExpirationInMinutes), Cache.NoSlidingExpiration)
                End If


            End Try
        End Sub
        Private Shared ReadOnly Property GetCache() As Cache
            Get
                If _cache Is Nothing Then
                    _cache = System.Web.HttpContext.Current.Cache
                End If

                If _cache Is Nothing Then
                    Throw New Exception("AppCache is null!")
                End If

                Return _cache
            End Get
        End Property
        ''' <summary>
        ''' Returns Item from the Cache based upon the key supplied.
        ''' </summary>
        ''' <param name="sKey"></param>
        ''' <returns></returns>
        Private Shared Function Item(ByVal sKey As String) As Object
            Return GetCache(sKey)
        End Function

        ''' <summary>
        ''' CQ 66355, JSK, 11/29/2007
        ''' There does not appear to be a method supporting insert/updates to the cache.
        ''' </summary>
        ''' <param name="key"></param>
        ''' <param name="value"></param>
        Private Shared Sub putItem(ByVal key As String, ByVal value As Object)
            If _cache Is Nothing Then
                _cache = System.Web.HttpContext.Current.Cache
            End If

            _cache(key) = value
        End Sub

        'starting point for resetting cache
        Public Shared Function RefreshCache() As Boolean
            Try
                CacheManager.CacheData.RefreshPortletList(_cache)

                Return True
            Catch ex As Exception
                Return False
                Throw ex
            End Try
        End Function
        Public Shared Property CacheExpirationInMinutes() As Integer
            Get
                Dim obj As Object = Item(CacheConstants.CACHE_EXPIRATION_IN_MINUTES)
                If obj IsNot Nothing Then
                    Return CInt(obj)
                End If

                Dim s As String = ConfigurationManager.AppSettings("CacheExpirationInMinutes")
                If Not String.IsNullOrEmpty(s) Then
                    Dim i As Integer = Integer.Parse(s)
                    GetCache(CacheConstants.CACHE_EXPIRATION_IN_MINUTES) = i
                    Return i
                End If

                'shouldn't get to this point, but just in case...
                Return DEFAULT_CACHE_EXPIRATION
            End Get
            Set(ByVal value As Integer)
                GetCache(CacheConstants.CACHE_EXPIRATION_IN_MINUTES) = value
            End Set
        End Property

        Public Shared Function GetPortletList() As PortletDescription()
            Dim obj As Object = Item(CacheConstants.PORTLET_LIST)
            If obj IsNot Nothing Then
                Return DirectCast(obj, PortletDescription())
            End If

            CacheManager.CacheData.RefreshPortletList(_cache)

            Return DirectCast(Item(CacheConstants.PORTLET_LIST), PortletDescription())
        End Function
    End Class
End Namespace

