%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

from core.bigint import BigInt3
from core.g1 import G1Point, ec_add, ec_mul

@external
func ecAdd{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    a: G1Point, b: G1Point
) -> (res: G1Point) {
    let (res) = ec_add(a, b);
    return (res=res);
}

@external
func ecMul{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    a: G1Point, s: BigInt3
) -> (res: G1Point) {
    let (res) = ec_mul(a, s);
    return (res=res);
}
