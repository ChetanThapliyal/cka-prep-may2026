# Storage (10%)

This section focuses on managing persistent data in Kubernetes, making up 10% of the CKA exam.

## Topics (2026 Syllabus)

- **Implement Storage Classes and Dynamic Volume Provisioning**
  - Creating and configuring StorageClass resources.
  - Understanding how dynamic provisioning eliminates manual PV creation.
  - Setting a default StorageClass.
- **Configure Volume Types, Access Modes and Reclaim Policies**
  - **Volume Types:** emptyDir, hostPath, NFS, CSI-backed volumes.
  - **Volume Modes:** `Filesystem` vs. `Block`.
  - **Access Modes:** `ReadWriteOnce` (RWO), `ReadOnlyMany` (ROX), `ReadWriteMany` (RWX), `ReadWriteOncePod` (RWOP).
  - **Reclaim Policies:** `Retain`, `Delete`.
- **Manage Persistent Volumes and Persistent Volume Claims**
  - Creating Persistent Volumes (PV) and Persistent Volume Claims (PVC).
  - Binding PVCs to PVs based on capacity, access modes, and StorageClass.
  - Expanding PVCs (when the StorageClass allows volume expansion).
  - Mounting PVCs into Pods as volumes.
