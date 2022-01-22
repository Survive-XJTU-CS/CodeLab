#!/bin/bash
score=0
#scoring=0
i=1
function Test_SQL {
	echo "Q$i Testing......";
	i=$[$i+1]
	cd diff
	diff diff1.csv correct.csv > /dev/null
	if [ $? == 0 ]; then
		echo "==========PASSED==========="
		score=$[$score+$1]
		cd ..
		rm -rf diff
	else
		echo "=========UNPASSED=========="
		cd ..
	fi
}

sh csv_generate.sh q1_sample.sql ../sol/q1_sample.sql;
Test_SQL 0
sh csv_generate.sh q2_string_function.sql ../sol/q2_string_function.sql;
Test_SQL 5
sh csv_generate.sh q3_northamerican.sql ../sol/q3_northamerican.sql;
tail  -n 20 ./diff/diff1.csv >> ./diff/diffing1.csv;
tail  -n 20 ./diff/correct.csv >> ./diff/correcting.csv; 

echo "Q$i Testing......";
i=$[$i+1]
cd diff
diff diffing1.csv correcting.csv > /dev/null
if [ $? == 0 ]; then
	echo "==========PASSED==========="
	score=$[$score+5]
	cd ..
	rm -rf diff
else
	echo "=========UNPASSED=========="
	cd ..
fi
sh csv_generate.sh q4_delaypercent.sql ../sol/q4_delaypercent.sql;
Test_SQL 10
sh csv_generate.sh q5_aggregates.sql ../sol/q5_aggregates.sql;
Test_SQL 10
sh csv_generate.sh q6_discontinued.sql ../sol/q6_discontinued.sql;
Test_SQL 10
sh csv_generate.sh q7_order_lags.sql ../sol/q7_order_lags.sql;
Test_SQL 15
sh csv_generate.sh q8_total_cost_quartiles.sql ../sol/q8_total_cost_quartiles.sql;
Test_SQL 15
sh csv_generate.sh q9_youngblood.sql ../sol/q9_youngblood.sql;
Test_SQL 15
sh csv_generate.sh q10_christmas.sql ../sol/q10_christmas.sql;
Test_SQL 15


echo "Your Final Score: $score "
if [ $score -eq 100 ]; then
	echo "Nice Work!!! You Have Passed All the Test!!! Keep Going!!!"
else
	echo "Come On!!"
fi

