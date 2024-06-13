Return-Path: <linux-integrity+bounces-2858-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EBF907B3D
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2024 20:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC38F2825CC
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2024 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E7F14AD23;
	Thu, 13 Jun 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YFFSDk4R"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6F14A4F3
	for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2024 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303216; cv=none; b=KL2MJY7sVqjeY1W/+ikw4JZukV/gAE/de01DwLfz++5DhCnD0z9+qAXqukZ7pj/w3Qi8VcyQrPAnze+yREIEhwYnDF8h36SbRixDNnjp2+aP1ZRaSYUNf56AWIljG3AhK7dEcNKPwiVk5aBLIP+r1nvGw38VDBIlP+sZ+FCrBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303216; c=relaxed/simple;
	bh=VLw0bWZBkfRfVs06AEgEM820Gqa5lkBzbVmDwF233Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/6gmEzS0g9h64PeGSOdEocluazs68UraENC265Dx1RIDriMd09P0EvuYoiN0VmrP2J33BPPpLWQXFVtQOTkN3HLE5no4nxRuFy250A1khrl2ApV/yhY70SebsFhZQ2p4DsEnNIBPR470Wyvceh967AgE7svDIcwe2fk50x3IjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YFFSDk4R; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62f86eaffbeso15007167b3.3
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2024 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718303214; x=1718908014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUZMZYdmH0PD0W1ckRqY92IjQ0umZRiAKgV8BSjjNmU=;
        b=YFFSDk4RTJVQ4wJDU3a9MCS2itsq9jf7OdJNnvZFA1zyM3OqnX2hGWPM1cPvWadPgK
         0NnKJlpnXvQ7rgmWWxZzWdIfQEYAt/sten0dE2w0z9I4TsDpK/zMtKdGrTFk7BmZpTFk
         onnHCe36ym/gZsB3gbgN20iO1DAuDkh//Nss/8QFM5yfKisvz5Lacneq0AavWKmBn+ZO
         6sOF/Rql6qIVFnLMp9eFJb3hPQ7hzH8+9zSi5Jbw0AnXiuv6bmwdB1zuruAQANrWAbjM
         bfJ27qf0hA1oJxLEVDyJfVPAlYUGLAbvJV9K+MHyhakn+mTCWrmdhIgUVsaMmDnvOiVG
         UdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303214; x=1718908014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUZMZYdmH0PD0W1ckRqY92IjQ0umZRiAKgV8BSjjNmU=;
        b=NRi/mGyVqO3wU94fMQgG6c42XRFLZMqRzpLm1D8A55X/47pehV8WmjerCULfsSJ9sz
         N5N/6+IT+3IcZKiKvNM3vc8XRZYJd3vnpJ/hTF46IsKDIYCvjbNHAk3u80CPzs9TRP/Z
         htMvohBkA0jGL8egYyieQymhHGBg08CzsllmZG9/y9IWIrtrcFpaoSknPB1iVhzi4WL/
         aPjxkgMj+Gffj83VZCnRZwYArok3zPAUq7H9R5S7f1AmEZg+5X7cMD1zZtVpveDY3hJA
         yl5hGKFBQDLkIE35iW4WTlU0U1IKGivTg1o967K2+EjvayLlNvTeF6lH6yHX29+bo/Xc
         KiHw==
X-Forwarded-Encrypted: i=1; AJvYcCUG99VLj2KXR4Bbtat9D3+HMQGIR5TCk1T/+2HQSRaXLxCSpu+qlbYQAx0se7vbTIodbJrcydOybGxKbQPT9xdvYEhN0mA13Xw/wgov9El+
X-Gm-Message-State: AOJu0Yz/wKqbboBa0aSjEmmwP/lH6dT3Q91aLLApjlEG98DsQdC3TLMy
	jmikrshIe0PxOc51S/gqXetaTeQStTpnciU9GDSJ+Po5KZrF5NTjJV5a2U078aOgrqTpLvfM2Bz
	vYBB4EcmxTADwMFtr+YYWyaLOs9XlNsFp6Blo
X-Google-Smtp-Source: AGHT+IFsylxSbj2uZgSGOJg0LMaFfRq7IjLxJeN2QodiQ5UR3ur142ShbPh1aawzB6Sp1Ix5B6xJW8rBRuAPSk+Aesw=
X-Received: by 2002:a81:a548:0:b0:62f:7ba7:d5a4 with SMTP id
 00721157ae682-6322265df68mr2812027b3.16.1718303213265; Thu, 13 Jun 2024
 11:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507012541.796421-1-guozihua@huawei.com> <00d88046025c611f2bf94708ffc65ecc@paul-moore.com>
In-Reply-To: <00d88046025c611f2bf94708ffc65ecc@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Jun 2024 14:26:42 -0400
Message-ID: <CAHC9VhRqvBsdy+U-wr+X6QmawLv6DnB32nwAO7Ex6L7cdR=mSg@mail.gmail.com>
Subject: Re: [PATCH v3] ima: Avoid blocking in RCU read-side critical section
To: GUO Zihua <guozihua@huawei.com>, john.johansen@canonical.com, jmorris@namei.org, 
	serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, stephen.smalley.work@gmail.com, 
	casey@schaufler-ca.com, eparis@redhat.com
