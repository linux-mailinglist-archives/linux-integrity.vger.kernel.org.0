Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0E91094BC
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2019 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYUmZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Nov 2019 15:42:25 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:43335
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbfKYUmZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Nov 2019 15:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574714542; bh=ppjQtUO+Qu++Rp6SZDXrwCFDjut94UaBpoVz8tCIwH8=; h=Subject:References:Cc:To:From:Date:In-Reply-To:From:Subject; b=mjDzR/JaEBS9ObEC7No9qqeJN7o1WY+pPxsz6OxGTa3RqQuxK1d1zKo/eXu+cYOUC6JDV2Jf6GtzvQ6Z7mZ5ft5KfVGHr7PORYWduEIBca5ls11bwcGOQHf+b3MI+glx6d40kBMviHlW+GFrLCU6nzDTEYcUZ9RcG4eaWTnx3C/ARoBlbWp4E8CAMEOy40AItLMJQhXZnv67FsKsQgSDWxoead7dm8dNuSjudP8tDjbw1TsB7LAin6wnwaI9RqcCapzRcQ/+8gEaEwUBH+T2qVkuPW+1dt+mbZNYyNoZyPJHp+AUcTCv0watRl4XVsX8bEHmVJfoqewH/kpvZ9yREg==
X-YMail-OSG: NeM8ZHMVM1kV321nNpVuF8wPYPqtA8diAJFNT_WIVA7jdxDH240BJbrTZWUoZ1S
 e0o170qF1Xru2ltbOJZKwpBczNykk322etwz_2CErhztn_ri7Ewu.iQ744BwyMZ1RaWlE9ATDtDM
 6setGHQbJDvTeB05gjuOOrF2UPuR4zrFLX8QayWhTIrvRRieUN52.fdTTQSam5rcK_BI_dvB.oZC
 fdwBzK3kAACNgeZrXo1K8.SK9j1c1UU2rcxQI_ld3mmNqOY_e9oXuagtfEyN6Um22Txq10t50Q9k
 ztmGAOZ1d2hPozPojl7kJZBcKDiHTkT0DQoKlXZllUGrJo8Ry0cfpFvs5qQJLwFPy2M3jZVyBn25
 MR71vFtjWflqc1zQrd1YbyRWtcp8msm5Go8F.ryopyR3IlR7NM3s_UhstNWn51T1eTR783EayoFF
 k2ZGRJzUbzG.14EmiLYiJ8C2vVequl6yxpSZc_kydyLLE_KOrORjr3MmVi2XkhD1zSfqglnHudnY
 8OBculnx7LzYZBJsZ.OlrpHVq0OGaalCwIEpRI0Eq07ed11aS7a1VXLyOK5ntZ7vLUdKn961hnof
 EugKOsw.Jk3VzGmkYQwv2nXensU7sqn77wbvdco5gimpUOenXzyUw6S6_Hjco60Pk84WXWQyubi8
 GC8ttyY6i4z2J5vDRgftrF71hTkOjtyYAJiGvuOZ2n_bOheHQbeg.6F.e_B220hHG_RtyNKvhnXc
 eMdaB22zetmCBRKNtFxxFYovA6pbo2lakKjsuhBGbP_F1I13hh5vh3VnQw_9RFrJnvQRrpINt0s4
 E81CGAdY_SKAnfm61EcXGAtPgmNhiGWBpefiWQZ3mVTZzsd8ltO6LmartjeGIbzxZFFxB.Ix3LL.
 k4VQSbjidxgRQQEsYV4JqhFUWJ4eRPgCCzEj8IZdEV4SlPayiTfvVvj3JUjdqrwZYK84fmDIMeok
 Jq48z0qJCqdqFK6tN2HtGiRacc7AAUsWtfq_N5OVHmXlL8ILY4_UhYCMu.tw6Ryw7Boa7Z8rHMdQ
 tRu7wsfHuMkU05eMCpTHEcpaCuqQPtJbq3xgk5QCjFtXiPK52GtSPz_S8vGMjmGTCzKE8HSi2den
 vH0m0grdix_tAyKa1stzlTJDWMISQuk7lGnquDz8EZrmhEfupmgsgXxg9Ruv355EoK0TMOItYbxm
 EzCLys7eTROiK3BJn0IYJrV52NOyHYOKA7uEKxe_PYTySiuarkDQJTTWrErNRDJLcBQ5atVvouaU
 gSKIDFRaEIaxLXi4P7tfNNLR_OnNE5qaw90yRIA6iqF3RXnrwp3CYEZ1_XGaUb.8I0T9mp7ievv.
 IQUkFXVvKAsfuGs4VBpvrRuU1h8rAdAu4Lc2gjUPjf6cvhyOegMjKFvZRZHivTJ8nvK1LBPK9stJ
 d_kgP8DTqYYzWiGsjmiWCqq5Ob4MvRJbomA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 Nov 2019 20:42:22 +0000
