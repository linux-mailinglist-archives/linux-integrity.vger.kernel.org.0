Return-Path: <linux-integrity+bounces-9862-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hibjHpGeRGovyAoAu9opvQ
	(envelope-from <linux-integrity+bounces-9862-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 06:58:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5676E9C18
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 06:58:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KrH0AeAK;
	dkim=pass header.d=redhat.com header.s=google header.b=CZcccIjI;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9862-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9862-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63F063027337
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2026 04:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB7238B7A1;
	Wed,  1 Jul 2026 04:58:51 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317B376A18
	for <linux-integrity@vger.kernel.org>; Wed,  1 Jul 2026 04:58:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782881931; cv=pass; b=TcQXKxFj96sww+dgDM8J8jy2SYVcSbv6/vNTd+FgkpiSKpB8ir9fFacM+VAbeXvr0gzVj5yzoQLdrYEqtb2MgiYVYeKu5cjpl9GK5mJveh9fV6g9wbaLwZFFyYO0V3IjvCJ5nXK6qjCGSJVfNN5dLaJYI5eiIRpartl/fNL8mIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782881931; c=relaxed/simple;
	bh=+0XPcsWuxEDcy8kzyztKUj7qpXFWihbDSFb/98Lt4jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzqzZfzFtBpeBuVeX/SQdSKxZ2LJzpl5B4ZgRQbcHtSU1RhpClcs3yUbpKE4sAbZ+MU/tAZDCTnG9XmBdQui5nYy3HqQOaMWZejGQtFbzZSK94dfdMvj0mqptiLjA4DmbFlnAmS3NUdypsMxCBSOG/v9H/4GOa1o3OWUudWGf6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrH0AeAK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZcccIjI; arc=pass smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782881928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijvj3rIROI2FO/mVXn6rz1WJEKmru4R1tDm+SMDG9ms=;
	b=KrH0AeAKE2Cw9/vHJytQh/L6LVC1o7vaGWuukg/XWFQyIyca+m+o5cYHjZp07jn/Sw51/b
	+bHsuJexkzzkPucJHS9uP9miz/nMnMUjzDpda6jv6CkKiZYElGoO9thDMDhYkI6eWl5Lq6
	P7PQe/liVyuRdtP275k7LkqZytJOiSw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-5ZCdlnLXN7SF9E9JQCMqUA-1; Wed, 01 Jul 2026 00:58:46 -0400
X-MC-Unique: 5ZCdlnLXN7SF9E9JQCMqUA-1
X-Mimecast-MFC-AGG-ID: 5ZCdlnLXN7SF9E9JQCMqUA_1782881926
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bff5c7035so4984741cf.2
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 21:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782881926; cv=none;
        d=google.com; s=arc-20260327;
        b=hGrbAIWiWzWLX22HITcpQxmMcE94AMhsaaFiS0pEj75AMRTPFyjLDtZx5k1L0iRAEH
         7+ggfTmW1sSEHHXm/PfntqmPFg5XDksd7W1LNFNTDhd7BVE00fQ802eew+pTpUkB/5qK
         Q8W+tVpJMLkz+X1qpjKm8jkeiCNM33HQe3hD6XSXbMeHx0T/Qz6IzEyt5AZElD4OSX9Y
         upUZgw8ZlwxKpHf14PTydH8s+t5Kf+wd1WWifRx0TqVHsteLpOX+MdriCuuykHWzn8IT
         if2VYxWSocvxT8Y5U/3iGT59fidtvKzJp2S1XrjVu+1lXQhJQpHylm6ti21W9qx8AnuV
         E/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ijvj3rIROI2FO/mVXn6rz1WJEKmru4R1tDm+SMDG9ms=;
        fh=IYJlAjwFbj1/IxVHKZQmF9G3gQB3iSDkoebinNI+ABI=;
        b=nC4Dyvy7Ep6M+W0Xg/qWvYn7wwhLdk+r4dVyC7lIYF1QQl0R89y3EI33CnDE+ACFUR
         rxKXKtbOhACEF8E6lVpxO8hlo0K+B7+inPhHDFM5KnZofjgY80OR1HGJ1qBh98hzlohK
         wC2glzGVQA+b4UqrqZUbJEDupp97OY4CbYEvBwHlDTqtmNSBhpDeXfccNmaJx0lWPYh8
         gBq9TVW3LvBydzutoA+jgh85pLFaVkY2nAWPvrXEORoJePUb+/7vC6Qf2AKy+NLRPEJ4
         +yic/AplzluHB4w/ck+m67mRZ8+wFybmI5MDWcjrUW73hhgYDEI9OyneW+B1L1J4PRsu
         vKQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782881926; x=1783486726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijvj3rIROI2FO/mVXn6rz1WJEKmru4R1tDm+SMDG9ms=;
        b=CZcccIjIXArdJ3gditTkES1UaoPFU42ukPgxc4ACkc9djzgHXTbzsnJpt7t99o6BR0
         LA3QOspifKqijzHzoaYbpl1rsVf3C5m8I77emU3Of51EBeI5NNfxd5NscHKNDBgKXdne
         bSHhFPPwapQHWv7VSxHu4KX6Q7Z9GfGi25CelrLNK++ShAJkqz+lXJyG5lQqWXb6GcYX
         9U0EkQ0nI5oS8ftoc6QNb8ew4rrehrD5EgPeDwS00QHwm/OZnGTwAhmehHVDhXB/gA/L
         2Y3QaEUGOSLE4o6qhs+cH31G1gf/f84t2xGsGQdwwYupoGTWkwiJYGLNTnnp3vEJ+QZf
         5m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782881926; x=1783486726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ijvj3rIROI2FO/mVXn6rz1WJEKmru4R1tDm+SMDG9ms=;
        b=PGgiPI6Uhax4Qn6ThE04C91oylkABObHuAhDJOtPm+8SleEgeJW1wrHkw4PSWvpBEk
         lViXq4BJzVwWD5k0NBMPrpAYsDXwnVTrmDgNG8xBLt9sw3eNJnzsHKV+orVt4QiQFGom
         8FnF19t02wkLSzg2P+stvXTRJnTE+v5ha6MGizTwNDpeankZoygSiEh97iB5Eq1xFmqy
         UKpVcKjxR+XyqNJrgu9wUcuDjbQTNLDJ3aiWFuIs5OEsrcTW1Wq8W/YPtPCQDRDNXp4M
         R41k0Rfzdf8ph0oR8VWnC61gFx3FalHTyL9WD5hG7ou4xr1JoJgG7w9C9wfTjnCYI77X
         wMwg==
X-Forwarded-Encrypted: i=1; AFNElJ8y2/gz2E+2cUB2+fckVA+nRJUL1cQ4Qqy8Ghly4mcWrRe1YqcyNF0arvrSBrLtclRGTeAEZlMDK0IZexXoygg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0RZ0aAYZd8sJONa+aC3jrV7pbThcNZre2P31fkN9EIHr64AFJ
	8wwzsK8xEIDQs9XgToJWlP1Q8wG/+q1LA/wQofppKtAe9REXiwdc05cZPUGqjYYfRdSxklzehFV
	lVwQgmIaynEMqOHEIzuj1T/8p4q3bD7sZASG3S0CNYWoE2ClLMGT78ynPKbTIEJu9+NtYz2C6/X
	BaQWKLL8qDOzzWC/aiCZakUcWQQXE80h8bLDJBafGOtKmc
X-Gm-Gg: AfdE7clsMZ5KuBqUwBloQVKM9zIgBJczdPMIvwagfmu8u1QmR+J/n3FsfLx+CHvROkW
	HEMQmN4jbYiPlRqxGOICaJbqKpvJ31NNH5dEybj36r8p2V4KdQhAlxb47B3BDSeW60aVbtjLk8f
	aS4bwL+Kl+8JXFMlCeaYCkFB7h/qT+NMrRmSBd136gyrBmfudgulr2IF2A8vU/qEi2iA==
X-Received: by 2002:a05:622a:5506:b0:517:5f04:f24c with SMTP id d75a77b69052e-51c26b0074emr1885891cf.39.1782881926264;
        Tue, 30 Jun 2026 21:58:46 -0700 (PDT)
X-Received: by 2002:a05:622a:5506:b0:517:5f04:f24c with SMTP id
 d75a77b69052e-51c26b0074emr1885651cf.39.1782881925860; Tue, 30 Jun 2026
 21:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701025732.66330-2-ltao@redhat.com> <akSOb1_1tcJvFyda@kernel.org>
In-Reply-To: <akSOb1_1tcJvFyda@kernel.org>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 1 Jul 2026 16:58:09 +1200
X-Gm-Features: AVVi8CecY3QtyR15biAB9c6BdBCvMEH22nDddc-TMyZfwtXlVx2ChNVQ9i9xRmk
Message-ID: <CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9862-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF5676E9C18

Hi Jarkko,

On Wed, Jul 1, 2026 at 3:50=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>
> On Wed, Jul 01, 2026 at 02:57:33PM +1200, Tao Liu wrote:
> > A NULL pointer dereference issue is noticed in riscv's machine_kexec_pr=
epare,
> > where image->segment[i].buf might be NULL and copied unchecked.
> >
> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> > but kbuf.buffer is NULL
>
> This should have a proper call sequence. Now the root cause is
> obfuscated.

Sure, I will attach the stack trace in v4. Here is the one:

[   62.867540] kexec_file(Image): Loaded kernel at 0x80200000
bufsz=3D0x34ed800 memsz=3D0x35d0000
[   62.879983] Unable to handle kernel access to user memory without
uaccess routines at virtual address 0000000000000000
[   62.880736] Current kexec pgtable: 4K pagesize, 57-bit VAs,
pgdp=3D0x00000001062eb000
[   62.881185] [0000000000000000] pgd=3D00000000413b4401,
p4d=3D000000004151bc01, pud=3D00000000415b7801, pmd=3D0000000040af5801,
pte=3D0000000000000000
[   62.881969] Oops [#1]
[   62.882077] Modules linked in:
[   62.882717] CPU: 1 UID: 0 PID: 894 Comm: kexec Not tainted 7.1.1 #4
PREEMPT(lazy)
[   62.883037] Hardware name: QEMU QEMU Virtual Machine, BIOS
edk2-20260508-2.fc44 05/08/2026
[   62.883365] epc : __memcpy+0xd4/0xf8
[   62.883685]  ra : machine_kexec_prepare+0x8a/0x298
[   62.883914] epc : ffffffff81393ee8 ra : ffffffff800366ca sp :
ff20000004a83d10
[   62.884214]  gp : ffffffff83258db8 tp : ff6000008573db80 t0 :
ffffffff80033640
[   62.884433]  t1 : 2152ffffffffffc0 t2 : 0000000003000000 s0 :
ff20000004a83d80
[   62.884710]  s1 : 0000000000000000 a0 : ff20000004a83d10 a1 :
0000000000000000
[   62.884987]  a2 : 0000000000000028 a3 : 0000000000000028 a4 :
0000000000000000
[   62.885208]  a5 : 0000000000000000 a6 : 0000000104e33fff a7 :
0000000000000000
[   62.885486]  s2 : ff60000082a35800 s3 : 0000000000000000 s4 :
0000000000000010
[   62.885774]  s5 : 0000000000000028 s6 : ff20000004a83d10 s7 :
0000000000000005
[   62.886005]  s8 : 00000000000000c0 s9 : 000000000ac0d220 s10:
ffffffff835420e8
[   62.886218]  s11: 0000000000000000 t3 : ffffff800000007c t4 :
ff1c000002138d00
[   62.886515]  t5 : ffffffffffffffff t6 : ff20000004a83d10 ssp :
0000000000000000
[   62.886860] status: 0000000200000120 badaddr: 0000000000000000
cause: 000000000000000d
[   62.887162] [<ffffffff81393ee8>] __memcpy+0xd4/0xf8
[   62.887388] [<ffffffff801b253a>] __do_sys_kexec_file_load+0x1b2/0x338
[   62.887612] [<ffffffff801b26e4>] __riscv_sys_kexec_file_load+0x24/0x40
[   62.887855] [<ffffffff81395ea4>] do_trap_ecall_u+0x1a4/0x5a8
[   62.888134] [<ffffffff813a9eec>] handle_exception+0x16c/0x178
[   62.888445] Code: 7613 07f6 ca05 86b3 00c5 e7b3 01f5 8fd5 8b8d eb89
(4198) 0591
[   62.889223] ---[ end trace 0000000000000000 ]---
Segmentation fault         kexec -l /boot/vmlinuz-7.1.1
--initrd=3D/boot/initramfs-7.1.1.img --reuse-cmdline

(gdb) p image->segment[0]
$3 =3D {{buf =3D 0x0, kbuf =3D 0x0}, bufsz =3D 0, mem =3D 10737586176, mems=
z =3D 4096}

The buf =3D 0x0 and bufsz =3D 0 comes from ima_add_kexec_buffer(), thought
I'm not sure why it added a NULL segment, but it is no harm to add a
NULL checker here in case any other scenarios similar as IMA.

>
> >
> > Fix this by simply adding a check before copy.
> >
> > Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
> > Acked-by: Baoquan He <bhe@redhat.com>
> > Acked-by: Pratyush Yadav <pratyush@kernel.org>
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >
> > v3 -> v2: Add fixes tag; Replace "reference" to "dereference".
> > link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-=
ltao@redhat.com/
> > link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-=
ltao@redhat.com/
> >
> > ---
> >  arch/riscv/kernel/machine_kexec.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/mach=
ine_kexec.c
> > index 2306ce3e5f22..afc68f6a4aa1 100644
> > --- a/arch/riscv/kernel/machine_kexec.c
> > +++ b/arch/riscv/kernel/machine_kexec.c
> > @@ -41,6 +41,13 @@ machine_kexec_prepare(struct kimage *image)
> >               if (image->segment[i].memsz <=3D sizeof(fdt))
> >                       continue;
> >
> > +             /*
> > +              * Some segments (e.g. IMA) reserve space but have no buf=
fer
> > +              * loaded yet. Skip them as they cannot contain an FDT.
> > +              */
>
> This is destined to rot over time. It also adds up also potentially to
> the backporting effort while backporting to stable kernes. And most
> importantly. Please, don't document every other null check.

OK, will get rid of it.

Thanks,
Tao Liu

>
> > +             if (image->segment[i].buf =3D=3D NULL)
>
> if (!image->segments[i].buf)
>
> > +                     continue;
> > +
> >               if (image->file_mode)
> >                       memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
> >               else if (copy_from_user(&fdt, image->segment[i].buf, size=
of(fdt)))
> > --
> > 2.54.0
> >
> >
>
> BR, Jarkko
>


