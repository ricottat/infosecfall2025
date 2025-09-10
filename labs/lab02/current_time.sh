#!/bin/bash
current_time=$(date +%s)
workday_end=$(date -d "18:00:00" +%s)
time_remaining=$((workday_end - current_time))

hours=$((time_remaining / 3600))
minutes=$(((time_remaining % 3600) / 60))
seconds=$((time_remaining % 60))

if [ $time_remaining -le 0 ]; then
        echo "Workday ended $hours hours, $minutes minutes and $seconds seconds ago."
else
        echo "Workday ends in $hours hours, $minutes minutes and $seconds seconds."
fi
