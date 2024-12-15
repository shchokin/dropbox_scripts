d=$(date "+%m_%d_%Y_%I_%M %p"); for i in {1..3}; 
                          do cp ../../type_simple/1oit.xml "ARTYOM_$d-$i.xml"; 
                          done;cd ../.. ; start erProxyTester.exe ; cd --