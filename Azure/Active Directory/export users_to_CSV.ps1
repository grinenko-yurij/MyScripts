$objSearcher = New-Object System.DirectoryServices.DirectorySearcher
$objSearcher.SearchRoot = "LDAP://ou=Users,ou=Departmets,dc=fff,dc=com,dc=ua"
$objSearcher.Filter = "(&(objectCategory=person)(!userAccountControl:1.2.840.113556.1.4.803:=2))"
$users = $objSearcher.FindAll()
# Количество учетных записей
$users.Count 
$users | ForEach-Object {
   $user = $_.Properties
   New-Object PsObject -Property @{
   Должность = [string]$user.description
   Отдел = [string]$user.department
   Логин = [string]$user.userprincipalname
   Телефон = [string]$user.telephonenumber
   Комната = [string]$user.physicaldeliveryofficename
   ФИО = [string]$user.cn
    }
} | Export-Csv -NoClobber -Encoding utf8 -Path  d:\list_users.csv