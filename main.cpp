#include <cstring>
#include <iostream>
#include <sqlite3.h>
#include <string>

using namespace std;

int main(int argc, char *argv[]) {
  sqlite3 *db;
  int rc = sqlite3_open("bobr.curve", &db);
  if (rc != SQLITE_OK) {
    cerr << "Cannot open database: " << sqlite3_errmsg(db) << endl;
    sqlite3_close(db);
    return 1;
  }

  char *zErrMsg = 0;
  string command;
  cout << ">" << flush;
  getline(cin, command);

  while (command != "C") {
    rc = sqlite3_exec(db, command.c_str(), NULL, 0, &zErrMsg);
    if (rc != SQLITE_OK) {
      cerr << "SQL error: " << zErrMsg << endl;
      sqlite3_free(zErrMsg);
    } else {
      sqlite3_stmt *stmt;
      rc = sqlite3_prepare_v2(db, command.c_str(), -1, &stmt, NULL);
      if (rc == SQLITE_OK) {
        int nCol = sqlite3_column_count(stmt);
        // Печатаем названия столбцов
        for (int i = 0; i < nCol; i++) {
          cout << sqlite3_column_name(stmt, i) << "\t";
        }
        cout << endl;

        // Печатаем данные
        while (sqlite3_step(stmt) == SQLITE_ROW) {
          for (int i = 0; i < nCol; i++) {
            cout << (const char *)sqlite3_column_text(stmt, i) << "\t";
          }
          cout << endl;
        }
      } else {
        cerr << "Prepare error: " << sqlite3_errmsg(db) << endl;
      }
      sqlite3_finalize(stmt);
    }
    cout << ">" << flush;
    getline(cin, command);
  }

  sqlite3_close(db);
  return 0;
}
