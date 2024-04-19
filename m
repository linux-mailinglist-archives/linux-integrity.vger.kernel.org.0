Return-Path: <linux-integrity+bounces-2191-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC038AB688
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Apr 2024 23:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4551F22953
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Apr 2024 21:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA5E13CA99;
	Fri, 19 Apr 2024 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNFMQAUy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947BC13C9C8;
	Fri, 19 Apr 2024 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562918; cv=none; b=hMOKt7r8ILWaQ8MeYpNN3Z2Kg51RFcLKtpNtNHmeQrP84CPVvz3pkuYv9Ffb/9dDl2fIECDzuLWjtraSdu/MgKVSaD+wzicGXMtEqhPv7dTt7rkGs7jU93GlS2mxWlMoICnYpvGh4az038nW4yAVDziY/AhjJdaXg6MxKnT7y5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562918; c=relaxed/simple;
	bh=7WjeErgmnMwrBwZrZfqqjuOl1oZSBpV1lbc+9NIEJ0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clR/YWDhVenyeHYiT3pcoTycmGAma2sSZj46D/sPDUrt92Munx0HwR2w/iVDp5EDGmdFGenuPhJC//UwLaGRh22zPZTNbTqYFTTMOxfiXbjyA6KXUDC2Nj8qurchtdKRJzt2yQ7DS5DCoKqdIXXetn0hh1zQsd/zxW8yy4t+8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNFMQAUy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a475bdd4a6so1740405a91.2;
        Fri, 19 Apr 2024 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713562916; x=1714167716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR3+PHWHo6FF5wlrd4ji2ITM8QunpvzwsPz+VIhemHU=;
        b=lNFMQAUyMxg2DDCqLMT83rMQtdjX7cJSwQvqSl/UIM4bf5AzTP0PnJcv6xE4qPbwbq
         /e88xusbb/WFemKEAy2wxAeLzA2HjTn1OfIeNqpk5AiWPcAlo/v9/rb8rV641KaS/6RL
         K3vIcZr4jb5jt+5EfFsH0CHeh5nHGBoKSuvCC1L2LTcE/ufa1npUZYAsJaPTB4gTvKuK
         998IwcoRVf1cSMwDdzROSFB1xG44Fkd15TLp/JXDUce+JtAEBwLtbQxBDV5e4MMi3ume
         Plj3HGlXEdiGGvOi1XdN4yiAoJxFXK+xef+XQo1CQNVj5uAl1VCyUrHjYmMzKiUuyrkF
         r20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713562916; x=1714167716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR3+PHWHo6FF5wlrd4ji2ITM8QunpvzwsPz+VIhemHU=;
        b=G8zVNTvZEBb10GrHMwAFD1L0vj2g5F9HLDh+NTlc0ecuzD5L96yMp2KGRIYgXlT+fj
         loeo+nBCrNDtfl+ax/KUsM+TUSV+aQ4yvBhp4h7uNZFfsI5Apv8DVGouNc2y6jZdA8px
         6tKxWxRMhgI5EjCMXQ24u9d4ZTMBic61K9DqQC3sRf7EOXiaOLKjx+0VPMUv3jJynfQ0
         OSm+IkzRsmzpYS9p8/dcSh4kGAKub+/GSusfkrEC3AG/HshBp364VQP6x0qfysJm5J6z
         SpU7+Bl/tqxTMyjrzF8xUxRVo1ko8IeH0VMXClCqnTnICVlYSACq4gMTXi/b8yVp3FZF
         tNBA==
X-Forwarded-Encrypted: i=1; AJvYcCXhUX7/iB/oHb2nBnP0GT1HSq10oVjDX8pVpijxqOaTEZj9hwONzpZPJnOE9u1egAtFqhTQfQJCjTsWTYVFqmwGMWD0Rg0eoOcM+KGvxkAzVtkTdlJcJ1cIAGxnomPfzWFqKUzEHK0ibA==
X-Gm-Message-State: AOJu0YyPSLi3EHIDB4b6J+Imr+KLT1LVNmWuWAVU07Fk9pBFOFNb5/tB
	25lDyv+iX3yp7oq4pHpIKx/e2fXxy6dzifcvaz0SCRh7CckPtwvy0aG8PAc/y8uDk9axpS4kC/y
	Z33YLd0Qj6yA/KKWDbNTlpcFQFARQsw==
