#pkill -9 meteor
#meteor --driver-package 'test-in-console' test-packages ./ > ./logs/packageTest.log &
meteor --port 5000 test-packages ./ #> ./linkstateTest.log
#tail -f ./logs/packageTest.log
