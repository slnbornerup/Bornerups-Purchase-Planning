page 80401 "BOR Req. Worksheet FactBox"
{
    Caption = 'Item Details', Comment = 'DAN="Bestilling"';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field("Reordering Policy"; ReorderingPolicy)
            {
                ApplicationArea = Planning;
                Caption = 'Reordering Policy';
                ToolTip = 'Specifies the reordering policy that is used to calculate the lot size per planning period (time bucket).';
            }
            field("Reorder Point"; ReorderingPoint)
            {
                ApplicationArea = Planning;
                Caption = 'Reorder Point';
                ToolTip = 'Specifies a stock quantity that sets the inventory below the level that you must replenish the item.';
            }
            field("Reorder Quantity"; ReorderQuantity)
            {
                ApplicationArea = Planning;
                Caption = 'Reorder Quantity';
                ToolTip = 'Specifies a standard lot size quantity to be used for all order proposals.';
            }
            field("Maximum Inventory"; MaximumInventory)
            {
                ApplicationArea = Planning;
                Caption = 'Maximum Inventory';
                ToolTip = 'Specifies a quantity that you want to use as a maximum inventory level.';
            }
            field("Safety Stock Quantity"; SafetyStockQty)
            {
                ApplicationArea = Planning;
                Caption = 'Safety Stock Quantity';
                ToolTip = 'Specifies a quantity of stock to have in inventory to protect against supply-and-demand fluctuations during replenishment lead time.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        // sæt værdierne af variablerne fra Item tabellen
        ReorderingPoint := Rec."Reorder Point";
        ReorderQuantity := Rec."Reorder Quantity";
        ReorderingPolicy := Rec."Reordering Policy";
        MaximumInventory := Rec."Maximum Inventory";
        SafetyStockQty := Rec."Safety Stock Quantity";
        if Location <> '' then begin
            //sæt værdierne af variablerne fra stockkeepingunit tabellen

            recStockKeepingUnit.SetRange("Item No.", Rec."No.");
            recStockKeepingUnit.SetRange("Location Code", Location);
            recStockKeepingUnit.SetRange("Variant Code", VariantCode);
            if recStockKeepingUnit.FindFirst() then begin
                ReorderingPoint := recStockKeepingUnit."Reorder Point";
                ReorderQuantity := recStockKeepingUnit."Reorder Quantity";
                ReorderingPolicy := recStockKeepingUnit."Reordering Policy";
                MaximumInventory := recStockKeepingUnit."Maximum Inventory";
                SafetyStockQty := recStockKeepingUnit."Safety Stock Quantity";
            end
        end;

    end;

    var

        recStockKeepingUnit: Record "Stockkeeping Unit";
        Location: Code[10];
        VariantCode: Code[10];

        ReorderingPoint: Decimal;
        ReorderQuantity: Decimal;
        ReorderingPolicy: Enum Microsoft.Inventory.Item."Reordering Policy";
        MaximumInventory: Decimal;
        SafetyStockQty: Decimal;

    procedure SetLocation(NewLocation: Code[10]; NewVariant: Code[10])
    begin
        Location := NewLocation;
        VariantCode := NewVariant;
    end;

}
