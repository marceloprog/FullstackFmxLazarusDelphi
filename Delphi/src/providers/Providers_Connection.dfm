object ProviderConnection: TProviderConnection
  OldCreateOrder = False
  Height = 243
  Width = 339
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 120
    Top = 24
  end
  object Connection: TFDConnection
    Params.Strings = (
      'Database=D:\Projetos\ClubeMObile\FullStack\bd\Books.fdb'
      'CharacterSet=WIN1252'
      'Password=masterkey'
      'Port=0'
      'User_Name=SYSDBA'
      'DriverID=FB')
    ConnectedStoredUsage = [auDesignTime]
    Left = 32
    Top = 16
  end
end
