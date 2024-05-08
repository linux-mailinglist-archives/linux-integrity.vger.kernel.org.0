Return-Path: <linux-integrity+bounces-2348-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB438BF892
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 10:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451A52868A6
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84911A28B;
	Wed,  8 May 2024 08:33:12 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4CC4204C;
	Wed,  8 May 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157192; cv=none; b=BfK77fuawm7svT4Lc5w4CuF1Ic4qmSN526N9KfBveZghFnCpfhuDmZKAPGDMd3CLD+aHRyWlnZp4eUOXca9Q7hk3bb38RKaZVIZQIpX9PkCaVkoydIZASuM4pOktpR2vYGH5ddSZEP+agkqfFfxN7w6Gm7jreOxZblwDTnyDBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157192; c=relaxed/simple;
	bh=9ms5LlfVxAFKLR7Uf5CfY/4zS4aJL+/Lgoiq48loue4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d4yru4mz2eq6fjhBOy7LJB214MR3lRkAYtgjquNO0ecB/HdV7lbodXjFCbXJDCE+xEpcCewup7h2hmGM/M9GuGLsHaPENVyuUYSH3Z4ZxAKcLIHmmQCDLus6fO2jGVcnSqVZUh/f607MzUizvaLvar/N6U9P6IE38n2Hzh3aoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VZ7C63vKrz9xGX5;
	Wed,  8 May 2024 16:11:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 4D6261404F5;
	Wed,  8 May 2024 16:32:56 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3LxiuODtmenbDBw--.36633S2;
	Wed, 08 May 2024 09:32:55 +0100 (CET)
Message-ID: <806c5b96130810b9c078b1b0d99a3e90bad6b106.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: Avoid blocking in RCU read-side critical section
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, GUO Zihua
	 <guozihua@huawei.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com,  paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, eric.snowberg@oracle.com,  omosnace@redhat.com,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Date: Wed, 08 May 2024 10:32:42 +0200
In-Reply-To: <CAEjxPJ52FzbBsVfbawiE=fx7UuMNp3pq2xuJnSebcPUhg6gc-A@mail.gmail.com>
References: <20240417074444.2834769-1-guozihua@huawei.com>
	 <CAEjxPJ52FzbBsVfbawiE=fx7UuMNp3pq2xuJnSebcPUhg6gc-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwA3LxiuODtmenbDBw--.36633S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW3Kw1fAFW5Kr1fZw48Crg_yoW7Wr4xpF
	WUKa4jkr48XryUAr17CF1UCr4Y9w4DCF1UWrn7Wr1UCFy5Zw18XrWUJFWY9F95Zr1rur1I
	qrs0qwsYyw1qvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBF1jj50elQABsy

On Fri, 2024-04-19 at 14:41 -0700, Stephen Smalley wrote:
> On Wed, Apr 17, 2024 at 12:49=E2=80=AFAM GUO Zihua <guozihua@huawei.com> =
wrote:
> >=20
> > A panic happens in ima_match_policy:
> >=20
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
> >  ima_file_check+0x64/0x90
> >  path_openat+0x571/0x1720
> >  do_filp_open+0x9b/0x110
> >  do_sys_open+0x1bd/0x250
> >  do_syscall_64+0x5d/0x1d0
> >  entry_SYSCALL_64_after_hwframe+0x65/0xca
> >=20
> > (stack trace marked with ? is deleted)
> >=20
> > Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> > ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
> > RCU read-side critical section which contains kmalloc with GFP_KERNEL.
> > This implies a possible sleep and violates limitations of RCU read-side
> > critical sections on non-PREEMPT systems.
> >=20
> > Sleeping within RCU read-side critical section might cause
> > synchronize_rcu() returning early and break RCU protection, allowing a
> > UAF to happen.
> >=20
> > The root cause of this issue could be described as follows:
> > >       Thread A        |       Thread B        |
> > >                       |ima_match_policy       |
> > >                       |  rcu_read_lock        |
> > > ima_lsm_update_rule    |                       |
> > >  synchronize_rcu      |                       |
> > >                       |    kmalloc(GFP_KERNEL)|
> > >                       |      sleep            |
> > =3D=3D> synchronize_rcu returns early
> > >  kfree(entry)         |                       |
> > >                       |    entry =3D entry->next|
> > =3D=3D> UAF happens and entry now becomes NULL (or could be anything).
> > >                       |    entry->action      |
> > =3D=3D> Accessing entry might cause panic.
> >=20
> > To fix this issue, we are converting all kmalloc that is called within
> > RCU read-side critical section to use GFP_ATOMIC.
> >=20
> > Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_m=
atch()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: GUO Zihua <guozihua@huawei.com>
> > ---
> >  security/integrity/ima/ima_policy.c | 2 +-
> >  security/selinux/ss/services.c      | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/i=
ma/ima_policy.c
> > index c0556907c2e6..c0cf9b6a01f0 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -410,7 +410,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(str=
uct ima_rule_entry *entry)
> >          * Immutable elements are copied over as pointers and data; onl=
y
> >          * lsm rules can change
> >          */
> > -       nentry =3D kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
> > +       nentry =3D kmemdup(entry, sizeof(*nentry), GFP_ATOMIC);
> >         if (!nentry)
> >                 return NULL;
> >=20
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index e88b1b6c4adb..b7cfad1a2964 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -3549,7 +3549,7 @@ int selinux_audit_rule_init(u32 field, u32 op, ch=
ar *rulestr, void **vrule)
> >                 return -EINVAL;
> >         }
> >=20
> > -       tmprule =3D kzalloc(sizeof(struct selinux_audit_rule), GFP_KERN=
EL);
> > +       tmprule =3D kzalloc(sizeof(struct selinux_audit_rule), GFP_ATOM=
IC);
>=20
> I would suggest passing in gfp flags from the callers and only using
> GFP_ATOMIC for the particular call chain that requires atomic
> allocations, or re-factoring the caller to perform the allocating
> operations outside of the critical section.
> Sidebar: the refactoring of the SELinux policy loading logic may have
> made it possible to revisit the approaches here to permit holding a
> reference to the policy from which the rule was derived so that we
> don't have to return -ESTALE in this scenario.

That would be really nice, would simplify the code for us.

I was wondering if the label comparison would be still reliable after a
policy update. I was thinking for example the case where a type is
removed from the newer policy, and that type was used in an IMA rule.

Thanks

Roberto

> >         if (!tmprule)
> >                 return -ENOMEM;
> >         context_init(&tmprule->au_ctxt);
> > --
>=20
> >=20


