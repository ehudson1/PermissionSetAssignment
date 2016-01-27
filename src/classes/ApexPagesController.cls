public class ApexPagesController {
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
    public List<PermissionSet> PSs {
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
    public Map<ApexPage, Map<PermissionSet, Boolean>> BiggestMap{
        get{
            Map<ApexPage, Map<PermissionSet, Boolean>> BiggestMap = new Map<ApexPage, Map<PermissionSet, Boolean>>();
            List<PermissionSet> OldestPS = [SELECT Id,Name,CreatedDate FROM PermissionSet order by CreatedDate ASC LIMIT 1];
            DateTime BeginningDate = OldestPS[0].CreatedDate;
            List<PermissionSet> PSAs = new List<PermissionSet>();
            List<ApexPage> ApexPages = new List<ApexPage>();
            if (selectedUser == 'All Users'){
                ApexPages = [SELECT Id,LastModifiedById,LastModifiedDate,Name,CreatedDate FROM ApexPage WHERE CreatedDate>:BeginningDate order by Id ASC];
            }
            else{
                ApexPages = [SELECT Id,LastModifiedById,LastModifiedDate,Name,CreatedDate FROM ApexPage WHERE LastModifiedById=:selectedUser AND CreatedDate>:BeginningDate order by Id ASC];
            }
            PSAs = [SELECT Id,Name,CreatedById,CreatedDate FROM PermissionSet WHERE CreatedDate>:BeginningDate order by Id ASC];
            for(ApexPage a: ApexPages){
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

    public ApexPagesController(){
        ID UserID = UserInfo.getUserId();
        ApexPage ac = new ApexPage();
        PermissionSet PS = new PermissionSet();
        ApexPage ap = new ApexPage();
        PermissionSet ppp = new PermissionSet();
    }

    @RemoteAction
    public static void dostuff(String selectedPSetName, String selectedApexName){
        List<PermissionSet> currentPermSet = new List<PermissionSet>();
        List<ApexPage> currentApexP = new List<ApexPage>();
        currentPermSet = [SELECT Id, Name FROM PermissionSet WHERE Name =: selectedPSetName LIMIT 1];
        currentApexP = [SELECT Id, Name FROM ApexPage WHERE Name =: selectedApexName LIMIT 1];
        PermissionSet ppp = currentPermSet[0];
        ApexPage ap = currentApexP[0];
        List<SetupEntityAccess> existingSEA = [SELECT Id, ParentId, SetupEntityId FROM SetupEntityAccess WHERE ParentId=:ppp.id AND SetupEntityId=:ap.id];
        if (existingSEA.isEmpty()){
            SetupEntityAccess newS = new SetupEntityAccess();
        	newS.SetupEntityId = ap.id;
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