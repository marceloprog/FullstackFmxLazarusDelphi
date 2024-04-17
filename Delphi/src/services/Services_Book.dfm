inherited BookService: TBookService
  OldCreateOrder = True
  object QryBooks: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select id, nome, descricao, autor, status from livro')
    Left = 56
    Top = 88
    object QryBooksID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ReadOnly = True
    end
    object QryBooksNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 250
    end
    object QryBooksDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 2000
    end
    object QryBooksAUTOR: TStringField
      FieldName = 'AUTOR'
      Origin = 'AUTOR'
      Size = 250
    end
    object QryBooksSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Required = True
    end
  end
end
