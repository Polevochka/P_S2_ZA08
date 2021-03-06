unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

// Создадит тип двухмерного массива,
//чтобы можно было передавать матрицы в различные функции

// Причом важно описать этот тип именно в области interface,
// а то данный тип не будет виден в модуле unit1,
// куда подключается наш модуль unit2 с этим типом
type
  Ar = array [1..10, 1..10] of integer;


// Прототипы функций - просто их заголовки
// - это те функции которые должны быть видны в модуле unit1 - та же причина,
// что и с типом unit1

procedure NewAr(var a: Ar; n: integer);
procedure AginHourHand(var a: Ar; n:integer);
procedure ByHourHand(var a: Ar; n: integer);

implementation

{Процедура заполнения матрицы рандомными числами}
//'var a' - т.к. меняем элементы матрицы
//  'n' - разменрность матрицы - число строк и столбцов
procedure NewAr(var a: Ar; n : integer);
var i, j: integer;
begin
   randomize;  // Для генератора случайных чисел - более случайное число
   for i:=1 to n do
       for j:=1 to n do
           a[i,j] := random(100); // рандомное число на отрезке [0;99]
end;

{Процедура делает ОДИН поворот элементов матрицы ПО ЧС}
//'var a' - т.к. меняем элементы матрицы
{
нам нужно повернуть элементы расположенные в этом треугольнике

1 1 1 1
1 0 1 0
1 1 0 0
1 0 0 0
}
procedure ByHourHand(var a: Ar; n: integer);
var i,j: integer;
  temp: integer; // вспомогательная переменная, для перемещения элементов
begin

   // как мы будем делать
   // сначала сохраним какой-нибудь элемент матрицы, лежащий в этом треугольнике
   // в буферную переменную temp
   // потом все элементы сдвинем на одну позицию по часовой, затиря его
   // и вконце ставим его на освободившееся место

   temp := a[1,1]; // удобно выбрать этот элемент

   // обходим первый столбец j = 1
   for i:= 1 to n-1 do
   begin
     a[i,1] := a[i+1,1];
   end;

   {
    то есть было:
    1 9 8 7
    2 0 6 0
    3 5 0 0
    4 0 0 0

    столо:
    2 9 8 7
    3 0 6 0
    4 5 0 0
    4 0 0 0
    }

   // обходим побочную диагональ
   // элемент на побочной диагонали имеет индекс a[i, n-i+1]
   for i:= n downto 2 do
   begin
     a[i,n-i+1] := a[i-1, n-i+2]; // сдвигаем элементы ПО ЧС
   end;
   {
    то есть было:
    2 9 8 7
    3 0 6 0
    4 5 0 0
    4 0 0 0

    стало:
    2 9 8 7
    3 0 7 0
    4 6 0 0
    5 0 0 0   - не забывам что 1 мы сохранили в temp
    }

   // обходим первую строку i = 1;
    for j:= n downto 2 do
    begin
      a[1,j] := a[1,j-1];
    end;
    {
    то есть было:
    2 9 8 7
    3 0 7 0
    4 6 0 0
    5 0 0 0

    столо:
    2 2 9 8
    3 0 7 0
    4 6 0 0
    5 0 0 0
    }

    // видно, что теперь два первых элемента в первой строке дублируются
    // теперь как раз можно вставить наш сохранённый элемент
    a[1,2] := temp;
    {
    стало:
    2 1 9 8
    3 0 7 0
    4 6 0 0
    5 0 0 0   - задача выполнена
    }

end;

{Процедура делает ОДИН поворот элементов матрицы ПРОТИВ ЧС}
//'var a' - т.к. меняем элементы матрицы
{
нам нужно повернуть элементы расположенные в этом треугольнике

1 1 1 1
1 0 1 0
1 1 0 0
1 0 0 0
}
procedure AginHourHand(var a: Ar; n:integer);
var i,j: integer;
  temp: integer; // вспомогательная переменная, для перемещения элементов
begin

   // как мы будем делать
   // сначала сохраним какой-нибудь элемент матрицы, лежащий в этом треугольнике
   // в буферную переменную temp
   // потом все элементы сдвинем на одну позицию против часовой, затиря его
   // и вконце ставим его на освободившееся место

   temp := a[1,n]; // удобно выбрать этот элемент

   // обходим побочную диагональ
   // элемент на побочной диагонали имеет индекс a[i, n-i+1]
   for i:= 1 to n-1 do
   begin
     a[i,n-i+1] := a[i+1, n-i]; // сдвигаем элементы ПО ЧС
   end;
   {
    то есть было:
    4 3 2 1
    5 0 9 0
    6 8 0 0
    7 0 0 0

    стало:
    4 3 2 9
    5 0 8 0
    6 7 0 0
    7 0 0 0   - не забывам что 1 мы сохранили в temp
    }

   // обходим первый столбец j = 1
   for i:= n downto 2 do
   begin
     a[i,1] := a[i-1,1];
   end;

   {
    то есть было:
    4 3 2 9
    5 0 8 0
    6 7 0 0
    7 0 0 0

    столо:
    4 3 2 9
    4 0 8 0
    5 7 0 0
    6 0 0 0
    }

    // обходим первую строку i = 1;
    for j:= 1 to n-1 do
    begin
      a[1,j] := a[1,j+1];
    end;
    {
    то есть было:
    4 3 2 9
    4 0 8 0
    5 7 0 0
    6 0 0 0

    столо:
    3 2 9 9
    4 0 8 0
    5 7 0 0
    6 0 0 0
    }


    // видно, что теперь два последних элемента в первой строке дублируются
    // теперь как раз можно вставить наш сохранённый элемент
    a[1,n-1] := temp;
    {
    стало:
    3 2 1 9
    4 0 8 0
    5 7 0 0
    6 0 0 0   - задача выполнена
    }

end;

end.

