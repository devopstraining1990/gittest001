Cmdlet
Functions
Script



-----
Get-Help
Get-Command
Get-Member

-Noun
-Verb

------
Get-Command -Noun File*

Get-Command -Verb Get -Noun File*
Get-Filehash -Path ./hello.txt -Algorithm SHA384



#Discover Commands in powershell

 Get-Help -Name Get-Help

 Update-Help -UICulture en-us -Verbose

#Filter help responses
Get-Help Get-FileHash -Examples

Full: Returns a detailed help page. It specifies information like parameters, inputs, and outputs that you don't get in the standard response.
Detailed: Returns a response that looks like the standard response, but it includes a section for parameters.
Examples: Returns only examples, if any exist.
Online: Opens a web page for your command.
Parameter: Requires a parameter name as an argument. It lists a specific parameter's properties.

    --------- Example 1: Compute the hash value for a file ---------

    Get-FileHash /etc/apt/sources.list | Format-List

        ------ Example 2: Compute the hash value for an ISO file ------

    Get-FileHash C:\Users\user1\Downloads\Contoso8_1_ENT.iso -Algorithm SHA384 | Format-List


#processes

 Get-Command -ParameterType  Process # list the  list of process commands

 Get-Process -Name 'name-of-process' | Get-Member | Select-Object Name, MemberType



#Understand the  syntax in windows powershell

Cmdlet verbs
The verb portion of a cmdlet name indicates what the cmdlet does. There's a set of approved verbs that cmdlet creators use, which provides consistency in cmdlet names. Common verbs include:

Get. Retrieves a resource, such as a file or a user.
Set. Changes the data associated with a resource, such as a file or user property.
New. Creates a resource, such as a file or user.
Add. Adds a resource to a container of multiple resources.
Remove. Deletes a resource from a container of multiple resources.

