$site = Invoke-WebRequest -uri "https://www.amazon.co.uk/Corsair-Vengeance-Enthusiast-Illuminated-Memory/dp/B07D1XCKWW/ref=sr_1_3?dchild=1&keywords=16gb+ram&qid=1629577161&sr=8-3"

#$site | Get-Member

$site.RawContent > "C:\Users\Si\OneDrive\Desktop\PSTesting.txt"

$search = "price_inside_buybox"
$linenumber=get-content "C:\Users\Si\OneDrive\Desktop\PSTesting.txt" | Select-String $search
$thenumber = $linenumber.LineNumber
$price = (Get-Content "C:\Users\Si\OneDrive\Desktop\PSTesting.txt")[$thenumber]

write-host "the price is" $price

Pause
