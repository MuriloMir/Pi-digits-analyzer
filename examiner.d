// This software will examine the letters extracted from the pi digits, in order to find words in them.

// import the tools we need
import std.algorithm : canFind, count;
import std.array : split;
import std.conv : to;
import std.file : readText, write;
import std.parallelism : parallel;
import std.range : iota;
import std.stdio : writeln;

// start the software
void main()
{
    // tell the user what is happening
    writeln("Reading the file with the English vocabulary.");
    // read the file with all the English words and turn it into an array
    string[] allWords = split(readText("english text.txt"), ' ');

    // tell the user what is happening
    writeln("Reading the file with the pi text.");
    // read the file with all the text extracted from the pi digits
    string piText = readText("pi text.txt");

    // tell the user what is happening
    writeln("Searching for the words.");

    // start a parallel loop to check all letters, with different threads
    foreach (index; parallel(iota(23)))
    {
        // this will contain the letter which is being examined in this thread, meaning the 1st letter of the words
        char letter = "abcdefghijklmnopqrstuvwxyz"[index];
        // this string will contain all the results
        string results;
        // this int will contain how many times the word appeared
        int quantity;

        // start a loop to check all words
        foreach (word; allWords)
            // if the word starts with the current letter being examined and it is located in the pi text
            if (word[0] == letter && canFind(piText, word))
            {
                // count how many times it appears, we cast it because the 'count()' function returns an 'ulong'
                quantity = cast(int) count(piText, word);
                // add it to the results
                results ~= word ~ ": " ~ to!string(quantity) ~ '\n';
                // show it to the user
                writeln(word, ": ", quantity);
            }

        // tell the user what is happening
        writeln("Saving the result.");
        // save the result of the current letter in a text file, so you can study it later
        write("result " ~ letter ~ ".txt", results);
        // tell the user what is happening
        writeln("Finished with the letter ", letter, '.');
    }
}
