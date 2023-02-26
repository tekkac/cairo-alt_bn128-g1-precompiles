%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

from core.bigint import BigInt3, nondet_bigint3
from core.g1 import G1Point, compute_doubling_slope, ec_double, ec_add, ec_mul, g1
from core.g1 import g1_two, g1_three, g1_negone, g1_negtwo, g1_negthree, eq_g1
from contracts.alt_bn128 import ecAdd, ecMul

@view
func test_ec_add{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    alloc_locals;
    let (local one) = g1();
    let (local two) = g1_two();
    let (local res) = ecAdd(one, two);
    let (local three) = g1_three();
    let (equals) = eq_g1(three, res);
    assert 1 = equals;
    return ();
}

@view
func test_ec_mul{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    alloc_locals;
    let (local one) = g1();
    let (local two) = g1_two();
    let (local three) = g1_three();
    let (local res_two) = ecMul(one, BigInt3(2, 0, 0));
    let (equals) = eq_g1(two, res_two);
    assert 1 = equals;
    let (local res_three) = ecMul(one, BigInt3(3, 0, 0));
    let (equals) = eq_g1(three, res_three);
    assert 1 = equals;

    let (local res_mul_1) = ecMul(one, BigInt3(123456789 * 987654321, 0, 0));
    let (local tmp_mul) = ecMul(one, BigInt3(123456789, 0, 0));
    let (local res_mul_2) = ecMul(tmp_mul, BigInt3(987654321, 0, 0));
    let (equals) = eq_g1(res_mul_1, res_mul_2);
    assert 1 = equals;
    return ();
}
