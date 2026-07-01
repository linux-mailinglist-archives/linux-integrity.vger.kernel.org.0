Return-Path: <linux-integrity+bounces-9865-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sl/mOoftRGpt3QoAu9opvQ
	(envelope-from <linux-integrity+bounces-9865-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 12:35:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5221C6EC31D
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 12:35:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i6ETZcbq;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9865-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9865-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2D653038165
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2026 10:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175541C30F;
	Wed,  1 Jul 2026 10:34:12 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40C28CF6F;
	Wed,  1 Jul 2026 10:34:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902051; cv=none; b=dKQcegwXNi3I0V+vJ+/frvqbyXdEN21hvH9nlHV7YlanYa3HgiqGKuVT/Q4fKbdj0wqDFoby7wZqtPjFLhbYXqw7kj11T0tkEnpzvEYxbgubNaEqrdZQ7xET1ethZs5wS0uKat84eEAOvseQIDJjGl5K9Ljiy4KzGPo/8Ug6Jyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902051; c=relaxed/simple;
	bh=//n8yQuXqMJdDkaH6TBXQfhz4KmXuGeEU0bKrvBD9Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgXahGk3MuvMMMa/TmgIQ7qqC7PuyzGbknEdJW0LlKz+x+P5khvFXEaC0unXomKls5KgKAcjglSWT5s1fOaKO37Ko2kgX4JGDlp7h/l3awelCNVJQSZTGkjIL2j/cEw+ghMoEupSZUTPK2/I7orrdopYGmIE8h5U0GUz5T2I+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6ETZcbq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A3B691F000E9;
	Wed,  1 Jul 2026 10:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782902049;
	bh=YC0bKrHQX1xBvkTArSRGDEKnTsZ6m1fH5b4vYO718+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i6ETZcbq3Ja5CM55rpJXRjrob3vRGBXuOFcb+/fD8tm2KMfrmZHGV8JvKtBfIHuhQ
	 iegJirAfp2Z+TOwirR4Las7MlTZnz286OEkzfDpfywbScC3lHKTq0zEKepm2Mugh8K
	 sghr4eSwknKkzslD4JE9cVTz6ULE9s3FsMADZCyrbN+dWqkHciegCqpVfz6dRib1VE
	 yGUJU0JxxWaiCaziPKmGA8pZ2xoAeS1XZCXxiqzF662dU4QoD9WtisPOcL3OI50D5u
	 oFZ3+oedgCJH3rN4CKR06W0MTGB4hiVrDph9Wt+QoV3E7FAVnyi8RoMGx4GRUft+K0
	 bOy1Ji1yuEGpg==
Date: Wed, 1 Jul 2026 13:34:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Tao Liu <ltao@redhat.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	bhe@redhat.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org, pratyush@kernel.org,
	Markus.Elfring@web.de, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in
 machine_kexec_prepare
Message-ID: <akTsE_jYq-GtXcpF@kernel.org>
References: <20260701025732.66330-2-ltao@redhat.com>
 <akSOb1_1tcJvFyda@kernel.org>
 <CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ltao@redhat.com,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kexec@lists.infradead.org,m:bhe@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:linux-integrity@vger.kernel.org,m:pratyush@kernel.org,m:Markus.Elfring@web.de,m:kernel-janitors@vger.kernel.org,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9865-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,web.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5221C6EC31D

On Wed, Jul 01, 2026 at 04:58:09PM +1200, Tao Liu wrote:
> Hi Jarkko,
> 
> On Wed, Jul 1, 2026 at 3:50 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, Jul 01, 2026 at 02:57:33PM +1200, Tao Liu wrote:
> > > A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare,
> > > where image->segment[i].buf might be NULL and copied unchecked.
> > >
> > > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> > > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> > > but kbuf.buffer is NULL
> >
> > This should have a proper call sequence. Now the root cause is
> > obfuscated.
> 
> Sure, I will attach the stack trace in v4. Here is the one:
> 
> [   62.867540] kexec_file(Image): Loaded kernel at 0x80200000
> bufsz=0x34ed800 memsz=0x35d0000
> [   62.879983] Unable to handle kernel access to user memory without
> uaccess routines at virtual address 0000000000000000
> [   62.880736] Current kexec pgtable: 4K pagesize, 57-bit VAs,
> pgdp=0x00000001062eb000
> [   62.881185] [0000000000000000] pgd=00000000413b4401,
> p4d=000000004151bc01, pud=00000000415b7801, pmd=0000000040af5801,
> pte=0000000000000000
> [   62.881969] Oops [#1]
> [   62.882077] Modules linked in:
> [   62.882717] CPU: 1 UID: 0 PID: 894 Comm: kexec Not tainted 7.1.1 #4
> PREEMPT(lazy)
> [   62.883037] Hardware name: QEMU QEMU Virtual Machine, BIOS
> edk2-20260508-2.fc44 05/08/2026
> [   62.883365] epc : __memcpy+0xd4/0xf8
> [   62.883685]  ra : machine_kexec_prepare+0x8a/0x298
> [   62.883914] epc : ffffffff81393ee8 ra : ffffffff800366ca sp :
> ff20000004a83d10
> [   62.884214]  gp : ffffffff83258db8 tp : ff6000008573db80 t0 :
> ffffffff80033640
> [   62.884433]  t1 : 2152ffffffffffc0 t2 : 0000000003000000 s0 :
> ff20000004a83d80
> [   62.884710]  s1 : 0000000000000000 a0 : ff20000004a83d10 a1 :
> 0000000000000000
> [   62.884987]  a2 : 0000000000000028 a3 : 0000000000000028 a4 :
> 0000000000000000
> [   62.885208]  a5 : 0000000000000000 a6 : 0000000104e33fff a7 :
> 0000000000000000
> [   62.885486]  s2 : ff60000082a35800 s3 : 0000000000000000 s4 :
> 0000000000000010
> [   62.885774]  s5 : 0000000000000028 s6 : ff20000004a83d10 s7 :
> 0000000000000005
> [   62.886005]  s8 : 00000000000000c0 s9 : 000000000ac0d220 s10:
> ffffffff835420e8
> [   62.886218]  s11: 0000000000000000 t3 : ffffff800000007c t4 :
> ff1c000002138d00
> [   62.886515]  t5 : ffffffffffffffff t6 : ff20000004a83d10 ssp :
> 0000000000000000
> [   62.886860] status: 0000000200000120 badaddr: 0000000000000000
> cause: 000000000000000d
> [   62.887162] [<ffffffff81393ee8>] __memcpy+0xd4/0xf8
> [   62.887388] [<ffffffff801b253a>] __do_sys_kexec_file_load+0x1b2/0x338
> [   62.887612] [<ffffffff801b26e4>] __riscv_sys_kexec_file_load+0x24/0x40
> [   62.887855] [<ffffffff81395ea4>] do_trap_ecall_u+0x1a4/0x5a8
> [   62.888134] [<ffffffff813a9eec>] handle_exception+0x16c/0x178
> [   62.888445] Code: 7613 07f6 ca05 86b3 00c5 e7b3 01f5 8fd5 8b8d eb89
> (4198) 0591
> [   62.889223] ---[ end trace 0000000000000000 ]---
> Segmentation fault         kexec -l /boot/vmlinuz-7.1.1
> --initrd=/boot/initramfs-7.1.1.img --reuse-cmdline
> 
> (gdb) p image->segment[0]
> $3 = {{buf = 0x0, kbuf = 0x0}, bufsz = 0, mem = 10737586176, memsz = 4096}
> 
> The buf = 0x0 and bufsz = 0 comes from ima_add_kexec_buffer(), thought
> I'm not sure why it added a NULL segment, but it is no harm to add a
> NULL checker here in case any other scenarios similar as IMA.

The mission oriented purpose of kernel's git log is to be a quick
checklist for bisecting bugs for instance. You have a dump of details
there for a transcript. Now you should do rationalize that because how
can you otherwise trust your own code?

Here's one recent example from me:

https://lore.kernel.org/linux-integrity/20260509185108.2681198-1-jarkko@kernel.org/

This is IMHO way more important part for a bug fix like this than the
code change itself.

It's the "engineering part" of the  equation.

> 
> >
> > >
> > > Fix this by simply adding a check before copy.
> > >
> > > Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
> > > Acked-by: Baoquan He <bhe@redhat.com>
> > > Acked-by: Pratyush Yadav <pratyush@kernel.org>
> > > Signed-off-by: Tao Liu <ltao@redhat.com>
> > > ---
> > >
> > > v3 -> v2: Add fixes tag; Replace "reference" to "dereference".
> > > link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
> > > link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/
> > >
> > > ---
> > >  arch/riscv/kernel/machine_kexec.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> > > index 2306ce3e5f22..afc68f6a4aa1 100644
> > > --- a/arch/riscv/kernel/machine_kexec.c
> > > +++ b/arch/riscv/kernel/machine_kexec.c
> > > @@ -41,6 +41,13 @@ machine_kexec_prepare(struct kimage *image)
> > >               if (image->segment[i].memsz <= sizeof(fdt))
> > >                       continue;
> > >
> > > +             /*
> > > +              * Some segments (e.g. IMA) reserve space but have no buffer
> > > +              * loaded yet. Skip them as they cannot contain an FDT.
> > > +              */
> >
> > This is destined to rot over time. It also adds up also potentially to
> > the backporting effort while backporting to stable kernes. And most
> > importantly. Please, don't document every other null check.
> 
> OK, will get rid of it.

general rules of thumb i personally follow usually:

1. features/improvements: can be a bit more eager with comments
2. bugs: you really have to have rationale for having a commnet. E.g.,
   mandatory SAFETY comment in linux-rust would obviously qualify.
3. both: if you add a comment are you sure it won't rot over time?

> 
> Thanks,
> Tao Liu
> 
> >
> > > +             if (image->segment[i].buf == NULL)
> >
> > if (!image->segments[i].buf)
> >
> > > +                     continue;
> > > +
> > >               if (image->file_mode)
> > >                       memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
> > >               else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
> > > --
> > > 2.54.0
> > >
> > >
> >
> > BR, Jarkko
> >
> 

BR, Jarkko

