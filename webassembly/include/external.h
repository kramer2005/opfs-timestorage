#ifndef __EXTERNAL_H__
#define __EXTERNAL_H__

#include <stdlib.h>

void save_nodes(void *head, size_t count, size_t struct_size);
void load_nodes(void *head, size_t *count, size_t struct_size);
void clear_storage();

#endif // __EXTERNAL_H__#include <__stddef_size_t.h>
