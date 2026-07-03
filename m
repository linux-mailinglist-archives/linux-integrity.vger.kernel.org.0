Return-Path: <linux-integrity+bounces-9879-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q8qNOIuZR2q4bwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9879-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 13:14:19 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CFF701B1B
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 13:14:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=aenZx4wq;
	dkim=pass header.d=redhat.com header.s=google header.b=bxaXsMQG;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9879-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9879-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C53E300F9EC
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jul 2026 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756B3B6347;
	Fri,  3 Jul 2026 11:09:17 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06065364926
	for <linux-integrity@vger.kernel.org>; Fri,  3 Jul 2026 11:09:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076957; cv=pass; b=uz6QbkvvWBAFkIVUM4A2VwN+f+SmuHNeO1ThdPsbXcQg0h6myQ98rp8+ZKaHV1P+r/PGu2H0Q+yz1xFS25kKi4OZ0/ls21HF9ZG5t/pMuVN/Uv3IjqxsBmjm44Ud/TtC64MYTw0j9AfHeMmbDs0Kd6XhCzj3lm75UVHb/tCewLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076957; c=relaxed/simple;
	bh=ky6LfkgCQQeUzwvB4OpjP0MRqV9I5n463ukg4Hx0N0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DD6/74GZR1UH1EjkoyisNB8CYRUTRA/ztlXBj6/5F4JZY+4xFbjhdrHCrb04GSm6lBz+PDxhAoZ4GbvAt1paA51KP5EtSW54Q2C7k/4txSj7oCSDf/zO2ODhWxcjKg44nWxB5S3t0OEVG1uoJpdRuY6DPk2f0vBzm8/WiMW7u5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aenZx4wq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxaXsMQG; arc=pass smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783076955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uh7HGlG5BHoSUsvlsYaBrF++hCjSyZH34tmkueyHFBM=;
	b=aenZx4wq18Qu+HQG3r2Zu1xEl0SqOCuCzLU62fubE8S3MiX8XJsPJh2rOxuIB+c0rLKHjr
	hhPFnFCDzE//KpkTkISYOCjpohOVbFUwdpXaxZGiHUEyJn2Z7EbhJAFue07fMFkWzYTcsI
	J6g0cAwKMZLo8WO/0yqDJu41TgC2zqs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-nDPyTIX6NqmIT7Uhnk3MVw-1; Fri, 03 Jul 2026 07:09:14 -0400
