Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A1610BE9E
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfK0VhY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:37:24 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:42559
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbfK0VhY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890642; bh=+ehEyrNStz+yt3dPfAiYq7/z0Yp/TRj4UTkYv8T6sOY=; h=From:To:Subject:Date:References:From:Subject; b=Efxl6p5qDiQJ2NG5JmPOTwSZIQ5LFr2N+7LT/GKFuVIavrpgiXVtBZ7p5C8hNrWcuAT8yMMdBfjDPCKHI92tPBcuUy8TgW6JXJI3LnwmGKg2AMLTfh4XZ37CraojbYMSHLt0vhF2BCCKBUvsVP/XH3znRUX0b0rG+6q9GNwuj/MeD+mHpyTk7TXkQTPTXiLGQN/du8ZgXXWpHI0Q+kIlXf0SuQu3Yxm/oyCh8lcJEOuzPIj8fWud/LIrIx2zpS9K3/Iitqo0uf37m9GA5t2LXhUMc/w7a+ttQcip9l9dRPSEeuYtIO0ce6uFmpqJqgjhityTU0uBVK4uRcJU59UnCA==
X-YMail-OSG: SmID.PsVM1l1yG44Uw1MHW_aFMjKb4Nia5rejoLW4wDUvEcfwINyV.rRkIN2cpb
 WpLAxstspXFIzihXOg0lsksZUvNxW0Zm0jvLGzOVGB2PrduGSdlT9vFqoy8Dwln5Vp5K_wOaMDVe
 b8nkJArY.BUAn9Iaf2NkwYHAEMyV1EnaBpNZaMhWukENpQn1DZxl3QubnvLdWiLl2cwkCC1EjKGp
 HMlwERxS4PPpeDxN1G26VgghGMA8m.1G7RuJfuD5isEeQjH0r9sLE4qmJhPuv.F4H3UX3UnjuSqr
 hideDH.IMrHyHeFJTGt98DFBA1npyqPAFavhsFVVJ2riWdzZuwkOBVBuwv_CEVcWZO03Yu5OUIDe
 xrPBrO_FH2TDkLn4A6g47ULnZ6Yj8cuAVMlo3eof2WnVaHzqD_OpkkrC.gi74C2c8yZR4Bpkl7mI
 XzD7JgI21D99dzslIqHrWsc0tOMsN2tKBp0kibwLaX.83NA4kzesr0WhJkvop1yQjIv17Vvrd8Fm
 Qi7zLQVutXYOnVIYr15Eoby9g0eR8VseF.vrKquayURULxwF7USLd3HDnnhT1mBDYtzZWjcdk_Z9
 9__zswOr8QjAkaOt.89pfhwjBipQswbDIh_wEW.HYpvEIl70f8uW0oe0GN8qfrIxx1w.MfJzUCvz
 28QlLTLqbhtmz1FcvxsKaCSR6rhhEQhnVzeOVU7P_ow3GPfTTC29nI09D_2bOMXGb43QGYjQlEEb
 WrYLXzEEfmbsUKjOjnlTQeRZUTOXOvPnK4Lgkyn.F4MoLJ8rDTtWs2Jar3Tafwgf3E0N.EcD8mUT
 YpQAy6NqF.SKV.aiHUzFQoqs.lNDmLTAmZeuhezonDzGFyrYCy00XcQjSlUi5qkwMWLNzGkcU_Je
 F1n_dghx7UezRFH_z4BL2CgwPeoen4.F8pOuEYgHlT3EoT7H77fuWI49eyAF6Yu5z4_GkEUjw1dq
 9b8DDjwksxVm4iUJH4tAM5XD1YaHzvrvucI4j7USPzVceObVVf75JH08.6HrGBarTMorVtRDpHxA
 5WaQflYKEqR0Ili1HW2ctbLnqpjuF0IA7_iWX7wI.UEf7RIVY.s6TcpzJHQA2bbpPz3gtVRLDkmV
 qmKsdkJPB6XT506xpjEEkIh8sCMQ9FQOtxW7dqAeUsSuILTC26peXK_JDKgXI3ex.JBR58FTXbb8
 o0qDtI54DD3TjqmrQIDVdTxmRHm3aJ3eN5lwh5aZXam4zae3qr5HDo1Phq36JYbBw7VHB.s4yzeB
 W2NtIewNyYYhOiGLf5.SJONEBhqbRicUrNOZkPsrml1i68jo93xAFnFBYRgT13.3gSAnhvNG.cs8
 .ZHUF6QAGfBAjd6bSVvL9rrLyHvrb3yYAxvuV0F4bMvQVvaSqH94rIXfKOYnhSiVzw8Kcglzq98R
 g4w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:37:22 +0000
