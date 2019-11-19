Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2840D102E74
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2019 22:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKSVqI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Nov 2019 16:46:08 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:35250
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbfKSVqI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Nov 2019 16:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574199966; bh=cYNRWIBTQRvER7xSrQGn/cC6CKiS2Ph/zsIKZgDobKc=; h=From:To:Cc:Subject:Date:References:From:Subject; b=jMVbcAhmD6nGKoFFLDq4pgJvwVx8pn5Tp2POKJ6Oc+2pQySmyEStTVSTe5hyQVEY/LuaijoWsdtuizuUQJJquINvht1FhKXdlN/6cOjeEtI1PA9Tk6OYY8wRLBFzmn7CM1bcPgbOyPs85VOKDUQFHzgXJd9it6vO747uw36+8EGSMFH49g7LwC9fibIuveADHHyKZZXA/q0wTyZpqo5mJjIlDYBdmC5diiMN3UQqZEOHo0bkry9VL+eoLQtwnjWropaIo7Qb1qvg+QFwMfKp6dx3Kbjo853wTyGcuYkovE3UqWziQaoJ5dJLZz/KTTjOv5u1yaOiZjszxHvwRmmYQg==
X-YMail-OSG: TLVlXqUVM1nDFtlRmrDcILKTksBDjAWTIQQYrc1Vmgg70NwDWaxV6er8QfvAnRF
 so2GuC1PghPKw5zCQVvLC06F5d14GWxQS__9UWTqlC9zuSlZZSSqjMSx.OCii1nbpg2AOBYxDMLj
 K37jQ3Z3qDNpuuu5MtKazpjqw4sHDvt44967PUz7uNuPOikaXcjSrelRXBy9.9V70beF9VQCojDA
 L4BdVn2eF.c974BPE1zzsv28Z7DAReq40u2eFqfEczB6zAA12zgdLfdWNqAXvVygLD..qhHFF7X2
 S78SYTzivH8qsoWdILmHKoP6L3Oq4GBBvAii6NyuftehfJN8jQeRVM52HpvS.DcCSeH8_v1YeTsz
 OwETK3y9kNQcGiZHa0AvA9khXngiy13ysCBQrSU.85gEnVLmL9Yb8EFbBFlimVEbf3ZhoSmrJT2z
 VuFBtJFoThdGxbI.KSE7tlSdgNBC6NjWq.hfdVsgAdSGgF1ILhVl7paBVcKgS.qdY8g0kBNB86tD
 Q1YQRCPbvi_9ujIeF1d_rI6yFHVEIHp0rEG_QfLfZIQoY3BXkkumbWRfy8VceXzO_Qqb1dKr3fCT
 bcqddWKpgxwjpmyO87VfGRUc4IwZEFLYVCHCInhutdJOCJgEeIE5wzxBzhVOxejj2.nUVcMsFeea
 HRDRAXnd55W.slriUM9uD1xNMFDNBISsip75gYxpVdH3v1LkoH1EziSbawOKutrTOTUPNeZHpvIT
 1U_dbUXIFGPUYt7_Y1zCQPn6YL_6NC4nD1URc32laewJfULG0vHt52PoNl28WG5nOaM2tItKqKC1
 Izzl.YZJwVprD59M4FA6JlBmGMZiBnoTEyhqDIaixqeAs62BhIyWBBxn6orhnMhII_Ef__8EGRJl
 AJvZMN_vG2.yxKEl_XTQk3KfyBKab587VTosg1rkJCu8PHH5tpjbonsMB82kUFblNGdVmiaXQSNb
 ranr3iJmhd2FTyA.o5wzHrqjX3Z_4BmOmIMy9P1alAX8ZSicK1TDAGXwQPkeE5LsC0vMeaJefcOT
 783b_i3WGzx73PHhq5x1wuvlOcn9FtUlxK6lUtmOXZUdkjU.ZQJXZdqrei9UPbSVncD2jyydcB0t
 G_eYvAzS7JMV.9Dt7rtR58Yj5RkBLcJguUVDcx50VNjxhQPKnxUQj4Zyn_.u7gxCcZcvaZp9jrN4
 1uzeShjgbKBmT0zewIGa5ksJAVjAI0Ef49_VFfoW.JzoVuRFunGjfe78RB4sGA4KGC9T22CdVufW
 1KO1J0BdePpSSlFD0CcYElIZ.b_d8K2nwzeloOQuaehDu6I7l.gp13ypgBYtxfOXfveIEsuR_bMi
 i7x8ytc1Edjl7aRrZxqI3.Bwb17EJLk_Ln0x6aXCmWa4H1CLC8qFmObylL26bGFaikKePR00CoAg
 Oh3gFqTGN_QT9NPAm0X01zw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 Nov 2019 21:46:06 +0000
Received: by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 44ccda8ccd0493c5e1e3acd1964ab202;
          Tue, 19 Nov 2019 21:46:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com
Subject: [PATCH v11 00/25] LSM: Module stacking for AppArmor
Date:   Tue, 19 Nov 2019 13:45:55 -0800
Message-Id: <20191119214601.13238-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20191119214601.13238-1-casey.ref@schaufler-ca.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Reposting to linux-integrity for additional exposure.

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
