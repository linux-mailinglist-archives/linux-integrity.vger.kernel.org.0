Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878F119FC31
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2020 19:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgDFR7Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Apr 2020 13:59:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51616 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgDFR7Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Apr 2020 13:59:25 -0400
Received: from dede-linux.corp.microsoft.com (unknown [131.107.147.242])
        by linux.microsoft.com (Postfix) with ESMTPSA id C01972072953;
        Mon,  6 Apr 2020 10:59:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C01972072953
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586195962;
        bh=Uqge906LoCmlU/rMxOqKmqgghLHgITLOvo0T/MF9lHs=;
        h=From:To:Cc:Subject:Date:From;
        b=nk6M2lWDM9O4F/prjRLzirkG7d0w91Fmw87rN3nsvSZsB8QtVDSQU9e7qmZQaIp6p
         1UwKEsuGLCA1w6STgqzag1FduC8TJg8CF3EQ8oboEKG4LwNm/yahsFqF6khyBuY2wl
         rgb42rhmVwyQzUEvyZxenYw3LSmKX3fuNb0OQTVc=
From:   deven.desai@linux.microsoft.com
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.org,
        linux-block@vger.kernel.org
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        mdsakib@microsoft.com, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com
Subject: [PATCH 00/11] Integrity Policy Enforcement LSM (IPE)
Date:   Mon,  6 Apr 2020 10:59:07 -0700
Message-Id: <20200406175919.1023205-1-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Deven Bowers <deven.desai@linux.microsoft.com>

Overview:
------------------------------------
IPE is a Linux Security Module, which allows for a configurable
policy to enforce integrity requirements on the whole system. It
attempts to solve the issue of Code Integrity: that any code being
executed (or files being read), are identical to the version that
was built by a trusted source.

The type of system for which IPE is designed for use is an embedded device
with a specific purpose (e.g. network firewall device in a data center),
where all software and configuration is built and provisioned by the owner.

Specifically, a system which leverages IPE is not intended for general
purpose computing and does not utilize any software or configuration
built by a third party. An ideal system to leverage IPE has both mutable
and immutable components, however, all binary executable code is immutable.

The scope of IPE is constrained to the OS. It is assumed that platform
firmware verifies the the kernel and optionally the root filesystem (e.g.
via U-Boot verified boot). IPE then utilizes LSM hooks to enforce a
flexible, kernel-resident integrity verification policy.

IPE differs from other LSMs which provide integrity checking (for instance,
IMA), as it has no dependency on the filesystem metadata itself. The
attributes that IPE checks are deterministic properties that exist solely
in the kernel. Additionally, IPE provides no additional mechanisms of
verifying these files (e.g. IMA Signatures) - all of the attributes of
verifying files are existing features within the kernel, such as dm-verity
or fsverity.

IPE provides a policy that allows owners of the system to easily specify
integrity requirements and uses dm-verity signatures to simplify the
authentication of allowed objects like authorized code and data.

