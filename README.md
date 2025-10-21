# Pi-digits-analyzer
This software, written in Dlang, analyzes the digits of pi in order to find images and words in them.

It is just a funny experiment, it read a file with 1 billion digits of pi and then it used an algorithm to turn the digits into images, later another algorithm was used to turn the digits into letters. The images unfortunately were all random, none of them formed a pattern, they were all similar to the image you can find in the "all results.zip" file.

The letters were counted to see how often each appeared, also the letters were examined to find words in them, each word was counted to see how often it appeared too. All letters appeared often, however some words barely appeared, whereas other words appeared all the time.

All results can be found in the "all results.zip" file.

If you want to compile and run it yourself then you must download the multimedia library, which can be found here on this page, and you must download a text file with a billion digits of pi, search for it on Google. Remember to compile it with "dmd 'name' -m64 -i -O -g".
