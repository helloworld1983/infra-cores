#!/bin/bash -f
bin_path="/opt/Questa/questasim/bin"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep source ./questa_compile.sh 2>&1 | tee -a compile.log
