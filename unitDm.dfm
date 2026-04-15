object dm: Tdm
  Height = 241
  Width = 381
  object Conn: TFDConnection
    Params.Strings = (
      'Database=D:\Sistema Principal\DB_ATUALIZADOR.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Port=3050'
      'Protocol=TCPIP'
      'Server=localhost'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    ConnectedStoredUsage = [auRunTime]
    LoginPrompt = False
    Left = 69
    Top = 50
  end
  object qry: TFDQuery
    Connection = Conn
    Left = 133
    Top = 50
  end
end
