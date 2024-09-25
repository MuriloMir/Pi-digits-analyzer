/*
    This program will read a file containing the number pi with a billion digits, then it will use the digits to create images and see what random
    images are formed with the random digits of pi, we will use a technique which takes the first 3 pi digits to make the R, then the next 3 pi
    digits to make the G and then the next 3 pi digits to make the B, thus creating RGB, which is what we need to make a pixel, then we will gather
    10000 of those pixels to make an image which is 100x100 pixels, since each pixel is made up of 3 numbers, R, G and B, we will need 3 * 10,000
    numbers to make all pixels, being a total of 30,000 numbers, and since each of those numbers has 3 digits (3 to make the R, 3 to make the G and
    3 to make the B) we will need 3 * 30,000 digits, being a total of 90000 digits per each image.
*/

// import the tools we need
import arsd.jpeg : writeJpeg;
import arsd.simpledisplay : Color, Image;
import std.array : array;
import std.conv : to;
import std.file : readText;
import std.range : iota;
import std.stdio : readln, writeln;
import std.string : chomp;

void main()
{
    // this array will hold the 30,000 numbers extracted from the pi digits, they will be used to make the pixel RGB numbers
    int[] pixelNumbers = new int[30000];
    // this array will hold the actual pixels, they will be made of RGB numbers taken from the array above
    Color[] pixels = new Color[10000];
    // this is the actual image, it will start blank and we will draw the pixels in it
    Image img = new Image(100, 100);

    // show a message to let the user know what is happening
    writeln("Reading pi digits text file, please wait.");
    // read the pi digits from the file, it takes seconds because the file is huge, ignore the first 2 digits because they are just the "3."
    string piDigits = readText("pi billion digits.txt")[2 .. $];
    // show a message to let the user know what is happening
    writeln("Please type the first piece number (start counting from 1):");
    // let the user type which will be the first image, in case you've already stored many images, we subtract 1 because it starts counting from 0
    int pieceIndex = to!int(chomp(readln())) - 1;
    // show a message to let the user know what is happening
    writeln("Please type the final piece number (start counting from 1):");
    // let the user type which will be the last image (not included), then subtract 1 because it will start counting from 0
    int finalIndex = to!int(chomp(readln())) - 1;

    // start a loop which will use the variables 'pieceIndex' (current piece) and 'finalIndex' (last piece)
    while (pieceIndex < finalIndex)
    {
        // start a loop to fill an array of 90,000 digits, so we can group them into 3 and make 30,000 numbers
        foreach (i, j; array(iota(90_000 * pieceIndex, 90_000 * (pieceIndex + 1), 3)))
            // each group of 3 digits gets stored as a number in 'pixelNumbers', it can't be any bigger than 255, hence the modulo operation
            pixelNumbers[i] = to!int(piDigits[j .. j + 3]) % 256;

        // start a loop to fill an array of 30,000 numbers so we can group them into 3 and make 10000 pixels
        foreach (i, j; array(iota(0, 30000, 3)))
            // take 3 numbers from 'pixelNumbers' and use them to create a pixel, then we store it in 'pixels'
            pixels[i] = Color(pixelNumbers[j], pixelNumbers[j + 1], pixelNumbers[j + 2]);

        // start a loop to finally draw the pixels on the image, check all 100 rows
        foreach (y; 0 .. 100)
            // start a loop to check all 100 columns
            foreach (x; 0 .. 100)
                // put the pixel where it belongs in the image
                img.putPixel(x, y, pixels[y * 100 + x]);

        // turn the image into a jpeg file and save it inside the folder, each name will be the number of the image
        writeJpeg(to!string(pieceIndex + 1) ~ ".jpeg", img.toTrueColorImage());
        // increment 'pieceIndex' so we can do it again with the next 90,000 digits of pi, until we reach 'finalIndex'
        pieceIndex++;
    }
}
