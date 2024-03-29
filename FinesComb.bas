Sub SetFormula(LastR, LastС, lastCS)
Cells(1, LastС).Value = "Замовлено"
Cells(1, LastС + 1).Value = "Факт. кількисть реал."
Cells(1, LastС + 2).Value = "Кількисть замовлень"
Cells(1, LastС + 3).Value = "Коментар"


Range(Cells(2, LastС + 3), Cells(LastR, LastС + 3)).FormulaR1C1 = "=IFERROR(IFERROR(VLOOKUP(RC2,Отгрузки!C2:C" & lastCS - 1 & "," & lastCS - 2 & ",0),""Дублікат замовлення? ""&VLOOKUP(RC1,Отгрузки!C1:C" & lastCS - 1 & "," & lastCS - 1 & ",0)),""За номером замовлення і датою доставки данні відсутні"")" 'Коментар
Range(Cells(2, LastС + 2), Cells(LastR, LastС + 2)).FormulaR1C1 = "=SUMIF(Отгрузки!C1,Коментарі!RC1,Отгрузки!C19)" 'Замовлень на дату
Range(Cells(2, LastС + 1), Cells(LastR, LastС + 1)).FormulaR1C1 = "=SUMIF(Отгрузки!C1,Коментарі!RC1,Отгрузки!C13)" ' Релизовано
Range(Cells(2, LastС), Cells(LastR, LastС)).FormulaR1C1 = "=SUMIF(Отгрузки!C1,Коментарі!RC1,Отгрузки!C10)" 'Замовлено

End Sub



Sub SetComments(Buyer, lastCS)
Dim LastR As Long, LastС As Long, r As Range, orderNumCol As Long, productIdNumCol As Long, outletNumCol As Long
If Buyer = "АТБ" Then

Sheets("Коментарі").Activate

LastR = Cells(1, 1).End(xlDown).Row

Columns(1).Insert
Cells(1, 1).Value = "IDO"
Columns(1).Insert
Cells(1, 1).Value = "IDD"
LastС = Cells(1, 1).End(xlToRight).Column + 1

'Cells(1, LastС).Value = "Замовлено"
'Cells(1, LastС + 1).Value = "Факт. кількисть реал."
'Cells(1, LastС + 2).Value = "Кількисть замовлень"
'Cells(1, LastС + 3).Value = "Коментар"


Range(Cells(2, 1), Cells(LastR, 1)).FormulaR1C1 = "=TEXT(RC7,""ГГГГММДД"")&""_""&VLOOKUP(RC4,ProductsCollation!C2:C4,3,0)&VLOOKUP(RC3,OutletsCollation!C3:C4,2,0)"
Range(Cells(2, 2), Cells(LastR, 2)).FormulaR1C1 = "=RC8&VLOOKUP(RC4,ProductsCollation!C2:C4,3,0)&VLOOKUP(RC3,OutletsCollation!C3:C4,2,0)&""_"""

SetFormula LastR, LastС, lastCS

'FOZZY -----------------------
ElseIf Buyer = "Fozzy" Then
 Sheets("Коментарі").Activate

    LastR = Cells(1, 1).End(xlDown).Row
    Columns(1).Insert
    Cells(1, 1).Value = "IDO"
    Columns(1).Insert
    Cells(1, 1).Value = "IDD"
    LastС = Cells(1, 1).End(xlToRight).Column + 1
    

    Set r = Range("1:1").Find("SAPID заказа", , xlValues, xlWhole, , , False)
    orderNumCol = r.Column

    Set r = Range("1:1").Find("Филиал", , xlValues, xlWhole, , , False)
    outletNumCol = r.Column

    Set r = Range("1:1").Find("Артикул", , xlValues, xlWhole, , , False) '
    productIdNumCol = r.Column

Range(Cells(2, 1), Cells(LastR, 1)).FormulaR1C1 = "=TEXT(RC8,""ГГГГММДД"")&""_""&VLOOKUP(RC" & productIdNumCol & ",ProductsCollation!C2:C4,3,0)&VLOOKUP(RC" & outletNumCol & ",OutletsCollation!C2:C4,3,0)"
Range(Cells(2, 2), Cells(LastR, 2)).FormulaR1C1 = "=RC" & orderNumCol & "&VLOOKUP(RC" & productIdNumCol & ",ProductsCollation!C2:C4,3,0)&VLOOKUP(RC" & outletNumCol & ",OutletsCollation!C2:C4,3,0)&""_"""
SetFormula LastR, LastС, lastCS

