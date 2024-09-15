declare const Module: EmscriptenModule & {
    _main: () => void;
};

type Pointer = number;

const saveNodes = async (head: Pointer, count: number, structSize: number) => {
    const memory = new Uint8Array(Module.HEAPU8.buffer, head, count * structSize);
    const opfsFolder = await navigator.storage.getDirectory();
    const file = await opfsFolder.getFileHandle('nodes.dat', { create: true });
    const writable = await file.createWritable();
    const writer = writable.getWriter();

    await writer.write(new Uint32Array([count]));
    await writer.write(memory);

    await writer.close();
}

const loadNodes = async (head: Pointer, count: Pointer, structSize: number) => {
    const opfsFolder = await navigator.storage.getDirectory();
    let file: FileSystemFileHandle;
    try {
        file = await opfsFolder.getFileHandle('nodes.dat', { create: false });
    } catch (error) {
        return;
    }

    const readable = await file.getFile();
    const data = await readable.arrayBuffer();

    const counterRead = new Uint32Array(data, 0, 1);
    const itemsRead = new Uint8Array(data, 4, counterRead[0] * structSize);

    const memory = new Uint8Array(Module.HEAPU8.buffer, head, count * structSize);
    memory.set(itemsRead);
    
    const countMemory = new Uint32Array(Module.HEAPU8.buffer, count, 1);
    countMemory[0] = counterRead[0];
}

const clearStorage = async () => {
    const opfsRoot = await navigator.storage.getDirectory();

    // @ts-expect-error Remove is not in the types
    opfsRoot.remove()
}