Received: by smtp402.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 624f2dcca999a08fd555e1a043575b9f;
          Wed, 27 Nov 2019 21:37:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 00/25] LSM: Module stacking for AppArmor
Date:   Wed, 27 Nov 2019 13:36:53 -0800
Message-Id: <20191127213718.18267-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20191127213718.18267-1-casey.ref@schaufler-ca.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Version based on origin/topic/ima branch of the powerpc tree.
For review purposes.

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v11: Rebase to 5.4-rc6
     Incorporate feedback from v10
     - Disambiguate reading /proc/.../attr/display by restricting
       all use of the interface to the current process.
     - Fix a merge error in AppArmor's display attribute check

v10: Ask the security modules if the display can be changed.

v9: There is no version 9

v8: Incorporate feedback from v7
    - Minor clean-up in display value management
    - refactor "compound" context creation to use a common
      append_ctx() function.

v7: Incorporate feedback from v6
    - Make setting the display a privileged operation. The
      availability of compound contexts reduces the need for
      setting the display.

v6: Incorporate feedback from v5
    - Add subj_<lsm>= and obj_<lsm>= fields to audit records
    - Add /proc/.../attr/context to get the full context in
      lsmname\0value\0... format as suggested by Simon McVittie
    - Add SO_PEERCONTEXT for getsockopt() to get the full context
      in the same format, also suggested by Simon McVittie.
    - Add /sys/kernel/security/lsm_display_default to provide
      the display default value.

v5: Incorporate feedback from v4
    - Initialize the lsmcontext in security_secid_to_secctx()
    - Clear the lsmcontext in all security_release_secctx() cases
    - Don't use the "display" on strictly internal context
      interfaces.
    - The SELinux binder hooks check for cases where the context
      "display" isn't compatible with SELinux.

v4: Incorporate feedback from v3
    - Mark new lsm_<blob>_alloc functions static
    - Replace the lsm and slot fields of the security_hook_list
      with a pointer to a LSM allocated lsm_id structure. The
      LSM identifies if it needs a slot explicitly. Use the
      lsm_id rather than make security_add_hooks return the
      slot value.
    - Validate slot values used in security.c
    - Reworked the "display" process attribute handling so that
      it works right and doesn't use goofy list processing.
    - fix display value check in dentry_init_security
    - Replace audit_log of secids with '?' instead of deleting
      the audit log

v3: Incorporate feedback from v2
    - Make lsmblob parameter and variable names more
      meaningful, changing "le" and "l" to "blob".
    - Improve consistency of constant naming.
    - Do more sanity checking during LSM initialization.
    - Be a bit clearer about what is temporary scaffolding.
    - Rather than clutter security_getpeersec_dgram with
      otherwise unnecessary checks remove the apparmor
      stub, which does nothing useful.

Patche 0001 moves management of the sock security blob from the individual
modules to the infrastructure.

Patches 0002-0012 replace system use of a "secid" with
a structure "lsmblob" containing information from the
security modules to be held and reused later. At this
point lsmblob contains an array of u32 secids, one "slot"
for each of the security modules compiled into the
kernel that used secids. A "slot" is allocated when
a security module requests one.
The infrastructure is changed to use the slot number
to pass the correct secid to or from the security module
hooks.

It is important that the lsmblob be a fixed size entity
that does not have to be allocated. Several of the places
where it is used would have performance and/or locking
issues with dynamic allocation.

Patch 0013 provides a mechanism for a process to
identify which security module's hooks should be used
when displaying or converting a security context string.
A new interface /proc/self/attr/display contains the name
of the security module to show. Reading from this file
will present the name of the module, while writing to
it will set the value. Only names of active security
modules are accepted. Internally, the name is translated
to the appropriate "slot" number for the module which
is then stored in the task security blob. Setting the
display requires that all modules using the /proc interfaces
allow the transition. The "display" of other processess
can be neither read nor written. All suggested cases
for reading the display of a different process have race
conditions.

Patch 0014 Starts the process of changing how a security
context is represented. Since it is possible for a
security context to have been generated by more than one
security module it is now necessary to note which module
created a security context so that the correct "release"
hook can be called. There are several places where the
module that created a security context cannot be inferred.

This is achieved by introducing a "lsmcontext" structure
which contains the context string, its length and the
"slot" number of the security module that created it.
The security_release_secctx() interface is changed,
replacing the (string,len) pointer pair with a lsmcontext
pointer.

