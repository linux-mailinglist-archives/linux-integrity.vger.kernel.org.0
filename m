Return-Path: <linux-integrity+bounces-2860-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A0090895A
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2024 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7174AB275F5
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2024 10:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC411922DB;
	Fri, 14 Jun 2024 10:08:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F913B7BC;
	Fri, 14 Jun 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359706; cv=none; b=ryCqTPcFk2Jhc5ZaBfYzZQF7S9YhRPBGKIJmD4JpBb7TxzwbzmqlKHKcpp1nOD85CnydMhmsjgEUGNQ0xRdDKEtogKAuaLYwKoYQcqd5blRd8MTF/z9SQsmBKQEjuc+ed8cK8ayWPVOpObYJts1glAYKMSn2cHjDL5kjEsF02tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359706; c=relaxed/simple;
	bh=Vjs0i/0wD1zfFuu4U1L5IftZy/BR2wHBuwrKKTjKJ+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uPc9vpoib/kVEeKOfk1B5RvzmlXMuP96bsWRUTh7PUZfVGC+CQJuoq3bdW+L/U60V4sPZ2pYhlK/7h+3xJlcxdszO7XiGUwzEtuSt9MbYbE5cSSJdMAKm4qK3MA2n5rnp0gd4YBbpcefinWks81zl8944XO7a9UAcQsZ9reRBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4W0vGF6fwHz9v7Hk;
	Fri, 14 Jun 2024 17:33:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A1FE21404F0;
	Fri, 14 Jun 2024 17:50:44 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCHDjleEmxmCXJlAA--.52264S2;
	Fri, 14 Jun 2024 10:50:43 +0100 (CET)
Message-ID: <8e898e2f5ae479ab08be61048481404d12cb6ea4.camel@huaweicloud.com>
Subject: Re: [PATCH v3] ima: Avoid blocking in RCU read-side critical section
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, GUO Zihua <guozihua@huawei.com>, 
	john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	stephen.smalley.work@gmail.com, casey@schaufler-ca.com, eparis@redhat.com
Cc: eric.snowberg@oracle.com, omosnace@redhat.com, audit@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Date: Fri, 14 Jun 2024 11:50:18 +0200
In-Reply-To: <CAHC9VhRqvBsdy+U-wr+X6QmawLv6DnB32nwAO7Ex6L7cdR=mSg@mail.gmail.com>
References: <20240507012541.796421-1-guozihua@huawei.com>
	 <00d88046025c611f2bf94708ffc65ecc@paul-moore.com>
	 <CAHC9VhRqvBsdy+U-wr+X6QmawLv6DnB32nwAO7Ex6L7cdR=mSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCHDjleEmxmCXJlAA--.52264S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWfJFy5WF4DWFykWF1kGrg_yoWxGr45pF
	WUKF1jkr48JFyUArsFvrnFgF1j93yUCF1UXrn3ur1UAF9IqF1kGr17Jr1jkry5Xr4rCr1I
	qrsFqwsI9r1qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj58tDQABsE

On Thu, 2024-06-13 at 14:26 -0400, Paul Moore wrote:
> On Wed, Jun 12, 2024 at 5:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On May  6, 2024 GUO Zihua <guozihua@huawei.com> wrote:
> > >=20
> > > A panic happens in ima_match_policy:
> > >=20
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
> > >  ? page_add_file_rmap+0x15/0x170
> > >  ? alloc_set_pte+0x269/0x4c0
> > >  ? prep_new_page+0x81/0x140
> > >  ? simple_xattr_get+0x75/0xa0
> > >  ? selinux_file_open+0x9d/0xf0
> > >  ima_file_check+0x64/0x90
> > >  path_openat+0x571/0x1720
> > >  do_filp_open+0x9b/0x110
> > >  ? page_counter_try_charge+0x57/0xc0
> > >  ? files_cgroup_alloc_fd+0x38/0x60
> > >  ? __alloc_fd+0xd4/0x250
> > >  ? do_sys_open+0x1bd/0x250
> > >  do_sys_open+0x1bd/0x250
> > >  do_syscall_64+0x5d/0x1d0
> > >  entry_SYSCALL_64_after_hwframe+0x65/0xca
> > >=20
> > > Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> > > ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within=
 a
