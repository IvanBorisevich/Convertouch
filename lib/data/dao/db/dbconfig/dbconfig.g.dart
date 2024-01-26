// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbconfig.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorConvertouchDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ConvertouchDatabaseBuilder databaseBuilder(String name) =>
      _$ConvertouchDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ConvertouchDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$ConvertouchDatabaseBuilder(null);
}

class _$ConvertouchDatabaseBuilder {
  _$ConvertouchDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$ConvertouchDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ConvertouchDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ConvertouchDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ConvertouchDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ConvertouchDatabase extends ConvertouchDatabase {
  _$ConvertouchDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UnitGroupDaoDb? _unitGroupDaoInstance;

  UnitDaoDb? _unitDaoInstance;

  RefreshableValueDaoDb? _refreshableValueDaoInstance;

  RefreshingJobDaoDb? _refreshingJobDaoInstance;

  JobDataSourceDaoDb? _jobDataSourceDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `unit_groups` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `icon_name` TEXT, `conversion_type` INTEGER, `refreshable` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `units` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `code` TEXT NOT NULL, `symbol` TEXT, `coefficient` REAL, `unit_group_id` INTEGER NOT NULL, FOREIGN KEY (`unit_group_id`) REFERENCES `unit_groups` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `refreshable_values` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `unit_id` INTEGER NOT NULL, `value` TEXT, FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `refreshing_jobs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `unit_group_id` INTEGER NOT NULL, `refreshable_data_part` INTEGER NOT NULL, `last_refresh_time` TEXT, `data_source_id` INTEGER, `cron_name` TEXT, FOREIGN KEY (`unit_group_id`) REFERENCES `unit_groups` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY (`data_source_id`) REFERENCES `job_data_sources` (`id`) ON UPDATE NO ACTION ON DELETE SET NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `job_data_sources` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `url` TEXT NOT NULL, `response_transformer_name` TEXT NOT NULL, `job_id` INTEGER NOT NULL, FOREIGN KEY (`job_id`) REFERENCES `refreshing_jobs` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_unit_groups_name` ON `unit_groups` (`name`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_units_code_unit_group_id` ON `units` (`code`, `unit_group_id`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_refreshable_values_unit_id` ON `refreshable_values` (`unit_id`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_refreshing_jobs_unit_group_id` ON `refreshing_jobs` (`unit_group_id`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_refreshing_jobs_data_source_id` ON `refreshing_jobs` (`data_source_id`)');
        await database.execute(
            'CREATE INDEX `index_job_data_sources_job_id` ON `job_data_sources` (`job_id`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UnitGroupDaoDb get unitGroupDao {
    return _unitGroupDaoInstance ??= _$UnitGroupDaoDb(database, changeListener);
  }

  @override
  UnitDaoDb get unitDao {
    return _unitDaoInstance ??= _$UnitDaoDb(database, changeListener);
  }

  @override
  RefreshableValueDaoDb get refreshableValueDao {
    return _refreshableValueDaoInstance ??=
        _$RefreshableValueDaoDb(database, changeListener);
  }

  @override
  RefreshingJobDaoDb get refreshingJobDao {
    return _refreshingJobDaoInstance ??=
        _$RefreshingJobDaoDb(database, changeListener);
  }

  @override
  JobDataSourceDaoDb get jobDataSourceDao {
    return _jobDataSourceDaoInstance ??=
        _$JobDataSourceDaoDb(database, changeListener);
  }
}

class _$UnitGroupDaoDb extends UnitGroupDaoDb {
  _$UnitGroupDaoDb(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _unitGroupEntityInsertionAdapter = InsertionAdapter(
            database,
            'unit_groups',
            (UnitGroupEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'icon_name': item.iconName,
                  'conversion_type': item.conversionType,
                  'refreshable': item.refreshable
                }),
        _unitGroupEntityUpdateAdapter = UpdateAdapter(
            database,
            'unit_groups',
            ['id'],
            (UnitGroupEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'icon_name': item.iconName,
                  'conversion_type': item.conversionType,
                  'refreshable': item.refreshable
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UnitGroupEntity> _unitGroupEntityInsertionAdapter;

  final UpdateAdapter<UnitGroupEntity> _unitGroupEntityUpdateAdapter;

  @override
  Future<List<UnitGroupEntity>> getAll() async {
    return _queryAdapter.queryList('select * from unit_groups',
        mapper: (Map<String, Object?> row) => UnitGroupEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            iconName: row['icon_name'] as String?,
            conversionType: row['conversion_type'] as int?,
            refreshable: row['refreshable'] as int?));
  }

  @override
  Future<List<UnitGroupEntity>> getBySearchString(String searchString) async {
    return _queryAdapter.queryList(
        'select * from unit_groups where name like ?1',
        mapper: (Map<String, Object?> row) => UnitGroupEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            iconName: row['icon_name'] as String?,
            conversionType: row['conversion_type'] as int?,
            refreshable: row['refreshable'] as int?),
        arguments: [searchString]);
  }

  @override
  Future<List<UnitGroupEntity>> getRefreshableGroups() async {
    return _queryAdapter.queryList(
        'select * from unit_groups where refreshable is not null',
        mapper: (Map<String, Object?> row) => UnitGroupEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            iconName: row['icon_name'] as String?,
            conversionType: row['conversion_type'] as int?,
            refreshable: row['refreshable'] as int?));
  }

  @override
  Future<UnitGroupEntity?> get(int id) async {
    return _queryAdapter.query(
        'select * from unit_groups where id = ?1 limit 1',
        mapper: (Map<String, Object?> row) => UnitGroupEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            iconName: row['icon_name'] as String?,
            conversionType: row['conversion_type'] as int?,
            refreshable: row['refreshable'] as int?),
        arguments: [id]);
  }

  @override
  Future<UnitGroupEntity?> getByName(String name) async {
    return _queryAdapter.query(
        'select * from unit_groups where name = ?1 limit 1',
        mapper: (Map<String, Object?> row) => UnitGroupEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            iconName: row['icon_name'] as String?,
            conversionType: row['conversion_type'] as int?,
            refreshable: row['refreshable'] as int?),
        arguments: [name]);
  }

  @override
  Future<void> remove(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    await _queryAdapter.queryNoReturn(
        'delete from unit_groups where id in (' + _sqliteVariablesForIds + ')',
        arguments: [...ids]);
  }

  @override
  Future<int> insert(UnitGroupEntity unitGroupEntity) {
    return _unitGroupEntityInsertionAdapter.insertAndReturnId(
        unitGroupEntity, OnConflictStrategy.fail);
  }

  @override
  Future<int> update(UnitGroupEntity unitGroupEntity) {
    return _unitGroupEntityUpdateAdapter.updateAndReturnChangedRows(
        unitGroupEntity, OnConflictStrategy.abort);
  }
}

class _$UnitDaoDb extends UnitDaoDb {
  _$UnitDaoDb(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _unitEntityInsertionAdapter = InsertionAdapter(
            database,
            'units',
            (UnitEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'code': item.code,
                  'symbol': item.symbol,
                  'coefficient': item.coefficient,
                  'unit_group_id': item.unitGroupId
                }),
        _unitEntityUpdateAdapter = UpdateAdapter(
            database,
            'units',
            ['id'],
            (UnitEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'code': item.code,
                  'symbol': item.symbol,
                  'coefficient': item.coefficient,
                  'unit_group_id': item.unitGroupId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UnitEntity> _unitEntityInsertionAdapter;

  final UpdateAdapter<UnitEntity> _unitEntityUpdateAdapter;

  @override
  Future<List<UnitEntity>> getAll(int unitGroupId) async {
    return _queryAdapter.queryList(
        'select * from units where unit_group_id = ?1',
        mapper: (Map<String, Object?> row) => UnitEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            code: row['code'] as String,
            symbol: row['symbol'] as String?,
            coefficient: row['coefficient'] as double?,
            unitGroupId: row['unit_group_id'] as int),
        arguments: [unitGroupId]);
  }

  @override
  Future<List<UnitEntity>> getBySearchString(
    int unitGroupId,
    String searchString,
  ) async {
    return _queryAdapter.queryList(
        'select * from units where unit_group_id = ?1 and name like ?2',
        mapper: (Map<String, Object?> row) => UnitEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            code: row['code'] as String,
            symbol: row['symbol'] as String?,
            coefficient: row['coefficient'] as double?,
            unitGroupId: row['unit_group_id'] as int),
        arguments: [unitGroupId, searchString]);
  }

  @override
  Future<UnitEntity?> getByCode(
    int unitGroupId,
    String code,
  ) async {
    return _queryAdapter.query(
        'select * from units where unit_group_id = ?1 and code = ?2',
        mapper: (Map<String, Object?> row) => UnitEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            code: row['code'] as String,
            symbol: row['symbol'] as String?,
            coefficient: row['coefficient'] as double?,
            unitGroupId: row['unit_group_id'] as int),
        arguments: [unitGroupId, code]);
  }

