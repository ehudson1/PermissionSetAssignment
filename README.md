Permission Set Assignment Tool
====================================
 
<a href="https://githubsfdeploy.herokuapp.com?owner=financialforcedev&repo=apex-mdapi">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

This tool allows for developers to quickly view which Apex Classes, Apex Pages, Custom Objects and Custom Fields are assigned to which Permission Sets.
You can edit Permission Set Assignments by simply checking and unchecking boxes of the table.

This tool works in both Lightning Experience and Aloha.

For the Visualforce Page and Apex Class Assignments: 
<p>
>1. Choose a user.  
<p>
2. See that the table displays elements last modified by that user, with checkboxes checked according to assignments.
<p>
3. Click the "Refresh Page" button at the bottom of the page to make sure the changes were made.  The page loads displaying current assignments in the org.
<p>

=======================================================
<p>
For the Custom Object and Custom Field Assignments:
<p>
>1. Choose a Permission Set
<p>
2. See that the checkboxes in the table show whether or not the objects in the org are assigned to that Permission Set, and whether they are given the Read, Edit, Create, and/or Delete Permissions for that Permission Set.
<p>
3. Click on the links in the right hand column to view the field assignments for each object. 
<p>
4. Clicking into the checkboxes assigns or removes fields from that corresponding Permission Set, and specifies the permissions Read, Create, Edit, or Delete.
<p>
5. Click the "Refresh Page" button at the bottom of the page to make sure the changes were made.  The page loads displaying current assignments in the org.

The only errors that may occur are:
>- if you try to remove the permissions of a parent object when the child object has them enabled
- if you try to add permissions of a child object when the parent child does not have them enabled

View screen shots of the tool below:
<img src="https://cloud.githubusercontent.com/assets/8573319/12995076/941495d0-d0d9-11e5-9d8f-710b857a2acf.png" width="90%"></img> <img src="https://cloud.githubusercontent.com/assets/8573319/12995052/60114256-d0d9-11e5-9ecd-44b9a2d5c261.png" width="90%"></img> <img src="https://cloud.githubusercontent.com/assets/8573319/12995139/0365c224-d0da-11e5-98c1-aeb6334bffe8.png" width="90%"></img> 