'СІЛЬПО -----------------------
ElseIf Buyer = "Сільпо" Then
 Sheets("Коментарі").Activate

    LastR = Cells(1, 1).End(xlDown).Row
    Columns(1).Insert
    Cells(1, 1).Value = "ID"
    LastС = Cells(1, 1).End(xlToRight).Column + 1
    Cells(1, LastС + 1).Value = "Коментар"
    Cells(1, LastС).Value = "Факт. кількисть реал."
        
        On Error GoTo altSet
    Set r = Range("1:1").Find("SAPID заказа", , xlValues, xlWhole, , , False)
altSet:         Set r = Range("1:1").Find("Дата приходу", , xlValues, xlWhole, , , False)
    orderNumCol = r.Column

    Set r = Range("1:1").Find("Філіал", , xlValues, xlWhole, , , False)
    outletNumCol = r.Column

    Set r = Range("1:1").Find("Артикул", , xlValues, xlWhole, , , False) '
    productIdNumCol = r.Column

Range(Cells(2, 1), Cells(LastR, 1)).FormulaR1C1 = "=TEXT(RC" & orderNumCol & ",""ГГГГММДД"")&""_""& VLOOKUP(RC" & productIdNumCol & ",ProductsCollation!C2:C5,4,0)&VLOOKUP(RC" & outletNumCol & ",OutletsCollation!C2:C4,3,0)"
Range(Cells(2, LastС + 1), Cells(LastR, LastС + 1)).FormulaR1C1 = "=VLOOKUP(RC1,Отгрузки!C1:C" & lastCS & "," & lastCS & ",0)"

'Range(Cells(2, LastС), Cells(LastR, LastС)).FormulaR1C1 = "=SUMIF(Отгрузки!C1,Коментарі!RC1,Отгрузки!C13)"
SetFormula LastR, LastС, lastCS

'НОВУС -----------------------
ElseIf Buyer = "Novus" Then

Sheets("Коментарі").Activate

LastR = Cells(1, 1).End(xlDown).Row
Columns(1).Insert
Cells(1, 1).Value = "IDO"
Columns(1).Insert
Cells(1, 1).Value = "IDD"
LastС = Cells(1, 1).End(xlToRight).Column + 1

Range(Cells(2, 1), Cells(LastR, 1)).FormulaR1C1 = "=TEXT(RC6,""ГГГГММДД"")&""_""& VLOOKUP(RC8,ProductsCollation!C2:C5,3,0)&VLOOKUP(RC3,OutletsCollation!C3:C4,2,0)"
Range(Cells(2, 2), Cells(LastR, 2)).FormulaR1C1 = "=RC4&VLOOKUP(RC8,ProductsCollation!C2:C4,3,0)&VLOOKUP(RC3,OutletsCollation!C3:C4,2,0)&""_"""


SetFormula LastR, LastС, lastCS

End If

End Sub

Sub ATBfinesComb()
ActiveWindow.DisplayWorkbookTabs = True 'Показать ярлыки листов
ActiveSheet.Copy Before:=Sheets(1)
ActiveSheet.Name = "Коментарі"
Cells.UnMerge
Cells.ClearOutline
ActiveWindow.FreezePanes = False
Dim r As Range, n As Long, delR As String, dateSalesCol As Range, LastR As Long, LastС As Long
Set r = Range("A:A").Find("Наименование склада", , xlValues, xlWhole, , , False)
n = r.Row
delR = "1:" & n - 1
Rows(delR).Delete
Rows("2:3").Delete
LastR = Cells(1, 1).End(xlDown).Row

Set r = Range("1:1").Find("Номер EDI", , xlValues, xlWhole, , , False)
n = r.Column
Dim arr As Variant, clArr As Variant, i As Long
arr = Range(Cells(2, n), Cells(LastR, n)).Value
ReDim clArr(LBound(arr, 1) To UBound(arr, 1), LBound(arr, 2) To UBound(arr, 2))
For i = 1 To UBound(arr, 1)

clArr(i, 1) = Right(arr(i, 1), Len(arr(i, 1)) - InStrRev(arr(i, 1), "_"))
Next i
Range(Cells(2, n), Cells(LastR, n)).Value = clArr


Set r = Range("1:1").Find("Дата поставки", , xlValues, xlWhole, , , False)
n = r.Column
dateIdfrom = Format(Application.WorksheetFunction.Min(Columns(n)), "YYYYMMDD")
dateIdto = Format(Application.WorksheetFunction.Max(Columns(n)), "YYYYMMDD")
SetPeriodOfSales.TextBoxFrom.Text = dateIdfrom
SetPeriodOfSales.TextBoxTo.Text = dateIdto

