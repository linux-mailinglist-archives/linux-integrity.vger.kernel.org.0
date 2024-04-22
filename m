Return-Path: <linux-integrity+bounces-2195-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B78ACCAC
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Apr 2024 14:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072FCB210D5
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Apr 2024 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAC114658C;
	Mon, 22 Apr 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny8weuof"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6841DFF7;
	Mon, 22 Apr 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788319; cv=none; b=PHtELN6rafmPAMlzEf41C8sDHttbz2b1b6AeN1uvtNssNy/r/W07Sd5le8PD0J/RsFpJp2rMIjXT9u2bwwKz+OT9cgQaaKaaP89jiwsseL3zZxkWBTg9H406LvBSqtOVHaNmNj/op+lhz9mtM1a3Mmz/2M2BgCZDCMZZmAtLJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788319; c=relaxed/simple;
	bh=j8TgBFrivvgjzKBW51Wg8d3smXh8H/1kSuvvJ8UmWLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2fLhGGidSYmrd1zxQqTZXmiCVdh54pheMbkko2SjxZgnJ+P2t+9vJxljIrtw6hQtxEszZ8vLy+V5aYLACyaQW8B7QsF6dp4Ql5fMgKe8+CH6YZvrZyY6/q9Xoo4sHjXoRQteAqvP5TG76NxLkJH4cLxPo5eb1Cb4ddXxqvzQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny8weuof; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a559928f46so2764278a91.0;
        Mon, 22 Apr 2024 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713788317; x=1714393117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzFCQ+97/iSVNs4/oCoFAzKjqkTWCfig8Fd2mmhZw/s=;
        b=Ny8weuofRKgp84HwITdHVTWhkE7Wj1pGu/zSxpgQdk8P2kkHBS81AZzHM4ZcOfgStV
         fw5QeO9FdFcsWx7rWYCNDIRKrRzbWsy9/bVm3iAxUFV3YXSs+jrLKGDSsr794LHzdu2Z
         IRAuq01nz7qHfs2hVv/CqZWdPbamcUzZxeT7YbJ/3IJIyAEmtcUaL16yms8ebtuysUt4
         V1fnU66ZCqkjG734P8yM8PxVwYiPcEf1/GjV3MBZu84kw9x7S8woXdbqnmRd6lFotlka
         ygkqNinKwC1VMMLWjqAV4mjLkd+mH9BF2RysTz/iQAHiw7XCUNta7CWiJD0TnaJr5LbH
         7Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713788317; x=1714393117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzFCQ+97/iSVNs4/oCoFAzKjqkTWCfig8Fd2mmhZw/s=;
        b=HhiT4dHcn3p11QzcvV6cJ2CRaqzzEuwWKAeb/oVa6dVzMGyeingeBqJB1qTvjlB9hv
         /Sp9WVBDL8mgdoOL+1KCLKdAvQN2y8gEy9E3XU4rzVnuPqzlBOjH6/Yvdc5m+vPPqfrA
         oi8B2DK/qowVNhTijugFcc3iTA+LhHhQwW+r5/lQEcNLbScKc85ISEzWz1TPT3PyMnF+
         D+ROkLFxvdxZDLGbi2FL+NSBECD2h5xWvYPkRnm0JXWzi68R2AZoFCUks88h8gEgxuUp
         wo+FkLG/JWPbtyY/6Ok/pbh1Ogts4GVmy94RA+XCRmop+zMbCH3iqywbQsgmpYzPz0xE
         6R1A==
X-Forwarded-Encrypted: i=1; AJvYcCXNC2w6N1n7UXv7M6BGk7tSohe8T7zMKZqatcmnJtwqP6fCNxYAfsMpuxZQM5Zb89HTP5NTIaSvOa56/JN1jjbRWPo6rYOqE63rcdJi7U8Xb/j3zkm0zA2/LuXcZcMG9wIJiwmoUvWTtA==
X-Gm-Message-State: AOJu0Yz6TqXfuGUYx+b5Bkic+gXbOspezNApT6dk4A2IQfAgfTMz/s+0
	QSIVulRahRANiAgLGv1ZwAkt3BDgntWvwJv5yhzMDbKAOcng6nJQHEGz3+DRjhp6NGijCZlYt2u
	Mgk8Ta+0C2kxmx19kxO8yglFF8Nk=
X-Google-Smtp-Source: AGHT+IEWu8NgPl2SWtVZEvbDa6PYnqtUDYhkSPSo04L0ziNHYrZfzm6NH/vJVNgwKdrwc0JDRPxi3XbhEy3INi2V/V4=
X-Received: by 2002:a17:90a:3481:b0:2a4:9836:aa2c with SMTP id
 p1-20020a17090a348100b002a49836aa2cmr7870858pjb.28.1713788317096; Mon, 22 Apr
 2024 05:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417074444.2834769-1-guozihua@huawei.com> <CAEjxPJ52FzbBsVfbawiE=fx7UuMNp3pq2xuJnSebcPUhg6gc-A@mail.gmail.com>
 <8b814f56-3987-5503-313d-fc3c3104e028@huawei.com>
