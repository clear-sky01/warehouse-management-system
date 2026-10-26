package frame.server.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OperationSnapshot {
    private String id;
    private String operationId;
    private String entityType;
    private String entityId;
    private String fieldName;
    private String oldValue;
    private String newValue;
}