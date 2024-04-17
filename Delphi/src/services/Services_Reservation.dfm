inherited ReservationService: TReservationService
  OldCreateOrder = True
  Height = 307
  Width = 432
  object qryReservation: TFDQuery
    Connection = Connection
    SchemaAdapter = FDSchemaAdapter
    SQL.Strings = (
      'select id,data,nome,cpf,email,telefone'
      'from reserva')
    Left = 72
    Top = 96
    object qryReservationID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ReadOnly = True
    end
    object qryReservationDATA: TSQLTimeStampField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object qryReservationNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 250
    end
    object qryReservationCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
    end
    object qryReservationEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 250
    end
    object qryReservationTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
    end
  end
  object qryitens: TFDQuery
    IndexFieldNames = 'ID_RESERVA'
    MasterSource = dsReservation
    MasterFields = 'ID'
    DetailFields = 'ID_RESERVA'
    Connection = Connection
    SchemaAdapter = FDSchemaAdapter
    SQL.Strings = (
      'select rl.id,rl.id_livro,rl.id_reserva, l.nome,l.autor'
      'from reserva_livro rl'
      'inner join livro l on l.id=rl.id_livro')
    Left = 208
    Top = 96
    object qryitensID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ReadOnly = True
    end
    object qryitensID_LIVRO: TIntegerField
      FieldName = 'ID_LIVRO'
      Origin = 'ID_LIVRO'
      Required = True
    end
    object qryitensID_RESERVA: TIntegerField
      FieldName = 'ID_RESERVA'
      Origin = 'ID_RESERVA'
      Required = True
      Visible = False
    end
    object qryitensNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 250
    end
    object qryitensAUTOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'AUTOR'
      Origin = 'AUTOR'
      ProviderFlags = []
      ReadOnly = True
      Size = 250
    end
  end
  object dsReservation: TDataSource
    DataSet = qryReservation
    Left = 72
    Top = 152
  end
  object FDSchemaAdapter: TFDSchemaAdapter
    Left = 200
    Top = 160
  end
  object qryReservationDetalhe: TFDQuery
    Connection = Connection
    SQL.Strings = (
      
        'select rl.id,rl.id_livro,rl.id_reserva, l.nome as nomelivro,l.au' +
        'tor,l.descricao,'
      'r.data,r.nome as nomepessoa,r.cpf,r.email,r.telefone'
      'from reserva_livro rl'
      'inner join livro l on l.id=rl.id_livro'
      'inner join reserva r on r.id=rl.id_reserva'
      'order by rl.id_reserva,nomepessoa')
    Left = 280
    Top = 200
  end
end
