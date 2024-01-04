

echo -e"\e[35m Disable Default Version NodeJS\e[om"
dnf module disable nodejs -y

echo -e "\e[35m Enable NodeJS18 Version\e[om"
dnf module enable nodejs:18 -y

echo -e "\e[35m Install NodeJS\e[om"
dnf install nodejs -y

echo -e "\e[35m Configure Backend Service\e[om"
cp backend.service /etc/systemd/system/backend.service

echo -e "\e[35m Adding Application User\e[om"
useradd expense

echo -e "\e[35m Remove Existing App Content\e[om"
rm -rf /app

echo -e "\e[35m Create Application Directory\e[om"
mkdir /app

echo -e "\e[35m Download Application Content\e[om"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip

cd /app

echo -e "\e[35m Extracting Application\e[om"
unzip /tmp/backend.zip

echo -e "\e[35m Downloading Application Dependencies\e[om"
npm install

echo -e "\e[35m Reloading SystemD and Start Backend Service\e[om"
systemctl daemon-reload
systemctl enable backend
systemctl restart backend

echo -e "\e[35m Install MySQL Client\e[om"
dnf install mysql -y

echo -e "\e[35m Load Schema\e[om"
mysql -h mysql-dev.raoulconstant.com -uroot -pExpenseApp@1 < /app/schema/backend.sql
