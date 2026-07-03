Return-Path: <linux-integrity+bounces-9878-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SiMkOLKXR2ocbwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9878-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 13:06:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F56A7019B5
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 13:06:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DGeyS26W;
	dkim=pass header.d=redhat.com header.s=google header.b=bVeDA70K;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9878-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9878-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4E6B3002326
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jul 2026 10:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A571C3B71A6;
	Fri,  3 Jul 2026 10:59:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8BB3BADB1
	for <linux-integrity@vger.kernel.org>; Fri,  3 Jul 2026 10:59:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076397; cv=pass; b=GR0L2Ol64SmKHGUHBi5HRSjDfH0HFAGMjayoci9i0FrwHNEBaRTr6LDwsmPz2WzWzFWhM5Saws/1kzXuLRiy1K5xsqkV5mFW5mBhcNoBQQJNBSIfBrmubghVvlaA4qn67oKuV3ejmJ6pWjVHl1YPiTV59ER10cEprBf3RJsD5z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076397; c=relaxed/simple;
	bh=Kdp2PH2HMMYY6AaCbfMKyegYJNpecovxW46S2fuHfAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ei1j/T/+2FOt3vcdaXMLCZuoTx9HgUNQG9aZLeBU6hhStBbuHqfh5aL5UenCb6NQ1lfWiE2ZwxSE7tdGmRc9p/swYgoldS5NzBtrfj8a7nJME3+91eGMhWHhQogahAh2xx09KVeJQUHu6eeHjpARxtwyowouz8zyMONi/gvl/v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGeyS26W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVeDA70K; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783076394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90otGYM9YNogT3/612Z38WIGOFh0NDbrJXj/gkAcc4M=;
	b=DGeyS26W8f/vEx9OpUibRjZev8iFzkTX9I0Jv7vcrq5J2aebsbcsc+beNxgH0pm7LEF87E
	8M1Nr9/aR2o3cdB0iOz7/EdqhmCNDK0BnoaeuKEVnjGADDjXxHx0PAOlYw6wHg2GpbbZRZ
	K3ErhCBTa1tpcn/qC6A4Z+9EKJs0j7c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-HCea8npmPrCzDOeS2huxTA-1; Fri, 03 Jul 2026 06:59:53 -0400
X-MC-Unique: HCea8npmPrCzDOeS2huxTA-1
X-Mimecast-MFC-AGG-ID: HCea8npmPrCzDOeS2huxTA_1783076393
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5e38fbc5so37223085a.2
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jul 2026 03:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783076393; cv=none;
        d=google.com; s=arc-20260327;
        b=J0TkxP45M20F1R6us0cczm0NZh5pbyoMr6SHqRYdbX/K4VoWbsoErGaxd9vT95LxsW
         TpiIj1zO+7LREYDlEwxAmpihKEpnhDyldiBBu/q+M2d7xVzkpmgncc3JRLNwOQKR8CxL
         adPXn/BUx3tvcuZfPkq0SAx+R3cO7unVrysXZhRH8IkwpnlEkKRD3WGbg2PkfZXJDUEK
         +baEVAY+YadFoZNenyzG537k8YoqQgWmkZYsnVPXwz9hmwVKdxAuIKa52xmIYM6iySev
         4heF7JxPmiyKC3CHzBCqn9iPF/eu5QP3au6fAPBn1fBOFecnP/swEC7IgJbxaF5SEt/5
         u5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=90otGYM9YNogT3/612Z38WIGOFh0NDbrJXj/gkAcc4M=;
        fh=PkXd10AIW/zHhOSLb211/jURt3wStFJYXVmA3ulF1Lk=;
        b=sUf6IcNaTiBgGfSzhKeiTHODQDeEHxSGO68OsikDQ9wVOZjSKF5BTLUEh37ve+JRm7
         C0Nj1zVb1MJcyQxAT6DNfks6pzi3x3wMuDBlX5AMzp941iH0lgvjlF4ISlJdy3v951pI
         j7ZjujkiuHl5jN//CDegkM1sWBY7EjrczFDllSI8LXEsJXidn4MS5xUrVSx8g3MMV6HM
         IVuU6i4uWAzt0tDRRzngbkIM5BRJjgF2Nge6efoVoVvEUlXR7R4Ug5FcaLEIgqAk+SwS
         +dZZhusCKZpPc+xOjGDo+n1WkwRbhxxVqVUsTGUJH2fsKEEQ2R0Xvhfllgca2E22AYtx
         eUXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783076393; x=1783681193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90otGYM9YNogT3/612Z38WIGOFh0NDbrJXj/gkAcc4M=;
        b=bVeDA70K4ksaazHQYpA4UhYenAC8HV7yk4Klli93b3vflFTJ6anQYho56kSrGKUjfp
         HnfNKpSb9KK92mHt4YS8KGQP1kHs5nT07oQ5Dli2GpkTIRHvsMNr4/BsC2l2d0b7rOyi
         ujXHDmKA1w8MZnorBPyDSiiZKlfGtL3TyVf8I7t/EwWWxyaro60F9Z0+AZWXMeTRWj2X
         /lzm/nT0OtY9MsivKvy9apty16/AWkOlFBefkjmTQ75vQEYXAt1xsPpHIg7C488p5u9W
         qr+sGD0nz+ENmnbqSkQgGXFnqBCAje/4mQnSlkuu/ST/kM2Ryg+JOO09uoH1mMqysMQt
         7xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076393; x=1783681193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=90otGYM9YNogT3/612Z38WIGOFh0NDbrJXj/gkAcc4M=;
        b=CfyP6mpPllP2IEvPFk0Ph5NmKiWM7WiUDOSI1b2M4Kef28F2/L7RgET2zyvHc/Sdqb
         a/Ey4XaNUpBiXRq76A0R/hC/I772QLdmMMhEtE7f5SXNvm3K+O5XMI8R9ehzSz940UI/
         iD3Zxeou049jn/aUAtxy/TwW+Qt19Pz+0tUJlRmcFxwtZQqvTgHm1pM7bRz8+ukynHWl
         q1Dh1Qd4u6D4wLD3aMf7FZHj3pVl8qDpKbCpZHq4rTHwK0XGi3D5YqQ19rIodH0RrUSf
         K3bRAhGXv8IY9hTdy7u+/UJyCsrKGh+f5zHs2r8krIg1tzaueBjQfJj1CnAMW861HvYs
         /Ztw==
