#!/usr/bin/env python3

"""
This script is used for generating WebAssembly SIMD test cases.
"""
import sys
import argparse
import importlib


SUBMODULES = (
    'simd_i8x16_cmp',
    'simd_i16x8_cmp',
    'simd_i32x4_cmp',
    'simd_f32x4_cmp',
    'simd_f64x2_cmp',
    'simd_i8x16_arith',
    'simd_i16x8_arith',
    'simd_i32x4_arith',
    'simd_f32x4_arith',
    'simd_sat_arith',
    'simd_bitwise',
    'simd_f32x4',
)


def gen_group_tests(mod_name):
    """mod_name is the back-end script name without the.py extension.
    There must be a gen_test_cases() function in each module."""
    mod = importlib.import_module(mod_name)
    mod.gen_test_cases()


def main():
    """
    Default program entry
    """

    parser = argparse.ArgumentParser(
        description='Front-end script to call other modules to generate SIMD tests')
    parser.add_argument('-a', '--all', dest='gen_all', action='store_true',
                        default=False, help='Generate all the tests')
    parser.add_argument('-i', '--inst', dest='inst_group', choices=SUBMODULES,
                        help='Back-end scripts that generate the SIMD tests')
    args = parser.parse_args()

    if len(sys.argv) < 2:
        parser.print_help()

    if args.inst_group:
        gen_group_tests(args.inst_group)
    if args.gen_all:
        for mod_name in SUBMODULES:
            gen_group_tests(mod_name)


if __name__ == '__main__':
    main()
    print('Done.')