  @override
  Future<UnitEntity?> getBaseUnit(int unitGroupId) async {
    return _queryAdapter.query(
        'select * from units where unit_group_id = ?1 and cast(coefficient as int) = 1 limit 1',
        mapper: (Map<String, Object?> row) => UnitEntity(id: row['id'] as int?, name: row['name'] as String, code: row['code'] as String, symbol: row['symbol'] as String?, coefficient: row['coefficient'] as double?, unitGroupId: row['unit_group_id'] as int),
        arguments: [unitGroupId]);
  }

  @override
  Future<UnitEntity?> getUnit(int id) async {
    return _queryAdapter.query('select * from units where id = ?1 limit 1',
        mapper: (Map<String, Object?> row) => UnitEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            code: row['code'] as String,
            symbol: row['symbol'] as String?,
            coefficient: row['coefficient'] as double?,
            unitGroupId: row['unit_group_id'] as int),
        arguments: [id]);
  }

  @override
  Future<List<UnitEntity>> getUnitsByIds(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select * from units where id in (' + _sqliteVariablesForIds + ')',
        mapper: (Map<String, Object?> row) => UnitEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            code: row['code'] as String,
            symbol: row['symbol'] as String?,
            coefficient: row['coefficient'] as double?,
            unitGroupId: row['unit_group_id'] as int),
        arguments: [...ids]);
  }

  @override
  Future<List<UnitEntity>> getUnitsByCodes(
    int unitGroupId,
    List<String> codes,
  ) async {
    const offset = 2;
    final _sqliteVariablesForCodes =
        Iterable<String>.generate(codes.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select * from units where unit_group_id = ?1 and code in (' +
            _sqliteVariablesForCodes +
            ')',
        mapper: (Map<String, Object?> row) => UnitEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            code: row['code'] as String,
            symbol: row['symbol'] as String?,
            coefficient: row['coefficient'] as double?,
            unitGroupId: row['unit_group_id'] as int),
        arguments: [unitGroupId, ...codes]);
  }

  @override
  Future<void> remove(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    await _queryAdapter.queryNoReturn(
        'delete from units where id in (' + _sqliteVariablesForIds + ')',
        arguments: [...ids]);
  }

  @override
  Future<int> insert(UnitEntity unit) {
    return _unitEntityInsertionAdapter.insertAndReturnId(
        unit, OnConflictStrategy.fail);
  }

  @override
  Future<int> update(UnitEntity unit) {
    return _unitEntityUpdateAdapter.updateAndReturnChangedRows(
        unit, OnConflictStrategy.abort);
  }
}

