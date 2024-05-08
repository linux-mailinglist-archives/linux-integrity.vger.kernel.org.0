Return-Path: <linux-integrity+bounces-2351-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EAF8C00DE
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 17:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C431C20C14
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF76126F1D;
	Wed,  8 May 2024 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpJlRgcy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5523B54FA3;
	Wed,  8 May 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181922; cv=none; b=qTIPkWy3gOm69As9n8POPWbVxmmibbR6tdJayMQM+12eTLuZqlqLdI0jHsrJ7qgyPN46eVlUywT4qmZJkDIk3yF2cQ+i74sgdIXT1epfOuHVrZU2T8QwEvfGA2ZBiSfXGob/DslFtqevEk44hQfFybw9GhWamI8rkTaom72GMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181922; c=relaxed/simple;
	bh=nfH5tt85PEkL9HFAu6ArAMYmW/z346iBmFiC1dAWbrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANvD7PzORCpUwSrg0o26WvlQ9CLRtEmXCVBMl/HM8iUSdtRmiJIjcsxgZswK/vMdjDfzeCmGTMGAgCEp0HBxypIttWjBEOSXJ4DPQbc8Hgf0devnUxEaBK03rSBckqoC7Xl/JlCRm8U5N0jOUg0C4KBrU0tWoWJqPnnn4vBbPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpJlRgcy; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so3422900a12.3;
        Wed, 08 May 2024 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715181920; x=1715786720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crcoThiWRI8c4/shk5YxoeZCCzFE0m6QaRrgFocug0U=;
        b=EpJlRgcy6tESKgRMLGnLFlhQFedUCzdJ/Ri3K7Y8KExLwcEVfFj8Gmwe/nxr9HRke5
         61FgmcemP0VIEsN1p82LIsLPS+75HikLvzJjNojIluKjS/BtEkouzyU0lBm/5a3Bwr7F
         j6ZRSqq/je5fW6qUpElI5+s3FSnDIltjyDFrq8b42q5fKYp4VWPc7p4+6ezV5VikqRxN
         3VKCOWpfJ9JkoHVXJutwWJIiprX6hL6KzH58+zwiH7wQgF6EhJ1VaIrh7+1J278BVZIu
         h76rl3p09Qq4JV0Fc9Qu3NEpz0ryPJosuChUTCM03VThS7OMBFCZfMxBmuVyGUF4kU/l
         iB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715181920; x=1715786720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crcoThiWRI8c4/shk5YxoeZCCzFE0m6QaRrgFocug0U=;
        b=XyyvrrgzEoxUTwiVTDRiogBoraxmdwnd+ko7LmULqCDXOsIznPAtQrta1xb6ZwD/fd
         opiqGMlQFaBlRRGUkKDJtX2TUK9/3vYPZ/bR2TPYBraXKDP/1mYnT9UL44ehpwX0mFCI
         fgQfXrYFT5RC5hjMQKcIgWpD/I3iW593laeghjFY0enw+Vwihclo+o490aAtaqDl692i
         vXJjh7m8X53XRXM3jcCjh6S83/Tm8VKxQsKo4ZVHXQ8JcadRUTHZpFwgn3ZGVu1WupHt
         6XOmgSTN4SOvHHYh8j2/GH8AWWIM+AxRWvaURNR3Rx3lA5zS7rNSUGHZ3WXDKSD9mxp+
         BcQg==
X-Forwarded-Encrypted: i=1; AJvYcCVoocDoDYDz5CDVCERTcDCX3y4Bm2p6rrm7fD5s7ns98vEwDrchGLdBwAKrTKscpmcFi9KPU4nJmlEi0XJSqJyNx3HJs6UgOgG8SJtGl/fRXB4yCKnWpYlGO8YjHpx1IXDk9I8mIMb73Q==
X-Gm-Message-State: AOJu0YyC1tz6gI4H2wZ2sOukbf+LUdg9FQGVhLoPqlDBCaAvvlhUchSF
	BExKwo+20PB9MAX/jPAIFkhAxgIZ9ByvRk8SjIska1E8EwOsIYkoUf1FAIFVZWVV9W4PxkH3Qu4
	mVf8K5Bc6NTaKcYbWwz63SIiJgm4=
