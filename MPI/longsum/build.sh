#!/bin/bash
export TMPDIR=/tmp  
export PMIX_MCA_gds=hash

echo "Compilation"
FULLDIR=$(dirname "$0")
mpic++ -Wall -Wextra -pedantic -O0 -Wshadow -Wformat=2 -Wfloat-equal \
-Wconversion -Wcast-qual -Wcast-align -D_GLIBCXX_DEBUG \
-D_GLIBCXX_DEBUG_PEDANTIC -fsanitize=undefined -fno-sanitize-recover=all \
-fstack-protector -std=c++17 -o $FULLDIR/test $FULLDIR/solution.cpp -lm \
|| exit 1

echo "Making res directory if necessary"
mkdir -p $FULLDIR/res

echo "Cleaning up res directory"
echo -n > $FULLDIR/res/data.txt

for ((i = 1; i <= 10; ++i))
do
mpirun --hostfile hostfile -np $i $FULLDIR/test $1 $2 >> res/data.txt
done

echo "Compilation"
FULLDIR=$(dirname "$0")
gcc -Wall -Wextra -pedantic -O3 -o $FULLDIR/test $FULLDIR/data.c || exit 1

echo "Making auxiliary files acceleration.txt and efficiency.txt"
$FULLDIR/test

echo "Plotting metrics"
gnuplot <<< "set terminal png size 1024, 720; \
            set xlabel 'Number of processes'; \
            set ylabel 'Acceleration'; \
            set xrange [1:10]; \
            set output 'res/acceleration.png'; \
            plot 'res/acceleration.txt' with lines; \
            set terminal png size 1024, 720; \
            set xlabel 'Number of processes'; \
            set ylabel 'Efficiency'; \
            set xrange [1:10]; \
            set output 'res/efficiency.png'; \
            plot 'res/efficiency.txt' with lines; "
echo "Plot image stored at res"
exit $?