X-Forwarded-Encrypted: i=1; AFNElJ+WSPhg3o/nXg+suCdS1sD+qHAIClYoiYQBLZmDB1O3vqXPq89HIk+IQZBhZHS8JvTuq2zSRw8WKaqh/3WQ86g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1uCTMeink3IP3XJZhMmm/jP+DPI8+q1NIWgKnnSer7LI/Mc4i
	8mA2y828oydyUfp2WCH35s+S7p1pzOMi608vvkXoxHff8NjGHeoZUJiJ9MLIf5F3olAOFKwD8ei
	97qJKXwOSzJEqa0Vh3O7mDDa5X4i91adPVVbPCognk1NvJbwUoHYb3QnC5q/Gin+lIkT3yoBh70
	/sg8LXEzqUHr4BNF+wNArqH2xyawDw1NIGsxR6jhIZS8EF
X-Gm-Gg: AfdE7cnsKruKY7542zBPfIuQwW664BaGbhNv1XgYjeJt4+VXOYZVC5u+o28uMX9Gig7
	FTvRyLswcsaAx9rgTKQOSawaSoCaGH6PI6k3IrensJ/yxZlFSGaEWmFLUVcy35t7O6sT1Hu/7Zj
	TN70wdNfYTr/GbFQtsVIM3R2VYgcBFZnm25mvAYX/BOwJY/lENAkbj8EG7gKzbGtFEAg==
X-Received: by 2002:a05:620a:4016:b0:92e:6a43:4768 with SMTP id af79cd13be357-92e781cde5emr1264294485a.11.1783076392679;
        Fri, 03 Jul 2026 03:59:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4016:b0:92e:6a43:4768 with SMTP id
 af79cd13be357-92e781cde5emr1264290485a.11.1783076392257; Fri, 03 Jul 2026
 03:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701025732.66330-2-ltao@redhat.com> <akSOb1_1tcJvFyda@kernel.org>
 <CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com> <2vxz33y2j4mi.fsf@kernel.org>
In-Reply-To: <2vxz33y2j4mi.fsf@kernel.org>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 3 Jul 2026 22:59:15 +1200
X-Gm-Features: AVVi8Cezbo0yX7OHAq34QhJe08uT7CxY47RNCIsfCYAyC3SXHTFCS-ZJgPFpSss
Message-ID: <CAO7dBbXBc4kvE2J09EhBs+MYpcJOV1UdNnSG=5RqcUUqimU5Qg@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in machine_kexec_prepare
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, bhe@redhat.com, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, linux-integrity@vger.kernel.org, 
	Markus.Elfring@web.de, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9878-lists,linux-integrity=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pratyush@kernel.org,m:jarkko@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kexec@lists.infradead.org,m:bhe@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:linux-integrity@vger.kernel.org,m:Markus.Elfring@web.de,m:kernel-janitors@vger.kernel.org,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F56A7019B5

Hi Pratyush,

On Thu, Jul 2, 2026 at 12:06=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Wed, Jul 01 2026, Tao Liu wrote:
>
> > Hi Jarkko,
> >
> > On Wed, Jul 1, 2026 at 3:50=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.o=
rg> wrote:
> >>
> >> On Wed, Jul 01, 2026 at 02:57:33PM +1200, Tao Liu wrote:
> >> > A NULL pointer dereference issue is noticed in riscv's machine_kexec=
_prepare,
> >> > where image->segment[i].buf might be NULL and copied unchecked.
> >> >
> >> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> >> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> >> > but kbuf.buffer is NULL
> >>
> >> This should have a proper call sequence. Now the root cause is
> >> obfuscated.
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
> From my reading of the IMA code, I think they do so because they don't
> want to add a buffer to the kimage just yet. This is because there can
> be IMA measurements between kexec load and kexec reboot. So they use
> kexec_add_buffer() to reserve the physical address space, then they vmap
> the destination pages in ima_kexec_post_load(), and then update the
> destination pages directly via a reboot notifier. So they do not have a
> buffer copied to the destination pages at the time of
> kexec_add_buffer().
>
> Now all that is fairly convoluted and not very obvious, but I am not
> sure if there is a better way of doing this off the top of my head.

Thank you very much for resolving my confusion! Now I understand it
much better...

Thanks,
Tao Liu

>
> >
> >>
> >> >
> >> > Fix this by simply adding a check before copy.
> >> >
> >> > Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
> >> > Acked-by: Baoquan He <bhe@redhat.com>
> >> > Acked-by: Pratyush Yadav <pratyush@kernel.org>
> >> > Signed-off-by: Tao Liu <ltao@redhat.com>
> [...]
>
> --
> Regards,
> Pratyush Yadav
>


