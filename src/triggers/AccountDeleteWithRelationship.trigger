trigger AccountDeleteWithRelationship on Account (before delete) {
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            Schema.Sobjecttype SobjectType = Trigger.old[0].getSObjectType();
            String objType = String.valueof(SobjectType);
            Set<String> schildObjs = new Set<String>();
            ShallowDeleteChildObject__mdt childobj=[SELECT Id,
                                                               Child_Object_Names__c,
                                                                Object__c
                                                        FROM ShallowDeleteChildObject__mdt
                                                        WHERE Object__c=:objType
                                                        LIMIT 1];
            if(childobj.Child_Object_Names__c != NULL){                                               
            for(String childNames:childobj.Child_Object_Names__c.split(';')){
                schildObjs.add(childNames);
            }                  
         }                                               
                                                        
            
            for ( Account acc  :Trigger.old ){
                System.debug('***1 '+schildObjs);
                ShallowDeleteWithChildRecords.init2(acc ,schildObjs );
            }
        }
    }
   
    

}