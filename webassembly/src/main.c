#include <emscripten.h>
#include <stdio.h>
#include <string.h>
#include <external.h>

typedef struct Node
{
    int x;
    int y;
} Node;

size_t count = 0;
Node head[100];

void print_nodes()
{
    if (count == 0)
    {
        printf("No nodes\n");
        return;
    }

    for (int i = 0; i < count; i++)
    {
        printf("Point %d: { x: %d, y: %d }\n", i, head[i].x, head[i].y);
    }
}

int main()
{
    load_nodes(&head, &count, sizeof(Node));
    print_nodes();

    head[0].x = 10;
    head[1].x = 20;
    head[2].x = 30;

    head[0].y = -10;
    head[1].y = -20;
    head[2].y = -30;

    count = 3;
    print_nodes();

    save_nodes(&head, count, sizeof(Node));

    head[0].x = 0;
    head[1].x = 0;
    head[2].x = 0;

    head[0].y = 0;
    head[1].y = 0;
    head[2].y = 0;

    count = 0;
    print_nodes();

    load_nodes(&head, &count, sizeof(Node));
    print_nodes();
    clear_storage();

    return 0;
}