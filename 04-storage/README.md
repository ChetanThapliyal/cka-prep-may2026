# Storage (10%)

This section focuses on managing persistent data in Kubernetes, making up 10% of the CKA exam.

## Extensive Topic List

- **Understand Storage Classes and Persistent Volumes (PV)**
  - Creating Persistent Volumes.
  - Understanding the role of StorageClasses in dynamic provisioning.
- **Understand Volume Mode, Access Modes, and Reclaim Policies for Volumes**
  - **Volume Modes:** `Filesystem` vs. `Block`.
  - **Access Modes:** `ReadWriteOnce` (RWO), `ReadOnlyMany` (ROX), `ReadWriteMany` (RWX), `ReadWriteOncePod` (RWOP).
  - **Reclaim Policies:** `Retain`, `Delete`, `Recycle`.
- **Understand Persistent Volume Claims (PVC) Primitive**
  - Creating Persistent Volume Claims.
  - Binding PVCs to PVs based on capacity and access modes.
- **Know How to Configure Applications with Persistent Storage**
  - Mounting PVCs into Pods as volumes.
  - Using emptyDir and hostPath volumes.
