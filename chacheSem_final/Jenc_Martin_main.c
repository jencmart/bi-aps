#include <stdio.h>
#include <stdlib.h>
#include <math.h>
typedef struct pixel {unsigned char r, g, b;} pix;
typedef struct histog {double r, g, b;} histo;
histo x[255];

int main(int argc, char **argv)
{
    int histogram[5] = {0, 0, 0, 0, 0};

    /// open file...
    char c; int trash1, width, height, trash2;
    FILE *fileIn = fopen( argv[1], "r"); //argv[1]

    /// read header
    fscanf(fileIn, "%c%d%d%d%d\n", &c, &trash1, &width, &height, &trash2);

    /// malloc space for cached lines...
    pix *row1 = (pix *) malloc(width * sizeof(pix));
    pix *row2 = (pix *) malloc(width * sizeof(pix));
    pix *row3 = (pix *) malloc(width * sizeof(pix));

    pix *result = (pix *) malloc(width * sizeof(pix));

    /// read first three lines...
    fread(row1, sizeof(pix), width, fileIn);
    fread(row2, sizeof(pix), width, fileIn);
    fread(row3, sizeof(pix), width, fileIn);

    /// write header and first line
    FILE *fileOut = fopen("output.ppm", "w");
    fprintf(fileOut, "P6\n%d\n%d\n%d\n", width, height, 255);
    fwrite(row1, 3, width, fileOut);

    /// precompute HISTOGRAM

    for (int i = 0; i <= 255; ++i)
    {
        x[i].r = 0.2126 * i;
        x[i].g = 0.7152 * i;
        x[i].b = 0.0722 * i;
    }

    /// compute histogram for the first line...
    for (int i = 0; i < width; ++i)
    {
        int val = (int) round(x[ row1[i].r ].r + x[ row1[i].g  ].g + x[row1[i].b].b);
        val = val >= 255 ? 254 : (val < 0 ? 0 : val);
        ++histogram[ val / 51];
    }

    /// go through all lines
    for (int i = 0; i < height - 2; ++i)
    {
        /// sides remain same...
        result[0].r  = row2[0].r;
        result[0].g  = row2[0].g;
        result[0].b  = row2[0].b;
        result[width-1].r  = row2[width-1].r;
        result[width-1].g  = row2[width-1].g;
        result[width-1].b  = row2[width-1].b;

        /// hist sides same also...
        int val = (int) round(x[ result[width - 1].r ].r + x[ result[width - 1].g  ].g + x[ result[width - 1].b ].b);
        val = val >= 255 ? 254 : (val < 0 ? 0 : val);
        ++histogram[val / 51];

        val = (int) round(x[ result[0].r ].r + x[ result[0].g  ].g + x[ result[0].b ].b);
        val = val >= 255 ? 254 : (val < 0 ? 0 : val);
        ++histogram[val / 51];

        /// go through all cols
        for (int j = 1; j < width - 1; ++j)
        {
            /// compute convolution
            int red, blue , green;
            red = (5 * row2[j].r ) - (row2[j - 1].r) - (row2[j + 1].r) -  row1[j].r -  row3[j].r;
            blue = (5 * row2[j].b) -  (row2[j - 1].b) - (row2[j + 1].b)  - row1[j].b -  row3[j].b;
            green = (5 * row2[j].g) -  (row2[j - 1].g) - (row2[j + 1].g)  - row1[j].g -  row3[j].g;
            result[j].r = red > 255 ? 255 : (red < 0 ? 0 : red);
            result[j].b = blue > 255 ? 255 : (blue < 0 ? 0 : blue);
            result[j].g = green > 255 ? 255 : (green < 0 ? 0 : green);

            /// histogram pixel

            val = (int)round(x[ result[j].r ].r + x[ result[j].g ].g + x[ result[j].b ].b);
            val = val >= 255 ? 254 : (val < 0 ? 0 : val);
            ++histogram[ val / 51];
        }

        /// write result to the file
        fwrite(result, sizeof(pix), width, fileOut);

        /// load new line
        pix *tmp = row1;
        row1 = row2;
        row2 = row3;
        row3 = tmp;
        fread(row3, sizeof(pix), width, fileIn);
    }

    /// write last line
    fwrite(row2, sizeof(pix), width, fileOut);

    /// HISTOGRAM
    FILE *hist = fopen("output.txt", "w");
    for (int i = 0; i < width; ++i)
    {
        int val = (int) round(x[ row2[i].r ].r + x[ row2[i].g  ].g + x[row2[i].b].b);
        val = val >= 255 ? 254 : (val < 0 ? 0 : val);
        ++histogram[val  / 51];
    }

    fprintf(hist, "%d %d %d %d %d", histogram[0], histogram[1], histogram[2], histogram[3], histogram[4]);

    /// close all files
    fclose(fileIn);fclose(fileOut);fclose(hist);

    /// free all memory
    free(row1);free(row2);free(row3);free(result);

    return 0;

}