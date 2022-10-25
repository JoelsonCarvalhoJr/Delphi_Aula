object DM: TDM
  OldCreateOrder = False
  Height = 192
  Width = 284
  object dbsMain: TFDConnection
    ConnectionName = 'dbsMain'
    Params.Strings = (
      'Database=kgvenda'
      'User_Name=root'
      'Password=root'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object MySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'C:\WINDOWS\libmySQL.dll'
    Left = 135
    Top = 17
  end
  object Qry: TFDQuery
    Connection = dbsMain
    Left = 192
    Top = 64
  end
end
