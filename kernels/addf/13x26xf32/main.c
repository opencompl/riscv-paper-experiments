#include "testcase.h"

#include <stddef.h>
#include <stdint.h>

int main(void) {
    uint32_t res = testcase_run();
    return (int)res;
}
