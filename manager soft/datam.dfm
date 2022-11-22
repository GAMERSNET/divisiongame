object DModule: TDModule
  Height = 353
  Width = 1073
  PixelsPerInch = 96
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=gt'
      'User_Name=postgres'
      'Password=12801024qwe'
      'Server=192.168.0.19'
      'DriverID=PG')
    Connected = True
    Left = 168
    Top = 56
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 88
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    ScreenCursor = gcrNone
    Left = 256
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorHome = 'C:\'
    Left = 280
    Top = 64
  end
  object FDQZone: TFDQuery
    Connection = FDConnection1
    Left = 32
    Top = 136
  end
  object FDQTariff: TFDQuery
    Connection = FDConnection1
    Left = 88
    Top = 136
  end
  object FDQSoft: TFDQuery
    Connection = FDConnection1
    Left = 152
    Top = 136
  end
  object FDQRegUser: TFDQuery
    Connection = FDConnection1
    Left = 232
    Top = 137
  end
  object FDQToken: TFDQuery
    Connection = FDConnection1
    Left = 304
    Top = 137
  end
  object FDUseerSearch: TFDQuery
    Connection = FDConnection1
    Left = 576
    Top = 9
  end
  object FDBalance: TFDQuery
    Connection = FDConnection1
    Left = 576
    Top = 65
  end
  object FDShiftInfo: TFDQuery
    Connection = FDConnection1
    Left = 576
    Top = 129
  end
  object RESTClient1: TRESTClient
    BaseURL = 'http://192.168.0.19:9090'
    Params = <>
    Left = 776
    Top = 24
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'bodyDFD791C360A0483B8BA1348B969554C0'
        Value = '{"cmd":"connect","data":{"mac":"AA-AA-AA-BB-BB-BB", "token":""}}'
        ContentTypeStr = 'application/json'
      end>
    Response = RESTResponse1
    Left = 848
    Top = 24
  end
  object RESTResponse1: TRESTResponse
    Left = 928
    Top = 24
  end
  object FDGames: TFDQuery
    Connection = FDConnection1
    Left = 576
    Top = 193
  end
  object IdTCPClient: TIdTCPClient
    ConnectTimeout = 0
    Port = 9098
    ReadTimeout = -1
    Left = 40
    Top = 272
  end
  object FDQClubStatistic: TFDQuery
    Connection = FDConnection1
    Left = 576
    Top = 249
  end
  object FDQBooking: TFDQuery
    Connection = FDConnection1
    Left = 672
    Top = 248
  end
  object IdTCPServer: TIdTCPServer
    Bindings = <>
    DefaultPort = 8099
    OnExecute = IdTCPServerExecute
    Left = 120
    Top = 272
  end
end
