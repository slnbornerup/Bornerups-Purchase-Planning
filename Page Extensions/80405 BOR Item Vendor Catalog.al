pageextension 80405 "BOR Item Vendor Catalog" extends "Item Vendor Catalog"
{
    layout
    {
        addlast(Control1) // brug korrekt navn fra Page Inspector
        {
            field(Price; Price)
            {
                ApplicationArea = All;
                Caption = 'Price';
                Editable = false;
                ToolTip = 'Show the current price from the vendor.';
            }
            field(DiscountPercentage; Discount)
            {
                ApplicationArea = All;
                Caption = 'Line Discount Percentage';
                Editable = false;
                ToolTip = 'Shows the discount from the vendor.';
            }
            field(UnitOfMeasure; UoM)
            {
                ApplicationArea = All;
                Caption = 'Unit of Measure';
                Editable = false;
                ToolTip = 'Shows the Unit of Measure from the vendor.';
            }
            field(MinimumQuantity; MinimumQty)
            {
                ApplicationArea = All;
                Caption = 'Minimum Quantity';
                Editable = false;
                ToolTip = 'Shows the Minimum Quantity from the vendor.';
            }
        }
    }

    var
        Price: Decimal;
        Discount: Decimal;
        UoM: Code[10];

        MinimumQty: Decimal;

    trigger OnAfterGetRecord()
    var
        recPriceListLine: Record "Price List Line";
        recPriceList: Record "Price List Header";
    begin
        Clear(Price);

        recPriceList.Reset();
        recPriceList.SetRange("Source Group", recPriceList."Source Group"::Vendor);
        recPriceList.SetRange("Source No.", Rec."Vendor No.");
        recPriceList.SetRange("Price Type", recPriceList."Price Type"::Purchase);
        recPriceList.SetRange("Status", recPriceList."Status"::Active);
        //recPriceList.SetFilter("Starting Date", '<=%1', Today);

        // Filtrér linjer efter leverandør og vare
        recPriceListLine.Reset();
        recPriceListLine.SetRange("Asset No.", Rec."Item No.");
        recPriceListLine.SetRange("Source No.", Rec."Vendor No.");

        Price := 0;

        if recPriceList.FindSet() then
            repeat
                if recPriceListLine.FindSet() then
                    repeat
                        if (Price = 0) or (recPriceListLine."Unit Price" < Price) then begin
                            Price := recPriceListLine."Direct Unit Cost";
                            Discount := recPriceListLine."Line Discount %";
                            UoM := recPriceListLine."Unit of Measure Code";
                            MinimumQty := recPriceListLine."Minimum Quantity";
                        end;
                    until recPriceListLine.Next() = 0;
            until recPriceList.Next() = 0;
    end;
}
