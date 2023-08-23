# RDWeb_BruteForce
Brute Force RD Web Access Portal.Requires to know AD name which can be obtained using this technique https://raxis.com/blog/rd-web-access-vulnerability/

Place the following 2 files in the directory running:
1)AD_users.txt (This file contains usernames list without domain name e.g 'admin1')
2)pass.txt (Passwords List)

Modify the code to edit the following parameters:
1) URL in curl request
2) ADName in curl request (Cookie and Post Form Data)

To Run:
chmod +x RDWeb_BruteForce.sh
./RDWeb_BruteForce.sh

Inspired from https://github.com/rapid7/metasploit-framework/blob/master/documentation/modules/auxiliary/scanner/http/rdp_web_login.md
