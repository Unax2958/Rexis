#pragma once

#include <stddef.h>

typedef struct {

    double *data;
    size_t rear;
    size_t front;
    size_t capacity;
} Queue;

void enqueue(Queue *queue, double value);
double dequeue(Queue *queue);