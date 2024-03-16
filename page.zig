const Page = struct {
    pub fn alloc(self: *@This(), size: u32) !void {
        //use operation memory allocator
        const mem = std.os.mmap(alignForward(size, page_size)) catch {
            return error.OutOfMemory;
        };

        return mem[0..size];
    }

    pub fn free(self: *@This(), mem: []u8) void {
        return std.os.munmap(mem);
    }
};
