#include <cstring>
#include <iostream>
#include <sqlite3.h>
#include <string>

using namespace std;

void executeSQL(sqlite3 *db, const string &sql) {
  char *zErrMsg = 0;
  int rc = sqlite3_exec(db, sql.c_str(), NULL, 0, &zErrMsg);
  if (rc != SQLITE_OK) {
    cerr << "SQL error: " << zErrMsg << endl;
    sqlite3_free(zErrMsg);
  } else {
    cout << "SQL executed successfully: " << sql << endl;
  }
}

void executeSelect(sqlite3 *db, const string &query) {
  sqlite3_stmt *stmt;
  int rc = sqlite3_prepare_v2(db, query.c_str(), -1, &stmt, NULL);
  if (rc == SQLITE_OK) {
    int nCol = sqlite3_column_count(stmt);
    for (int i = 0; i < nCol; i++) {
      cout << sqlite3_column_name(stmt, i) << "\t";
    }
    cout << endl;

    while (sqlite3_step(stmt) == SQLITE_ROW) {
      for (int i = 0; i < nCol; i++) {
        const char *text = (const char *)sqlite3_column_text(stmt, i);
        cout << (text ? text : "NULL") << "\t";
      }
      cout << endl;
    }
  } else {
    cerr << "Prepare error: " << sqlite3_errmsg(db) << endl;
  }
  sqlite3_finalize(stmt);
}

int main() {
  sqlite3 *db;
  string dbName;

  cout << "Enter database name (without extension): ";
  getline(cin, dbName);
  dbName += ".db";

  int rc = sqlite3_open(dbName.c_str(), &db);
  if (rc != SQLITE_OK) {
    cerr << "Cannot open database: " << sqlite3_errmsg(db) << endl;
    return 1;
  }

  cout << "Database '" << dbName << "' opened successfully!" << endl;

  string command;
  cout << "Enter SQL commands (type 'C' or 'EXIT' to quit):" << endl;
  cout << ">" << flush;

  while (getline(cin, command) && command != "C" && command != "EXIT") {
    if (command.empty()) {
      cout << "Empty command. Please try again." << endl;
      continue;
    }
    if (command.find("CREATE TABLE") == 0 || command.find("INSERT INTO") == 0) {
      executeSQL(db, command);
    } else if (command.find("SELECT") == 0) {
      executeSelect(db, command);
    } else {
      executeSQL(db, command);
    }
    cout << ">" << flush;
  }

  sqlite3_close(db);
  return 0;
}
