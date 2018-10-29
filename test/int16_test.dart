// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library Int32test;

import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';

void main() {
  group('isX tests', () {
    test('isEven', () {
      expect((-Int16.ONE).isEven, false);
      expect(Int16.ZERO.isEven, true);
      expect(Int16.ONE.isEven, false);
      expect(Int16.TWO.isEven, true);
    });
    test('isMaxValue', () {
      expect(Int16.MIN_VALUE.isMaxValue, false);
      expect(Int16.ZERO.isMaxValue, false);
      expect(Int16.MAX_VALUE.isMaxValue, true);
    });
    test('isMinValue', () {
      expect(Int16.MIN_VALUE.isMinValue, true);
      expect(Int16.ZERO.isMinValue, false);
      expect(Int16.MAX_VALUE.isMinValue, false);
    });
    test('isNegative', () {
      expect(Int16.MIN_VALUE.isNegative, true);
      expect(Int16.ZERO.isNegative, false);
      expect(Int16.ONE.isNegative, false);
    });
    test('isOdd', () {
      expect((-Int16.ONE).isOdd, true);
      expect(Int16.ZERO.isOdd, false);
      expect(Int16.ONE.isOdd, true);
      expect(Int16.TWO.isOdd, false);
    });
    test('isZero', () {
      expect(Int16.MIN_VALUE.isZero, false);
      expect(Int16.ZERO.isZero, true);
      expect(Int16.MAX_VALUE.isZero, false);
    });
    test('bitLength', () {
      expect(new Int16(-2).bitLength, 1);
      expect((-Int16.ONE).bitLength, 0);
      expect(Int16.ZERO.bitLength, 0);
      expect(Int16.ONE.bitLength, 1);
      expect(new Int16(2).bitLength, 2);
      expect(Int16.MAX_VALUE.bitLength, 15);
      expect(Int16.MIN_VALUE.bitLength, 15);
    });
  });

  group('arithmetic operators', () {
    Int16 n1 = new Int16(1234);
    Int16 n2 = new Int16(9876);
    Int16 n3 = new Int16(-1234);
    Int16 n4 = new Int16(-9876);

    test('+', () {
      expect(n1 + n2, new Int16(11110));
      expect(n3 + n2, new Int16(8642));
      expect(n3 + n4, new Int16(-11110));
      expect(n3 + new Int32(1), new Int32(-1233));
      expect(n3 + new Int64(1), new Int64(-1233));
      expect(Int16.MAX_VALUE + 1, Int16.MIN_VALUE);
      expect(() => new Int16(17) + null, throwsArgumentError);
    });

    test('-', () {
      expect(n1 - n2, new Int16(-8642));
      expect(n3 - n2, new Int16(-11110));
      expect(n3 - n4, new Int16(8642));
      expect(n3 - new Int64(1), new Int64(-1235));
      expect(Int16.MIN_VALUE - 1, Int16.MAX_VALUE);
      expect(() => new Int16(17) - null, throwsArgumentError);
    });

    test('unary -', () {
      expect(-n1, new Int16(-1234));
      expect(-Int16.ZERO, Int16.ZERO);
    });

    test('*', () {
      Int16 n1 = new Int16(123);
      Int16 n2 = new Int16(98);
      Int16 n3 = new Int16(-123);
      Int16 n4 = new Int16(-98);

      expect(n1 * n2, new Int16(12054));
      expect(n2 * n3, new Int16(-12054));
      expect(n3 * n3, new Int16(15129));
      expect(n3 * n2, new Int16(-12054));
      expect(new Int16(0x123) * new Int16(0x22), new Int16(9894));
      expect((new Int16(1234) * new Int16(98)), new Int16(-10140));
      expect(new Int32(0x1234) * new Int64(0x21411f10), new Int64(2599888187200));
      // Wraps
      expect(new Int16(12345) * 98765, new Int16(22181));
      expect(() => new Int16(17) * null, throwsArgumentError);
    });

    test('~/', () {
      expect(new Int16(3893) ~/ new Int16(1919), new Int16(2));
      expect(new Int16(0x1234) ~/ new Int16(0x22), new Int16(0x1234 ~/ 0x22));
      expect(new Int16(13893) ~/ new Int64(1919), new Int16(7));
      expect(new Int16(0x5678) ~/ new Int64(0x22), new Int16(0x5678 ~/ 0x22));
      expect(new Int16(13893) ~/ 1919, new Int16(7));
      expect(
          () => new Int32(16) ~/ Int32.ZERO,
          // with dart2js, `UnsupportedError` is thrown
          // on the VM: IntegerDivisionByZeroException
          throwsA(anyOf(new TypeMatcher<IntegerDivisionByZeroException>(),
              isUnsupportedError)));
      expect(() => new Int32(17) ~/ null, throwsArgumentError);
    });

    // test("%", () {
    //   expect(new Int32(0x12345678) % new Int32(0x22),
    //       new Int32(0x12345678 % 0x22));
    //   expect(new Int32(0x12345678) % new Int64(0x22),
    //       new Int32(0x12345678 % 0x22));
    //   expect(() => new Int32(17) % null, throwsArgumentError);
    // });

    // test("remainder", () {
    //   expect(new Int32(0x12345678).remainder(new Int32(0x22)),
    //       new Int32(0x12345678.remainder(0x22)));
    //   expect(new Int32(0x12345678).remainder(new Int32(-0x22)),
    //       new Int32(0x12345678.remainder(-0x22)));
    //   expect(new Int32(-0x12345678).remainder(new Int32(-0x22)),
    //       new Int32(-0x12345678.remainder(-0x22)));
    //   expect(new Int32(-0x12345678).remainder(new Int32(0x22)),
    //       new Int32(-0x12345678.remainder(0x22)));
    //   expect(new Int32(0x12345678).remainder(new Int64(0x22)),
    //       new Int32(0x12345678.remainder(0x22)));
    //   expect(() => new Int32(17).remainder(null), throwsArgumentError);
    // });

    // test("abs", () {
    //   // NOTE: Int32.MIN_VALUE.abs() is undefined
    //   expect((Int32.MIN_VALUE + 1).abs(), Int32.MAX_VALUE);
    //   expect(new Int32(-1).abs(), new Int32(1));
    //   expect(new Int32(0).abs(), new Int32(0));
    //   expect(new Int32(1).abs(), new Int32(1));
    //   expect(Int32.MAX_VALUE.abs(), Int32.MAX_VALUE);
    // });

    // test("clamp", () {
    //   Int32 val = new Int32(17);
    //   expect(val.clamp(20, 30), new Int32(20));
    //   expect(val.clamp(10, 20), new Int32(17));
    //   expect(val.clamp(10, 15), new Int32(15));

    //   expect(val.clamp(new Int32(20), new Int32(30)), new Int32(20));
    //   expect(val.clamp(new Int32(10), new Int32(20)), new Int32(17));
    //   expect(val.clamp(new Int32(10), new Int32(15)), new Int32(15));

    //   expect(val.clamp(new Int64(20), new Int64(30)), new Int32(20));
    //   expect(val.clamp(new Int64(10), new Int64(20)), new Int32(17));
    //   expect(val.clamp(new Int64(10), new Int64(15)), new Int32(15));
    //   expect(val.clamp(Int64.MIN_VALUE, new Int64(30)), new Int32(17));
    //   expect(val.clamp(new Int64(10), Int64.MAX_VALUE), new Int32(17));

    //   expect(() => val.clamp(30.5, 40.5), throwsArgumentError);
    //   expect(() => val.clamp(5.5, 10.5), throwsArgumentError);
    //   expect(() => val.clamp('a', 1), throwsArgumentError);
    //   expect(() => val.clamp(1, 'b'), throwsArgumentError);
    //   expect(() => val.clamp('a', 1), throwsArgumentError);
    // });
  });

  // group("leading/trailing zeros", () {
  //   test("numberOfLeadingZeros", () {
  //     expect(new Int32(0).numberOfLeadingZeros(), 32);
  //     expect(new Int32(1).numberOfLeadingZeros(), 31);
  //     expect(new Int32(0xffff).numberOfLeadingZeros(), 16);
  //     expect(new Int32(-1).numberOfLeadingZeros(), 0);
  //   });
  //   test("numberOfTrailingZeros", () {
  //     expect(new Int32(0).numberOfTrailingZeros(), 32);
  //     expect(new Int32(0x80000000).numberOfTrailingZeros(), 31);
  //     expect(new Int32(1).numberOfTrailingZeros(), 0);
  //     expect(new Int32(0x10000).numberOfTrailingZeros(), 16);
  //   });
  // });

  // group("comparison operators", () {
  //   test("compareTo", () {
  //     expect(new Int32(0).compareTo(-1), 1);
  //     expect(new Int32(0).compareTo(0), 0);
  //     expect(new Int32(0).compareTo(1), -1);
  //     expect(new Int32(0).compareTo(new Int32(-1)), 1);
  //     expect(new Int32(0).compareTo(new Int32(0)), 0);
  //     expect(new Int32(0).compareTo(new Int32(1)), -1);
  //     expect(new Int32(0).compareTo(new Int64(-1)), 1);
  //     expect(new Int32(0).compareTo(new Int64(0)), 0);
  //     expect(new Int32(0).compareTo(new Int64(1)), -1);
  //   });

  //   test("<", () {
  //     expect(new Int32(17) < new Int32(18), true);
  //     expect(new Int32(17) < new Int32(17), false);
  //     expect(new Int32(17) < new Int32(16), false);
  //     expect(new Int32(17) < new Int64(18), true);
  //     expect(new Int32(17) < new Int64(17), false);
  //     expect(new Int32(17) < new Int64(16), false);
  //     expect(Int32.MIN_VALUE < Int32.MAX_VALUE, true);
  //     expect(Int32.MAX_VALUE < Int32.MIN_VALUE, false);
  //     expect(() => new Int32(17) < null, throwsArgumentError);
  //   });

  //   test("<=", () {
  //     expect(new Int32(17) <= new Int32(18), true);
  //     expect(new Int32(17) <= new Int32(17), true);
  //     expect(new Int32(17) <= new Int32(16), false);
  //     expect(new Int32(17) <= new Int64(18), true);
  //     expect(new Int32(17) <= new Int64(17), true);
  //     expect(new Int32(17) <= new Int64(16), false);
  //     expect(Int32.MIN_VALUE <= Int32.MAX_VALUE, true);
  //     expect(Int32.MAX_VALUE <= Int32.MIN_VALUE, false);
  //     expect(() => new Int32(17) <= null, throwsArgumentError);
  //   });

  //   test("==", () {
  //     expect(new Int32(17) == new Int32(18), false);
  //     expect(new Int32(17) == new Int32(17), true);
  //     expect(new Int32(17) == new Int32(16), false);
  //     expect(new Int32(17) == new Int64(18), false);
  //     expect(new Int32(17) == new Int64(17), true);
  //     expect(new Int32(17) == new Int64(16), false);
  //     expect(Int32.MIN_VALUE == Int32.MAX_VALUE, false);
  //     expect(new Int32(17) == 18, false);
  //     expect(new Int32(17) == 17, true);
  //     expect(new Int32(17) == 16, false);
  //     expect(new Int32(17) == new Object(), false);
  //     expect(new Int32(17) == null, false);
  //   });

  //   test(">=", () {
  //     expect(new Int32(17) >= new Int32(18), false);
  //     expect(new Int32(17) >= new Int32(17), true);
  //     expect(new Int32(17) >= new Int32(16), true);
  //     expect(new Int32(17) >= new Int64(18), false);
  //     expect(new Int32(17) >= new Int64(17), true);
  //     expect(new Int32(17) >= new Int64(16), true);
  //     expect(Int32.MIN_VALUE >= Int32.MAX_VALUE, false);
  //     expect(Int32.MAX_VALUE >= Int32.MIN_VALUE, true);
  //     expect(() => new Int32(17) >= null, throwsArgumentError);
  //   });

  //   test(">", () {
  //     expect(new Int32(17) > new Int32(18), false);
  //     expect(new Int32(17) > new Int32(17), false);
  //     expect(new Int32(17) > new Int32(16), true);
  //     expect(new Int32(17) > new Int64(18), false);
  //     expect(new Int32(17) > new Int64(17), false);
  //     expect(new Int32(17) > new Int64(16), true);
  //     expect(Int32.MIN_VALUE > Int32.MAX_VALUE, false);
  //     expect(Int32.MAX_VALUE > Int32.MIN_VALUE, true);
  //     expect(() => new Int32(17) > null, throwsArgumentError);
  //   });
  // });

  // group("bitwise operators", () {
  //   test("&", () {
  //     expect(new Int32(0x12345678) & new Int32(0x22222222),
  //         new Int32(0x12345678 & 0x22222222));
  //     expect(new Int32(0x12345678) & new Int64(0x22222222),
  //         new Int64(0x12345678 & 0x22222222));
  //     expect(() => new Int32(17) & null, throwsArgumentError);
  //   });

  //   test("|", () {
  //     expect(new Int32(0x12345678) | new Int32(0x22222222),
  //         new Int32(0x12345678 | 0x22222222));
  //     expect(new Int32(0x12345678) | new Int64(0x22222222),
  //         new Int64(0x12345678 | 0x22222222));
  //     expect(() => new Int32(17) | null, throwsArgumentError);
  //   });

  //   test("^", () {
  //     expect(new Int32(0x12345678) ^ new Int32(0x22222222),
  //         new Int32(0x12345678 ^ 0x22222222));
  //     expect(new Int32(0x12345678) ^ new Int64(0x22222222),
  //         new Int64(0x12345678 ^ 0x22222222));
  //     expect(() => new Int32(17) ^ null, throwsArgumentError);
  //   });

  //   test("~", () {
  //     expect(~(new Int32(0x12345678)), new Int32(~0x12345678));
  //     expect(-(new Int32(0x12345678)), new Int64(-0x12345678));
  //   });
  // });

  // group("bitshift operators", () {
  //   test("<<", () {
  //     expect(new Int32(0x12345678) << 7, new Int32(0x12345678 << 7));
  //     expect(new Int32(0x12345678) << 32, Int32.ZERO);
  //     expect(new Int32(0x12345678) << 33, Int32.ZERO);
  //     expect(() => new Int32(17) << -1, throwsArgumentError);
  //     expect(() => new Int32(17) << null, throwsNoSuchMethodError);
  //   });

  //   test(">>", () {
  //     expect(new Int32(0x12345678) >> 7, new Int32(0x12345678 >> 7));
  //     expect(new Int32(0x12345678) >> 32, Int32.ZERO);
  //     expect(new Int32(0x12345678) >> 33, Int32.ZERO);
  //     expect(new Int32(-42) >> 32, new Int32(-1));
  //     expect(new Int32(-42) >> 33, new Int32(-1));
  //     expect(() => new Int32(17) >> -1, throwsArgumentError);
  //     expect(() => new Int32(17) >> null, throwsNoSuchMethodError);
  //   });

  //   test("shiftRightUnsigned", () {
  //     expect(new Int32(0x12345678).shiftRightUnsigned(7),
  //         new Int32(0x12345678 >> 7));
  //     expect(new Int32(0x12345678).shiftRightUnsigned(32), Int32.ZERO);
  //     expect(new Int32(0x12345678).shiftRightUnsigned(33), Int32.ZERO);
  //     expect(new Int32(-42).shiftRightUnsigned(32), Int32.ZERO);
  //     expect(new Int32(-42).shiftRightUnsigned(33), Int32.ZERO);
  //     expect(() => (new Int32(17).shiftRightUnsigned(-1)), throwsArgumentError);
  //     expect(() => (new Int32(17).shiftRightUnsigned(null)),
  //         throwsNoSuchMethodError);
  //   });
  // });

  // group("conversions", () {
  //   test("toSigned", () {
  //     expect(Int32.ONE.toSigned(2), Int32.ONE);
  //     expect(Int32.ONE.toSigned(1), -Int32.ONE);
  //     expect(Int32.MAX_VALUE.toSigned(32), Int32.MAX_VALUE);
  //     expect(Int32.MIN_VALUE.toSigned(32), Int32.MIN_VALUE);
  //     expect(Int32.MAX_VALUE.toSigned(31), -Int32.ONE);
  //     expect(Int32.MIN_VALUE.toSigned(31), Int32.ZERO);
  //     expect(() => Int32.ONE.toSigned(0), throwsRangeError);
  //     expect(() => Int32.ONE.toSigned(33), throwsRangeError);
  //   });
  //   test("toUnsigned", () {
  //     expect(Int32.ONE.toUnsigned(1), Int32.ONE);
  //     expect(Int32.ONE.toUnsigned(0), Int32.ZERO);
  //     expect(Int32.MAX_VALUE.toUnsigned(32), Int32.MAX_VALUE);
  //     expect(Int32.MIN_VALUE.toUnsigned(32), Int32.MIN_VALUE);
  //     expect(Int32.MAX_VALUE.toUnsigned(31), Int32.MAX_VALUE);
  //     expect(Int32.MIN_VALUE.toUnsigned(31), Int32.ZERO);
  //     expect(() => Int32.ONE.toUnsigned(-1), throwsRangeError);
  //     expect(() => Int32.ONE.toUnsigned(33), throwsRangeError);
  //   });
  //   test("toDouble", () {
  //     expect(new Int32(17).toDouble(), same(17.0));
  //     expect(new Int32(-17).toDouble(), same(-17.0));
  //   });
  //   test("toInt", () {
  //     expect(new Int32(17).toInt(), 17);
  //     expect(new Int32(-17).toInt(), -17);
  //   });
  //   test("toInt32", () {
  //     expect(new Int32(17).toInt32(), new Int32(17));
  //     expect(new Int32(-17).toInt32(), new Int32(-17));
  //   });
  //   test("toInt64", () {
  //     expect(new Int32(17).toInt64(), new Int64(17));
  //     expect(new Int32(-17).toInt64(), new Int64(-17));
  //   });
  //   test("toBytes", () {
  //     expect(new Int32(0).toBytes(), [0, 0, 0, 0]);
  //     expect(new Int32(0x01020304).toBytes(), [4, 3, 2, 1]);
  //     expect(new Int32(0x04030201).toBytes(), [1, 2, 3, 4]);
  //     expect(new Int32(-1).toBytes(), [0xff, 0xff, 0xff, 0xff]);
  //   });
  // });

  // group("parse", () {
  //   test("base 10", () {
  //     checkInt(int x) {
  //       expect(Int32.parseRadix('$x', 10), new Int32(x));
  //     }

  //     checkInt(0);
  //     checkInt(1);
  //     checkInt(1000);
  //     checkInt(12345678);
  //     checkInt(2147483647);
  //     checkInt(2147483648);
  //     checkInt(4294967295);
  //     checkInt(4294967296);
  //     expect(() => Int32.parseRadix('xyzzy', -1), throwsArgumentError);
  //     expect(() => Int32.parseRadix('plugh', 10), throwsFormatException);
  //   });

  //   test("parseRadix", () {
  //     check(String s, int r, String x) {
  //       expect(Int32.parseRadix(s, r).toString(), x);
  //     }

  //     check('deadbeef', 16, '-559038737');
  //     check('95', 12, '113');
  //   });

  //   test("parseInt", () {
  //     expect(Int32.parseInt('0'), new Int32(0));
  //     expect(Int32.parseInt('1000'), new Int32(1000));
  //     expect(Int32.parseInt('4294967296'), new Int32(4294967296));
  //   });

  //   test("parseHex", () {
  //     expect(Int32.parseHex('deadbeef'), new Int32(0xdeadbeef));
  //     expect(Int32.parseHex('cafebabe'), new Int32(0xcafebabe));
  //     expect(Int32.parseHex('8badf00d'), new Int32(0x8badf00d));
  //   });
  // });

  group('string representation', () {
    test('toString', () {
      expect(new Int16(0).toString(), '0');
      expect(new Int16(1).toString(), '1');
      expect(new Int16(-1).toString(), '-1');
      expect(new Int16(1000).toString(), '1000');
      expect(new Int16(-1000).toString(), '-1000');
      expect(new Int16(12345).toString(), '12345');
      expect(new Int16(32767).toString(), '32767');
      expect(new Int16(32768).toString(), '-32768');
      expect(new Int16(32769).toString(), '-32767');
      expect(new Int16(32770).toString(), '-32766');
      expect(new Int16(-32768).toString(), '-32768');
      expect(new Int16(-32769).toString(), '32767');
      expect(new Int16(-32770).toString(), '32766');
      // expect(new Int16(-2147483649).toString(), '2147483647');
      // expect(new Int16(-2147483650).toString(), '2147483646');
    });
  });

  group('toHexString', () {
    test('returns hexadecimal string representation', () {
      expect(new Int16(-1).toHexString(), '-1');
      expect((new Int16(-1) >> 8).toHexString(), '-1');
      expect((new Int16(-1) << 8).toHexString(), '-100');
      expect(new Int16(12345).toHexString(), '3039');
      expect(new Int16(-1).shiftRightUnsigned(8).toHexString(), 'ff');
    });
  });

  group('toRadixString', () {
    test('returns base n string representation', () {
      expect(new Int32(12345).toRadixString(5), '343340');
    });
  });
}
