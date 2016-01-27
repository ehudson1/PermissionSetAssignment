public with sharing class ApexClassesController {
    public PageReference pagerefresh(){
        return null;
    }
    public string selectedUser {get; set;}
    public PageReference test(){
        return null;
    }
    public List<SelectOption> UserList {
        get{
            List<SelectOption> UserList = new List<SelectOption>();
            List<User> users = new List<User>();
            users = [SELECT Name FROM User];
            UserList.add(new SelectOption('', '---Select a user---'));
            for (User u:users){
                UserList.add(new SelectOption(u.id, u.Name));
            }
            UserList.add(new SelectOption('All Users', 'All Users'));
            return UserList;
        }
        set;
    }
    public List<PermissionSet> PSs 
    {
        get
        {
        	List<PermissionSet> PSs = new List<PermissionSet>();
        	List<PermissionSet> OldestPS = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1];
        	DateTime BeginningDate = OldestPS[0].CreatedDate;
        	PSs = [SELECT Id,Name,CreatedById,CreatedDate FROM PermissionSet WHERE CreatedDate>:BeginningDate order by Id ASC];
        	return PSs;
    	}
        set;
    }
    public Map<ApexClass, Map<PermissionSet, Boolean>> BiggestMap{
        get{
            Map<ApexClass, Map<PermissionSet, Boolean>> BiggestMap = new Map<ApexClass, Map<PermissionSet, Boolean>>();
            List<PermissionSet> OldestPS = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1];
            DateTime BeginningDate = OldestPS[0].CreatedDate;
            List<PermissionSet> PSAs = new List<PermissionSet>();
            List<ApexClass> ApexClasses = new List<ApexClass>();
            if (selectedUser == 'All Users'){
                ApexClasses = [SELECT Id,LastModifiedById,LastModifiedDate,Name,CreatedDate FROM ApexClass WHERE CreatedDate>:BeginningDate order by Id ASC];
            }
            else{
                ApexClasses = [SELECT Id,LastModifiedById,LastModifiedDate,Name,CreatedDate FROM ApexClass WHERE LastModifiedById=:selectedUser AND CreatedDate>:BeginningDate order by Id ASC];
            }
            PSAs = [SELECT Id,Name,CreatedById,CreatedDate FROM PermissionSet WHERE CreatedDate>:BeginningDate order by Id ASC];
            for(ApexClass a: ApexClasses){
                Map<PermissionSet, Boolean> InnerMap = new Map<PermissionSet, Boolean>();
                List<SetupEntityAccess> fora = [SELECT ParentId, Id FROM SetupEntityAccess WHERE SetupEntityId=:a.id];
                Set<ID> SetofIds = new Set<ID>();
                for (SetupEntityAccess f:fora){
                    SetofIds.add(f.ParentId);
                }
                for (PermissionSet p: PSAs){
                    boolean response = (SetofIds.contains(p.id));
                    InnerMap.put(p, response);
                }
                BiggestMap.put(a,InnerMap);
            }
        return BiggestMap;
        }
        set;
    }
    public ApexClassesController(){
        ApexClass apxc = new ApexClass();
        BiggestMap.get(apxc);
    }

    
    @RemoteAction
    public static void addApexClass(String selectedPSetName, String selectedApexName){
        List<PermissionSet> currentPermSet = new List<PermissionSet>();
        List<ApexClass> currentApexC = new List<ApexClass>();
        currentPermSet = [SELECT Id, Name FROM PermissionSet WHERE Name =: selectedPSetName LIMIT 1];
        currentApexC = [SELECT Id, Name FROM ApexClass WHERE Name =: selectedApexName LIMIT 1];
        PermissionSet ppp = currentPermSet[0];
        ApexClass acc = currentApexC[0];
        List<SetupEntityAccess> existingSEA = [SELECT Id, ParentId, SetupEntityId FROM SetupEntityAccess WHERE ParentId=:ppp.id AND SetupEntityId=:acc.id];
        if (existingSEA.isEmpty()){
            SetupEntityAccess newS = new SetupEntityAccess();
            newS.SetupEntityId = acc.id;
            newS.ParentId = ppp.id;
            insert newS;
        }
        else{
            for(SetupEntityAccess s1: existingSEA){
                delete s1;
        }
    }
 }
    }