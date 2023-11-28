CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
rm -rf student-submission
rm -rf grading-area
mkdir grading-area
git clone $1 student-submission
echo 'Finished cloning'
# Draw a picture/take notes on the directory structure that's set up after
# getting to this point
# DIRECTORY STRUCTURE:
#   - grading-area
#       - ListExamples.java
file=`find student-submission -name "*.java"`
expected="ListExamples.java"
if [[ $file == $expected ]]
then
    echo "$file: mismatched expected file name"
    echo "test"
    exit
fi
cp -r GradeServer.java grading-area
cp -r Server.java grading-area
cp -r TestListExamples.java grading-area
cp -r student-submission/ListExamples.java grading-area
cp -r lib grading-area
# Then, add here code to compile and run, and do any post-processing of the
# tests
cd grading-area
javac -cp ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar" *.java
java -cp ".:lib/junit-4.13.2.jar:lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > output.txt
echo "Tests ran sucessfully. The got the following output:"
grep -h "Fail" output.txt
grep -h "OK" output.txt
