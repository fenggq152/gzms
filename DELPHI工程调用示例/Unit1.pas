unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure PrnBar(hd:HDC;bpreview:Boolean;x1,y1,w,h:Real;str_Bar:PChar);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

//启动打印机   (vcHDC是指定预览句柄设备，bPreview为是否预览)
function UTC_Begin(vcHDC: HDC; bPreview: Boolean): Boolean; stdcall;  external 'UTC_Prn.dll';

//指定字体，字形，大小
function UTC_SetFont(FontName: PChar; FontSize: Integer; Bold, Italic,
  Underline, StrikeOut: Boolean): Boolean; stdcall; external 'UTC_Prn.dll';

//打印指定的文字
function UTC_Text(x, y: Real; sText: PChar; angle: Integer): Boolean; stdcall; external 'UTC_Prn.dll';

//设置条码的相对宽度比例
procedure UTC_SetBCRatio(iRatio: Integer); stdcall; external 'UTC_Prn.dll';

//打印直线
function UTC_Line(X1, Y1, X2, Y2: Real; PenWidth: Integer): Boolean; stdcall; external 'UTC_Prn.dll';

//打印条形码
function UTC_Barcode(X, Y, Width, Height: Real; BarcodeData, BarcodeType: PChar; Angle: Integer; IsReadable: Boolean): Boolean; stdcall;
  external  'UTC_Prn.dll';

//打印完成
function UTC_End: Boolean; stdcall; external  'UTC_Prn.dll';

//初始打印机
function UTC_OpenPrinter(): Boolean; stdcall; external  'UTC_Prn.dll';

//关闭打印机
function UTC_ClosePrinter(): Boolean; stdcall;external  'UTC_Prn.dll';

implementation

{$R *.dfm}

//自定义过程
procedure TForm1.PrnBar(hd:HDC;bpreview:Boolean;x1,y1,w,h:Real;str_Bar:PChar);
begin
    UTC_OpenPrinter;
    UTC_Begin(hd, bpreview);
    UTC_SetFont(PChar('宋体'),10,true,False,False,False);
    UTC_Text(10,10,'固定资产管理标签',0);
    UTC_Barcode( x1, y1, w, h, PChar(str_Bar),'Code128C',0,True );
    UTC_End;

end;



procedure TForm1.btn1Click(Sender: TObject);
begin
    UTC_OpenPrinter;
    PrnBar(0,False,15,15,38,8,'000603080001'); //调用过程并打印
    UTC_ClosePrinter;
end;

end.

Function uLong GetModuleFileNameA(long hinstModule, Ref String lpszPath, uLong cchPath) Library "kernel32.dll";Function Long HtmlHelpA (long hwnd ,string lpHelpFile , long wCommand, string dwData) Library "hhctrl.ocx" 
//启动打印机   (vcHDC是指定预览句柄设备，bPreview为是否预览)
Function Boolean UTC_Begin(ulong vcHDC, Boolean bPreview) Library "UTC_Prn.dll" 
//指定字体，字形，大小
Function Boolean UTC_SetFont(string FontName, uint FontSize,Boolean bold,Boolean Italic,Boolean Underline, Boolean StrikeOut) Library "UTC_Prn.dll" 
//打印指定的文字
function Boolean UTC_Text(double x, double y,string sText,uint angle) Library  'UTC_Prn.dll'
//打印直线
function Boolean UTC_Line(double X1,double Y1,double X2,double  Y2,uint PenWidth) Library  'UTC_Prn.dll'
//打印条形码
function Boolean UTC_Barcode(double X, double Y, double  Width, double Height, string BarcodeData, string BarcodeType, uint Angle, Boolean IsReadable) Library  'UTC_Prn.dll'
//打印完成
function Boolean UTC_End() Library 'UTC_Prn.dll'
//初始打印机
function Boolean UTC_OpenPrinter() Library 'UTC_Prn.dll'
//关闭打印机
function Boolean UTC_ClosePrinter() Library 'UTC_Prn.dll'
 