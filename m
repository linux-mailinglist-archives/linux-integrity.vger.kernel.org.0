Return-Path: <linux-integrity+bounces-9406-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HgqFfB792kpiQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9406-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 03 May 2026 18:46:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A88344B6910
	for <lists+linux-integrity@lfdr.de>; Sun, 03 May 2026 18:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F0983005674
	for <lists+linux-integrity@lfdr.de>; Sun,  3 May 2026 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8037CD22;
	Sun,  3 May 2026 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LwpDfoqR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B237CD20
	for <linux-integrity@vger.kernel.org>; Sun,  3 May 2026 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777826797; cv=pass; b=OnspgXhqy5yU5HbFy4GE+beO0iffzceVIcyMIcgqyxdxiDxxoyzHprLU05mDcnYMk6E9SyGW9a+YD9rJjpaqve1IOQVtEBNroABqghZBS2qWxnquRB13DzAvJnlrcuiKbEMc+5X74WP7Yuk6MK5t2MZQG2VEMlVjg+gEzgvUWcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777826797; c=relaxed/simple;
	bh=YM2w+8iga6X0KGUCUEQ+IcUBubK3K3glecWKuCK54Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnjbTluk2QQqlVzdsUH00c011iLtsYRW4tPE4wunAQnqRwFgxJ+f1g8qbKUO0sD1X3EuRBWRW2ZFQbM4Y8ePqt6eRo5+j87SxH4MatDzfUwwbjFqna5ObwsIK3YogD4CgcL8JU8/OO232xbnXLUGXHWcTqcD/EcPm2X956VVxlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LwpDfoqR; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3652546e41aso449157a91.1
        for <linux-integrity@vger.kernel.org>; Sun, 03 May 2026 09:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777826795; cv=none;
        d=google.com; s=arc-20240605;
        b=VvRgsf3wf6YuVaebMl90mjsg5EXO8MFWC5j1/l4eU3VM5D8YHZg2UMZK73CxOgXzzm
         MaWRCuwn3bZTKK7fH9OZF/Re8Fi4ghQxzi3rBpJ2Gmims7eCnGba88ryWwC6c9FGAs/6
         sgY//Z0/Nj+jCl41Za5EDy9thGg1Ps3jplScT0Gzy1G9YSABTw+2CzqEb2mAjOuM+4qL
         5FFpNEq+E66kUep1oaqaHhTnAmih9JpmVckTaFxLkNf+b6m695Z+fyf0Y6ibDHQooDs9
         BOXoBOWROyBDcdys4RmMfMj8IPGeDnoe99bbOSVPWwiyC76Jmh2u6qzdxRazNeI7IhHb
         w1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lV+PWS6h5YsTugRvYXVkVMVA3Y637YXU6QnwmmlucsU=;
        fh=gONNCr0JXzR5I3p3YK/9HLbclAVat/0RUvXkPjaZYD8=;
        b=X6IQXxVOynXEgZmPxtZdqRQRe20aimUs8U0RCSH/UI59pgisHjL/jXfNU2vRGWwB3j
         uJ3BpDRrYZvFVIxARfkILqJoiydh8zf/nqTtEeZV+iK9Bt6n6BXWPBKli2o2cbIgLo4a
         ZzJ6eTeuyb+2XxxVd0+E3QV7WKjpnt+BTUFwMxEER/FYnt/nydN65NipjG2tcNLJIsAY
         sXERnJoVjcOg88kEuigzsD8KWp5qmpHmIn/OSdJnqspfuJDdeiwne2ZCoClpnx8Xs1xk
         fqLfIrbIdIooiIjgcI22myTmvTGewnJOIafQbPbzedRSBL2U4D9KGvnqgOtXGkSp3qKe
         xx0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777826795; x=1778431595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV+PWS6h5YsTugRvYXVkVMVA3Y637YXU6QnwmmlucsU=;
        b=LwpDfoqRRUUb1UVKoIAAo4bld4m00G4+bFiEaVlCP1gnddr9nd0jF+lQ8lccFNLeQT
         43cfHHEuJE/fnyo6cp4agULY/cMhbFSkGlm4LbxVUzl1mNP5b716d4t4TuD2vFhFjrVZ
         4QF81mbyqbt1KLgvmDRHFeoSju5ABmJvVqvvG8uDxn3Mu7PrmEHfPsP3vrWlpKmY1rgk
         Bt3L/UgERg+OQ3yWm9go4ipvh8SusV1JnNZlB0c33KSqSsMxb7cXwtBiKX6rcPVTxode
         BUFELIabuOjsNtSrIlNxuYZ+GuQj2ytDCvV/vDNX9nyoSziOprS0/9W08DWdK/xOp9jR
         WUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777826795; x=1778431595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lV+PWS6h5YsTugRvYXVkVMVA3Y637YXU6QnwmmlucsU=;
        b=KD4UvbPrN/RTPo5DmodVzAsLUG29LC5D2C200x+we0KRR8KvBdzwtFx1s7NfgDDBeR
         njSr24tYhavxf2QCOZl3bPWOweFDU5qYUvwAVdnsxCVFPXy4Mf2Xc4yneQRgot/tPMy8
         t8+omSGL4PmfNnIdg9vr6ctfzI1ar61qQCsb4tws3dY08xc7m1BFtEVIqdcMJh03hL7R
         nM0lHqJEoippiUbiZ6e50aUbg7BJ00o7AiaUz/c5drgfGnkXD0H38JOSAS4IPmyomhla
         4Hv1GQ2l1NnOlb+EYtOx0pJz/8hdho9BPN3LomTLO22sZHJWF1aHItxmr4cA7baz9aBd
         WEiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wXIlUxv3kFYmu3JF/Es53zP0IlyF8mje8RXURcjmG0eMNJZpRslG98ygU+Fhp+and/+I4cVZFK27ClS64eGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrrVLUIDcwxL+gW4rpGMP31ykF/riJ0Sa8NtLxmQj/w1xO3Ju
	rynkPm41uf0G5ybHD/4H4rsQpYTZQRrEX3d9YJN47m/jkC5VHgHlyzIwEt7WWblbxMx0lXpnS2T
	GnZfMQu/tC3ceaR9lDJL0+nwd9fCMmfce286juBdw
