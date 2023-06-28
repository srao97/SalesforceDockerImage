trigger OpportunityTrigger on Opportunity (before insert, before update) {
    // This trigger runs before an Opportunity record is inserted or updated

    // Iterate over the records that triggered the trigger
    for (Opportunity opp : Trigger.new) {
        if (Trigger.isInsert) {
            // Perform actions specific to record insertions
            // Example: Set default values or perform validation
            opp.StageName = 'Prospecting';
        } else if (Trigger.isUpdate) {
            // Perform actions specific to record updates
            // Example: Validate changes or perform calculations
            if (opp.Amount > 100000) {
                opp.CloseDate = System.today().addDays(30);
            }
        }
    }
}