SetPeriodOfSales.Show
End Sub
Sub FOZZYfinesComb()
ActiveWindow.DisplayWorkbookTabs = True 'Показать ярлыки листов
ActiveSheet.Copy Before:=Sheets(1)
ActiveSheet.Name = "Коментарі"
Cells.UnMerge
Cells.ClearOutline
ActiveWindow.FreezePanes = False
Dim r As Range, n As Long, delR As String, dateSalesCol As Range, LastR As Long, LastС As Long
Set r = Range("A:A").Find("Филиал", , xlValues, xlWhole, , , False)
n = r.Row
On Error Resume Next
delR = "1:" & n - 1
Rows(delR).Delete

On Error GoTo 0

LastR = Cells(1, 1).End(xlDown).Row

Set r = Range("1:1").Find("Дата поставки", , xlValues, xlWhole, , , False)
n = r.Column
dateIdfrom = Format(Application.WorksheetFunction.Min(Columns(n)), "YYYYMMDD")
dateIdto = Format(Application.WorksheetFunction.Max(Columns(n)), "YYYYMMDD")
SetPeriodOfSales.TextBoxFrom.Text = dateIdfrom
SetPeriodOfSales.TextBoxTo.Text = dateIdto

SetPeriodOfSales.Show
End Sub
Sub SILPOfinesComb()
ActiveWindow.DisplayWorkbookTabs = True 'Показать ярлыки листов
Columns.EntireColumn.Hidden = False
Rows.EntireRow.Hidden = False

ActiveSheet.Copy Before:=Sheets(1)
ActiveSheet.Name = "Коментарі"
Cells.UnMerge
Cells.ClearOutline
ActiveWindow.FreezePanes = False
Dim r As Range, n As Long, delR As String, salesDates As Range, LastR As Long, LastС As Long, i As Range
Set r = Range("A:A").Find("Філіал", , xlValues, xlWhole, , , False)
n = r.Row
On Error Resume Next
delR = "1:" & n - 1
Rows(delR).Delete

On Error GoTo 0

LastR = Cells(1, 1).End(xlDown).Row

Set r = Range("1:1").Find("Дата приходу", , xlValues, xlWhole, , , False)
n = r.Column
Set salesDates = Range(Cells(2, n), Cells(LastR, n))
salesDates.NumberFormat = "General"
For Each i In salesDates.Cells
i.Offset(, 0) = DateValue(Format(i, "dd.mm.yyyy"))
Next i
salesDates.NumberFormat = "dd.mm.yyyy"
dateIdfrom = Format(Application.WorksheetFunction.Min(Columns(n)), "YYYYMMDD")
dateIdto = Format(Application.WorksheetFunction.Max(Columns(n)), "YYYYMMDD")
SetPeriodOfSales.TextBoxFrom.Text = dateIdfrom
SetPeriodOfSales.TextBoxTo.Text = dateIdto

SetPeriodOfSales.Show

Sub NOVUSfinesComb()
ActiveWindow.DisplayWorkbookTabs = True
ActiveSheet.Copy Before:=Sheets(1)
ActiveSheet.Name = "Коментарі"
Cells.UnMerge
Cells.ClearOutline
ActiveWindow.FreezePanes = False
Dim r As Range, n As Long, delR As String, dateSalesCol As Range, LastR As Long, LastС As Long
Set r = Range("A:A").Find("Магазин", , xlValues, xlWhole, , , False)
n = r.Row
On Error Resume Next
delR = "1:" & n - 1
Rows(delR).Delete

On Error GoTo 0
LastR = Cells(1, 1).End(xlDown).Row

Set r = Range("1:1").Find("Магазин", , xlValues, xlWhole, , , False)
n = r.Column
Dim arr As Variant, clArr As Variant, i As Long
arr = Range(Cells(2, n), Cells(LastR, n)).Value
ReDim clArr(LBound(arr, 1) To UBound(arr, 1), LBound(arr, 2) To UBound(arr, 2))
For i = 1 To UBound(arr, 1)

'clArr(i, 1) = Right(arr(i, 1), Len(arr(i, 1)) - InStrRev(arr(i, 1), "~"))
charsAm = InStrRev(arr(i, 1), "~") - 1
clArr(i, 1) = Left(arr(i, 1), charsAm)
Next i
Range(Cells(2, n), Cells(LastR, n)).Value = clArr


Set r = Range("1:1").Find("Дата ожидаемой поставки", , xlValues, xlWhole, , , False)
n = r.Column
dateIdfrom = Format(Application.WorksheetFunction.Min(Columns(n)), "YYYYMMDD")
dateIdto = Format(Application.WorksheetFunction.Max(Columns(n)), "YYYYMMDD")
SetPeriodOfSales.TextBoxFrom.Text = dateIdfrom
SetPeriodOfSales.TextBoxTo.Text = dateIdto

SetPeriodOfSales.Show
End Sub
