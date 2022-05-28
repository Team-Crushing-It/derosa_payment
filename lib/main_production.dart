// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derosa_payment/app/app.dart';
import 'package:derosa_payment/bootstrap.dart';
import 'package:derosa_payment/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_payments_api/firestore_payments_api.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authenticationRepository = AuthenticationRepository();

  final firestorePaymentsApi =
      FirestorePaymentsApi(firestore: FirebaseFirestore.instance);

  await bootstrap(
    () => App(
      authenticationRepository: authenticationRepository,
      firestorePaymentsApi: firestorePaymentsApi,
    ),
  );
}
