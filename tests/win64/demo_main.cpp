#include <cstdint>
#include <cstring>
#include <iostream>

extern "C" std::uint64_t sum_u64(const std::uint64_t* values, std::uint64_t len);
extern "C" std::uint64_t strlen_asm(const char* s);
extern "C" std::uint64_t bitcount_u64(std::uint64_t value);

static bool test_sum() {
    const std::uint64_t values[] = {1, 2, 3, 4, 5, 100};
    const auto got = sum_u64(values, 6);
    const auto expected = static_cast<std::uint64_t>(115);
    std::cout << "[sum_u64] expected=" << expected << " got=" << got << "\n";
    return got == expected;
}

static bool test_strlen() {
    const char* text = "vortex-digital";
    const auto got = strlen_asm(text);
    const auto expected = static_cast<std::uint64_t>(std::strlen(text));
    std::cout << "[strlen_asm] expected=" << expected << " got=" << got << "\n";
    return got == expected;
}

static bool test_bitcount() {
    const std::uint64_t value = 0xF0F0F0F00F0F0F0FULL;
    const auto got = bitcount_u64(value);
    const auto expected = static_cast<std::uint64_t>(32);
    std::cout << "[bitcount_u64] expected=" << expected << " got=" << got << "\n";
    return got == expected;
}

int main() {
    bool ok = true;
    ok = test_sum() && ok;
    ok = test_strlen() && ok;
    ok = test_bitcount() && ok;

    if (ok) {
        std::cout << "ALL TESTS PASSED\n";
        return 0;
    }

    std::cout << "TEST FAILURE\n";
    return 1;
}
