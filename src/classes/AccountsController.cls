/*******************************************************************************************************
    * @author  : SARAVANAN C
    * @date    :  12 Jan 2017
    * @modified : 12 Jan 2017
    * @group    :  
    * @group-content : 
    * @description : Example SDLS Class - Can be deleted
********************************************************************************************************/

Public with sharing class AccountsController {
    
    
     /*******************************************************************************************************
    * @description :  
    * @param : NA
    * @param : 
    * @return :  
    * @example 
    *  
    *******************************************************************************************************/
    //Use @AuraEnabled to enable client- and server-side access to the method
    @AuraEnabled
    public static String recoverDelRecord( String recoverId) {
        
         System.Debug(' recoverId ==> '+ recoverId);
        
        /* if ( ShallowServiceCls.recoverDelete(recoverId) <> NULL ) {

             return 'Record Successfully Recovered!' ;

         } else {
             return null;
         }
         
         */
        
        return ShallowServiceCls.recoverDelete(recoverId) ;
    }   
    
    
    //Use @AuraEnabled to enable client- and server-side access to the method
    @AuraEnabled
    public static List<WrapperClass> getDeletedRecords() {
    
        List<WrapperClass> Records =  New List<WrapperClass> ();
        
        Shallow_Delete__c[] ShallowRecords = [SELECT Id, Name, Object__c, Deleted_by__r.Name, Deleted_on__c
                                                FROM Shallow_Delete__c ORDER BY CreatedDate ASC];
        
        for ( Shallow_Delete__c a : ShallowRecords ){
            Records.add( new WrapperClass (a)  );
        } 
        
        
        return Records ; 
     }   
    
     
    Public Class WrapperClass  {
        
        @AuraEnabled Public String recId ;
        @AuraEnabled Public String Name ;
        @AuraEnabled Public String Obj ;
        @AuraEnabled Public String DeletedBy ;
        @AuraEnabled Public String DeletedOn ;
        
        Public WrapperClass ( Shallow_Delete__c DelRecord) {
            recId     = DelRecord.Id ;
            Name      = DelRecord.Name ;
            DeletedOn = DelRecord.Deleted_on__c.format('MM/dd/YYYY');
            DeletedBy = DelRecord.Deleted_by__r.Name ;
            Obj       = DelRecord.Object__c ;
        }
        
        
    }
    
    
    
    
}