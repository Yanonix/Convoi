##### old version
#./bas.tk --whatwho --ident=writer --auto --dest=HLG --delay=1000 --autosend | \
#./hlg.tk --whatwho --ident=writer --auto --source=BAS --appname=HLG  --debug | \
#./hlg.tk --whatwho --ident=reader --auto --appname=HLG --source=HLG --debug | \
#./bas.tk --whatwho --ident=reader --auto


##### Bi-lateral communication: BAS1 <-> HLG1 <-> HLG2 <-> BAS2
#mkfifo in1 in2 in3 in4
#mkfifo out1 out2 out3 out4

#./bas.tk --whatwho --ident=rw1 --auto --dest=HLG --delay=10000 --autosend < in1 > out1 &
#./hlg.tk --whatwho --ident=rw1 --auto --source=BAS --appname=HLG --debug < in2 > out2 &
#./hlg.tk --whatwho --ident=rw2 --auto --source=BAS --appname=HLG --debug < in3 > out3 &
#./bas.tk --whatwho --ident=rw2 --auto --dest=HLG --delay=5000 --autosend < in4 > out4 &

#cat out1 > in2 &
#cat out2 | tee in1 in3 &
#cat out4 > in3 &
#cat out3 | tee in2 in4 &

##### Tri-node communication BAS1 <-> HLG1 <-> HLG2 <-> HLG3 <-> BAS3
#####					    |<->BAS2

mkfifo in1 in2 in3 in4 in5 in6
mkfifo out1 out2 out3 out4 out5 out6

./bas.tk --whatwho --ident=rw1 --auto --dest=HLG --delay=1000 --autosend < in1 > out1 &
./hlg.tk --whatwho --ident=rw1 --auto --source=BAS --appname=HLG --debug < in2 > out2 &
./bas.tk --whatwho --ident=rw2 --auto --dest=HLG --delay=2000 --autosend < in4 > out4 &
./hlg.tk --whatwho --ident=rw2 --auto --source=BAS --appname=HLG --debug < in3 > out3 &
./bas.tk --whatwho --ident=rw3 --auto --dest=HLG --delay=3000 --autosend < in6 > out6 &
./hlg.tk --whatwho --ident=rw3 --auto --source=BAS --appname=HLG --debug < in5 > out5 &

cat out1 > in2 &
cat out2 | tee in1 in3 &
cat out4 > in3 &
cat out3 | tee in2 in4 in5 &
cat out6 > in5 &
cat out5 | tee in3 in6 &