X-Google-Smtp-Source: AGHT+IF3TLeT5qCjdC5WQJ84TW7aBr38P3pXa84kY9r6S+HGf/fdUcZO2VFQR8mpu4kAUHaAwm/zRsbV20fcqaF25xo=
X-Received: by 2002:a17:90a:d90e:b0:2ae:9176:f928 with SMTP id
 98e67ed59e1d1-2b6165a143amr2726320a91.15.1715181920553; Wed, 08 May 2024
 08:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417074444.2834769-1-guozihua@huawei.com> <CAEjxPJ52FzbBsVfbawiE=fx7UuMNp3pq2xuJnSebcPUhg6gc-A@mail.gmail.com>
 <806c5b96130810b9c078b1b0d99a3e90bad6b106.camel@huaweicloud.com> <CAEjxPJ4TjB2thTRwy1tRf17RhpLx2Qd+Fo6en=Esrzqyq=NO8Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4TjB2thTRwy1tRf17RhpLx2Qd+Fo6en=Esrzqyq=NO8Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 8 May 2024 11:25:08 -0400
Message-ID: <CAEjxPJ5bWwEhZdpcT8A2airYYyDrxfv_KZDmqCh+WvO4+REYoQ@mail.gmail.com>
Subject: Re: [PATCH] ima: Avoid blocking in RCU read-side critical section
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: GUO Zihua <guozihua@huawei.com>, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, eric.snowberg@oracle.com, omosnace@redhat.com, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 11:15=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, May 8, 2024 at 4:33=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > On Fri, 2024-04-19 at 14:41 -0700, Stephen Smalley wrote:
> > > On Wed, Apr 17, 2024 at 12:49=E2=80=AFAM GUO Zihua <guozihua@huawei.c=
om> wrote:
> > > >
> > > > A panic happens in ima_match_policy:
> > > >
> > > > BUG: unable to handle kernel NULL pointer dereference at 0000000000=
000010
> > > > PGD 42f873067 P4D 0
> > > > Oops: 0000 [#1] SMP NOPTI
> > > > CPU: 5 PID: 1286325 Comm: kubeletmonit.sh Kdump: loaded Tainted: P
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 0=
2/06/2015
> > > > RIP: 0010:ima_match_policy+0x84/0x450
> > > > Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39 7b 18 74 26 4=
1 83 ff 05 74 20 48 8b 1b 48 3b 1d f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73=
 10 74 ea 44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> > > > RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> > > > RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> > > > RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> > > > R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> > > > R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> > > > FS:  00007f5195b51740(0000) GS:ff3e278b12d40000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  ima_get_action+0x22/0x30
> > > >  process_measurement+0xb0/0x830
> > > >  ima_file_check+0x64/0x90
> > > >  path_openat+0x571/0x1720
> > > >  do_filp_open+0x9b/0x110
> > > >  do_sys_open+0x1bd/0x250
> > > >  do_syscall_64+0x5d/0x1d0
> > > >  entry_SYSCALL_64_after_hwframe+0x65/0xca
> > > >
> > > > (stack trace marked with ? is deleted)
> > > >
> > > > Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> > > > ima_filter_rule_match()") introduced call to ima_lsm_copy_rule with=
in a
> > > > RCU read-side critical section which contains kmalloc with GFP_KERN=
EL.
> > > > This implies a possible sleep and violates limitations of RCU read-=
side
> > > > critical sections on non-PREEMPT systems.
> > > >
> > > > Sleeping within RCU read-side critical section might cause
> > > > synchronize_rcu() returning early and break RCU protection, allowin=
g a
> > > > UAF to happen.
> > > >
> > > > The root cause of this issue could be described as follows:
> > > > >       Thread A        |       Thread B        |
> > > > >                       |ima_match_policy       |
> > > > >                       |  rcu_read_lock        |
> > > > > ima_lsm_update_rule    |                       |
> > > > >  synchronize_rcu      |                       |
> > > > >                       |    kmalloc(GFP_KERNEL)|
> > > > >                       |      sleep            |
> > > > =3D=3D> synchronize_rcu returns early
> > > > >  kfree(entry)         |                       |
> > > > >                       |    entry =3D entry->next|
> > > > =3D=3D> UAF happens and entry now becomes NULL (or could be anythin=
g).
> > > > >                       |    entry->action      |
> > > > =3D=3D> Accessing entry might cause panic.
> > > >
> > > > To fix this issue, we are converting all kmalloc that is called wit=
hin
> > > > RCU read-side critical section to use GFP_ATOMIC.
> > > >
> > > > Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_ru=
le_match()")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: GUO Zihua <guozihua@huawei.com>
> > > > ---
> > > >  security/integrity/ima/ima_policy.c | 2 +-
> > > >  security/selinux/ss/services.c      | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/security/integrity/ima/ima_policy.c b/security/integri=
ty/ima/ima_policy.c
> > > > index c0556907c2e6..c0cf9b6a01f0 100644
> > > > --- a/security/integrity/ima/ima_policy.c
> > > > +++ b/security/integrity/ima/ima_policy.c
> > > > @@ -410,7 +410,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule=
(struct ima_rule_entry *entry)
> > > >          * Immutable elements are copied over as pointers and data;=
 only
> > > >          * lsm rules can change
> > > >          */
> > > > -       nentry =3D kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
> > > > +       nentry =3D kmemdup(entry, sizeof(*nentry), GFP_ATOMIC);
> > > >         if (!nentry)
> > > >                 return NULL;
> > > >
> > > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/s=
ervices.c
> > > > index e88b1b6c4adb..b7cfad1a2964 100644
> > > > --- a/security/selinux/ss/services.c
> > > > +++ b/security/selinux/ss/services.c
> > > > @@ -3549,7 +3549,7 @@ int selinux_audit_rule_init(u32 field, u32 op=
, char *rulestr, void **vrule)
> > > >                 return -EINVAL;
> > > >         }
> > > >
> > > > -       tmprule =3D kzalloc(sizeof(struct selinux_audit_rule), GFP_=
KERNEL);
> > > > +       tmprule =3D kzalloc(sizeof(struct selinux_audit_rule), GFP_=
ATOMIC);
> > >
> > > I would suggest passing in gfp flags from the callers and only using
> > > GFP_ATOMIC for the particular call chain that requires atomic
> > > allocations, or re-factoring the caller to perform the allocating
> > > operations outside of the critical section.
> > > Sidebar: the refactoring of the SELinux policy loading logic may have
> > > made it possible to revisit the approaches here to permit holding a
> > > reference to the policy from which the rule was derived so that we
> > > don't have to return -ESTALE in this scenario.
> >
> > That would be really nice, would simplify the code for us.
> >
> > I was wondering if the label comparison would be still reliable after a
> > policy update. I was thinking for example the case where a type is
> > removed from the newer policy, and that type was used in an IMA rule.
>
> The basic idea would be to add a refcount to struct selinux_policy,
> add a reference to the corresponding selinux_policy in
> selinux_audit_rule (same as for ima), and defer the freeing of the
> selinux_policy until the refcount goes to zero. And have
> selinux_audit_rule_match() use the policy from the audit rule instead
> of the global state/active policy. That said, looking at it again, I'm
> not confident that would work since we'd likely end up looking up a
> SID from one policy in the SID table of another...

Actually, that might be ok since on policy reload we convert over all
existing SIDs, so the SIDs themselves don't change.
So we'd look up the SID in the old policy's SID table, obtaining its
old user/role/type/level values, and compare against the values in the
audit rule created from the old policy.
In theory, that should work. YMMV.