X-Gm-Gg: AeBDieu9jEBJqR2tLTnDWmcdOBXrrWAH38QTNi+erFppqQEgyT+sqqQk11R0b91RbV7
	XCDycSlbT2B6HkFpITaPbuC1JnqC28Ya1BfoTK7if1drde1ebDQ1nuTmRYgkCbWoAiwx6vgy6cX
	RHAyFQ8tlK3N75psIaDsxRsMQGXqVHoqW89aRIMrxLskxM74lfYrfo0i9M0M09HU3HcDUmPK41o
	jmNWiSYqNoHt3YlwQb2N1zKYs55uNF70N6nuwuPiiIx8YBki3vdz6vvGmcsLe9mW38FFeqrZa4A
	fIl1O/xbHX9njOO3UAP9hOkX1jGZ
X-Received: by 2002:a17:90b:3e46:b0:35e:5ae3:298a with SMTP id
 98e67ed59e1d1-3650cece2d0mr6631879a91.18.1777826795343; Sun, 03 May 2026
 09:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777036497.git.noodles@meta.com> <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com> <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
 <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com> <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
In-Reply-To: <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 3 May 2026 12:46:23 -0400
X-Gm-Features: AVHnY4L2at1Ee87namZ-f-yBAzCWpTyJONd_xc3EwssaGjpCZndG6MYs1AyLIxg
Message-ID: <CAHC9VhRE2kRr1fdDf6xgQgpSrtvqtP8Vy9LVGJhDZFUbzLKGmQ@mail.gmail.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jarkko@kernel.org, jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org, 
	oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	noodles@meta.com, sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A88344B6910
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9406-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:url]

