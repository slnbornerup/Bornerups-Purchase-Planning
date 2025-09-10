table 80400 "BOR Purchase Planning Setup"
{
    Caption = 'BOR Purchase Planning Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; SettingsId; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Settings Id';
        }
        field(20; "DateFormulaSalesPerDay"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Date Formula Sales Per Day';
        }

    }
    keys
    {
        key(PK; SettingsId)
        {
            Clustered = true;
        }
    }
}
