#include <sys/mman.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <assert.h>

size_t getFilesize(const char* filename) {
    struct stat st;
    stat(filename, &st);
    return st.st_size;
}

/// P6
/// SIRKA VYSKA
/// 255
/// RGB RGB RGB ..... (R/G/B 8byte/8byte/8byte

int main(int argc, char **argv)
{
    // m map
    size_t filesize = getFilesize(argv[1]);

    //Open file
    int fd = open(argv[1], O_RDONLY, 0);

    //Execute mmap
    void* mmappedData = mmap(NULL, filesize, PROT_READ, MAP_PRIVATE | MAP_POPULATE, fd, 0);


    /// NACTI P6
    /// NACTI SIRKA VYSKA
    /// NACTI 255
    /// 3 RADKY ZPRACUJ NARAZ VZDY

    //Write the mmapped data to stdout (= FD #1)
    write(1, mmappedData, filesize);

    //Cleanup
    int rc = munmap(mmappedData, filesize);

    close(fd);
    return 0;
}