TEST_NUMBER=26
TEST_REQUIREMENTS="3.3.1"
TEST_FOLDER="test$TEST_NUMBER"
FS_INPUT='"./testdir/testwhat.BBB содержит строку «THIS IS TESTING!!!»\n./testdir/testadd содержит строку «This text will be appended»"'
FS_OUTPUT=""
RUN_COMMAND="append-to-end.sh testdir testwhat testadd"
OUTPUT_STRING_EXPECTED=""
OUTPUT_CODE_EXPECTED=0
#Prepare
mkdir $TEST_FOLDER
cd $TEST_FOLDER
mkdir testdir
echo "THIS IS TESTING!!!" > testdir/testwhat.BBB
echo "This text will be appended" > testdir/testadd
cat testdir/testwhat.BBB > testfile
cat testdir/testadd >> testfile
#Execution
OUTPUT_STRING=`../../$RUN_COMMAND`
OUTPUT_CODE=$?
FS_OUTPUT="\"./testdir/testwhat.BBB содержит строку «$(cat testdir/testwhat.BBB)»"
FS_OUTPUT="$FS_OUTPUT\n./testdir/testadd содержит строку «$(cat testdir/testadd)»\""
#Check
if [ "$OUTPUT_STRING" = "$OUTPUT_STRING_EXPECTED" ] && [ $OUTPUT_CODE -eq $OUTPUT_CODE_EXPECTED ]
then
	if diff testdir/testwhat.BBB testfile > /dev/null
	then
		VERDICT="Ok"
	else
		VERDICT="Fail(append)"
	fi
else
	VERDICT="Fail"
fi
#Clear
cd ..
rm -rf $TEST_FOLDER
#Output
echo -e "$TEST_NUMBER,$TEST_REQUIREMENTS,$RUN_COMMAND,$FS_INPUT,$OUTPUT_CODE,$OUTPUT_STRING,$FS_OUTPUT,$VERDICT"
