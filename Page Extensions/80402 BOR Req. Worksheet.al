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
                SubPageLink = "Item No." = field("No."), "Location Code" = field("Location Code");
                Visible = true;
            }
        }
    }
}
