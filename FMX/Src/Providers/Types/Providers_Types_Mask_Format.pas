unit Providers_Types_Mask_Format;

interface
uses system.classes,system.sysutils;

type
{$SCOPEDENUMS ON}
  TMaskFormat = (CPF, Celular);
{$SCOPEDENUMS OFF}

  TMaskFormatHelper = record helper for TMaskFormat
  private

  public
    function MaskText(Const Avalue:String):string;
    function GetMask:String;
    function ExtractNumber(const AValue:String):String;
    function format(const Avalue:String):String;


  end;

implementation

{ TMaskFormatHelper }

function TMaskFormatHelper.ExtractNumber(const AValue: String): String;
var
  i:integer;
begin
  Result:=EmptyStr;
  for i:=1 to Avalue.Length do
  begin
    if (CharInSet(Avalue[i],['0'..'9'])) then
      Result:=Result+AVAlue[i];
   end;

end;

function TMaskFormatHelper.format(const Avalue:String): String;
begin
Result:=MaskText(ExtractNumber(Avalue));

end;

function TMaskFormatHelper.GetMask: String;
begin
 case self of
   TMaskFormat.CPF:
     Result:='###.###.###-##';
   TMaskFormat.Celular:
     Result:='(##)#####-####';
 end;
end;

function TMaskFormatHelper.MaskText(const Avalue: String): string;
var
i,J:Integer;
begin
  Result:=EmptyStr;
 if (Avalue.Trim.IsEmpty) then
   Exit;

   J:=0;
 for I := 0 to Pred(Self.GetMask.Length) do
 begin
   if (Self.GetMask.Chars[i]='#') then
   begin
     Result := Result+Avalue.Chars[j];
     inc(j);
   end
   else
   begin
     Result:=Result+self.GetMask.Chars[i];
      //inc(j);
   end;
     if j=Avalue.Length then
        Break;


 end;



end;

end.
