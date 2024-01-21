log_file=/tmp/expense.log

Head() {
  echo -e "\e[35m$1\e[0m"
}

App_Prereq() {

}

Stat() {
  if [ "$1" -eq 0 ]; then
  echo SUCCESS
  else
  echo FAILURE
  exit 1
  fi
}
