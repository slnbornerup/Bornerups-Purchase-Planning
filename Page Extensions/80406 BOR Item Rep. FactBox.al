pageextension 80406 "BOR Item Rep. FactBox" extends "Item Replenishment FactBox"
{
    layout
    {
        addbefore("Vendor No.")
        {
            field("Reordering Policy"; Rec."Reordering Policy")
            {
                ApplicationArea = Planning;
                ToolTip = 'Specifies the reordering policy that is used to calculate the lot size per planning period (time bucket).';
            }
            field("Reorder Point"; Rec."Reorder Point")
            {
                ApplicationArea = Planning;
                ToolTip = 'Specifies a stock quantity that sets the inventory below the level that you must replenish the item.';
            }
            field("Reorder Quantity"; Rec."Reorder Quantity")
            {
                ApplicationArea = Planning;
                ToolTip = 'Specifies a standard lot size quantity to be used for all order proposals.';
            }
            field("Maximum Inventory"; Rec."Maximum Inventory")
            {
                ApplicationArea = Planning;
                ToolTip = 'Specifies a quantity that you want to use as a maximum inventory level.';
            }
            field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
            {
                ApplicationArea = Planning;
                ToolTip = 'Specifies a quantity of stock to have in inventory to protect against supply-and-demand fluctuations during replenishment lead time.';
            }

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
