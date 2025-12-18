pageextension 80402 "BOR Req. Worksheet" extends "Req. Worksheet"
{
    layout
    {
        //addafter("Item Replenishment FactBox")
        addafter(Control1903326807)
        {
            part(BORItemDetails; "BOR Req. Worksheet FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
                Visible = true;
            }
            part(BORItemDetailsLocation; "BOR Req. Work. Loc. FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No."), "Location Filter" = field("Location Code");
                Visible = true;
            }

        }
        modify("Price Calculation Method")
        {
            Visible = false;
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.BORItemDetails.Page.SetLocation(Rec."Location Code", Rec."Variant Code");
        CurrPage.BORItemDetailsLocation.Page.SetLocation(Rec."Location Code", Rec."Variant Code");
        CurrPage.BORItemDetails.Page.Update();
        CurrPage.BORItemDetailsLocation.Page.Update();
        // can i repaint the subpages here ?
    end;
}
