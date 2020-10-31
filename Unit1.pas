unit Unit1;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.ExtCtrls, WEBLib.StdCtrls, WEBLib.JSON, WEBLib.WebCtrls, WEBLib.Buttons;

type
  TForm1 = class(TWebForm)
    WebHTMLContainer1: TWebHTMLContainer;
    lDescription: TWebLabel;
    eDescription: TWebEdit;
    lUnits: TWebLabel;
    seUnits: TWebSpinEdit;
    sbAddValue: TWebSpeedButton;
    sbDeleteValue: TWebSpeedButton;
    lbData: TWebListBox;
    cbChartType: TWebComboBox;
    bShowChart: TWebButton;
    chartdiv: TWebHTMLDiv;
    procedure sbAddValueClick(Sender: TObject);
    procedure sbDeleteValueClick(Sender: TObject);
    procedure Form1Show(Sender: TObject);
    procedure bShowChartClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadChart;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.bShowChartClick(Sender: TObject);
begin
  if (lbData.items.Count > 0) and (cbChartType.ItemIndex >= 0) then
    LoadChart;  
end;


procedure TForm1.Form1Show(Sender: TObject);
begin
  lbData.ItemIndex := -1;  
end;

procedure TForm1.sbDeleteValueClick(Sender: TObject);
begin
  if lbdata.ItemIndex >= 0 then
    lbdata.items.delete(lbData.ItemIndex)
  else
    ShowMessage('No ha seleccionado ningún elemento.');
end;

procedure TForm1.sbAddValueClick(Sender: TObject);
begin
  if (eDescription.text <> '')  then
    begin
      lbdata.items.Add(eDescription.Text.trim() + ' - '+ seUnits.Value.ToString());
      lbData.ItemIndex := -1;
    end;
end;

procedure TForm1.LoadChart;
var
  arrayValues: TJSArray;
  arrayCategories: TJSArray;
  strType, strData: string;
  intItem: Integer;
begin
  arrayValues := TJSArray.new();
  arrayCategories := TJSArray.new();
  strType := cbChartType.Text;

  for strData in lbData.Items do
    begin
      arrayCategories.push(copy(strData, 0, Pos('-', strData) -1).Trim());
      arrayValues.push(copy(strData, Pos('-', strData) + 1, Length(strData)-1).Trim());      
    end;

  asm
    var options = {
        chart: {
          type: strType,
          width: 400,
          heigth: 400
        },
        series: [{
          name: 'Ciudades y Valores',
          data: arrayValues
        }],
        xaxis: {
          categories: arrayCategories
        }
      };
    var chart = new ApexCharts(document.getElementById('chartdiv'), options);
    chart.render();
  end;
end;



end.                     