On Thu, Apr 30, 2026 at 9:51=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Thu, 2026-04-30 at 18:35 -0400, Paul Moore wrote:
> > On Thu, Apr 30, 2026 at 5:39=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Thu, 2026-04-30 at 10:48 +0100, Yeoreum Yun wrote:
> > > > With above change I confirmed there is no meaurement log
> > > > between boot_aggregate and boot_aggregate_late except "kernel_versi=
on"
> > > > But this is ignorable since this UTS measurement is done in
> > > > "ima_init_core() (old: ima_init())" and it is part of ima initialis=
ation.
> > > >
> > > > 1. ima_policy=3Dtcb
> > > >
> > > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000=
000000000000000000000000000000000000000000000000000000000 boot_aggregate
> > > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000=
000000000000000000000000000000000000000000000000000000000 boot_aggregate_la=
te
> > > >   10 7c23cc970eceec906f7a41bc2fbde770d7092209 ima-ng sha256:72ade6a=
e3d35cfe5ede7a77b1c0ed1d1782a899445fdcb219c0e994a084a70d5 /bin/busybox
> > > >   10 17ec669c65c401e5e85875cf2962eb7d8c47595f ima-ng sha256:dc6b013=
e9768d9b13bcd6678470448090138ca831f4771a43ce3988d8e54ffce /lib/ld-linux-aar=
ch64.so.1
> > > >   10 58679a66ac1de17f02595625a8fbeafa259a4c81 ima-ng sha256:494f62b=
cfb2fcf1b427d5092fafa62c8df39a83b4a64402620b28846724f237f /usr/lib/libtirpc=
.so.3.0.0
> > > >   10 42f74ee200434576e33be153830b3d55bbe6d2bf ima-ng sha256:a18856b=
4f6927bc2b8dd4608c0768b8f98544a161b85bf4a64419131243ad300 /lib/libresolv.so=
.2
> > > >   10 626b4f7bd4f123d18d3a3d8719ed0ae19ee5f331 ima-ng sha256:b8d442d=
e5d31c3f9d1bbb98785f04d4a23dc53442b286d85d4b355927cbe9af4 /lib/libc.so.6
> > > >   10 655a200869696207646377a58cab417fd35b09d2 ima-ng sha256:ad46146=
b6dd32b47213e5327f1bb2f962ef838a4b707ef7445fa2dbc9019b44f /etc/inittab
> > > >   10 81353202685e022fcd0069a3b2fc4eaa6b1db537 ima-ng sha256:74d698f=
e0a6862050af29083aa591c960ec1f67be960047e96bb6be5fc2bc0c0 /bin/mount
> > > >   10 ae64184ee607ef8f3aa08ab52cb548318534fd4b ima-ng sha256:27846b5=
7e8234c6a9611b00351f581a54ad6f9a1920b9aa18ceb0ae28e4f7564 /lib/libmount.so.=
1.1.0
> > > >   10 5ea01f34e7705d1bdb936fd576e2aeb5fd78dab9 ima-ng sha256:3d2a414=
ec0355fcf0910224fb4a3c53e13d98731a35241edfdf4fb911ed9b210 /lib/libblkid.so.=
1.1.0
> > > >   10 22c48b4853594a08a73ad4ae6dbe6f2c2bebc6c5 ima-ng sha256:e3b0c44=
298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 /run/utmp
> > > >   10 3024ea5021f8a5d9fb4bd519d599bdca43b7fb93 ima-ng sha256:71ea9ff=
e2b30e5a9bdceff78785cf281cc41544474db8dc4605a06a597ce1edc /etc/fstab
> > > >   10 2e7530a0f56420991ac7611734cea4774b92b9ef ima-ng sha256:df4697d=
699442cfe73db7cc8b4c1b37e8a31e75e01f66a0d70134ac812fa683b /bin/mkdir
> > > >   10 3ad117a863aa1ed7b7c09e1d106f84abf7d2ae96 ima-ng sha256:c19a710=
989b43222431b02399273dba409fe10ca8eefff88eaa936fa695f8324 /bin/ln
> > > >   10 4141c82cb516ac3c846e0b08abcd6abeee7efa1a ima-ng sha256:b75d7f2=
8772f71715a941c77e07e3922815391dd9cc5718ad21f2231c2da09bb /etc/hostname
> > > >   10 dfcedd3c7dc3ed42e09219804504489ab264e2e3 ima-ng sha256:dc1615d=
f9f2012b20b81ffad8e07e16293039ba7fd897854ca3646d6cfea0c0f /etc/init.d/rcS
> > > >   ...
> > > >
> > > > 2. ima_policy=3Dcritical_data
> > > >
> > > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000=
000000000000000000000000000000000000000000000000000000000 boot_aggregate
> > > >   10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf sha256:0c907a=
ab3261194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2 kernel_version 3=
72e312e302d7263312b // Ignorable since it's generated by ima_init(_core)().
> > > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000=
000000000000000000000000000000000000000000000000000000000 boot_aggregate_la=
te
> > > >
> > > > Therefore, init_ima() could move into late_initcall_sync like v1 di=
d:
> > > >   - https://lore.kernel.org/all/20260417175759.3191279-2-yeoreum.yu=
n@arm.com/
> > >
> > > Thanks, Yeoreum.  It's a bit premature to claim it's "safe" to move t=
he
> > > initcall.  Hopefully others will respond.
> >
> > Is it not possible to look at the code and determine if it is safe or
> > not?  Or is the initialization of TPM devices at boot done in a random
> > order with respect to the initcall levels?
>
> The TPM is normally initialized at the device_initcall, except when other
> resources are not ready.
>
> (Abbreviated) AI explanation:
>    If the TPM's first probe succeeds at device_initcall with no deferral,=
 IMA
>    finds it fine. It is only when the TPM is pushed onto the deferred lis=
t that
>    late_initcall can execute before the retry succeeds, leaving
>    tpm_default_chip() returning NULL.

I really hope you are using AI only to phrase a response and not as a
substitute for actually investigating the code and determining what is
happening.

Regardless, assuming you always want IMA to leverage a TPMs when they
exist, your reply suggests that using an initcall based IMA init
scheme, even a late-sync initcall, may not be sufficient because
deferred TPM initialization could happen later, yes?

--=20
paul-moore.com

