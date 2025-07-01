/*
    This program will read a file containing the number pi with a billion digits, then it will use the digits to create letters and see what
    random words are formed with the random digits of pi, we will use a technique which takes the first 2 digit of pi and then uses them to
    represent the position of a letter in the alphabet, then the next 2 digits and so on.
*/

// import the tools we need
import std.conv : to;
import std.file : readText, write;
import std.range : iota;
import std.stdio : writeln;

// start the software
void main()
{
    // this char will hold each individual letter
    char letter;
    // 'result' will hold the final text, 'alphabet' will hold all the letters we will use
    string result, alphabet = "abcdefghijklmnopqrstuvwxyz";

    // show a message to let the user know what is happening
    writeln("Reading pi digits text file, please wait.");
    // read the pi digits from the file, it takes seconds because the file is huge, ignore the first 2 digits because they are just the "3."
    string piDigits = readText("pi billion digits.txt")[2 .. $];
    // show a message to let the user know what is happening
    writeln("Done.\nNow we are converting them to letters, please wait.");

    // start a loop to go through all digits of pi, 2 at a time
    foreach (i; iota(0, 1_000_000_000, 2))
    {
        // turn the 2 digits into an 'int', we use the modulo operation in case it's bigger than 25, then get the corresponding letter from 'alphabet'
        letter = alphabet[to!int(piDigits[i .. i + 2]) % 26];
        // add it to the result string
        result ~= letter;
    }

    // write it all to a text file
    write("pi text.txt", result);
    // show a message to let the user know what is happening
    writeln("Done.");
}
