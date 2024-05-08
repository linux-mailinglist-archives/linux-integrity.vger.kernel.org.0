Return-Path: <linux-integrity+bounces-2350-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F258C00BD
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 17:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E5AEB20C27
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1C86AF4;
	Wed,  8 May 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXQw1Uh7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D17BB0F;
	Wed,  8 May 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181366; cv=none; b=cOz+sMyDeTaTYacv6N6SU43Or7KK2UqZ8/MGIQSAUA0FfRD5ibrKJ8iw985HFIdcpMOIqitnrnZjh6HCtpIVTKpFjeaR3Tmb0EQ/UhHOESkH86tdwjrMDBXUbvNq4MhG2kXdy+VNH78Frndgn3IWreA24yuWqqmR7SQ5+00X4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181366; c=relaxed/simple;
	bh=pXrFMci5U1DcmT8dEN/S32Hh8nTzGHDxDc7D0gqM0i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SE6HAbf0sTznM2LsBCz7nJn5Dkjrj3UgcdySe+OoNTLt/jpJkEXAMc/6R+3lB8Swr71n96R7qnpUatn2ubgMFedvIv5O5YpXfhg9kHnwyoaqVZRky/XKC1SV5L4/yT/hhhBYgIlTZRUC0hPJv3YKYh5qPfJGhsyzrREbmzUtW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXQw1Uh7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5e152c757a5so2773700a12.2;
        Wed, 08 May 2024 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715181364; x=1715786164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez929IlO1LL7ARl++EL22/ilT/I3v6OPA9Ro65HgCxY=;
        b=EXQw1Uh7ZOPPPCaU9xsS1FV9RlwvXywasCkNYfMpXcL97ILY+ve6BsdCWXqjebquon
         mTan5mVe26D21pwuEtn/IGbi2AEIFCpupGfaAHqfV8vFQZCwS/Qjzjy6cdBiar8mLE/b
         RTNhsuLbOYTWWoR7DknSZ5RJg6r13xHZnG2RXiSQQYfDJLcFJCXjaa259BR8+r2Nz8xe
         vw5s/qyPsky6HbU0fMWmqJHdQ3SE5mGwB4/PSobmTHWYsuKZanZISooBP7sTROcKYQMu
         GR4OZ3YBX5F8hArJgfji28FX4zHYg/sEYWHCtgoRIcxB+s2OR2bbihdCtWCLTd1tTfKN
         KGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715181364; x=1715786164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez929IlO1LL7ARl++EL22/ilT/I3v6OPA9Ro65HgCxY=;
        b=QSRHYAv33hKfU6ti8D0yM/kqGB20j6VTR58i9p4m2IyaqjrfZWXJzQsvPkKUUAZQVJ
         DlR7UTJmbNSr/dUwkKI5ZdNipxOKQ8IFNubYNtXQNau62G86zJSN8wbEw6ZmfRVB35YY
         zFgwsBgtkiFYXeVjGSxTk3djVVNdBM8PbsBnD6pPmcQej+fXsvIdnWcpamlPFUoLnmdy
         Utdxgosu7YE/kHYysg6plLQxyZ/sJBlBjjPr7r/ZIQuiEw9I2swWk+g2REyHHJjadlUB
         f9C20HYzauxPEVUea4zktb5iWOYjDnGRDI6wFPrgF1EsRUnwlCdePW4yVb9u4cAhK2/2
         dgKA==
X-Forwarded-Encrypted: i=1; AJvYcCUUpjV6LLtEfWtA282/ioagCcOec4URQrQLcw0djXIJMpaaCVgk0tcbbSnSwf3N9uYC1+5d9eoATa8zOdlR+h6HE3WcW8VWeQWQ837/ArzLNAMC2xKCdgASmvIVFX5n8KKEoFarhr/3jw==
X-Gm-Message-State: AOJu0YzARZNcxFR2O0B0AUnPj+ooVmTtmeKbHasfmWDU8JM/pASFhnU0
	gh2O5smdcvF2EuSrQeHM3FVeZO7PVIG2I/w3V1ZZzwQzmuOMFnxOqFoWua9TK8bBfGDloZtDOrH
	WcfQR44AbLmlNceU/AVrRLJlHJkA=
X-Google-Smtp-Source: AGHT+IFrUIVMbzKcz7uzd1AMsQKy883KLnb8zgimhFnqyE5rBLDzsCpAvHtyLzALNuxUz3PrqLxs3qGlTfYL4Rxk16I=
X-Received: by 2002:a17:90a:b706:b0:2b2:9a77:3371 with SMTP id
 98e67ed59e1d1-2b6165a0bc4mr2638927a91.12.1715181363721; Wed, 08 May 2024
 08:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417074444.2834769-1-guozihua@huawei.com> <CAEjxPJ52FzbBsVfbawiE=fx7UuMNp3pq2xuJnSebcPUhg6gc-A@mail.gmail.com>
 <806c5b96130810b9c078b1b0d99a3e90bad6b106.camel@huaweicloud.com>
