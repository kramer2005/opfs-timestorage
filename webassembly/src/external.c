#include <emscripten.h>
#include <external.h>

EM_ASYNC_JS(void, save_nodes, (void *head, size_t count, size_t struct_size), {
    await saveNodes(head, count, struct_size);
})

EM_ASYNC_JS(void, load_nodes, (void *head, size_t *count, size_t struct_size), {
    await loadNodes(head, count, struct_size);
})

EMSCRIPTEN_KEEPALIVE
void clear_storage()
{
    EM_ASM({
        clearStorage();
    });
}