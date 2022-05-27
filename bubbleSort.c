// C program for implementation of Bubble sort
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 20

void swap(int* xp, int* yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}

// A function to implement bubble sort
void bubbleSort(int arr[], int n)
{
    int i, j, again;
    do{
        i = 0;
        again = 0;
        while (i < n - 1) {
            j = i + 1;
            
            if (arr[i] > arr[j]) {
                swap(&arr[i], &arr[j]);
                again = 1;
            }
            i++;
        }

    } while (again);
}

/* Function to print an array */
void printArray(int arr[], int size)
{
    int i;
    for (i = 0; i < size; i++)
        printf("%4d", arr[i]);
    printf("\n");
}

// Driver program to test above functions
int main()
{

    int arr[SIZE];
    int a, b, temp;

    /* seed the randomizer */
    srand((unsigned)time(NULL));

    /* build and display the random values */
    printf("%d random values, unsorted:\n", SIZE);
    for (a = 0; a < SIZE; a++)
    {
        arr[a] = rand() % 100 + 1;	/* values from 1 to 100 */
        printf("%4d", arr[a]);
    }
    putchar('\n');

    int n = sizeof(arr) / sizeof(arr[0]);
    bubbleSort(arr, n);
    printf("%d random values, sorted:\n", SIZE);
    printArray(arr, n);
    
    return 0;
}