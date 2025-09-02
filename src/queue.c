#include <queue.h>
#include <stdio.h>
#include <stdlib.h>

void enqueue(Queue *queue, double value) {

    if ((queue->rear + 1) % queue->capacity == queue->front) {

        // Never should happen
        printf("The queue is full!\n");
        abort();
    }
    queue->data[queue->rear] = value;
    queue->rear = (queue->rear + 1) % queue->capacity;
}

double dequeue(Queue *queue) {

    if (queue->front == queue->rear) {

        // Never should happen
        printf("The queue is empty!\n");
        abort();
    }
    double value = queue->data[queue->front];
    queue->front = (queue->front + 1) % queue->capacity;
    return value;
}