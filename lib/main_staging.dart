// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/app.dart';
import 'package:pokedex/bootstrap.dart';

void main() {
  bootstrap(() => const ProviderScope(child: PokedexApp()));
}