class _$RefreshableValueDaoDb extends RefreshableValueDaoDb {
  _$RefreshableValueDaoDb(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<RefreshableValueEntity?> get(int unitId) async {
    return _queryAdapter.query(
        'select * from refreshable_values where unit_id = ?1 limit 1',
        mapper: (Map<String, Object?> row) => RefreshableValueEntity(
            id: row['id'] as int?,
            unitId: row['unit_id'] as int,
            value: row['value'] as String?),
        arguments: [unitId]);
  }

  @override
  Future<List<RefreshableValueEntity>> getList(List<int> unitIds) async {
    const offset = 1;
    final _sqliteVariablesForUnitIds =
        Iterable<String>.generate(unitIds.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select * from refreshable_values where unit_id in (' +
            _sqliteVariablesForUnitIds +
            ')',
        mapper: (Map<String, Object?> row) => RefreshableValueEntity(
            id: row['id'] as int?,
            unitId: row['unit_id'] as int,
            value: row['value'] as String?),
        arguments: [...unitIds]);
  }
}

class _$RefreshingJobDaoDb extends RefreshingJobDaoDb {
  _$RefreshingJobDaoDb(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _refreshingJobEntityUpdateAdapter = UpdateAdapter(
            database,
            'refreshing_jobs',
            ['id'],
            (RefreshingJobEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'unit_group_id': item.unitGroupId,
                  'refreshable_data_part': item.refreshableDataPartNum,
                  'last_refresh_time': item.lastRefreshTime,
                  'data_source_id': item.selectedDataSourceId,
                  'cron_name': item.cronName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final UpdateAdapter<RefreshingJobEntity> _refreshingJobEntityUpdateAdapter;

  @override
  Future<List<RefreshingJobEntity>> getAll() async {
    return _queryAdapter.queryList('select * from refreshing_jobs',
        mapper: (Map<String, Object?> row) => RefreshingJobEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            unitGroupId: row['unit_group_id'] as int,
            refreshableDataPartNum: row['refreshable_data_part'] as int,
            lastRefreshTime: row['last_refresh_time'] as String?,
            selectedDataSourceId: row['data_source_id'] as int?,
            cronName: row['cron_name'] as String?));
  }

  @override
  Future<RefreshingJobEntity?> get(int id) async {
    return _queryAdapter.query('select * from refreshing_jobs where id = ?1',
        mapper: (Map<String, Object?> row) => RefreshingJobEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            unitGroupId: row['unit_group_id'] as int,
            refreshableDataPartNum: row['refreshable_data_part'] as int,
            lastRefreshTime: row['last_refresh_time'] as String?,
            selectedDataSourceId: row['data_source_id'] as int?,
            cronName: row['cron_name'] as String?),
        arguments: [id]);
  }

  @override
  Future<RefreshingJobEntity?> getByGroupId(int unitGroupId) async {
    return _queryAdapter.query(
        'select * from refreshing_jobs where unit_group_id = ?1',
        mapper: (Map<String, Object?> row) => RefreshingJobEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            unitGroupId: row['unit_group_id'] as int,
            refreshableDataPartNum: row['refreshable_data_part'] as int,
            lastRefreshTime: row['last_refresh_time'] as String?,
            selectedDataSourceId: row['data_source_id'] as int?,
            cronName: row['cron_name'] as String?),
        arguments: [unitGroupId]);
  }

  @override
  Future<void> update(RefreshingJobEntity entity) async {
    await _refreshingJobEntityUpdateAdapter.update(
        entity, OnConflictStrategy.fail);
  }
}

class _$JobDataSourceDaoDb extends JobDataSourceDaoDb {
  _$JobDataSourceDaoDb(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<JobDataSourceEntity?> get(int id) async {
    return _queryAdapter.query('select * from job_data_sources where id = ?1',
        mapper: (Map<String, Object?> row) => JobDataSourceEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            url: row['url'] as String,
            responseTransformerClassName:
                row['response_transformer_name'] as String,
            jobId: row['job_id'] as int),
        arguments: [id]);
  }

  @override
  Future<List<JobDataSourceEntity>> getByIds(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select * from job_data_sources where id in (' +
            _sqliteVariablesForIds +
            ')',
        mapper: (Map<String, Object?> row) => JobDataSourceEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            url: row['url'] as String,
            responseTransformerClassName:
                row['response_transformer_name'] as String,
            jobId: row['job_id'] as int),
        arguments: [...ids]);
  }

  @override
  Future<List<JobDataSourceEntity>> getByJobId(int jobId) async {
    return _queryAdapter.queryList(
        'select * from job_data_sources where job_id = ?1',
        mapper: (Map<String, Object?> row) => JobDataSourceEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            url: row['url'] as String,
            responseTransformerClassName:
                row['response_transformer_name'] as String,
            jobId: row['job_id'] as int),
        arguments: [jobId]);
  }
}