IPE supports two modes, permissive (similar to SELinux's permissive mode)
and enforce. Permissive mode performs the same checks, and logs policy
violations as enforce mode, but will not enforce the policy. This allows
users to test policies before enforcing them.

The default mode is enforce, and can be changed via the kernel commandline
parameter `ipe.enforce=(0|1)`, or the sysctl `ipe.enforce=(0|1)`. The
ability to switch modes can be compiled out of the LSM via setting the
config CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH to N.

IPE additionally supports success auditing. When enabled, all events
that pass IPE policy and are not blocked will emit an audit event. This
is disabled by default, and can be enabled via the kernel commandline
`ipe.success_audit=(0|1)` or the sysctl `ipe.success_audit=(0|1)`.

Policies can be staged at runtime through securityfs and activated through
sysfs. Please see the Deploying Policies section of this cover letter for
more information.

The IPE LSM is compiled under CONFIG_SECURITY_IPE.

Policy:
------------------------------------

IPE policy is designed to be both forward compatible and backwards
compatible. There is one required line, at the top of the policy,
indicating the policy name, and the policy version, for instance:

  policy_name="Ex Policy" policy_version=0.0.0

The policy version indicates the current version of the policy (NOT the
policy syntax version). This is used to prevent roll-back of policy to
potentially insecure previous versions of the policy.

The next portion of IPE policy, are rules. Rules are formed by key=value
pairs, known as properties. IPE rules require two properties: "action",
which determines what IPE does when it encounters a match against the
policy, and "op", which determines when that rule should be evaluated.
Thus, a minimal rule is:

  op=EXECUTE action=ALLOW

This example will allow any execution. Additional properties are used to
restrict attributes about the files being evaluated. These properties are
intended to be deterministic attributes that are resident in the kernel.
Available properties for IPE described in the properties section of this
cover-letter, the repository available in Appendix A, and the kernel
documentation page.

Order does not matter for the rule's properties - they can be listed in
any order, however it is encouraged to have the "op" property be first,
and the "action" property be last, for readability.

Additionally, rules are evaluated top-to-bottom. As a result, any
revocation rules, or denies should be placed early in the file to ensure
that these rules are evaluated before a rule with "action=ALLOW" is hit.

IPE policy is designed to be forward compatible and backwards compatible,
thus any failure to parse a rule will result in the line being ignored,
and a warning being emitted. If backwards compatibility is not required,
the kernel commandline parameter and sysctl, ipe.strict_parse can be
enabled, which will cause these warnings to be fatal.

For more information about the policy syntax, please see Appendix A or
the kernel documentation page.

Early Usermode Protection:
--------------------------

IPE can be provided with a policy at startup to load and enforce.
This is intended to be a minimal policy to get the system to a state
where userland is setup and ready to receive commands, at which
point a policy can be deployed via securityfs. This "boot policy" can be
specified via the config, SECURITY_IPE_BOOT_POLICY, which accepts a path
to a plain-text version of the IPE policy to apply. This policy will be
compiled into the kernel. If not specified, IPE will be disabled until a
policy is deployed and activated through the method above.

Policy Examples:
------------------------------------

Allow all:

  policy_name="Allow All" policy_version=0.0.0
  DEFAULT action=ALLOW

Allow only initial superblock:

  policy_name="Allow All Initial SB" policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE boot_verified=TRUE action=ALLOW

Allow any signed dm-verity volume and the initial superblock:

  policy_name="AllowSignedAndInitial" policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE boot_verified=TRUE action=ALLOW
  op=EXECUTE dmverity_signature=TRUE action=ALLOW

Prohibit execution from a specific dm-verity volume:

  policy_name="AllowSignedAndInitial" policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE dmverity_roothash=401fcec5944823ae12f62726e8184407a5fa9599783f030dec146938 action=DENY
  op=EXECUTE boot_verified=TRUE action=ALLOW
  op=EXECUTE dmverity_signature=TRUE action=ALLOW

Allow only a specific dm-verity volume:

  policy_name="AllowSignedAndInitial" policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE dmverity_roothash=401fcec5944823ae12f62726e8184407a5fa9599783f030dec146938 action=ALLOW

Deploying Policies:
-------------------

Deploying policies is simple. First sign a plain text policy, with a
certificate that is present in the SYSTEM_TRUSTED_KEYRING of your test
machine. Through openssl, the signing can be done via:

  openssl smime -sign -in "$MY_POLICY" -signer "$MY_CERTIFICATE" \
    -inkey "$MY_PRIVATE_KEY" -binary -outform der -noattr -nodetach \
    -out "$MY_POLICY.p7s"

Then, simply cat the file into the IPE's "new_policy" securityfs node:

  cat "$MY_POLICY.p7s" > /sys/kernel/security/ipe/new_policy

The policy should now be present under the policies/ subdirectory, under
its "policy_name" attribute.

The policy is now present in the kernel and can be marked as active,
via the sysctl "ipe.active_policy":

  sysctl ipe.active_policy="$MY_POLICY_NAME"

This will now mark the policy as active and the system will be enforcing
$MY_POLICY_NAME. At any point the policy can be updated on the provision
that the policy version to be deployed is greater than or equal to the
running version (to prevent roll-back attacks). This update can be done
by redirecting the file into the policy's "raw" node, under the policies
subdirectory:

  cat "$MY_UPDATED_POLICY.p7s" > \
    "/sys/kernel/security/ipe/policies/$MY_POLICY_NAME/raw"

Additionally, policies can be deleted via the "del_policy" securityfs
node. Simply write the name of the policy to be deleted to that node:

  echo -n "$MY_POLICY_NAME" > /sys/kernel/security/ipe/del_policy

There are two requirements to delete policies:

1. The policy being deleted must not be the active policy.
2. The policy being deleted must not be the boot policy.

It's important to know above that the "echo" command will add a newline
to the end of the input, and this will be considered as part of the
filename. You can remove the newline via the -n parameter.

NOTE: If a MAC LSM is enabled, all of these commands will require
CAP_MAC_ADMIN.

Properties:
------------------------------------

This initial patchset introducing IPE adds three properties:
'boot_verified', 'dmverity_signature' and 'dmverity_roothash'.

boot_verified (CONFIG_IPE_BOOT_PROP):
  This property can be utilized for authorization of the first
  super-block that is mounted on the system, where IPE attempts
  to evaluate a file. Typically this is used for systems with
  an initramfs or other initial disk, where this is unmounted before
  the system becomes available, and is not covered by any other property.
  The format of this property is:

    boot_verified=(TRUE|FALSE)

  WARNING: This property will trust any disk where the first IPE
  evaluation occurs. If you do not have a startup disk that is
  unpacked and unmounted (like initramfs), then it will automatically
  trust the root filesystem and potentially overauthorize the entire
  disk.

dmverity_roothash (CONFIG_IPE_DM_VERITY_ROOTHASH):
  This property can be utilized for authorization or revocation of
  specific dmverity volumes, identified via root hash. It has a
  dependency on the DM_VERITY module. The format of this property is:

    dmverity_roothash=<HashHexDigest>

dmverity_signature (CONFIG_IPE_DM_VERITY_SIGNATURE):
  This property can be utilized for authorization of all dm-verity
  volumes that have a signed roothash that chains to the system
  trusted keyring. It has a dependency on the
  DM_VERITY_VERIFY_ROOTHASH_SIG config. The format of this property is:

    dmverity_signature=(TRUE|FALSE)

Testing:
------------------------------------

A test suite is available (Appendix B) for ease of use. For manual
instructions:

Enable IPE through the following Kconfigs:

  CONFIG_SECURITY_IPE=y
  CONFIG_SECURITY_IPE_BOOT_POLICY="../AllowAllInitialSB.pol"
  CONFIG_SECURITY_IPE_AUDIT_SWITCH=y
  CONFIG_IPE_BOOT_PROP=y
  CONFIG_IPE_DM_VERITY_ROOTHASH=y
  CONFIG_IPE_DM_VERITY_SIGNATURE=y
  CONFIG_DM_VERITY=y
  CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
  CONFIG_SYSTEM_TRUSTED_KEYRING=y
  CONFIG_SYSTEM_TRUSTED_KEYS="/path/to/my/cert/list.pem"

Start a test system, that boots directly from the filesystem, without
an initrd. I recommend testing in permissive mode until all tests
pass, then switch to enforce to ensure behavior remains identical.

boot_verified:

  If booted correctly, the filesystem mounted on / should be marked as
  boot_verified. Verify by turning on success auditing (sysctl
  ipe.success_audit=1), and run a binary. In the audit output,
  `prop_boot_verified` should be `TRUE`.

  To test denials, mount a temporary filesystem (mount -t tmpfs -o
  size=4M tmp tmp), and copy a binary (e.g. ls) to this new
  filesystem. Disable success auditing and attempt to run the file.
  The file should have an audit event, but be allowed to execute in
  permissive mode, and prop_boot_verified should be FALSE.

dmverity_roothash:

  First, you must create a dm-verity volume. This can be done through
  squashfs-tools and veritysetup (provided by cryptsetup).

  Creating a squashfs volume:

    mksquashfs /path/to/directory/with/executable /path/to/output.squashfs

  Format the volume for use with dm-verity & save the root hash:

    output_rh=$(veritysetup format output.squashfs output.hashtree | \
      tee verity_out.txt | awk "/Root hash/" | \
      sed -E "s/Root hash:\s+//g")

    echo -n $output_rh > output.roothash

  Create a two policies, filling in the appropriate fields below:

    Policy 1:

      policy_name="roothash-denial" policy_version=0.0.0
      DEFAULT action=ALLOW
      op=EXECUTE dmverity_roothash=$output_rh action=DENY

    Policy 2:

      policy_name="roothash-allow" policy_version=0.0.0
      DEFAULT action=ALLOW
      DEFAULT op=EXECUTE action=DENY

      op=EXECUTE boot_verified=TRUE action=ALLOW
      op=EXECUTE dmverity_roothash=$output_rh action=ALLOW

  Deploy each policy, then mark the first, "roothash-denial" as active,
  per the "Deploying Policies" section of this cover letter. Mount the
  dm-verity volume:

    veritysetup open output.squashfs output.hashtree unverified \
      `cat output.roothash`

    mount /dev/mapper/unverified /my/mount/point

  Attempt to execute a binary in the mount point, and it should emit an
  audit event for a match against the rule:
  
    op=EXECUTE dmverity_roothash=$output_rh action=DENY

  To test the second policy, perform the same steps, but this time, enable
  success auditing before running the executable. The success audit event
  should be a match against this rule:

    op=EXECUTE dmverity_roothash=$output_rh action=ALLOW

dmverity_signature:

  Follow the setup steps for dmverity_roothash. Sign the roothash via:

    openssl smime -sign -in "output.roothash" -signer "$MY_CERTIFICATE" \
      -inkey "$MY_PRIVATE_KEY" -binary -outform der -noattr \
      -out "output.p7s"

    Create a policy:

      policy_name="verified" policy_version=0.0.0
      DEFAULT action=DENY

      op=EXECUTE boot_verified=TRUE action=ALLOW
      op=EXECUTE dmverity_verified=TRUE action=ALLOW

  Deploy the policy, and mark as active, per the "Deploying Policies"
  section of this cover letter. Mount the dm-verity volume with
  verification:

    veritysetup open output.squashfs output.hashtree unverified \
      `cat output.roothash` --root-hash-signature=output.p7s

    mount /dev/mapper/unverified /my/mount/point

  NOTE: The --root-hash-signature option was introduced in veritysetup
  2.3.0

  Turn on success auditing and attempt to execute a binary in the mount
  point, and it should emit an audit event for a match against the rule:

    op=EXECUTE dmverity_verified=TRUE action=ALLOW

  To test denials, mount the dm-verity volume the same way as the
  "dmverity_roothash" section, and attempt to execute a binary. Failure
  should occur.

Documentation:
------------------------------------

Full documentation is available on github in IPE's master repository
(Appendix A). This is intended to be an exhaustive source of documentation
around IPE.

Additionally, there is higher level documentation in the admin-guide.

Known Gaps:
------------------------------------

IPE has two known gaps:

1. IPE cannot verify the integrity of anonymous executable memory, such as
  the trampolines created by gcc closures and libffi, or JIT'd code.
  Unfortunately, as this is dynamically generated code, there is no way for
  IPE to detect that this code has not been tampered with in transition
  from where it was built, to where it is running. As a result, IPE is
  incapable of tackling this problem for dynamically generated code.
  However, there is a patch series being prepared that addresses this
  problem for libffi and gcc closures by implemeting a safer kernel
  trampoline API.

2. IPE cannot verify the integrity of interpreted languages' programs when
  these scripts invoked via `<interpreter> <file>`. This is because the way
  interpreters execute these files, the scripts themselves are not
  evaluated as executable code through one of IPE's hooks. Interpreters
  can be enlightened to the usage of IPE by trying to mmap a file into
  executable memory (+X), after opening the file and responding to the
  error code appropriately. This also applies to included files, or high
  value files, such as configuration files of critical system components.
  This specific gap is planned on being addressed within IPE. For more
  information on how we plan to address this gap, please see the Future
  Development section, below.

Future Development:
------------------------------------

Support for filtering signatures by specific certificates. In this case,
our "dmverity_signature" (or a separate property) can be set to a
specific certificate declared in IPE's policy, allowing for more
controlled use-cases determine by a user's PKI structure.

Support for integrity verification for general file reads. This addresses
the script interpreter issue indicated in the "Known Gaps" section, as
these script files are typically opened with O_RDONLY. We are evaluating
whether to do this by comparing the original userland filepath passed into
the open syscall, thereby allowing existing callers to take advantage
without any code changes; the alternate design is to extend the new
openat2(2) syscall, with an new flag, tentatively called "O_VERIFY". While
the second option requires a code change for all the interpreters,
frameworks and languages that wish to leverage it, it is a wholly cleaner
implementation in the kernel.

Onboarding IPE's test suite to KernelCI. Currently we are developing a
test suite in the same vein as SELinux's test suite. Once development
of the test suite is complete, and provided IPE is accepted, we intend
to onboard this test suite onto KernelCI.

Hardened resistance against roll-back attacks. Currently there exists a
window of opportunity between user-mode setup and the user-policy being
deployed, where a prior user-policy can be loaded, that is potentially
insecure. However, with a kernel update, you can revise the boot policy's
version to be the same version as the latest policy, closing this window.
In the future, I would like to close this window of opportunity without
a kernel update, using some persistent storage mechanism.

Open Issues:
------------

For linux-audit/integrity folks:
1. Introduction of new audit definitions in the kernel integrity range - is
  this preferred, as opposed to reusing definitions with existing IMA
  definitions?

TODOs:
------

linux-audit changes to support the new audit events.


Appendix:
------------------------------------

A. IPE Github Repository: https://github.com/microsoft/ipe
   Hosted Documentation: https://microsoft.github.io/ipe
B. IPE Users' Guide: Documentation/admin-guide/LSM/ipe.rst
C. IPE Test Suite: *TBA* (under development)

Deven Bowers (11):
  scripts: add ipe tooling to generate boot policy
  security: add ipe lsm
  ipe: add property for trust of boot volume
  fs: add security blob and hooks for block_device
  dm-verity: move signature check after tree validation
  dm-verity: add bdev_setsecurity hook for dm-verity signature
  ipe: add property for signed dmverity volumes
  dm-verity: add bdev_setsecurity hook for root-hash
  ipe: add property for dmverity roothash
  documentation: Add IPE Documentation
  cleanup: uapi/linux/audit.h

 Documentation/admin-guide/LSM/index.rst       |   1 +
 Documentation/admin-guide/LSM/ipe.rst         | 487 ++++++++++
 .../admin-guide/kernel-parameters.txt         |  20 +
 MAINTAINERS                                   |   8 +
 drivers/md/dm-verity-target.c                 |  50 +-
 drivers/md/dm-verity-verify-sig.c             | 147 ++-
 drivers/md/dm-verity-verify-sig.h             |  20 +-
 drivers/md/dm-verity.h                        |   2 +-
 fs/block_dev.c                                |   8 +
 include/linux/device-mapper.h                 |   3 +
 include/linux/fs.h                            |   1 +
 include/linux/lsm_hook_defs.h                 |   5 +
 include/linux/lsm_hooks.h                     |  11 +
 include/linux/security.h                      |  22 +
 include/uapi/linux/audit.h                    |  36 +-
 scripts/Makefile                              |   1 +
 scripts/ipe/Makefile                          |   2 +
 scripts/ipe/polgen/.gitignore                 |   1 +
 scripts/ipe/polgen/Makefile                   |   7 +
 scripts/ipe/polgen/polgen.c                   | 136 +++
 security/Kconfig                              |  12 +-
 security/Makefile                             |   2 +
 security/ipe/.gitignore                       |   2 +
 security/ipe/Kconfig                          |  43 +
 security/ipe/Makefile                         |  34 +
 security/ipe/ipe-audit.c                      | 313 ++++++
 security/ipe/ipe-audit.h                      |  76 ++
 security/ipe/ipe-blobs.c                      |  90 ++
 security/ipe/ipe-blobs.h                      |  18 +
 security/ipe/ipe-engine.c                     | 352 +++++++
 security/ipe/ipe-engine.h                     |  61 ++
 security/ipe/ipe-hooks.c                      | 171 ++++
 security/ipe/ipe-hooks.h                      | 159 ++++
 security/ipe/ipe-parse.c                      | 898 ++++++++++++++++++
 security/ipe/ipe-parse.h                      |  35 +
 security/ipe/ipe-pin.c                        |  93 ++
 security/ipe/ipe-pin.h                        |  56 ++
 security/ipe/ipe-policy.c                     | 181 ++++
 security/ipe/ipe-policy.h                     | 116 +++
 security/ipe/ipe-prop-internal.h              |  43 +
 security/ipe/ipe-property.c                   | 112 +++
 security/ipe/ipe-property.h                   | 159 ++++
 security/ipe/ipe-secfs.c                      | 814 ++++++++++++++++
 security/ipe/ipe-secfs.h                      |  25 +
 security/ipe/ipe-sysfs.c                      | 203 ++++
 security/ipe/ipe-sysfs.h                      |  21 +
 security/ipe/ipe.c                            | 146 +++
 security/ipe/ipe.h                            |  23 +
 security/ipe/properties/Kconfig               |  35 +
 security/ipe/properties/Makefile              |  13 +
 security/ipe/properties/boot-verified.c       |  84 ++
 security/ipe/properties/dmverity-roothash.c   | 155 +++
 security/ipe/properties/dmverity-signature.c  |  84 ++
 security/ipe/properties/prop-entry.h          |  38 +
 security/ipe/utility.h                        |  32 +
 security/security.c                           |  61 ++
 56 files changed, 5634 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/ipe.rst
 create mode 100644 scripts/ipe/Makefile
 create mode 100644 scripts/ipe/polgen/.gitignore
 create mode 100644 scripts/ipe/polgen/Makefile
 create mode 100644 scripts/ipe/polgen/polgen.c
 create mode 100644 security/ipe/.gitignore
 create mode 100644 security/ipe/Kconfig
 create mode 100644 security/ipe/Makefile
 create mode 100644 security/ipe/ipe-audit.c
 create mode 100644 security/ipe/ipe-audit.h
 create mode 100644 security/ipe/ipe-blobs.c
 create mode 100644 security/ipe/ipe-blobs.h
 create mode 100644 security/ipe/ipe-engine.c
 create mode 100644 security/ipe/ipe-engine.h
 create mode 100644 security/ipe/ipe-hooks.c
 create mode 100644 security/ipe/ipe-hooks.h
 create mode 100644 security/ipe/ipe-parse.c
 create mode 100644 security/ipe/ipe-parse.h
 create mode 100644 security/ipe/ipe-pin.c
 create mode 100644 security/ipe/ipe-pin.h
 create mode 100644 security/ipe/ipe-policy.c
 create mode 100644 security/ipe/ipe-policy.h
 create mode 100644 security/ipe/ipe-prop-internal.h
 create mode 100644 security/ipe/ipe-property.c
 create mode 100644 security/ipe/ipe-property.h
 create mode 100644 security/ipe/ipe-secfs.c
 create mode 100644 security/ipe/ipe-secfs.h
 create mode 100644 security/ipe/ipe-sysfs.c
 create mode 100644 security/ipe/ipe-sysfs.h
 create mode 100644 security/ipe/ipe.c
 create mode 100644 security/ipe/ipe.h
 create mode 100644 security/ipe/properties/Kconfig
 create mode 100644 security/ipe/properties/Makefile
 create mode 100644 security/ipe/properties/boot-verified.c
 create mode 100644 security/ipe/properties/dmverity-roothash.c
 create mode 100644 security/ipe/properties/dmverity-signature.c
 create mode 100644 security/ipe/properties/prop-entry.h
 create mode 100644 security/ipe/utility.h

-- 
2.26.0
