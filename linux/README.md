# DEV-4: Shared Team Directory

## What it does
Creates a shared directory (`/srv/project`) where the `dev` team can read and write, the `ops` team can only read, and everyone else has no access.

## How to run
Run on a test Linux machine (e.g. the `lab` VM), never on your own computer:

```
sudo bash linux/setup_team.sh
```

The script is idempotent: safe to run more than once. Existing groups and users are skipped, and all permissions are re-applied.

## Permissions and why

| Setting | Why |
|---|---|
| Owner `root` | A shared resource belongs to the team, not to one person. If a user owned it, they could change permissions alone, and if they left, the directory would be orphaned. |
| Group `dev` | Access is granted through group membership, so adding or removing a developer is one `usermod` command. |
| `2770` | `7` owner, `7` dev group (read, write, enter), `0` others. On a directory, `x` is required to enter it, so `6` would lock the group out. |
| setgid (the `2`) | New files inherit the `dev` group instead of the creator's private group, so every developer can edit them. |
| ACL `g:ops:rx` | A directory has only one group. ACL adds `ops` as a second group: `r` to list, `x` to enter, no `w` so they cannot create or delete. |
| Default ACL `d:g:ops:rx` | The first ACL applies only to the directory itself. The default ACL makes every new file readable by `ops` too. |
| Others `0` | Least privilege: users outside both teams see nothing. |
| No `777` | Nobody gets more access than they need. |

## Decision: no sticky bit
The original requirement asked that users cannot delete each other's files (sticky bit).

**Problem:** With the sticky bit on a group-writable directory, Ubuntu's kernel protection `fs.protected_regular=2` blocks `dev` members from appending to each other's files (`>>`, `tee -a`, `nano`). Collaboration breaks.

**Options:**
1. Keep the sticky bit: deletion protection, broken collaboration.
2. Remove the sticky bit: full collaboration, `dev` members can delete each other's files.
3. Disable `protected_regular`: rejected, it weakens security for the whole system to fix one directory.

**Chosen:** Option 2. `ops` and others still cannot delete anything, because they have no `w` on the directory.

**Mitigation:** Project files must be tracked in Git, so an accidental deletion can be restored.

## Proof (tested on a fresh `clean-state` restore)
| Test | Expected | Result |
|---|---|---|
| alice creates a file, group is `dev` | allowed | ✅ |
| bob appends to alice's file | allowed | ✅ |
| carol reads a file | allowed | ✅ |
| carol creates a file | Permission denied | ✅ |
| ubuntu (others) lists the directory | Permission denied | ✅ |
| Second run of the script | no errors, "already exists" | ✅ |
