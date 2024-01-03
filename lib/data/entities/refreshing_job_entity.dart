import 'package:convertouch/data/entities/cron_entity.dart';
import 'package:convertouch/data/entities/unit_group_entity.dart';
import 'package:floor/floor.dart';

const String refreshingJobsTableName = 'refreshing_jobs';

@Entity(
  tableName: refreshingJobsTableName,
  indices: [
    Index(value: ['unit_group_id'], unique: true),
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['unit_group_id'],
      parentColumns: ['id'],
      entity: UnitGroupEntity,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['cron_id'],
      parentColumns: ['id'],
      entity: CronEntity,
      onDelete: ForeignKeyAction.setNull,
    ),
  ],
)
class RefreshingJobEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  @ColumnInfo(name: 'unit_group_id')
  final int unitGroupId;
  @ColumnInfo(name: 'refreshable_data_part')
  final int refreshableDataPartNum;
  @ColumnInfo(name: 'last_refresh_time')
  final String? lastRefreshTime;
  @ColumnInfo(name: 'cron_id')
  final int? cronId;

  const RefreshingJobEntity({
    this.id,
    required this.name,
    required this.unitGroupId,
    required this.refreshableDataPartNum,
    required this.lastRefreshTime,
    required this.cronId,
  });

  RefreshingJobEntity.coalesce(
    RefreshingJobEntity entity, {
    bool replaceWithNull = false,
    int? dataRefreshingStatusNum,
    String? lastRefreshTime,
    int? cronId,
  }) : this(
          id: entity.id,
          name: entity.name,
          unitGroupId: entity.unitGroupId,
          refreshableDataPartNum: entity.refreshableDataPartNum,
          lastRefreshTime: _coalesce(
            what: entity.lastRefreshTime,
            patchWith: lastRefreshTime,
            replaceWithNull: replaceWithNull,
          ),
          cronId: _coalesce(
            what: entity.cronId,
            patchWith: cronId,
            replaceWithNull: replaceWithNull,
          ),
        );

  static dynamic _coalesce({
    required dynamic what,
    required dynamic patchWith,
    required bool replaceWithNull,
  }) {
    if (replaceWithNull) {
      return patchWith;
    } else {
      return patchWith ?? what;
    }
  }
}
