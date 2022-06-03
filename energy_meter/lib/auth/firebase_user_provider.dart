import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EnergyMeterFirebaseUser {
  EnergyMeterFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

EnergyMeterFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EnergyMeterFirebaseUser> energyMeterFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<EnergyMeterFirebaseUser>(
        (user) => currentUser = EnergyMeterFirebaseUser(user));
