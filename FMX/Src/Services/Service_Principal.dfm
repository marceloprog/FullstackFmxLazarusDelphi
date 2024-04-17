object DMServicePrincipal: TDMServicePrincipal
  OldCreateOrder = False
  Height = 150
  Width = 453
  object mtBooks: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 72
    Top = 24
    object mtBooksID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
    end
    object mtBooksNOME: TStringField
      FieldName = 'NOME'
      Size = 250
    end
    object mtBooksDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 2000
    end
    object mtBooksAUTOR: TStringField
      FieldName = 'AUTOR'
      Size = 250
    end
    object mtBooksSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
  end
  object mtReservas: TFDMemTable
    IndexFieldNames = 'id_reserva'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 160
    Top = 40
    object mtReservasID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
    end
    object mtReservasID_LIVRO: TIntegerField
      FieldName = 'ID_LIVRO'
    end
    object mtReservasID_RESERVA: TIntegerField
      FieldName = 'ID_RESERVA'
    end
    object mtReservasNOMELIVRO: TStringField
      FieldName = 'NOMELIVRO'
      Size = 250
    end
    object mtReservasAUTOR: TStringField
      FieldName = 'AUTOR'
      Size = 250
    end
    object mtReservasDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 2000
    end
    object mtReservasDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
    object mtReservasNOMEPESSOA: TStringField
      FieldName = 'NOMEPESSOA'
      Size = 250
    end
    object mtReservasCPF: TStringField
      FieldName = 'CPF'
    end
    object mtReservasEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 250
    end
    object mtReservasTELEFONE: TStringField
      FieldName = 'TELEFONE'
    end
  end
end
