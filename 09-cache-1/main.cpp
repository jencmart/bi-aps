#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<stdint.h>
#define N 100000

struct DATA {
    uint8_t a;
    int b;
    char c;
};

int main(void){
    struct DATA * pMyData= (struct DATA*)malloc(N*sizeof(struct DATA));

    long int i;
    double avg=0;

    if(pMyData ==NULL){
        printf("Nedostatek pameti.\n");
        return 0;
    }

    for(i=0; i<N; i++){    // Inicializace datovych prvku struktury v poli
        pMyData[i].b = 0;
        pMyData[i].a = 0;
        pMyData[i].c = 0;
    }

    // ZDE: Zacatek mereni casu behu programu
    // ... Nasledovaly by byly nejake mezivypocty, ktere pouzivaji pole pMyData..


    for(i=0; i<N; i++)
    {
        pMyData[i].b++;
        if(i%2 ==0)
            avg+=pMyData[i].a;
    }

    avg /= ((N/2)+(N%2));

    // ZDE: Konec mereni casu behu programu
    return 0;
}