Cc: eric.snowberg@oracle.com, omosnace@redhat.com, audit@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 5:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On May  6, 2024 GUO Zihua <guozihua@huawei.com> wrote:
> >
> > A panic happens in ima_match_policy:
> >
> > BUG: unable to handle kernel NULL pointer dereference at 00000000000000=
10
> > PGD 42f873067 P4D 0
> > Oops: 0000 [#1] SMP NOPTI
> > CPU: 5 PID: 1286325 Comm: kubeletmonit.sh Kdump: loaded Tainted: P
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06=
/2015
> > RIP: 0010:ima_match_policy+0x84/0x450
> > Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39 7b 18 74 26 41 83=
 ff 05 74 20 48 8b 1b 48 3b 1d f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10 =
74 ea 44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> > RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> > RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> > RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> > R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> > R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> > FS:  00007f5195b51740(0000) GS:ff3e278b12d40000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  ima_get_action+0x22/0x30
> >  process_measurement+0xb0/0x830
> >  ? page_add_file_rmap+0x15/0x170
> >  ? alloc_set_pte+0x269/0x4c0
> >  ? prep_new_page+0x81/0x140
> >  ? simple_xattr_get+0x75/0xa0
> >  ? selinux_file_open+0x9d/0xf0
> >  ima_file_check+0x64/0x90
> >  path_openat+0x571/0x1720
> >  do_filp_open+0x9b/0x110
> >  ? page_counter_try_charge+0x57/0xc0
> >  ? files_cgroup_alloc_fd+0x38/0x60
> >  ? __alloc_fd+0xd4/0x250
> >  ? do_sys_open+0x1bd/0x250
> >  do_sys_open+0x1bd/0x250
> >  do_syscall_64+0x5d/0x1d0
> >  entry_SYSCALL_64_after_hwframe+0x65/0xca
> >
> > Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> > ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
> > RCU read-side critical section which contains kmalloc with GFP_KERNEL.
> > This implies a possible sleep and violates limitations of RCU read-side
> > critical sections on non-PREEMPT systems.
> >
> > Sleeping within RCU read-side critical section might cause
> > synchronize_rcu() returning early and break RCU protection, allowing a
> > UAF to happen.
> >
> > The root cause of this issue could be described as follows:
> > |     Thread A        |       Thread B        |
> > |                     |ima_match_policy       |
> > |                     |  rcu_read_lock        |
> > |ima_lsm_update_rule  |                       |
> > |  synchronize_rcu    |                       |
> > |                     |    kmalloc(GFP_KERNEL)|
> > |                     |      sleep            |
> > =3D=3D> synchronize_rcu returns early
> > |  kfree(entry)               |                       |
> > |                     |    entry =3D entry->next|
> > =3D=3D> UAF happens and entry now becomes NULL (or could be anything).
> > |                     |    entry->action      |
> > =3D=3D> Accessing entry might cause panic.
> >
> > To fix this issue, we are converting all kmalloc that is called within
> > RCU read-side critical section to use GFP_ATOMIC.
> >
> > Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_m=
atch()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: GUO Zihua <guozihua@huawei.com>
> > Acked-by: John Johansen <john.johansen@canonical.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> > v3:
> >   ima_lsm_copy_rule takes a GFP flag as input as well.
> > v2:
> >   Changed the audit_rule_init security hook to accept a new GFP flag, a=
s
> > per Stephen's suggestion.
> >
> > ---
> >  include/linux/lsm_hook_defs.h       |  2 +-
> >  include/linux/security.h            |  5 +++--
> >  kernel/auditfilter.c                |  5 +++--
> >  security/apparmor/audit.c           |  6 +++---
> >  security/apparmor/include/audit.h   |  2 +-
> >  security/integrity/ima/ima_policy.c | 15 +++++++++------
> >  security/security.c                 |  6 ++++--
> >  security/selinux/include/audit.h    |  4 +++-
> >  security/selinux/ss/services.c      |  5 +++--
> >  security/smack/smack_lsm.c          |  3 ++-
> >  10 files changed, 32 insertions(+), 21 deletions(-)
>
> With the exception of one small gotcha (see below), this looks okay to
> me.  At Mimi's request I'm going to merge this into the LSM tree, via
> lsm/stable-6.10, where I'll give it a few days in linux-next before
> sending it up to Linus.

I also had to apply the following fix to this patch to resolve the
!CONFIG_IMA_LSM_RULES ca
se ... grrrrr.

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3e568126cd48..c51e24d24d1e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -546,7 +546,7 @@ static inline void ima_free_modsig(struct modsig *modsi=
g)
#else

static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
-                                      void **lsmrule)
+                                      void **lsmrule, gfp_t gfp)
{
       return -EINVAL;
}

> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 146667937811..a4943628d75a 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -4696,7 +4696,8 @@ static int smack_post_notification(const struct c=
red *w_cred,
> >   * Prepare to audit cases where (@field @op @rulestr) is true.
> >   * The label to be audited is created if necessay.
> >   */
> > -static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, voi=
d **vrule)
> > +static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, voi=
d **vrule,
> > +                              gfp_t gfp)
>
> You forgot to add the new @gfp parameter to the function's header
> comment block.  I'm going to add the following as the text is used in
> other Smack functions, if anyone has any objections please let me know.
>
>   " * @gfp: type of the memory for the allocation"
>
> >  {
> >       struct smack_known *skp;
> >       char **rule =3D (char **)vrule;

--=20
paul-moore.com