Received: by smtp416.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0666c9c09584bcd1c26a5ff3db0c37a0;
          Mon, 25 Nov 2019 20:42:19 +0000 (UTC)
Subject: Re: [PATCH v10 00/25] LSM: Module stacking for AppArmor
References: <20191024205228.6922-1-casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <1a7e9e00-afb5-9164-912c-84f2cde7a2e1@schaufler-ca.com>
Date:   Mon, 25 Nov 2019 12:42:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Has anyone from the integrity development team been watching
the stack patch effort? There are changes that could be of
concern.

On 10/24/2019 1:52 PM, Casey Schaufler wrote:
> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.
>
> v10: Ask the security modules if the display can be changed.
>
> v9: There is no version 9
>
> v8: Incorporate feedback from v7
>     - Minor clean-up in display value management
>     - refactor "compound" context creation to use a common
>       append_ctx() function.
>
> v7: Incorporate feedback from v6
>     - Make setting the display a privileged operation. The
>       availability of compound contexts reduces the need for
>       setting the display.
>
> v6: Incorporate feedback from v5
>     - Add subj_<lsm>= and obj_<lsm>= fields to audit records
>     - Add /proc/.../attr/context to get the full context in
>       lsmname\0value\0... format as suggested by Simon McVittie
>     - Add SO_PEERCONTEXT for getsockopt() to get the full context
>       in the same format, also suggested by Simon McVittie.
>     - Add /sys/kernel/security/lsm_display_default to provide
>       the display default value.
>
> v5: Incorporate feedback from v4
>     - Initialize the lsmcontext in security_secid_to_secctx()
>     - Clear the lsmcontext in all security_release_secctx() cases
>     - Don't use the "display" on strictly internal context
>       interfaces.
>     - The SELinux binder hooks check for cases where the context
>       "display" isn't compatible with SELinux.
>
> v4: Incorporate feedback from v3
>     - Mark new lsm_<blob>_alloc functions static
>     - Replace the lsm and slot fields of the security_hook_list
>       with a pointer to a LSM allocated lsm_id structure. The
>       LSM identifies if it needs a slot explicitly. Use the
>       lsm_id rather than make security_add_hooks return the
>       slot value.
>     - Validate slot values used in security.c
>     - Reworked the "display" process attribute handling so that
>       it works right and doesn't use goofy list processing.
>     - fix display value check in dentry_init_security
>     - Replace audit_log of secids with '?' instead of deleting
>       the audit log
>
> v3: Incorporate feedback from v2
>     - Make lsmblob parameter and variable names more
>       meaningful, changing "le" and "l" to "blob".
>     - Improve consistency of constant naming.
>     - Do more sanity checking during LSM initialization.
>     - Be a bit clearer about what is temporary scaffolding.
>     - Rather than clutter security_getpeersec_dgram with
>       otherwise unnecessary checks remove the apparmor
>       stub, which does nothing useful.
>
> Patche 0001 moves management of the sock security blob from the individual
> modules to the infrastructure.
>
> Patches 0002-0012 replace system use of a "secid" with
> a structure "lsmblob" containing information from the
> security modules to be held and reused later. At this
> point lsmblob contains an array of u32 secids, one "slot"
> for each of the security modules compiled into the
> kernel that used secids. A "slot" is allocated when
> a security module requests one.
> The infrastructure is changed to use the slot number
> to pass the correct secid to or from the security module
> hooks.
>
> It is important that the lsmblob be a fixed size entity
> that does not have to be allocated. Several of the places
> where it is used would have performance and/or locking
> issues with dynamic allocation.
>
> Patch 0013 provides a mechanism for a process to
> identify which security module's hooks should be used
> when displaying or converting a security context string.
> A new interface /proc/.../attr/display contains the name
> of the security module to show. Reading from this file
> will present the name of the module, while writing to
> it will set the value. Only names of active security
> modules are accepted. Internally, the name is translated
> to the appropriate "slot" number for the module which
> is then stored in the task security blob. Setting the
> display requires that all modules using the /proc interfaces
> allow the transition.
>
> Patch 0014 Starts the process of changing how a security
> context is represented. Since it is possible for a
> security context to have been generated by more than one
> security module it is now necessary to note which module
> created a security context so that the correct "release"
> hook can be called. There are several places where the
> module that created a security context cannot be inferred.
>
> This is achieved by introducing a "lsmcontext" structure
> which contains the context string, its length and the
> "slot" number of the security module that created it.
> The security_release_secctx() interface is changed,
> replacing the (string,len) pointer pair with a lsmcontext
> pointer.
>
> Patches 0015-0017 convert the security interfaces from
> (string,len) pointer pairs to a lsmcontext pointer.
> The slot number identifying the creating module is
> added by the infrastructure. Where the security context
> is stored for extended periods the data type is changed.
>
> The Netlabel code is converted to save lsmblob structures
> instead of secids in Patches 0018-0019.
>
> Patch 0020 adds checks to the binder hooks which verify
> that if both ends of a transaction use the same "display".
>
> Patches 0021-0022 add addition data to the audit records
> to identify the LSM specific data for all active modules.
>
> Patches 0023-0024 add new interfaces for getting the
> compound security contexts.
>
> Finally, with all interference on the AppArmor hooks
> removed, Patch 0025 removes the exclusive bit from
> AppArmor. An unnecessary stub hook was also removed.
>
> The Ubuntu project is using an earlier version of
> this patchset in their distribution to enable stacking
> for containers.
>
> Performance measurements to date have the change
> within the "noise". The sockperf and dbench results
> are on the order of 0.2% to 0.8% difference, with
> better performance being as common as worse. The
> benchmarks were run with AppArmor and Smack on Ubuntu.
>
> https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v10-apparmor
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h    |   1 +
>  arch/mips/include/uapi/asm/socket.h     |   1 +
>  arch/parisc/include/uapi/asm/socket.h   |   1 +
>  arch/sparc/include/uapi/asm/socket.h    |   1 +
>  drivers/android/binder.c                |  24 +-
>  fs/kernfs/dir.c                         |   5 +-
>  fs/kernfs/inode.c                       |  35 +-
>  fs/kernfs/kernfs-internal.h             |   3 +-
>  fs/nfs/nfs4proc.c                       |  22 +-
>  fs/nfsd/nfs4xdr.c                       |  20 +-
>  fs/proc/base.c                          |   2 +
>  include/linux/audit.h                   |   1 +
>  include/linux/cred.h                    |   3 +-
>  include/linux/lsm_hooks.h               |  37 +-
>  include/linux/security.h                | 175 ++++++++--
>  include/net/af_unix.h                   |   2 +-
>  include/net/netlabel.h                  |   8 +-
>  include/net/scm.h                       |  15 +-
>  include/uapi/asm-generic/socket.h       |   1 +
>  kernel/audit.c                          |  70 +++-
>  kernel/audit.h                          |   9 +-
>  kernel/audit_fsnotify.c                 |   1 +
>  kernel/auditfilter.c                    |  10 +-
>  kernel/auditsc.c                        | 129 ++++---
>  kernel/cred.c                           |  12 +-
>  net/core/sock.c                         |   7 +-
>  net/ipv4/cipso_ipv4.c                   |   6 +-
>  net/ipv4/ip_sockglue.c                  |  12 +-
>  net/netfilter/nf_conntrack_netlink.c    |  20 +-
>  net/netfilter/nf_conntrack_standalone.c |  11 +-
>  net/netfilter/nfnetlink_queue.c         |  26 +-
>  net/netfilter/nft_meta.c                |  13 +-
>  net/netfilter/xt_SECMARK.c              |   5 +-
>  net/netlabel/netlabel_kapi.c            |   6 +-
>  net/netlabel/netlabel_unlabeled.c       |  97 +++---
>  net/netlabel/netlabel_unlabeled.h       |   2 +-
>  net/netlabel/netlabel_user.c            |  13 +-
>  net/netlabel/netlabel_user.h            |   6 +-
>  net/unix/af_unix.c                      |   6 +-
>  net/xfrm/xfrm_policy.c                  |   2 +
>  net/xfrm/xfrm_state.c                   |   2 +
>  security/apparmor/include/apparmor.h    |   3 +-
>  security/apparmor/include/net.h         |   6 +-
>  security/apparmor/lsm.c                 | 121 ++++---
>  security/commoncap.c                    |   7 +-
>  security/integrity/ima/ima.h            |  14 +-
>  security/integrity/ima/ima_api.c        |  10 +-
>  security/integrity/ima/ima_appraise.c   |   6 +-
>  security/integrity/ima/ima_main.c       |  36 +-
>  security/integrity/ima/ima_policy.c     |  19 +-
>  security/integrity/integrity_audit.c    |   1 +
>  security/loadpin/loadpin.c              |   8 +-
>  security/safesetid/lsm.c                |   8 +-
>  security/security.c                     | 586 +++++++++++++++++++++++++++++---
>  security/selinux/hooks.c                | 109 +++---
>  security/selinux/include/classmap.h     |   2 +-
>  security/selinux/include/objsec.h       |   5 +
>  security/selinux/include/security.h     |   1 +
>  security/selinux/netlabel.c             |  25 +-
>  security/selinux/ss/services.c          |   4 +-
>  security/smack/smack.h                  |   6 +
>  security/smack/smack_lsm.c              | 124 ++++---
>  security/smack/smack_netfilter.c        |   8 +-
>  security/smack/smackfs.c                |  10 +-
>  security/tomoyo/tomoyo.c                |   8 +-
>  security/yama/yama_lsm.c                |   7 +-
>  66 files changed, 1376 insertions(+), 580 deletions(-)
>
