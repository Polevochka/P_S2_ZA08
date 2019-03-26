unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

  // Делаем матрицу и её размерность глобальными переменными
  // чтобы они были видны во всех функциях -
  // обработчиков нажатия кнопок
  a: Ar;
  n : integer;
  b: Ar; // Вспомогательная матрица - эталонная(исходная)

implementation

{$R *.lfm}

{ TForm1 }


// удобно будет создать процедуру вывода матрицы в объект типа TMemo
// 'var output:TMemo' так как мы будем изменять объект Memo - записывать в него
// Хотя это не обязательно, работает и без, тупо для приличия делаем так
procedure printAr(a: Ar; n: integer; var output: TMemo);
var
  // строковое представление одного числа
  s_x: string;
  // вспомогательная строка, чтобы добавить элементы матрицы
  // то есть это сумма строковых представлений каждого элемента(s_x) матрциы
  s: string;
  // переменные для циклов обхода матрицы
  i,j: integer;
begin
  // перед записью чего-то в Memo очищаем его
  // В Memo могла остаться старая матрица
  output.Clear;

  // сначала мы будем собирать строку из элементов матрицы,
  // лежащих на i-ой строчке
  // Потом добавляем эту строку в Memo через Append
  for i:=1 to n do
  begin
    // присваиваем пустую строку про обработке каждой строки матрицы
    // То есть обработали одну строку, очистили переменную, обработать другую
    // иначе элементы с другой (предыдущей) строки будут выводиться и в новой строке
    s := '';
    for j:=1 to n do
    begin
      // преобразуем елемент матрицы в строку
      // число 5 - так же как и в writeln - ширина поля под число
      // чтобы не замарачиваться с пробелами при выводе
      str(a[i,j]:5, s_x);
      // по одному элементы i-ой строки собираем в одну строку
      s := s + s_x;
    end;
    // собрали одну строку, теперь добавляем её в Memo
    output.Append(s);

  end;
end;

{Нажали 'Новая матрица'}
procedure TForm1.Button1Click(Sender: TObject);
begin
    // Получаем размерность матрицы от пользователя
    // InputBox возвращает строку, но ГЛОБАЛЬНАЯ переменная 'n' типа integer
    // поэтому преобразуем возвращаем значение в целое число при помощи StrToInt
    n := StrToInt(InputBox('Размерность матрицы', 'Введите целое число', '5'));

    // Теперь так как УЖЕ ЕСТЬ число строк и столбцов
    // Заполняем ЭТАЛОННУЮ матрицу
    NewAr(b, n);

    // выводим матрицу в Memo1 - исходная матрица
    PrintAr(b, n, Memo1);

end;

{Нажали 'ПО ЧС'}
procedure TForm1.Button2Click(Sender: TObject);
var i, k: integer;
begin

  // копируем матрицу из ЭТАЛОНА
  a := b;

  // получаем сколько поворотов нужно сделать
  k := StrToInt(InputBox('Количество Поворотов', 'Введите целое число', '1'));

  // K раз вращаем по очасовой
  for i:=1 to k do
    ByHourHand(a, n);

  // выводим изменённую матрицу в Memo2
  printAr(a,n, Memo2);

end;

{Нажали 'ПРОТИВ ЧС'}
procedure TForm1.Button3Click(Sender: TObject);
var i, k: integer;
begin

  // копируем матрицу из ЭТАЛОНА
  a := b;

  // получаем сколько поворотов нужно сделать
  k := StrToInt(InputBox('Количество Поворотов', 'Введите целое число', '1'));

  // K раз вращаем против очасовой
  for i:=1 to k do
    AginHourHand(a, n);

  // выводим изменённую матрицу в Memo2
  printAr(a,n, Memo2);
end;

{Нажали 'Закрыть'}
procedure TForm1.Button4Click(Sender: TObject);
begin
  close;
end;

end.