> > > RCU read-side critical section which contains kmalloc with GFP_KERNEL=
.
> > > This implies a possible sleep and violates limitations of RCU read-si=
de
> > > critical sections on non-PREEMPT systems.
> > >=20
> > > Sleeping within RCU read-side critical section might cause
> > > synchronize_rcu() returning early and break RCU protection, allowing =
a
> > > UAF to happen.
> > >=20
> > > The root cause of this issue could be described as follows:
> > > >     Thread A        |       Thread B        |
> > > >                     |ima_match_policy       |
> > > >                     |  rcu_read_lock        |
> > > > ima_lsm_update_rule  |                       |
> > > >  synchronize_rcu    |                       |
> > > >                     |    kmalloc(GFP_KERNEL)|
> > > >                     |      sleep            |
> > > =3D=3D> synchronize_rcu returns early
> > > >  kfree(entry)               |                       |
> > > >                     |    entry =3D entry->next|
> > > =3D=3D> UAF happens and entry now becomes NULL (or could be anything)=
.
> > > >                     |    entry->action      |
> > > =3D=3D> Accessing entry might cause panic.
> > >=20
> > > To fix this issue, we are converting all kmalloc that is called withi=
n
> > > RCU read-side critical section to use GFP_ATOMIC.
> > >=20
> > > Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule=
_match()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: GUO Zihua <guozihua@huawei.com>
> > > Acked-by: John Johansen <john.johansen@canonical.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > ---
> > > v3:
> > >   ima_lsm_copy_rule takes a GFP flag as input as well.
> > > v2:
> > >   Changed the audit_rule_init security hook to accept a new GFP flag,=
 as
> > > per Stephen's suggestion.
> > >=20
> > > ---
> > >  include/linux/lsm_hook_defs.h       |  2 +-
> > >  include/linux/security.h            |  5 +++--
> > >  kernel/auditfilter.c                |  5 +++--
> > >  security/apparmor/audit.c           |  6 +++---
> > >  security/apparmor/include/audit.h   |  2 +-
> > >  security/integrity/ima/ima_policy.c | 15 +++++++++------
> > >  security/security.c                 |  6 ++++--
> > >  security/selinux/include/audit.h    |  4 +++-
> > >  security/selinux/ss/services.c      |  5 +++--
> > >  security/smack/smack_lsm.c          |  3 ++-
> > >  10 files changed, 32 insertions(+), 21 deletions(-)
> >=20
> > With the exception of one small gotcha (see below), this looks okay to
> > me.  At Mimi's request I'm going to merge this into the LSM tree, via
> > lsm/stable-6.10, where I'll give it a few days in linux-next before
> > sending it up to Linus.
>=20
> I also had to apply the following fix to this patch to resolve the
> !CONFIG_IMA_LSM_RULES ca
> se ... grrrrr.

Argh, sorry...

Thanks Paul!

Roberto

> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 3e568126cd48..c51e24d24d1e 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -546,7 +546,7 @@ static inline void ima_free_modsig(struct modsig *mod=
sig)
> #else
>=20
> static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> -                                      void **lsmrule)
> +                                      void **lsmrule, gfp_t gfp)
> {
>        return -EINVAL;
> }
>=20
> > > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > > index 146667937811..a4943628d75a 100644
> > > --- a/security/smack/smack_lsm.c
> > > +++ b/security/smack/smack_lsm.c
> > > @@ -4696,7 +4696,8 @@ static int smack_post_notification(const struct=
 cred *w_cred,
> > >   * Prepare to audit cases where (@field @op @rulestr) is true.
> > >   * The label to be audited is created if necessay.
> > >   */
> > > -static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, v=
oid **vrule)
> > > +static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, v=
oid **vrule,
> > > +                              gfp_t gfp)
> >=20
> > You forgot to add the new @gfp parameter to the function's header
> > comment block.  I'm going to add the following as the text is used in
> > other Smack functions, if anyone has any objections please let me know.
> >=20
> >   " * @gfp: type of the memory for the allocation"
> >=20
> > >  {
> > >       struct smack_known *skp;
> > >       char **rule =3D (char **)vrule;
>=20