X-Google-Smtp-Source: AGHT+IEapMbgUnYi3uwcwYKXa5MrZ0JfPCLOAed0kmsL5AqvZldygO6R9+crS/BY1jh/qQGdFfwrO1Kqa2pNEmCJ43c=
X-Received: by 2002:a17:90a:7d0f:b0:2aa:ead0:900c with SMTP id
 g15-20020a17090a7d0f00b002aaead0900cmr3321945pjl.24.1713562915770; Fri, 19
 Apr 2024 14:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417074444.2834769-1-guozihua@huawei.com>
In-Reply-To: <20240417074444.2834769-1-guozihua@huawei.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 19 Apr 2024 14:41:43 -0700
Message-ID: <CAEjxPJ52FzbBsVfbawiE=fx7UuMNp3pq2xuJnSebcPUhg6gc-A@mail.gmail.com>
Subject: Re: [PATCH] ima: Avoid blocking in RCU read-side critical section
To: GUO Zihua <guozihua@huawei.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	eric.snowberg@oracle.com, omosnace@redhat.com, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 12:49=E2=80=AFAM GUO Zihua <guozihua@huawei.com> wr=
ote:
>
> A panic happens in ima_match_policy:
>
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> PGD 42f873067 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 5 PID: 1286325 Comm: kubeletmonit.sh Kdump: loaded Tainted: P
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2=
015
> RIP: 0010:ima_match_policy+0x84/0x450
> Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39 7b 18 74 26 41 83 f=
f 05 74 20 48 8b 1b 48 3b 1d f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10 74=
 ea 44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> FS:  00007f5195b51740(0000) GS:ff3e278b12d40000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ima_get_action+0x22/0x30
>  process_measurement+0xb0/0x830
>  ima_file_check+0x64/0x90
>  path_openat+0x571/0x1720
>  do_filp_open+0x9b/0x110
>  do_sys_open+0x1bd/0x250
>  do_syscall_64+0x5d/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
>
> (stack trace marked with ? is deleted)
>
> Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
> RCU read-side critical section which contains kmalloc with GFP_KERNEL.
> This implies a possible sleep and violates limitations of RCU read-side
> critical sections on non-PREEMPT systems.
>
> Sleeping within RCU read-side critical section might cause
> synchronize_rcu() returning early and break RCU protection, allowing a
> UAF to happen.
>
> The root cause of this issue could be described as follows:
> |       Thread A        |       Thread B        |
> |                       |ima_match_policy       |
> |                       |  rcu_read_lock        |
> |ima_lsm_update_rule    |                       |
> |  synchronize_rcu      |                       |
> |                       |    kmalloc(GFP_KERNEL)|
> |                       |      sleep            |
> =3D=3D> synchronize_rcu returns early
> |  kfree(entry)         |                       |
> |                       |    entry =3D entry->next|
> =3D=3D> UAF happens and entry now becomes NULL (or could be anything).
> |                       |    entry->action      |
> =3D=3D> Accessing entry might cause panic.
>
> To fix this issue, we are converting all kmalloc that is called within
> RCU read-side critical section to use GFP_ATOMIC.
>
> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_mat=
ch()")
> Cc: stable@vger.kernel.org
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>  security/integrity/ima/ima_policy.c | 2 +-
>  security/selinux/ss/services.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index c0556907c2e6..c0cf9b6a01f0 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -410,7 +410,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struc=
t ima_rule_entry *entry)
>          * Immutable elements are copied over as pointers and data; only
>          * lsm rules can change
>          */
> -       nentry =3D kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
> +       nentry =3D kmemdup(entry, sizeof(*nentry), GFP_ATOMIC);
>         if (!nentry)
>                 return NULL;
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index e88b1b6c4adb..b7cfad1a2964 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3549,7 +3549,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char=
 *rulestr, void **vrule)
>                 return -EINVAL;
>         }
>
> -       tmprule =3D kzalloc(sizeof(struct selinux_audit_rule), GFP_KERNEL=
);
> +       tmprule =3D kzalloc(sizeof(struct selinux_audit_rule), GFP_ATOMIC=
);

I would suggest passing in gfp flags from the callers and only using
GFP_ATOMIC for the particular call chain that requires atomic
allocations, or re-factoring the caller to perform the allocating
operations outside of the critical section.
Sidebar: the refactoring of the SELinux policy loading logic may have
made it possible to revisit the approaches here to permit holding a
reference to the policy from which the rule was derived so that we
don't have to return -ESTALE in this scenario.

>         if (!tmprule)
>                 return -ENOMEM;
>         context_init(&tmprule->au_ctxt);
> --

>

