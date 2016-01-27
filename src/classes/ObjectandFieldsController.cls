public class ObjectandFieldsController {
    public PageReference pagerefresh(){
        return null;
    }
    Schema.DescribeSObjectResult objDescribe;
    public String selectedObject{get;set;}
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public List<SelectOption> listofpermsets 
    {
        get{
            List<SelectOption> listofpermsets = new List<SelectOption>();
            DateTime BeginningDate = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC][24].CreatedDate;
            List<PermissionSet> PS = [SELECT Id,Name,CreatedDate FROM PermissionSet WHERE CreatedDate>:BeginningDate order by CreatedDate DESC];
            for (PermissionSet s:PS){
                listofpermsets.add(new SelectOption(s.id, s.Name));
            }
            return listofpermsets;
        }
        set;
    }
    public List<String> ListofObjects{
        get{
            List<String> ListofObjects = new List<String>();
            Map<String, Boolean> MapofReadPermissions = new Map<String, Boolean>();
            List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                ListOfObjects.add(nameofob);
        }
            return ListOfObjects;
    }
        set;
    }
    
    public String chosenPermSetNames {get;set;}
    
    public Map<String, Boolean> MapofReadPermissionsOb
    {
        get{
            Map<String, Boolean> MapofReadPermissionsOb = new Map<String, Boolean>();
            List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }
            DateTime BeginningDate = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1][0].CreatedDate;
            List<PermissionSet> psets = [SELECT Id,Name,CreatedDate FROM PermissionSet WHERE Id=:chosenPermSetNames order by CreatedDate DESC];
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                Map<PermissionSet, Boolean> InMap = new Map<PermissionSet, Boolean>();
                List<ObjectPermissions> tempPSs = [SELECT Id,ParentId,PermissionsCreate,PermissionsDelete,PermissionsEdit,PermissionsModifyAllRecords,PermissionsRead,PermissionsViewAllRecords,SobjectType FROM ObjectPermissions WHERE SObjectType=:nameofob AND PermissionsRead=true];
                Set<Id> tempSet = new Set<Id>();
                boolean response = false;
                for(ObjectPermissions s: tempPSs)
                {
                     tempSet.add(s.ParentId);
                }
                for (PermissionSet p:psets)
                {
                    response = (tempSet.contains(p.id));
                 }
                MapofReadPermissionsOb.put(nameofob, response);
             }
            return MapofReadPermissionsOb;
        }
        set;
    }
    public Map<String, Boolean> MapofEditPermissionsOb
    {
        get{
            Map<String, Boolean> MapofEditPermissionsOb = new Map<String, Boolean>();
            List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }
            DateTime BeginningDate = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1][0].CreatedDate;
            List<PermissionSet> psets = [SELECT Id,Name,CreatedDate FROM PermissionSet WHERE Id=:chosenPermSetNames order by CreatedDate DESC];
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                Map<PermissionSet, Boolean> InMap = new Map<PermissionSet, Boolean>();
                List<ObjectPermissions> tempPSs = [SELECT Id,ParentId,PermissionsCreate,PermissionsDelete,PermissionsEdit,PermissionsModifyAllRecords,PermissionsRead,PermissionsViewAllRecords,SobjectType FROM ObjectPermissions WHERE SObjectType=:nameofob AND PermissionsEdit=true];
                Set<Id> tempSet = new Set<Id>();
                boolean response = false;
                for(ObjectPermissions s: tempPSs)
                {
                     tempSet.add(s.ParentId);
                }
                for (PermissionSet p:psets)
                {
                    response = (tempSet.contains(p.id));
                 }
                MapofEditPermissionsOb.put(nameofob, response);
             }
            return MapofEditPermissionsOb;
        }
        set;
    }
    public Map<String, Boolean> MapofCreatePermissionsOb
    {
        get{
            Map<String, Boolean> MapofCreatePermissionsOb = new Map<String, Boolean>();
            List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }
            DateTime BeginningDate = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1][0].CreatedDate;
            List<PermissionSet> psets = [SELECT Id,Name,CreatedDate FROM PermissionSet WHERE Id=:chosenPermSetNames order by CreatedDate DESC];
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                Map<PermissionSet, Boolean> InMap = new Map<PermissionSet, Boolean>();
                List<ObjectPermissions> tempPSs = [SELECT Id,ParentId,PermissionsCreate,PermissionsDelete,PermissionsEdit,PermissionsModifyAllRecords,PermissionsRead,PermissionsViewAllRecords,SobjectType FROM ObjectPermissions WHERE SObjectType=:nameofob AND PermissionsCreate=true];
                Set<Id> tempSet = new Set<Id>();
                boolean response = false;
                for(ObjectPermissions s: tempPSs)
                {
                     tempSet.add(s.ParentId);
                }
                for (PermissionSet p:psets)
                {
                    response = (tempSet.contains(p.id));
                 }
                MapofCreatePermissionsOb.put(nameofob, response);
             }
            return MapofCreatePermissionsOb;
        }
        set;
    }
    public Map<String, Boolean> MapofDeletePermissionsOb
    {
        get{
            Map<String, Boolean> MapofDeletePermissionsOb = new Map<String, Boolean>();
            List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }
            DateTime BeginningDate = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1][0].CreatedDate;
            List<PermissionSet> psets = [SELECT Id,Name,CreatedDate FROM PermissionSet WHERE Id=:chosenPermSetNames order by CreatedDate DESC];
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                Map<PermissionSet, Boolean> InMap = new Map<PermissionSet, Boolean>();
                List<ObjectPermissions> tempPSs = [SELECT Id,ParentId,PermissionsCreate,PermissionsDelete,PermissionsEdit,PermissionsModifyAllRecords,PermissionsRead,PermissionsViewAllRecords,SobjectType FROM ObjectPermissions WHERE SObjectType=:nameofob AND PermissionsDelete=true];
                Set<Id> tempSet = new Set<Id>();
                boolean response = false;
                for(ObjectPermissions s: tempPSs)
                {
                     tempSet.add(s.ParentId);
                }
                for (PermissionSet p:psets)
                {
                    response = (tempSet.contains(p.id));
                 }
                MapofDeletePermissionsOb.put(nameofob, response);
             }
            return MapofDeletePermissionsOb;
        }
        set;
    }
    
    
     @RemoteAction
    public static String ChangeReadPermOb(String selectedPSet, String selectedObjectName){
        try{
        String response1 = '';
        PermissionSet ppp= [SELECT Id, Name FROM PermissionSet WHERE Id =: selectedPSet LIMIT 1][0];
        List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }
            ID CurrentUserID = UserInfo.getUserId();
            DateTime BeginningDate = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1][0].CreatedDate;
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                                Set<String> tempName = new Set<String>();
                tempName.add(nameofob);
                if(tempName.contains(selectedObjectName)){
                    List<ObjectPermissions> existingOP = new List<ObjectPermissions>();
                        existingOP =[SELECT Id,ParentId,PermissionsCreate,PermissionsDelete,PermissionsEdit,PermissionsModifyAllRecords,PermissionsRead,PermissionsViewAllRecords,SobjectType FROM ObjectPermissions WHERE SObjectType=:nameofob AND ParentId=:selectedPSet];
                    if (existingOP.isEmpty()){
                        ObjectPermissions newOP = new ObjectPermissions();
                        newOP.ParentId = selectedPSet;
                        newOP.SobjectType = nameofob;
                        newOP.PermissionsRead = true;
                        insert newOP;
                        response1 = 'Success!  The ability for the Object '+selectedObjectName+' to be read has been added to the Permission Set '+ppp.Name;
                    }
                    else{
                        System.debug('**The existing PS looks like this: '+existingOP);
                        for (ObjectPermissions opp: existingOP){
                            delete opp;
                        }
                        response1 = 'Success!  The ability for the Object '+selectedObjectName+' to be read has been removed from the Permission Set '+ppp.Name;
                        }
                }
            }
            return response1;
        }
        catch(DmlException e){
           String response2 = 'The save failed because you are trying to assign or remove a permission from a child object that requires a different permission on the parent object.  Please change the parent object permission first, then try again.';
           return response2;
        }
        catch(Exception e){
           String response3 = 'The following error occurred: '+e;
           return response3;
        }
    }          

    @RemoteAction
    public static String ChangeEditPermOb(String selectedPSet, String selectedObjectName){
    try{
        String response1 = '';
        PermissionSet ppp= [SELECT Id, Name FROM PermissionSet WHERE Id =: selectedPSet LIMIT 1][0];
        List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }
            ID CurrentUserID = UserInfo.getUserId();
            DateTime BeginningDate = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1][0].CreatedDate;
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                                Set<String> tempName = new Set<String>();
                tempName.add(nameofob);
                if(tempName.contains(selectedObjectName)){
                    List<ObjectPermissions> existingOP = new List<ObjectPermissions>();
                        existingOP =[SELECT Id,ParentId,PermissionsCreate,PermissionsDelete,PermissionsEdit,PermissionsModifyAllRecords,PermissionsRead,PermissionsViewAllRecords,SobjectType FROM ObjectPermissions WHERE SObjectType=:nameofob AND ParentId=:selectedPSet];
                    if (existingOP.isEmpty()){
                        ObjectPermissions newOP = new ObjectPermissions();
                        newOP.ParentId = selectedPSet;
                        newOP.SobjectType = nameofob;
                        newOP.PermissionsRead = true;
                        newOP.PermissionsEdit = true;
                        insert newOP;
                        response1= 'The ability for the Object '+selectedObjectName+' to be edited and read has been added to the Permission Set '+ppp.Name;
                    }
                    else{
                        for (ObjectPermissions op: existingOP){
                            if(op.PermissionsEdit==false){
                              op.PermissionsEdit = true;
                              update op;
                              response1= 'The ability for the Object '+selectedObjectName+' to be edited has been added to the Permission Set '+ppp.Name;
                            }
                                else if(op.PermissionsEdit == true){
                              op.PermissionsEdit = false;
                              op.PermissionsCreate = false;
                              op.PermissionsDelete = false;
                              update op;    
                             response1 = 'The ability for the Object '+selectedObjectName+' to be edited has been removed from the Permission Set '+ppp.Name;
                                        }
                        }
                        }
                }
            }
        String s= 'Success! ';
        return s+response1;
    }
    catch(DmlException e){
        String response2 = 'The save failed because you are trying to assign or remove a permission from a child object that requires a different permission on the parent object.  Please change the parent object permission first, then try again.';
        return response2;
    }
    catch(Exception e){
        String response3 = 'The following error occurred: '+e;
        return response3;
    }
 }

    @RemoteAction
    public static String ChangeCreatePermOb(String selectedPSet, String selectedObjectName){
    try{
        String response1 = '';
        PermissionSet ppp= [SELECT Id, Name FROM PermissionSet WHERE Id =: selectedPSet LIMIT 1][0];
        List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }
            ID CurrentUserID = UserInfo.getUserId();
            DateTime BeginningDate = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1][0].CreatedDate;
                for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                                Set<String> tempName = new Set<String>();
                tempName.add(nameofob);
                if(tempName.contains(selectedObjectName)){
                    List<ObjectPermissions> existingOP = new List<ObjectPermissions>();
                        existingOP =[SELECT Id,ParentId,PermissionsCreate,PermissionsDelete,PermissionsEdit,PermissionsModifyAllRecords,PermissionsRead,PermissionsViewAllRecords,SobjectType FROM ObjectPermissions WHERE SObjectType=:nameofob AND ParentId=:selectedPSet];
                    if (existingOP.isEmpty()){
                        ObjectPermissions newOP = new ObjectPermissions();
                        newOP.ParentId = selectedPSet;
                        newOP.SobjectType = nameofob;
                        newOP.PermissionsRead = true;
                        newOP.PermissionsCreate = true;
                        insert newOP;
                        response1= 'The ability for the Object '+selectedObjectName+' to be created and read has been added to the Permission Set '+ppp.Name;
                    }
                    else{
                        for (ObjectPermissions op: existingOP){
                              if(op.PermissionsCreate==false){
                              op.PermissionsCreate = true;
                              update op;
                              response1 ='The ability for the Object '+selectedObjectName+' to be created has been added to the Permission Set '+ppp.Name;
                              }
                        else if(op.PermissionsCreate == true){
                              op.PermissionsCreate = false;
                              update op;     
                             response1= 'The ability for the Object '+selectedObjectName+' to be created has been removed from the Permission Set '+ppp.Name;
                                }
                    }
                }
            }
        }
        String s= 'Success! ';
        return s+response1;
    }
    catch(DmlException e){
        String response2 = 'The save failed because you are trying to assign or remove a permission from a child object that requires a different permission on the parent object.  Please change the parent object permission first, then try again.';
        return response2;
    }
    catch(Exception e){
        String response3 = 'The following error occurred: '+e;
        return response3;
    }
 }

    @RemoteAction
    public static String ChangeDeletePermOb(String selectedPSet, String selectedObjectName){
    try{
        String response1 = '';
        PermissionSet ppp= [SELECT Id, Name FROM PermissionSet WHERE Id =: selectedPSet LIMIT 1][0];
        List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }
            ID CurrentUserID = UserInfo.getUserId();
            DateTime BeginningDate = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1][0].CreatedDate;
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                                Set<String> tempName = new Set<String>();
                tempName.add(nameofob);
                if(tempName.contains(selectedObjectName)){
                    List<ObjectPermissions> existingOP = new List<ObjectPermissions>();
                        existingOP =[SELECT Id,ParentId,PermissionsCreate,PermissionsDelete,PermissionsEdit,PermissionsModifyAllRecords,PermissionsRead,PermissionsViewAllRecords,SobjectType FROM ObjectPermissions WHERE SObjectType=:nameofob AND ParentId=:selectedPSet];
                    if (existingOP.isEmpty()){
                        ObjectPermissions newOP = new ObjectPermissions();
                        newOP.ParentId = selectedPSet;
                        newOP.SobjectType = nameofob;
                        newOP.PermissionsRead = true;
                        newOP.PermissionsEdit = true;
                        newOP.PermissionsDelete = true;
                        insert newOP;
                        response1= 'The ability for the Object '+selectedObjectName+' to be deleted, edited, and read has been added to the Permission Set '+ppp.Name;
                    }
                    else{
                        for (ObjectPermissions op: existingOP){
                              if(op.PermissionsDelete==false){
                              op.PermissionsEdit = true;
                              op.PermissionsDelete = true;
                              update op;
                              response1 ='The ability for the Object '+selectedObjectName+' to be deleted has been added to the Permission Set '+ppp.Name;
                              }
                        else if(op.PermissionsDelete == true){
                              op.PermissionsDelete = false;
                              update op;     
                             response1= 'The ability for the Object '+selectedObjectName+' to be deleted has been removed from the Permission Set '+ppp.Name;
                                }
                    }
                }
            }
        }
        String s= 'Success! ';
        return s+response1;
    }
    catch(DmlException e){
        String response2 = 'The save failed because you are trying to assign or remove a permission from a child object that requires a different permission on the parent object.  Please change the parent object permission first, then try again.';
        return response2;
    }
    catch(Exception e){
        String response3 = 'The following error occurred: '+e;
        return response3;
    }
 }
    
    
    
    
    //FIELD STUFF
    //
    //
    public List<String> FieldName{
        get{
            List<String> FieldName = new List<String>();
            List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }             
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                System.debug('****In field list, the selected object is: '+selectedObject+' and name of ob is: '+nameofob);
                if (nameofob.equalsIgnoreCase(selectedObject)){
                    System.debug('****This worked.... matches name of object');
                        Map<String,Schema.SObjectField> mfields = ob.getDescribe().fields.getMap();
                        List<Schema.SObjectField> objectFields = mfields.values();
                    System.debug('*****The fields to iterate through are: '+objectFields);
                        for(Schema.SObjectField o:objectFields)
                        {
                        String fieldString = String.valueOf(o);
                        String actual = nameofob+'.'+fieldString;
                        System.debug('*****The field is: '+fieldString+' and object.field is: '+actual);
                        if(mfields.get(fieldString).getDescribe().iscustom()) {
                                if(mfields.get(fieldString).getDescribe().isUpdateable()) { 
                                System.debug('****custom and updateable object!');
                                FieldName.add(fieldString);
                                System.debug('****The final list of field names that should display is: '+FieldName);
                                
                                }
                        }
           
                }
                }
            }
            return FieldName;
        }
        set;
    }
       public Map<String, Boolean> MapofReadPermissionsField
    {
        get
        {
            Map<String, Boolean> MapofReadPermissionsField = new Map<String, Boolean>();
            List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }             
            DateTime BeginningDate = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1][0].CreatedDate;
            List<PermissionSet> Perms = [SELECT Id,Name,CreatedById,CreatedDate FROM PermissionSet WHERE Id=:chosenPermSetNames];                   
            System.debug('***The variable chosenpermsetsnames is: '+chosenPermSetNames);
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                if (selectedObject == nameofob){
                Map<String,Schema.SObjectField> mfields = ob.getDescribe().fields.getMap();
                List<Schema.SObjectField> objectFields = mfields.values();
                for(Schema.SObjectField o:objectFields)
                {
                    String fieldString = String.valueOf(o);
                    if(mfields.get(fieldString).getDescribe().iscustom()) {
                        if(mfields.get(fieldString).getDescribe().isUpdateable()) {  
                                Map<PermissionSet, Boolean> InMap = new Map<PermissionSet, Boolean>();
                                List<FieldPermissions> tempPSs = new List<FieldPermissions>();
                                        String actualName = nameofob+'.'+fieldString;
                                tempPSs = [SELECT ParentId FROM FieldPermissions WHERE Field=:actualname AND PermissionsRead=true];
                            Set<Id> tempSet = new Set<Id>();
                            boolean response = false;
                                for(FieldPermissions s: tempPSs)
                                {       
                                        tempSet.add(s.ParentId);
                                }
                                for (PermissionSet psss:Perms)
                                {
                                        response = (tempSet.contains(psss.Id));
                                }
                                MapOfReadPermissionsField.put(fieldString, response);
                                }
                                }
                }
                }
            }
        return MapofReadPermissionsField;
    }
         set;
    }
    public Map<String, Boolean> MapofEditPermissionsField
    {
        get
        {
            Map<String, Boolean> MapofEditPermissionsField = new Map<String, Boolean>();
            List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }             
            DateTime BeginningDate = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1][0].CreatedDate;
            List<PermissionSet> Perms = [SELECT Id,Name,CreatedById,CreatedDate FROM PermissionSet WHERE Id=:chosenPermSetNames];                   
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                if (nameofob == selectedObject){
                Map<String,Schema.SObjectField> mfields = ob.getDescribe().fields.getMap();
                List<Schema.SObjectField> objectFields = mfields.values();
                for(Schema.SObjectField o:objectFields)
                {
                    String fieldString = String.valueOf(o);
                    if(mfields.get(fieldString).getDescribe().iscustom()) {
                        if(mfields.get(fieldString).getDescribe().isUpdateable()) {
                                List<FieldPermissions> tempPSs = new List<FieldPermissions>();
                                        String actualName = nameofob+'.'+fieldString;
                                tempPSs = [SELECT ParentId FROM FieldPermissions WHERE Field=:actualname AND PermissionsRead=true AND PermissionsEdit=true];
                            Set<Id> tempSet = new Set<Id>();
                            boolean response = false;
                                for(FieldPermissions s: tempPSs)
                                {       
                                        tempSet.add(s.ParentId);
                                }
                                for (PermissionSet psss:Perms)
                                {
                                        response = (tempSet.contains(psss.Id));
                                }
                                MapOfEditPermissionsField.put(fieldString, response);
                                }
                    }
                }
                }
            }
        return MapofEditPermissionsField;
    }
         set;
    }
        
     @RemoteAction
    public static String changeReadPermField(String selectedPSet, String selectedFieldName){
        try{
            String response1 = '';
        List<PermissionSet> currentPermSet = new List<PermissionSet>();
        PermissionSet ppp = [SELECT Id, Name FROM PermissionSet WHERE Id =: selectedPSet LIMIT 1][0];
                List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                }
            }               
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                Map<String,Schema.SObjectField> mfields = ob.getDescribe().fields.getMap();
                List<Schema.SObjectField> objectFields = new List<Schema.SObjectField>();
                objectFields = mfields.values();
                for(Schema.SObjectField o:objectFields)
                                {
                            String returnValue = String.valueOf(o);
                                String actualName = nameofob+'.'+returnvalue;
                            if(mfields.get(returnValue).getDescribe().iscustom()) {
                                if(mfields.get(returnValue).getDescribe().isUpdateable()) {
                                        Set<String> tempName = new Set<String>();
                                        tempName.add(returnvalue);
                                        if(tempName.contains(selectedFieldName)){
                                        	List<FieldPermissions> existingFP = [SELECT Id,ParentId FROM FieldPermissions WHERE ParentId=:selectedPSet AND Field=:actualName];
                                            	if (existingFP.isEmpty()){
                                        			FieldPermissions newFP = new FieldPermissions();                                        
                                                    newFP.ParentId = ppp.id;
                                                    newFP.Field = actualName;
                                                    newFP.SObjectType = nameofob;
                                                    newFP.PermissionsRead = true;
                                                    insert newFP;
                                        			response1 = 'The Field '+selectedFieldName+' has been successfully added to the Permission Set '+ppp.Name+' with the read permission';
                                    }
                                                else{
                                                        System.debug('~~~The field permission did not exist');
                                        for(FieldPermissions f1:existingFP){
                                                        delete f1;
                                            System.debug('~~~The field permission has been deleted: '+f1);
                                            response1 = 'The Field '+selectedFieldName+' has been successfully added to the Permission Set '+ppp.Name+' with the read permission';
                                        }}
                    }
                    else{
                        System.debug('*the actual name does not equal the selected field name');
                    }}}
                        }}
    return response1;
        }
    catch(DmlException e){
        String response2 = 'The following error occurred: '+e;
        return response2;
    }
    catch(Exception e){
        String response3 = 'The following error occurred: '+e;
        return response3;
    }}
        
                            
    
    @RemoteAction
    public static String changeEditPermField(String selectedPSet, String selectedFieldName){
        try{
        System.debug('~Entering change edit perm field');
            String response1 = '';
        List<PermissionSet> currentPermSet = new List<PermissionSet>();
        PermissionSet ppp = [SELECT Id, Name FROM PermissionSet WHERE Id =: selectedPSet LIMIT 1][0];
                List<Schema.SObjectType> options=new List<Schema.SObjectType>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                if(objTyp.getDescribe().isCustom()){
                    options.add(objTyp);
                    }
                
            }                
            for(Schema.SObjectType ob:options)
            {
                String nameofob = ob.getdescribe().getName();
                Map<String,Schema.SObjectField> mfields = ob.getDescribe().fields.getMap();
                List<Schema.SObjectField> objectFields = new List<Schema.SObjectField>();
                objectFields = mfields.values();
                for(Schema.SObjectField o:objectFields)
                                {
                            String returnValue = String.valueOf(o);
                                String actualName = nameofob+'.'+returnvalue;
                            if(mfields.get(returnValue).getDescribe().iscustom()){
                                if(mfields.get(returnValue).getDescribe().isUpdateable()) {
                                    System.debug('***********Does it make it here?');
                                        Set<String> tempName = new Set<String>();
                                        tempName.add(returnvalue);
                                        if(tempName.contains(selectedFieldName)){
                                                System.debug('*****This is the field we want to change: '+selectedFieldName);
                                    List<FieldPermissions> existingFP = [SELECT Id,ParentId,PermissionsEdit,PermissionsRead FROM FieldPermissions WHERE ParentId=:selectedPSet AND Field=:actualName];
                                    System.debug('***The existing fieldspmermissions is: '+existingFP);
                                    if(existingFP.isEmpty()){
                                        FieldPermissions newfp = new FieldPermissions();
                                            newfp.ParentId = ppp.id;
                                            newfp.SobjectType = nameofob;
                                            newfp.Field = actualName;
                                            newfp.PermissionsRead = true;
                                            newfp.PermissionsEdit=true;
                                                System.debug('****There was nothing there so I am inserting: '+newfp);
                                                insert newfp;
                                                response1 = 'The field '+selectedFieldName+' has been added to the Permission Set '+ppp.Name+' with the edit permission';
                                    }
                                    else{
                                        for (FieldPermissions fp: existingFP){
                                            if(fp.PermissionsEdit==false){
                                                fp.PermissionsEdit = true;
                                                System.debug('***There used to be read only, adding edit: '+fp);
                                                update fp;
                                                response1 = 'The editing ability of the field '+selectedFieldName+' has been added to the Permission Set '+ppp.Name;
                                                }
                                                else if(fp.PermissionsEdit == true){
                                                fp.PermissionsEdit = false;
                                                System.debug('***This exists and I dont want it anymore: '+fp);
                                                update fp;
                                                response1 = 'The ability for the field '+selectedFieldName+' to be edited has been removed from the Permission Set '+ppp.Name;
                                                }
                                        }
                                        }
                                }
                                        }
                            }
                        }
                        }
            return response1;
    }
        catch(DmlException e){
        String response2 = 'The save failed because you are trying to assign or remove a permission from a child object that requires a different permission on the parent object.  Please change the parent object permission first, then try again.';
        return response2;
    }
    catch(Exception e){
        String response3 = 'The following error occurred: '+e;
        return response3;
    }}
}