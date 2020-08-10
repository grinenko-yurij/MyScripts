$HKLM="HKLM:\SOFTWARE\Microsoft\BCDRAGENT"

# Create new value in reg
New-ItemProperty -Path $HKLM -Name USEVSSCOPYBACKUP -PropertyType "String" -Value TRUE

# Restart servise
Restart-Service VSS