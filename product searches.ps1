#Powershell script to open multiple tabs for browser searches.

#finding default browser works to read the default program for HTML documents


#list of browsers, add in the following pattern
$defaultB = (Get-ItemProperty HKCU:\Software\Microsoft\windows\Shell\Associations\UrlAssociations\http\UserChoice).ProgId #DefaultBrowser
write-host "Please exit application if default browser is incorrect!`n"
if ($defaultB.StartsWith("Fire"))
{
    write-host "default browser is firefox"
    $browserlocation = "C:\Program Files\Mozilla Firefox\firefox.exe"
}
elseif ($defaultB.StartsWith("IE"))
{
    write-host "default browser is Internet Explorer"
    $browserlocation = "C:\Program Files\Internet Explorer\iexplore.exe" #will not work in Windows 11
}
elseif ($defaultB.Contains("MSEdge"))
{
    Write-Host "default browser is Microsoft Edge"
    $browserlocation = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
}
elseif ($defaultB.Contains("ChromeHTML"))
{
    write-host "default browser is Google Chrome"
    $browserlocation = "C:\Program Files\Google\Chrome\Application\chrome.exe"    
}

""

#websites and their searches, using '16GB RAM' as search


#amazon - https://www.amazon.co.uk/s?k=16GB+RAM&ref=nb_sb_noss_2
#balicom - https://www.ballicom.co.uk/search/16GB+RAM
#box limited - https://www.box.co.uk/products/ex/true/keywords/16gb+ram
#ccl computers - https://www.cclonline.com/search/?q=16GB+RAM
#curry's - https://www.currys.co.uk/gbuk/search-keywords/xx_xx_xx_xx_xx/16gb%2bram/xx-criteria.html
#ebuyer - https://www.ebuyer.com/search?q=16gb+ram
#ingram micro - https://uk-new.ingrammicro.com/Site/Search#keywords%3a16GB%20RAM
#insight - https://www.uk.insight.com/en-gb/apps/nbs/results.php?K=16gb%20ram
#john lewis - https://www.johnlewis.com/search?search-term=16GB%20RAM
#lambdatek - http://www.lambda-tek.com/shop/?region=GB&searchString=16GB+RAM
#laptops direct - https://www.laptopsdirect.co.uk/search-results/16gb%20ram?gaExpId=TlEJSQIGRKeaZ6jVHzOq2g&gaExpVar=1
#overclockers UK - https://www.overclockers.co.uk/search?sSearch=16gb+ram
#Scan - https://www.scan.co.uk/search?q=16gb+ram
#Techdata (might be hard)


###############################################################################################################################

#menu selection for websites. When new site is added to list, make sure to include it in here
$mainselect = (
($machines = @{name = "PCs/laptops"; sites = ($amazon, $box)}), 
($parts = @{name = "parts"; sites = ($ccl, $johnlewis)})
)

$counter = 1
foreach ($items in $mainselect) {
    write-host ($counter,"-", $items["name"])
    $counter++
}

#finds options
$chosen = $false
$counter2 = 1
while ($chosen -eq $false) {
    write-host "Please select an option`n"
    $useroption = read-host
    if ($useroption -eq 1) {
        write-host $mainselect[($useroption - 1)].name, "selected`n" #references hash table above
        $chosen = $true
        break
    }
    if ($useroption -eq 2) {
        write-host $mainselect[($useroption - 1)].name, "selected`n"
        $chosen = $true
        break
    }
    if ($useroption -eq 3) {
        write-host $mainselect[($useroption - 1)].name, "selected`n"
        $chosen = $true
        break
    } 
    else {
        write-host "...input was invalid, please try again..."
    }     
}

###############################################################################################################################

echo "Please enter a product (BE AS SPECIFIC AS POSSIBLE)"
$input1 =  Read-Host

