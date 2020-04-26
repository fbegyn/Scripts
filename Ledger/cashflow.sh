#!/bin/sh

INCOME=^income
EXPENSES=^expenses

START="$(date --date='last year' +%Y)-12-20"
END="$(date +%Y)-12-10"

if [ -z "$LEDGER_TERM" ]; then
	LEDGER_TERM="pngcairo size 1920,1020 font 'Source Sans Pro,14'"
fi

ledger -J --market --no-rounding reg "$INCOME" -M --collapse --plot-total-format="%(format_date(date, \"%Y-%m-%d\")) %(abs(quantity(scrub(display_total))))\n" > ledgeroutput_in.tmp
ledger -J --market --no-rounding reg "$EXPENSES" -M --collapse > ledgeroutput_ex.tmp

(cat <<EOF) | gnuplot > cashflow.png
	set terminal $LEDGER_TERM
	set xdata time
	set timefmt "%Y-%m-%d"
	set xrange ["$START":"$END"]
	set xtics nomirror "$(date +%Y)-01-01",2592000 format "%b"
	unset mxtics
	set mytics 2
	set grid xtics ytics mytics front
	set title "Cashflow"
	set ylabel "Accumulative income and expenses"
	set style fill transparent solid 0.6 noborder
	set key left top
	plot "ledgeroutput_in.tmp" using 1:2 with filledcurves x1 title "Income" fs transparent solid .3 linecolor rgb "seagreen", \\
		"ledgeroutput_ex.tmp" using 1:2 with filledcurves x1 title "Expenses" fs transparent solid .3 linecolor rgb "light-salmon", \\
		"ledgeroutput_in.tmp" using 1:2 with line linecolor rgb "#61ef61" notitle, \\
		"ledgeroutput_ex.tmp" using 1:2 with line linecolor rgb "light-salmon" notitle, \\
		"ledgeroutput_in.tmp" using 1:2:(sprintf('€ %d', \$2)) with labels font "Source Sans Pro,9" notitle, \\
		"ledgeroutput_ex.tmp" using 1:2:(sprintf('€ %d', \$2)) with labels font "Source Sans Pro,9" notitle
EOF

rm ledgeroutput*.tmp
imv cashflow.png
rm cashflow.png