X-MC-Unique: nDPyTIX6NqmIT7Uhnk3MVw-1
X-Mimecast-MFC-AGG-ID: nDPyTIX6NqmIT7Uhnk3MVw_1783076954
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e820609d9so31285285a.2
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jul 2026 04:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783076954; cv=none;
        d=google.com; s=arc-20260327;
        b=NTCc/mebOR/p0n5iDfqw91d3uD6HnB1qOArlSCmq9aIvnwt5pso1rE+GKVjsnDC0IO
         GzkiEaX4VbcyBGt53CZ+PjbMvFsj/G3QgelSgUGUThBi6gvEoFw6GhZ53uAMFELl48k4
         sGh0MhHS4xsUaZYkj6ZffM5znfT2xguVJdEr3lYYL6/UbfBq7vsch0MuZJXB9VcWlWFs
         UVVS+FXJzFkFJt9DHl/Kiv17ygXt7B8LMpcsq8s2HvAvRRYVqT1+wN6tWTXwlE3IkPcx
         Pf0Q6ARqNfbu8K8NJisJBhrIxLHHLad+g2N4l3NRmsru0KEO0ZIPIO2X3IqtQcPK9Czm
         2nPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uh7HGlG5BHoSUsvlsYaBrF++hCjSyZH34tmkueyHFBM=;
        fh=SW6FeIeMf49NRkjk/bdqYGdq6fFgTHnOGtoymqwIiDs=;
        b=nGaLwVekEwZzIPgXa+EFyrqFb+pARP7nVxyvrMzmprg5ifTJc9NX3YBw3Pr3GeCS7O
         6rE/cWKntLD38zFMxGgJ3NxVPV/P9ZgDPaTNwuPTrKRoVxy553LyJqLBEiLRXy24o12K
         B/SMIPll7ZQ1I2EdtuSzdF7CQjV3FiqSiQwlSr7XSf68g/0XL0v4oGc9k1V3OnhHRdM5
         Sjbqnyd/V60EpmuENFIhCrzNNfvxd5TLN9IAF9tIcu97B81ScChAZU0H2r5eJ3T/5xNr
         WzdPSiFS2n41QNq0VDZRkHX946CCEMWr+KcM/+UfXulNrjoU3yy64NvICN9mH7c/icdS
         eW0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783076954; x=1783681754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh7HGlG5BHoSUsvlsYaBrF++hCjSyZH34tmkueyHFBM=;
        b=bxaXsMQGXkI/tTwDwDZjWwQYeiKCf3M0BUJsbzefxriGgrzkiCAVhgfKX8/maGV6kw
         yj9OZbusx64gE0icE2tFL0No/Csfl9dZt5q7bC4RbBhc3g4drS59hWDyqkyrFXSyQAO0
         yXIpIoKZct2MSQbYphEHxicfvA25rxm0wpjiBKrl6no64c431xUAmtywWVHcke20DpgE
         8BSVPmJ8xRyymDDgztlC1lGUpVdnqqowP+INwpFZzlqJ6+/5ejtWEYzTPh4zx7PZX4Fm
         z3jCOidw4XM+j+gTfNYyTUIpW9g0ZCI1o5Rng92V1y4M6x3L80samGDufmO7Fj5MClSz
         XVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076954; x=1783681754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uh7HGlG5BHoSUsvlsYaBrF++hCjSyZH34tmkueyHFBM=;
        b=agtzspoBAv8u1QF/KKj+cnXR7DN9CkxMVQ+3HO+PhhWqRtIfZWOJ3GWXRbc5Gmmyb0
         CiKMHffRI5bxoTCwXralcQKvjNHmA3L3OZTMuIh9wJzclV9K/LshPKxDnO0kO+Afj5hC
         oMKkHhqq7s0JlXydhHUMa7jzotKEeBRnSb7Jx2w0ij3zoFi/vQrMntLOjCIBN9brVnq7
         vRSF3d/X/OLev+wZNjg8xnUhIh3wIXH5lZLILodoCDpJCM9zYnQ/LKko64xV8l4ginFP
         hHUubGUnHJMauo7YQf4ebOavz4eRv2+snJ5eCyXdLzeQNQk3BftOCZRQbhjBlE/y5mn4
         o2Pw==
X-Forwarded-Encrypted: i=1; AFNElJ8hdrXUxaI1Pmdb5gyT2CvMNAhpoiuqU46GqE/HhdjzidkW5MzSlkv6oLv3gliTz7+qr1P8NTpo1gigoOa+XSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO3Dc3wQlW3WPSLOezZM0rGXaxYjKyYKGaY7AZ2y0Qu/pyHfhD
	YllPh3FwotORFfDBqA1as3fOExVmDei7aTwi+A1FUtGjgWifNg8NwkIZVVlWs+Hrcwl8XcUJUp+
	bWIk4bYse8sEYM82Gd2YED249Z9h431zD5vc4LtMg2pDZaoAFFp/Q54aADkIdk1XFcEIWmDBNAs
	Ks3io5ITM9S2/KiGRYfmq44ypLcYJzKt6+GaN2ab7H6xbB
X-Gm-Gg: AfdE7cmA+Im1t2PeJwBCUBKAh+fNxSgKM4+Ic8SUMscaBNPHKCd5zIw68jv6oJaCPB8
	x6vA4pXhJNZXRdxbK5Qc3vlbhJ+SuudTclJzGlv/pfWqqGMOJ3WFEeE5Gs3BmUBASq64b1r7yul
	g3C78uHUFi+QIOGbNg6RrEV2HlgZAYhLr7/f8QSE+ohxLyaVhr7l0pxCQbCXFFjn1sPw==
X-Received: by 2002:a05:622a:44:b0:51c:24c:59de with SMTP id d75a77b69052e-51c26b629eamr143143311cf.72.1783076953389;
        Fri, 03 Jul 2026 04:09:13 -0700 (PDT)
X-Received: by 2002:a05:622a:44:b0:51c:24c:59de with SMTP id
 d75a77b69052e-51c26b629eamr143142551cf.72.1783076952684; Fri, 03 Jul 2026
 04:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701025732.66330-2-ltao@redhat.com> <akSOb1_1tcJvFyda@kernel.org>
 <CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com> <akTsE_jYq-GtXcpF@kernel.org>
