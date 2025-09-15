page 80402 "BOR Req. Work. Loc. FactBox"
{
    Caption = 'Location Details', Comment = 'DAN="Varedetaljer"';
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
            field("Reorder Point"; Rec."Reorder Point")
            {
                Caption = 'Reorder Point', Comment = 'DAN="Genbestillingspunkt"';
                ToolTip = 'Specifies a stock quantity that sets the inventory below the level that you must replenish the item.', Comment = 'DAN=" "';
                ApplicationArea = all;
            }
            field("Reorder Quantity"; Rec."Reorder Quantity")
            {
                Caption = 'Reorder Quantity', Comment = 'DAN="Genbestillings antal"';
                ToolTip = 'Specifies a standard lot size quantity to be used for all order proposals.', Comment = 'DAN=" "';
                ApplicationArea = all;
            }

            group(Salg)
            {
                Caption = 'Sale', comment = 'DAN="Salg"';

                field(QtyTextArr1_2; QtyTextArr[1, 2])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
                field(QtyTextArr2_2; QtyTextArr[2, 2])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
                field(QtyTextArr3_2; QtyTextArr[3, 2])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
                field(QtyTextArr4_2; QtyTextArr[4, 2])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
                field(QtyTextArr5_2; QtyTextArr[5, 2])
                {
                    caption = '', comment = 'DAN=" "';
                    ApplicationArea = All;
                    ToolTip = 'Some Quantity', comment = 'DAN=" "';
                }
                field(QtyTextArr6_2; QtyTextArr[6, 2])
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

        // Refactor - Anette dont think that it is relevant with earlier purchases
        Item.GET(Rec."No.");
        Item.SETRANGE("Date Filter");
        Item.SetRange("Location Filter");

        Item.CALCFIELDS("Purchases (Qty.)", "Sales (Qty.)", Inventory, "Qty. on Purch. Order", "Qty. on Sales Order");
        Qty[1, 1] := Item."Purchases (Qty.)";
        Qty[1, 2] := Item."Sales (Qty.)";
        QtyText[1] := 'I alt';
        StartDate := CALCDATE('<-CY-1Y>', WORKDATE());
        EndDate := CALCDATE('<CY>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Purchases (Qty.)", "Sales (Qty.)");
        Qty[2, 1] := Item."Purchases (Qty.)";
        Qty[2, 2] := Item."Sales (Qty.)";
        QtyText[2] := FORMAT(StartDate, 0, '<Year4>');
        StartDate := CALCDATE('<-CY>', WORKDATE());
        EndDate := CALCDATE('<CY>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Purchases (Qty.)", "Sales (Qty.)");
        Qty[3, 1] := Item."Purchases (Qty.)";
        Qty[3, 2] := Item."Sales (Qty.)";
        QtyText[3] := FORMAT(StartDate, 0, '<Year4>');
        StartDate := CALCDATE('<-CM>', WORKDATE());
        EndDate := CALCDATE('<CM>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Purchases (Qty.)", "Sales (Qty.)");
        Qty[6, 1] := Item."Purchases (Qty.)";
        Qty[6, 2] := Item."Sales (Qty.)";
        QtyText[6] := FORMAT(StartDate, 0, '<Month Text>');
        StartDate := CALCDATE('<-1M>', StartDate);
        EndDate := CALCDATE('<CM>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Purchases (Qty.)", "Sales (Qty.)");
        Qty[5, 1] := Item."Purchases (Qty.)";
        Qty[5, 2] := Item."Sales (Qty.)";
        QtyText[5] := FORMAT(StartDate, 0, '<Month Text>');
        StartDate := CALCDATE('<-1M>', StartDate);
        EndDate := CALCDATE('<CM>', StartDate);
        Item.SETRANGE("Date Filter", StartDate, EndDate);
        Item.CALCFIELDS("Purchases (Qty.)", "Sales (Qty.)");
        Qty[4, 1] := Item."Purchases (Qty.)";
        Qty[4, 2] := Item."Sales (Qty.)";
        QtyText[4] := FORMAT(StartDate, 0, '<Month Text>');
        QtyTextArr[1, 2] := COPYSTR(Trailing(QtyText[1], 30, ' ') + Leading(FORMAT(Qty[1, 2]), 30, ' '), 1, 60);
        QtyTextArr[2, 2] := COPYSTR(Trailing(QtyText[2], 30, ' ') + Leading(FORMAT(Qty[2, 2]), 30, ' '), 1, 60);
        QtyTextArr[3, 2] := COPYSTR(Trailing(QtyText[3], 30, ' ') + Leading(FORMAT(Qty[3, 2]), 30, ' '), 1, 60);
        QtyTextArr[4, 2] := COPYSTR(Trailing(QtyText[4], 30, ' ') + Leading(FORMAT(Qty[4, 2]), 30, ' '), 1, 60);
        QtyTextArr[5, 2] := COPYSTR(Trailing(QtyText[5], 30, ' ') + Leading(FORMAT(Qty[5, 2]), 30, ' '), 1, 60);
        QtyTextArr[6, 2] := COPYSTR(Trailing(QtyText[6], 30, ' ') + Leading(FORMAT(Qty[6, 2]), 30, ' '), 1, 60);
        QtyTextArr[1, 1] := COPYSTR(Trailing(QtyText[1], 30, ' ') + Leading(FORMAT(Qty[1, 1]), 30, ' '), 1, 60);
        QtyTextArr[2, 1] := COPYSTR(Trailing(QtyText[2], 30, ' ') + Leading(FORMAT(Qty[2, 1]), 30, ' '), 1, 60);
        QtyTextArr[3, 1] := COPYSTR(Trailing(QtyText[3], 30, ' ') + Leading(FORMAT(Qty[3, 1]), 30, ' '), 1, 60);
        QtyTextArr[4, 1] := COPYSTR(Trailing(QtyText[4], 30, ' ') + Leading(FORMAT(Qty[4, 1]), 30, ' '), 1, 60);
        QtyTextArr[5, 1] := COPYSTR(Trailing(QtyText[5], 30, ' ') + Leading(FORMAT(Qty[5, 1]), 30, ' '), 1, 60);
        QtyTextArr[6, 1] := COPYSTR(Trailing(QtyText[6], 30, ' ') + Leading(FORMAT(Qty[6, 1]), 30, ' '), 1, 60);
    end;

    var
        Item: Record Item;
        Qty: array[6, 2] of Decimal;
        QtyText: array[6] of Text[30];
        StartDate: Date;
        EndDate: Date;
        //StartDateArr: array [6] of Date;
        Text001: Label 'Tekstens længde %1 er længere end den tilladte længde %2';
        QtyTextArr: array[6, 2] of Text[60];

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