$amazon = -join ("https://www.amazon.co.uk/s?k=", $input1.replace(" ", "+"), "&ref=nb_sb_noss_2")
$broadbandbuyer = -join("http://www.broadbandbuyer.com/search/?q=", $input1.replace(" ","+"))
$balicom = -join ("https://www.ballicom.co.uk/search/", $input1.replace(" ", "+"))
$box = -join ("https://www.box.co.uk/products/ex/true/keywords/", $input1.replace(" ", "+"))
$ccl = -join ("https://www.cclonline.com/search/?q=", $input1.replace(" ", "+"))
$currys = -join("https://www.currys.co.uk/gbuk/search-keywords/xx_xx_xx_xx_xx/", $input1.replace(" ", "%2b"), "/xx-criteria.html")
$ebuyer = -join("https://www.ebuyer.com/search?q=", $input1.replace(" ", "+")) #if item is too specific, the page will return the closest item. (problem?)
$ingram = -join("https://uk-new.ingrammicro.com/Site/Search#keywords%3a", $input1.replace(" ", "%20"))
$insight = -join("https://www.uk.insight.com/en-gb/apps/nbs/results.php?K=", $input1.replace(" ", "%20"))
$johnlewis = -join("https://www.johnlewis.com/search?search-term=", $input1.replace(" ", "%20"))
$lambdatek = -join("http://www.lambda-tek.com/shop/?region=GB&searchString=", $input1.replace(" ", "+"))
$laptopsdirect = -join("https://www.laptopsdirect.co.uk/search-results/", $input1.replace(" ", "%20"), "?gaExpId=TlEJSQIGRKeaZ6jVHzOq2g&gaExpVar=1") #this uses authentication token that may be expired now
$overclockers = -join("https://www.overclockers.co.uk/search?sSearch=", $input1.replace(" ", "+"), "&__cf_chl_jschl_tk__=pmd_af7cc76959a85f83ca80d464cf4adba3a99cbb4a-1629033534-0-gqNtZGzNAiKjcnBszQki")
$scan = -join("https://www.scan.co.uk/search?q=", $input1.replace(" ", "+"))

$mainselect = (
($machines = @{name = "PCs/laptops"; sites = ($amazon, $box, $ccl, $currys, $ebuyer, $insight, $laptopsdirect)}), 
($parts = @{name = "parts"; sites = ($ccl, $johnlewis, $amazon, $broadbandbuyer, $balicom, $box, $currys, $ebuyer, $ingram, $insight, $lambdatek, $overclockers, $scan)})
)
$completesites = $mainselect[($useroption - 1)].sites
Start-Process -FilePath $browserlocation $completesites


#logs

#14/08/2021 - created
#16/08/2021 - added broadbandbuyer to list of websites
#21/08/2021 - added 4 browser options that change the program used to open the websites in (works off finding out the default browser. Tried testing some website searches but this returns everything (do not use)
#22/08/2021 - started basic structure for menu options - used as a hash list. I'm not sure this is the best way but it's the one i'm going with for now.
#24/08/2021 - Added menu options and gave "function" to allow a change in script if a different option was selected. Still need to add a lot of websites - might need to do this with external file to reference
#29/08/2021 - Compiled most of code into functions to allow better tracking of logic
#30/08/2021 / MORNING - Removed all functions and returned to complete run-code, as this was causing issues with values saving from previous runs
#30/08/2021 / AFTERNOON - Fixed issue with selections not completing and tested code. I think this is as far as I can get with Powershell



#still to do

#Find out how to work around human checks and allow a search after authentication has been authorised.
#Add subsections to allow different item search types (Laptops/PCs, software/licenses, parts). Each search will return different sites.
#In menu options, allow to go back if wrong one selected
#Add all sites from file in this folder. Also add them to the hashtable of items so the sections can be referenced correctly    
#[end game] find a way to export only prices, product numbers etc into own front-end. or maybe just a csv for now and give prices (exl vat or incl vat?
