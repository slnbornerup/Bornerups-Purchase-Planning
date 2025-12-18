page 80401 "BOR Req. Worksheet FactBox"
{
    Caption = 'Item Details', Comment = 'DAN="Varedetaljer"';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                Caption = 'Item No.', Comment = 'DAN="Varenr."';
                ApplicationArea = All;
                ToolTip = 'Specifies a number to identify the item. You can use ranges of item numbers to logically group products or to imply information about them. Or use simple numbers and item categories to group items.', Comment = 'DAN="Angiver et nummer for at identificere varen. Du kan bruge intervaller af varenumre til logisk at gruppere produkter eller til at antyde oplysninger om dem. Eller brug simple tal og varekategorier til at gruppere varer."';

                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            field(Inventory; Rec.Inventory)
            {
                Caption = 'Inventory', Comment = 'DAN="Lager"';
                ApplicationArea = All;
                ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.', Comment = 'DAN="Angiver, hvor mange enheder, såsom stykker, kasser eller dåser, af varen er på lager."';
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                Caption = 'Qty. on Purch. Order', comment = 'DAN="Antal i købsordre"';
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the item are inbound on purchase orders, meaning listed on outstanding purchase order lines.', Comment = 'DAN="Angiver, hvor mange enheder af varen, der er indgående på indkøbsordrer, hvilket betyder, at de er opført på udestående indkøbsordrelinjer."';
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                Caption = 'Qty. on Sales Order', comment = 'DAN="Antal i salgsordre"';
                ToolTip = 'Specifies how many units of the item are allocated to sales orders, meaning listed on outstanding sales orders lines.', Comment = 'DAN="Angiver, hvor mange enheder af varen, der er allokeret til salgsordrer, dvs. angivet på udestående salgsordrelinjer."';
                ApplicationArea = all;
            }


            group(Sum)
            {
                Caption = 'Total Sales', comment = 'DAN="Salg"';

                field(QtyTextArr1_2; QtyTextArr[1, 1])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }



            }
            group(ThisYear)
            {
                Caption = 'This Year', comment = 'DAN="I år"';

                field(QtyTextArr2_2; QtyTextArr[2, 1])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
                field(QtyTextArr3_2; QtyTextArr[3, 1])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
                field(QtyTextArr4_2; QtyTextArr[4, 1])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
                field(QtyTextArr5_2; QtyTextArr[5, 1])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
            }

            group(LastYear)
            {
                Caption = 'Last Year', comment = 'DAN="Sidste år"';

                field(QtyTextArr6_2; QtyTextArr[6, 1])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
                field(QtyTextArr7_2; QtyTextArr[7, 1])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
                field(QtyTextArr8_2; QtyTextArr[8, 1])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
                field(QtyTextArr9_2; QtyTextArr[9, 1])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }

            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    begin


        Item.GET(Rec."No.");
        Item.SETRANGE("Date Filter");
        Item.CALCFIELDS("Sales (Qty.)", Inventory, "Qty. on Purch. Order", "Qty. on Sales Order");

        Qty[1, 1] := Item."Sales (Qty.)";
        QtyText[1] := 'I alt';

        StartDate := CALCDATE('<-CY>', WORKDATE());
        EndDate := CALCDATE('<CY>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Sales (Qty.)");
        Qty[2, 1] := Item."Sales (Qty.)";
        QtyText[2] := FORMAT(StartDate, 0, '<Year4>');

        StartDate := CALCDATE('<-CM>', EndDate);
        EndDate := CalcDate('<CM>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Sales (Qty.)");
        Qty[3, 1] := Item."Sales (Qty.)";
        QtyText[3] := FORMAT(StartDate, 0, '<Month Text>');

        StartDate := CALCDATE('<-1M>', StartDate);
        EndDate := CALCDATE('<CM>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Sales (Qty.)");
        Qty[4, 1] := Item."Sales (Qty.)";
        QtyText[4] := FORMAT(StartDate, 0, '<Month Text>');

        StartDate := CALCDATE('<-1M>', StartDate);
        EndDate := CALCDATE('<CM>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Sales (Qty.)");
        Qty[5, 1] := Item."Sales (Qty.)";
        QtyText[5] := FORMAT(StartDate, 0, '<Month Text>');

        // last year

        StartDate := CALCDATE('<-CY-1Y>', WORKDATE());
        EndDate := CALCDATE('<CY>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Sales (Qty.)");
        Qty[6, 1] := Item."Sales (Qty.)";
        QtyText[6] := FORMAT(StartDate, 0, '<Year4>');

        StartDate := CALCDATE('<-CM>', EndDate);
        EndDate := CALCDATE('<CM>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Sales (Qty.)");
        Qty[7, 1] := Item."Sales (Qty.)";
        QtyText[7] := FORMAT(StartDate, 0, '<Month Text>');

        StartDate := CALCDATE('<-1M>', StartDate);
        EndDate := CALCDATE('<CM>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Sales (Qty.)");
        Qty[8, 1] := Item."Sales (Qty.)";
        QtyText[8] := FORMAT(StartDate, 0, '<Month Text>');

        StartDate := CALCDATE('<-1M>', StartDate);
        EndDate := CALCDATE('<CM>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Sales (Qty.)");
        Qty[9, 1] := Item."Sales (Qty.)";
        QtyText[9] := FORMAT(StartDate, 0, '<Month Text>');

        QtyTextArr[1, 1] := COPYSTR(QtyText[1] + Leading(FORMAT(Qty[1, 1]), 30, ' '), 1, 60);
        QtyTextArr[2, 1] := COPYSTR(QtyText[2] + Leading(FORMAT(Qty[2, 1]), 30, ' '), 1, 60);
        QtyTextArr[3, 1] := COPYSTR(QtyText[3] + Leading(FORMAT(Qty[3, 1]), 30, ' '), 1, 60);
        QtyTextArr[4, 1] := COPYSTR(QtyText[4] + Leading(FORMAT(Qty[4, 1]), 30, ' '), 1, 60);
        QtyTextArr[5, 1] := COPYSTR(QtyText[5] + Leading(FORMAT(Qty[5, 1]), 30, ' '), 1, 60);
        QtyTextArr[6, 1] := COPYSTR(QtyText[6] + Leading(FORMAT(Qty[6, 1]), 30, ' '), 1, 60);
        QtyTextArr[7, 1] := COPYSTR(QtyText[7] + Leading(FORMAT(Qty[7, 1]), 30, ' '), 1, 60);
        QtyTextArr[8, 1] := COPYSTR(QtyText[8] + Leading(FORMAT(Qty[8, 1]), 30, ' '), 1, 60);
        QtyTextArr[9, 1] := COPYSTR(QtyText[9] + Leading(FORMAT(Qty[9, 1]), 30, ' '), 1, 60);

    end;

    var
        Item: Record Item;
        Qty: array[9, 1] of Decimal;
        QtyText: array[9] of Text[30];
        StartDate: Date;
        EndDate: Date;
        //StartDateArr: array [6] of Date;
        Text001: Label 'Tekstens længde %1 er længere end den tilladte længde %2';
        QtyTextArr: array[9, 1] of Text[60];

    local procedure ShowDetails()
    begin
        PAGE.RUN(PAGE::"Item Card", Rec);
    end;

    local procedure Leading(String: Text[250]; Length: Integer; LeadChar: Text[1]): Text
    begin
        // Leading      //Højrestillet
        // 1. This function takes 3 parameters. The original string.
        // 2. The length of the string that should be returned.
        // 3. The leading character.
        if STRLEN(String) > Length then ERROR(Text001, String, Length);
        exit(PADSTR('', Length - STRLEN(String), LeadChar) + String);
    end;

    local procedure Trailing(String: Text[250]; Length: Integer; Trailchar: Text[1]): Text
    begin
        // Trailing     //Venstrestillet
        // 1. This function takes 3 parameters. The original string.
        // 2. The length of the string that should be returned.
        // 3. The trailing character.
        if STRLEN(String) > Length then ERROR(Text001, String, Length);
        exit(PADSTR(String, Length, Trailchar));
    end;
}
