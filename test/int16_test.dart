// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library Int32test;

import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';

void main() {
  group("isX tests", () {
    test("isEven", () {
      expect((-Int16.ONE).isEven, false);
      expect(Int16.ZERO.isEven, true);
      expect(Int16.ONE.isEven, false);
      expect(Int16.TWO.isEven, true);
    });
  });
}