In-Reply-To: <akTsE_jYq-GtXcpF@kernel.org>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 3 Jul 2026 23:08:35 +1200
X-Gm-Features: AVVi8Cclc4CZSlkWyFCrDTmGWrXtXO513XB-yjh4k4HPtk_zt3VKjRYaC6ARqq0
Message-ID: <CAO7dBbVoppy-1AY8paE8KBb93UubhBHBhvsgjOm0Hnbxiq4byQ@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in machine_kexec_prepare
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, bhe@redhat.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	linux-integrity@vger.kernel.org, pratyush@kernel.org, Markus.Elfring@web.de, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9879-lists,linux-integrity=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jarkko@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kexec@lists.infradead.org,m:bhe@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:linux-integrity@vger.kernel.org,m:pratyush@kernel.org,m:Markus.Elfring@web.de,m:kernel-janitors@vger.kernel.org,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ltao@redhat.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,web.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltao@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59CFF701B1B

Hi Jarkko,

On Wed, Jul 1, 2026 at 10:34=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed, Jul 01, 2026 at 04:58:09PM +1200, Tao Liu wrote:
> > Hi Jarkko,
> >
> > On Wed, Jul 1, 2026 at 3:50=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.o=
rg> wrote:
> > >
> > > On Wed, Jul 01, 2026 at 02:57:33PM +1200, Tao Liu wrote:
> > > > A NULL pointer dereference issue is noticed in riscv's machine_kexe=
c_prepare,
> > > > where image->segment[i].buf might be NULL and copied unchecked.
> > > >
> > > > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> > > > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> > > > but kbuf.buffer is NULL
> > >
> > > This should have a proper call sequence. Now the root cause is
> > > obfuscated.
> >
> > Sure, I will attach the stack trace in v4. Here is the one:
> >
> > [   62.867540] kexec_file(Image): Loaded kernel at 0x80200000
> > bufsz=3D0x34ed800 memsz=3D0x35d0000
> > [   62.879983] Unable to handle kernel access to user memory without
> > uaccess routines at virtual address 0000000000000000
> > [   62.880736] Current kexec pgtable: 4K pagesize, 57-bit VAs,
> > pgdp=3D0x00000001062eb000
> > [   62.881185] [0000000000000000] pgd=3D00000000413b4401,
> > p4d=3D000000004151bc01, pud=3D00000000415b7801, pmd=3D0000000040af5801,
> > pte=3D0000000000000000
> > [   62.881969] Oops [#1]
> > [   62.882077] Modules linked in:
> > [   62.882717] CPU: 1 UID: 0 PID: 894 Comm: kexec Not tainted 7.1.1 #4
> > PREEMPT(lazy)
> > [   62.883037] Hardware name: QEMU QEMU Virtual Machine, BIOS
> > edk2-20260508-2.fc44 05/08/2026
> > [   62.883365] epc : __memcpy+0xd4/0xf8
> > [   62.883685]  ra : machine_kexec_prepare+0x8a/0x298
> > [   62.883914] epc : ffffffff81393ee8 ra : ffffffff800366ca sp :
> > ff20000004a83d10
> > [   62.884214]  gp : ffffffff83258db8 tp : ff6000008573db80 t0 :
> > ffffffff80033640
> > [   62.884433]  t1 : 2152ffffffffffc0 t2 : 0000000003000000 s0 :
> > ff20000004a83d80
> > [   62.884710]  s1 : 0000000000000000 a0 : ff20000004a83d10 a1 :
> > 0000000000000000
> > [   62.884987]  a2 : 0000000000000028 a3 : 0000000000000028 a4 :
> > 0000000000000000
> > [   62.885208]  a5 : 0000000000000000 a6 : 0000000104e33fff a7 :
> > 0000000000000000
> > [   62.885486]  s2 : ff60000082a35800 s3 : 0000000000000000 s4 :
> > 0000000000000010
> > [   62.885774]  s5 : 0000000000000028 s6 : ff20000004a83d10 s7 :
> > 0000000000000005
> > [   62.886005]  s8 : 00000000000000c0 s9 : 000000000ac0d220 s10:
> > ffffffff835420e8
> > [   62.886218]  s11: 0000000000000000 t3 : ffffff800000007c t4 :
> > ff1c000002138d00
> > [   62.886515]  t5 : ffffffffffffffff t6 : ff20000004a83d10 ssp :
> > 0000000000000000
> > [   62.886860] status: 0000000200000120 badaddr: 0000000000000000
> > cause: 000000000000000d
> > [   62.887162] [<ffffffff81393ee8>] __memcpy+0xd4/0xf8
> > [   62.887388] [<ffffffff801b253a>] __do_sys_kexec_file_load+0x1b2/0x33=
8
> > [   62.887612] [<ffffffff801b26e4>] __riscv_sys_kexec_file_load+0x24/0x=
40
> > [   62.887855] [<ffffffff81395ea4>] do_trap_ecall_u+0x1a4/0x5a8
> > [   62.888134] [<ffffffff813a9eec>] handle_exception+0x16c/0x178
> > [   62.888445] Code: 7613 07f6 ca05 86b3 00c5 e7b3 01f5 8fd5 8b8d eb89
> > (4198) 0591
> > [   62.889223] ---[ end trace 0000000000000000 ]---
> > Segmentation fault         kexec -l /boot/vmlinuz-7.1.1
> > --initrd=3D/boot/initramfs-7.1.1.img --reuse-cmdline
> >
> > (gdb) p image->segment[0]
> > $3 =3D {{buf =3D 0x0, kbuf =3D 0x0}, bufsz =3D 0, mem =3D 10737586176, =
memsz =3D 4096}
> >
> > The buf =3D 0x0 and bufsz =3D 0 comes from ima_add_kexec_buffer(), thou=
ght
> > I'm not sure why it added a NULL segment, but it is no harm to add a
> > NULL checker here in case any other scenarios similar as IMA.
>
> The mission oriented purpose of kernel's git log is to be a quick
> checklist for bisecting bugs for instance. You have a dump of details
> there for a transcript. Now you should do rationalize that because how
> can you otherwise trust your own code?
>
> Here's one recent example from me:
>
> https://lore.kernel.org/linux-integrity/20260509185108.2681198-1-jarkko@k=
ernel.org/
>
> This is IMHO way more important part for a bug fix like this than the
> code change itself.
>
> It's the "engineering part" of the  equation.
>
> >
> > >
> > > >
> > > > Fix this by simply adding a check before copy.
> > > >
> > > > Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
> > > > Acked-by: Baoquan He <bhe@redhat.com>
> > > > Acked-by: Pratyush Yadav <pratyush@kernel.org>
> > > > Signed-off-by: Tao Liu <ltao@redhat.com>
> > > > ---
> > > >
> > > > v3 -> v2: Add fixes tag; Replace "reference" to "dereference".
> > > > link to v2: https://lore.kernel.org/linux-riscv/20260627222602.2359=
4-2-ltao@redhat.com/
> > > > link to v1: https://lore.kernel.org/linux-riscv/20260529032739.1326=
4-2-ltao@redhat.com/
> > > >
> > > > ---
> > > >  arch/riscv/kernel/machine_kexec.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/=
machine_kexec.c
> > > > index 2306ce3e5f22..afc68f6a4aa1 100644
> > > > --- a/arch/riscv/kernel/machine_kexec.c
> > > > +++ b/arch/riscv/kernel/machine_kexec.c
> > > > @@ -41,6 +41,13 @@ machine_kexec_prepare(struct kimage *image)
> > > >               if (image->segment[i].memsz <=3D sizeof(fdt))
> > > >                       continue;
> > > >
> > > > +             /*
> > > > +              * Some segments (e.g. IMA) reserve space but have no=
 buffer
> > > > +              * loaded yet. Skip them as they cannot contain an FD=
T.
> > > > +              */
> > >
> > > This is destined to rot over time. It also adds up also potentially t=
o
> > > the backporting effort while backporting to stable kernes. And most
> > > importantly. Please, don't document every other null check.
> >
> > OK, will get rid of it.
>
> general rules of thumb i personally follow usually:
>
> 1. features/improvements: can be a bit more eager with comments
> 2. bugs: you really have to have rationale for having a commnet. E.g.,
>    mandatory SAFETY comment in linux-rust would obviously qualify.
> 3. both: if you add a comment are you sure it won't rot over time?
>

Thank you very much for providing detailed guidance on code commenting
and commit log drafting. I really appreciate your help with those!

Thanks,
Tao Liu

> >
> > Thanks,
> > Tao Liu
> >
> > >
> > > > +             if (image->segment[i].buf =3D=3D NULL)
> > >
> > > if (!image->segments[i].buf)
> > >
> > > > +                     continue;
> > > > +
> > > >               if (image->file_mode)
> > > >                       memcpy(&fdt, image->segment[i].buf, sizeof(fd=
t));
> > > >               else if (copy_from_user(&fdt, image->segment[i].buf, =
sizeof(fdt)))
> > > > --
> > > > 2.54.0
> > > >
> > > >
> > >
> > > BR, Jarkko
> > >
> >
>
> BR, Jarkko
>