In-Reply-To: <806c5b96130810b9c078b1b0d99a3e90bad6b106.camel@huaweicloud.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 8 May 2024 11:15:51 -0400
Message-ID: <CAEjxPJ4TjB2thTRwy1tRf17RhpLx2Qd+Fo6en=Esrzqyq=NO8Q@mail.gmail.com>
Subject: Re: [PATCH] ima: Avoid blocking in RCU read-side critical section
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: GUO Zihua <guozihua@huawei.com>, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, eric.snowberg@oracle.com, omosnace@redhat.com, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:33=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Fri, 2024-04-19 at 14:41 -0700, Stephen Smalley wrote:
> > On Wed, Apr 17, 2024 at 12:49=E2=80=AFAM GUO Zihua <guozihua@huawei.com=
> wrote:
> > >
> > > A panic happens in ima_match_policy:
> > >
> > > BUG: unable to handle kernel NULL pointer dereference at 000000000000=
0010
> > > PGD 42f873067 P4D 0
> > > Oops: 0000 [#1] SMP NOPTI
> > > CPU: 5 PID: 1286325 Comm: kubeletmonit.sh Kdump: loaded Tainted: P
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/=
06/2015
> > > RIP: 0010:ima_match_policy+0x84/0x450
> > > Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39 7b 18 74 26 41 =
83 ff 05 74 20 48 8b 1b 48 3b 1d f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 1=
0 74 ea 44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> > > RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> > > RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> > > RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> > > R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> > > R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> > > FS:  00007f5195b51740(0000) GS:ff3e278b12d40000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  ima_get_action+0x22/0x30
> > >  process_measurement+0xb0/0x830
> > >  ima_file_check+0x64/0x90
> > >  path_openat+0x571/0x1720
> > >  do_filp_open+0x9b/0x110
> > >  do_sys_open+0x1bd/0x250
> > >  do_syscall_64+0x5d/0x1d0
> > >  entry_SYSCALL_64_after_hwframe+0x65/0xca
> > >
> > > (stack trace marked with ? is deleted)
> > >
> > > Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> > > ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within=
 a
> > > RCU read-side critical section which contains kmalloc with GFP_KERNEL=
.
> > > This implies a possible sleep and violates limitations of RCU read-si=
de
> > > critical sections on non-PREEMPT systems.
> > >
> > > Sleeping within RCU read-side critical section might cause
> > > synchronize_rcu() returning early and break RCU protection, allowing =
a
> > > UAF to happen.
> > >
> > > The root cause of this issue could be described as follows:
> > > >       Thread A        |       Thread B        |
> > > >                       |ima_match_policy       |
> > > >                       |  rcu_read_lock        |
> > > > ima_lsm_update_rule    |                       |
> > > >  synchronize_rcu      |                       |
> > > >                       |    kmalloc(GFP_KERNEL)|
> > > >                       |      sleep            |
> > > =3D=3D> synchronize_rcu returns early
> > > >  kfree(entry)         |                       |
> > > >                       |    entry =3D entry->next|
> > > =3D=3D> UAF happens and entry now becomes NULL (or could be anything)=
.
> > > >                       |    entry->action      |
> > > =3D=3D> Accessing entry might cause panic.
> > >
> > > To fix this issue, we are converting all kmalloc that is called withi=
n
> > > RCU read-side critical section to use GFP_ATOMIC.
> > >
> > > Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule=
_match()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: GUO Zihua <guozihua@huawei.com>
> > > ---
> > >  security/integrity/ima/ima_policy.c | 2 +-
> > >  security/selinux/ss/services.c      | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity=
/ima/ima_policy.c
> > > index c0556907c2e6..c0cf9b6a01f0 100644
> > > --- a/security/integrity/ima/ima_policy.c
> > > +++ b/security/integrity/ima/ima_policy.c
> > > @@ -410,7 +410,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(s=
truct ima_rule_entry *entry)
> > >          * Immutable elements are copied over as pointers and data; o=
nly
> > >          * lsm rules can change
> > >          */
> > > -       nentry =3D kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
> > > +       nentry =3D kmemdup(entry, sizeof(*nentry), GFP_ATOMIC);
> > >         if (!nentry)
> > >                 return NULL;
> > >
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/ser=
vices.c
> > > index e88b1b6c4adb..b7cfad1a2964 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -3549,7 +3549,7 @@ int selinux_audit_rule_init(u32 field, u32 op, =
char *rulestr, void **vrule)
> > >                 return -EINVAL;
> > >         }
> > >
> > > -       tmprule =3D kzalloc(sizeof(struct selinux_audit_rule), GFP_KE=
RNEL);
> > > +       tmprule =3D kzalloc(sizeof(struct selinux_audit_rule), GFP_AT=
OMIC);
> >
> > I would suggest passing in gfp flags from the callers and only using
> > GFP_ATOMIC for the particular call chain that requires atomic
> > allocations, or re-factoring the caller to perform the allocating
> > operations outside of the critical section.
> > Sidebar: the refactoring of the SELinux policy loading logic may have
> > made it possible to revisit the approaches here to permit holding a
> > reference to the policy from which the rule was derived so that we
> > don't have to return -ESTALE in this scenario.
>
> That would be really nice, would simplify the code for us.
>
> I was wondering if the label comparison would be still reliable after a
> policy update. I was thinking for example the case where a type is
> removed from the newer policy, and that type was used in an IMA rule.

The basic idea would be to add a refcount to struct selinux_policy,
add a reference to the corresponding selinux_policy in
selinux_audit_rule (same as for ima), and defer the freeing of the
selinux_policy until the refcount goes to zero. And have
selinux_audit_rule_match() use the policy from the audit rule instead
of the global state/active policy. That said, looking at it again, I'm
not confident that would work since we'd likely end up looking up a
SID from one policy in the SID table of another...

