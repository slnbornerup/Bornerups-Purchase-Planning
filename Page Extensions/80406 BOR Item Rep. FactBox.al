pageextension 80406 "BOR Item Rep. FactBox" extends "Item Replenishment FactBox"
{
    layout
    {
        addbefore("Vendor No.")
        {
            field("Vendor Count"; VendorCount)
            {
                ApplicationArea = All;
                Caption = 'Vendor Count';
                Editable = false;
                ToolTip = 'Shows the number of vendors.';
            }

        }
    }

    var

        VendorCount: Integer;

    trigger OnAfterGetRecord()
    var
        recItemVendor: Record "Item Vendor";
    begin
        recItemVendor.SetRange("Item No.", Rec."No.");
        VendorCount := recItemVendor.Count();
    end;

}