In-Reply-To: <8b814f56-3987-5503-313d-fc3c3104e028@huawei.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Apr 2024 08:18:25 -0400
Message-ID: <CAEjxPJ7mTgOG=POD0XfSmnE-vFx5wXT2TRnx_DoTPW6QNoGAMg@mail.gmail.com>
Subject: Re: [PATCH] ima: Avoid blocking in RCU read-side critical section
To: "Guozihua (Scott)" <guozihua@huawei.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	eric.snowberg@oracle.com, omosnace@redhat.com, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 9:26=E2=80=AFPM Guozihua (Scott) <guozihua@huawei.c=
om> wrote:
>
> On 2024/4/20 5:41, Stephen Smalley wrote:
> > On Wed, Apr 17, 2024 at 12:49=E2=80=AFAM GUO Zihua <guozihua@huawei.com=
> wrote:
> >>
> >> A panic happens in ima_match_policy:
> >>
> >> BUG: unable to handle kernel NULL pointer dereference at 0000000000000=
010
> >> PGD 42f873067 P4D 0
> >> Oops: 0000 [#1] SMP NOPTI
> >> CPU: 5 PID: 1286325 Comm: kubeletmonit.sh Kdump: loaded Tainted: P
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/0=
6/2015
> >> RIP: 0010:ima_match_policy+0x84/0x450
> >> Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39 7b 18 74 26 41 8=
3 ff 05 74 20 48 8b 1b 48 3b 1d f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10=
 74 ea 44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> >> RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> >> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> >> RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> >> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> >> R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> >> R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> >> FS:  00007f5195b51740(0000) GS:ff3e278b12d40000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>  ima_get_action+0x22/0x30
> >>  process_measurement+0xb0/0x830
> >>  ima_file_check+0x64/0x90
> >>  path_openat+0x571/0x1720
> >>  do_filp_open+0x9b/0x110
> >>  do_sys_open+0x1bd/0x250
> >>  do_syscall_64+0x5d/0x1d0
> >>  entry_SYSCALL_64_after_hwframe+0x65/0xca
> >>
> >> (stack trace marked with ? is deleted)
> >>
> >> Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> >> ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within =
a
> >> RCU read-side critical section which contains kmalloc with GFP_KERNEL.
> >> This implies a possible sleep and violates limitations of RCU read-sid=
e
> >> critical sections on non-PREEMPT systems.
> >>
> >> Sleeping within RCU read-side critical section might cause
> >> synchronize_rcu() returning early and break RCU protection, allowing a
> >> UAF to happen.
> >>
> >> The root cause of this issue could be described as follows:
> >> |       Thread A        |       Thread B        |
> >> |                       |ima_match_policy       |
> >> |                       |  rcu_read_lock        |
> >> |ima_lsm_update_rule    |                       |
> >> |  synchronize_rcu      |                       |
> >> |                       |    kmalloc(GFP_KERNEL)|
> >> |                       |      sleep            |
> >> =3D=3D> synchronize_rcu returns early
> >> |  kfree(entry)         |                       |
> >> |                       |    entry =3D entry->next|
> >> =3D=3D> UAF happens and entry now becomes NULL (or could be anything).
> >> |                       |    entry->action      |
> >> =3D=3D> Accessing entry might cause panic.
> >>
> >> To fix this issue, we are converting all kmalloc that is called within
> >> RCU read-side critical section to use GFP_ATOMIC.
> >>
> >> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_=
match()")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> >> ---
> >>  security/integrity/ima/ima_policy.c | 2 +-
> >>  security/selinux/ss/services.c      | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/=
ima/ima_policy.c
> >> index c0556907c2e6..c0cf9b6a01f0 100644
> >> --- a/security/integrity/ima/ima_policy.c
> >> +++ b/security/integrity/ima/ima_policy.c
> >> @@ -410,7 +410,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(st=
ruct ima_rule_entry *entry)
> >>          * Immutable elements are copied over as pointers and data; on=
ly
> >>          * lsm rules can change
> >>          */
> >> -       nentry =3D kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
> >> +       nentry =3D kmemdup(entry, sizeof(*nentry), GFP_ATOMIC);
> >>         if (!nentry)
> >>                 return NULL;
> >>
> >> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/serv=
ices.c
> >> index e88b1b6c4adb..b7cfad1a2964 100644
> >> --- a/security/selinux/ss/services.c
> >> +++ b/security/selinux/ss/services.c
> >> @@ -3549,7 +3549,7 @@ int selinux_audit_rule_init(u32 field, u32 op, c=
har *rulestr, void **vrule)
> >>                 return -EINVAL;
> >>         }
> >>
> >> -       tmprule =3D kzalloc(sizeof(struct selinux_audit_rule), GFP_KER=
NEL);
> >> +       tmprule =3D kzalloc(sizeof(struct selinux_audit_rule), GFP_ATO=
MIC);
> >
> > I would suggest passing in gfp flags from the callers and only using
> > GFP_ATOMIC for the particular call chain that requires atomic
> > allocations, or re-factoring the caller to perform the allocating
> > operations outside of the critical section.
>
> Well unfortunately the SELinux involved in this patch is called via
> security hooks. Adding new flags would mean define macros as well as all
> the callers and implementations would have to be changed.

That is ok if it is what is required to fix this correctly. However,
if you can re-factor the caller to move the allocation outside of the
RCU read lock, or eliminate the need for an allocation altogether,
that would be better.

> > Sidebar: the refactoring of the SELinux policy loading logic may have
> > made it possible to revisit the approaches here to permit holding a
> > reference to the policy from which the rule was derived so that we
> > don't have to return -ESTALE in this scenario.
>
> This would be nice if we are able to make this re-init happen in-place
> which would spare IMA from initializing a temporary rule and the list
> replace behavior.

Yes, that would be best if possible.

