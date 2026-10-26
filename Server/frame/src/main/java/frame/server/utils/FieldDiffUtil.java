package frame.server.utils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import frame.server.dao.OperationSnapshotDao;
import frame.server.domain.OperationSnapshot;

@Component
public class FieldDiffUtil {

    @Autowired
    private OperationSnapshotDao snapshotDao;

    public void compareAndSave(String operationId, String entityType, String entityId,
                               Object oldObj, Object newObj) {
        if (oldObj == null || newObj == null || oldObj.getClass() != newObj.getClass()) {
            return;
        }
        List<OperationSnapshot> snapshots = new ArrayList<>();
        Field[] fields = oldObj.getClass().getDeclaredFields();
        for (Field field : fields) {
            field.setAccessible(true);
            try {
                Object oldVal = field.get(oldObj);
                Object newVal = field.get(newObj);
                if (!Objects.equals(oldVal, newVal)) {
                    snapshots.add(new OperationSnapshot(
                            RandomUtil.genarateId(),
                            operationId != null ? operationId : "",
                            entityType, entityId,
                            field.getName(),
                            oldVal != null ? oldVal.toString() : null,
                            newVal != null ? newVal.toString() : null));
                }
            } catch (IllegalAccessException ignored) {
            }
        }
        if (!snapshots.isEmpty()) {
            snapshotDao.batchInsert(snapshots);
        }
    }
}