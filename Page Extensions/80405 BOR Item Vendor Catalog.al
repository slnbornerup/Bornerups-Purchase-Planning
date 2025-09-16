pageextension 80405 "BOR Item Vendor Catalog" extends "Item Vendor Catalog"
{
    layout
    {
        addlast(Control1) // brug korrekt navn fra Page Inspector
        {
            field(CurrentPurchasePrice; CurrentVendorPrice)
            {
                ApplicationArea = All;
                Caption = 'Current Purchase Price';
                Editable = false;
                ToolTip = 'Viser den gældende pris fra Purchase Prices.';
            }
        }
    }

    var
        CurrentVendorPrice: Decimal;

    trigger OnAfterGetRecord()
    var
        recPriceListLine: Record "Price List Line";
        recPriceList: Record "Price List Header";
    begin
        Clear(CurrentVendorPrice);

        recPriceList.Reset();
        recPriceList.SetRange("Source Group", recPriceList."Source Group"::Vendor);
        recPriceList.SetRange("Source No.", Rec."Vendor No.");
        recPriceList.SetRange("Price Type", recPriceList."Price Type"::Purchase);
        recPriceList.SetRange("Status", recPriceList."Status"::Active);
        recPriceList.SetFilter("Starting Date", '<=%1', Today);

        // Filtrér linjer efter leverandør og vare
        recPriceListLine.Reset();
        recPriceListLine.SetRange("Asset No.", Rec."Item No.");

        CurrentVendorPrice := 0;

        if recPriceList.FindSet() then
            repeat
                if recPriceListLine.FindSet() then
                    repeat
                        if (CurrentVendorPrice = 0) or (recPriceListLine."Unit Price" < CurrentVendorPrice) then
                            CurrentVendorPrice := recPriceListLine."Unit Price";
                    until recPriceListLine.Next() = 0;
            until recPriceList.Next() = 0;
    end;
}