Patches 0015-0017 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

The Netlabel code is converted to save lsmblob structures
instead of secids in Patches 0018-0019.

Patch 0020 adds checks to the binder hooks which verify
that if both ends of a transaction use the same "display".

Patches 0021-0022 add addition data to the audit records
to identify the LSM specific data for all active modules.

Patches 0023-0024 add new interfaces for getting the
compound security contexts.

Finally, with all interference on the AppArmor hooks
removed, Patch 0025 removes the exclusive bit from
AppArmor. An unnecessary stub hook was also removed.

The Ubuntu project is using an earlier version of
this patchset in their distribution to enable stacking
for containers.

Performance measurements to date have the change
within the "noise". The sockperf and dbench results
are on the order of 0.2% to 0.8% difference, with
better performance being as common as worse. The
benchmarks were run with AppArmor and Smack on Ubuntu.

https://github.com/cschaufler/lsm-stacking.git#stack-5.4-rc6-v11-apparmor

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/alpha/include/uapi/asm/socket.h    |   1 +
 arch/mips/include/uapi/asm/socket.h     |   1 +
 arch/parisc/include/uapi/asm/socket.h   |   1 +
 arch/sparc/include/uapi/asm/socket.h    |   1 +
 drivers/android/binder.c                |  26 +-
 fs/ceph/xattr.c                         |   6 +-
 fs/nfs/nfs4proc.c                       |  22 +-
 fs/nfsd/nfs4xdr.c                       |  20 +-
 fs/proc/base.c                          |   2 +
 include/linux/audit.h                   |   1 +
 include/linux/cred.h                    |   3 +-
 include/linux/lsm_hooks.h               |  37 +-
 include/linux/security.h                | 175 ++++++++--
 include/net/af_unix.h                   |   2 +-
 include/net/netlabel.h                  |   8 +-
 include/net/scm.h                       |  15 +-
 include/uapi/asm-generic/socket.h       |   1 +
 kernel/audit.c                          |  72 +++-
 kernel/audit.h                          |   9 +-
 kernel/audit_fsnotify.c                 |   1 +
 kernel/auditfilter.c                    |  10 +-
 kernel/auditsc.c                        | 127 ++++---
 kernel/cred.c                           |  12 +-
 net/core/sock.c                         |   7 +-
 net/ipv4/cipso_ipv4.c                   |   6 +-
 net/ipv4/ip_sockglue.c                  |  12 +-
 net/netfilter/nf_conntrack_netlink.c    |  20 +-
 net/netfilter/nf_conntrack_standalone.c |  11 +-
 net/netfilter/nfnetlink_queue.c         |  26 +-
 net/netfilter/nft_meta.c                |  13 +-
 net/netfilter/xt_SECMARK.c              |   5 +-
 net/netlabel/netlabel_kapi.c            |   6 +-
 net/netlabel/netlabel_unlabeled.c       |  97 +++---
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  13 +-
 net/netlabel/netlabel_user.h            |   6 +-
 net/unix/af_unix.c                      |   6 +-
 net/xfrm/xfrm_policy.c                  |   2 +
 net/xfrm/xfrm_state.c                   |   2 +
 security/apparmor/include/apparmor.h    |   3 +-
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/lsm.c                 | 117 +++----
 security/commoncap.c                    |   7 +-
 security/integrity/ima/ima.h            |  15 +-
 security/integrity/ima/ima_api.c        |  11 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  49 +--
 security/integrity/ima/ima_policy.c     |  19 +-
 security/integrity/integrity_audit.c    |   1 +
 security/loadpin/loadpin.c              |   8 +-
 security/safesetid/lsm.c                |   8 +-
 security/security.c                     | 593 +++++++++++++++++++++++++++++---
 security/selinux/hooks.c                | 109 +++---
 security/selinux/include/classmap.h     |   2 +-
 security/selinux/include/objsec.h       |   5 +
 security/selinux/include/security.h     |   1 +
 security/selinux/netlabel.c             |  25 +-
 security/selinux/ss/services.c          |   4 +-
 security/smack/smack.h                  |   6 +
 security/smack/smack_lsm.c              | 124 ++++---
 security/smack/smack_netfilter.c        |   8 +-
 security/smack/smackfs.c                |  10 +-
 security/tomoyo/tomoyo.c                |   8 +-
 security/yama/yama_lsm.c                |   7 +-
 64 files changed, 1376 insertions(+), 563 deletions(-)
