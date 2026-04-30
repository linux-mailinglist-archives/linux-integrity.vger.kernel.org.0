Return-Path: <linux-integrity+bounces-9392-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BheD1rZ82kJ8AEAu9opvQ
	(envelope-from <linux-integrity+bounces-9392-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 00:36:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F564A8958
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 00:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3320E300B5A3
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 22:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74243A1E69;
	Thu, 30 Apr 2026 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T6sPXz0e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5F39EF02
	for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2026 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777588564; cv=pass; b=slgiT0FQKHKGkIjO4Wo6FwM4rUayEgddxscdsW9T2XfkaKrOeAUmT+ytKqRwFZ+LZgsrQqje048gSTM9TI29V3CYF8FjPlylPI+e2N0e2ypgB+q+KaeWLIhMqcbuEqRqMVVnpLZMn81Dg33VuOueX/FX4AyECXUHMd3xuE7kAgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777588564; c=relaxed/simple;
	bh=RupXQyAldnCzNNGczOH42PPaEYMriYyLdhvSATo5FwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLclvJgs03nd/PrOnc6/EzPzexH1SynGc7SAiy8OBc70D7lPeXJenhAFjsJjnleyPOXRTWP7ChPVABCU+2I9Ctsj5XewXohaiyBWnbqX+qc33K/4YeGAgSV47DbifznVML5sqkdZKHYa/isl2ZiqWp80DRemAX4eRvLMqoPC78w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T6sPXz0e; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d965648a2so1652540a91.0
        for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2026 15:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777588563; cv=none;
        d=google.com; s=arc-20240605;
        b=SDlUzVQhPzeU2RChYnnqD6vWPywr3KeeRRHFiEso+ihZeQSzJdSF4WGqx7BgqvpYT8
         1gPZuyZHRf0KoGTOQmU6XK8Txp2dyG5LvRw27O/+MrSX7ZCwmPYrMUqSC7Y8LZEDnhkL
         chh7EKKqpRyp//ged8BSyNZyUMuRqRa82ukdmV7I2omiNIdehrBncXH2XW+zsSjaA/7y
         zDH9p1H97x0NcYnGxO/CraV/j6VmDAtJlHH7Gezhusn52MsA9Ue8nVdlRlH+y3X10Lua
         0D2g0yQTrN17dTONs32x+ivZgGw0hQmfGy3VOIvHvKLVzIWnQ7lKO/jp9lO/wBM4Jx6k
         6lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HdHOWqrJRE/TIxXfheRFRvDV3pWT8VAKvfg7GHpSJqI=;
        fh=0nOmxwxnqtIJggQjSde6OLLJiIg5XYduJbOTzvv8v/w=;
        b=kGmylkOvMO85NNjJ/oo3eiM/fBlah0cmP63WsvP/XCRxU+A24lhFWZ8nctRs89MHiu
         RNgB7fSu3MLXj1ibhJvIIgX4fKDqCGy61kSjrUSjlUkkebgkQnQQ8F9LhhOb1brJN+b5
         QOsHs6NZF18mm9w+ftgyhB1l/1OhPVCZhMqCbZMzQMtzC913/ifUfeZWj+HTPLemdMWH
         E/hpfxX2RrLof4aoYsskbSHLOjKtMiftZDdOoatoVCu3fAvhTt7xIFUBBHWIQsctaEq6
         +VVWb+j7dQ8CKedtj9jwuuGCDmNGYKjcJkUpr3vRGPuZ+6H1YFk55sMfIFeHqvOE+w8l
         B+xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777588563; x=1778193363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdHOWqrJRE/TIxXfheRFRvDV3pWT8VAKvfg7GHpSJqI=;
        b=T6sPXz0eadwdoPIizJagyxBpBm7jV0gs3heFMhWlDi3T7m+KWWnfOkYK90etmq/qER
         uvx4gM2hzQ0gcp6R2OJNuriXch/vEknYOoAwwvO8jhRb8D/vDhjile6aE1Sd+EnE3a/k
         QjjN10k7gWTozw3wnFXanHsEPE6TRzLo+3/T4Gvfmty4XpOYxETQ5NqfaMtNlJUgXDxC
         BPdjDudWByJMeJaYAXQGIEnu6LYuDB0mGYlBVztI2ezTjLQ0QmSDrR/5TBWCv7kz+5E/
         dkqrTH3jNd7BT5vcWFk6nq5ykFl0BZ9ym93Eauzr3TdaRCpcSGy6ajE13I2mhuwH+ux6
         kEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777588563; x=1778193363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HdHOWqrJRE/TIxXfheRFRvDV3pWT8VAKvfg7GHpSJqI=;
        b=U6rAEF0ihcJXK8YvlBURDYqfpfEgq8s7qUBijHUv0Fxrc2fY6voP8wRIMEp+g/46L1
         CuW/mWsliuHyzfWcvap9+n2b6AdNfbhc/DeF2FRn8uhHZ+WBIIeAU/BOm9ATrWjSPqH0
         j7mt928UmGoiMbIFsGCYRDKWVGSTACLSNzr+9PmLodBNng1AMFUBjVpHB8FWEcSLnzjT
         MgozKzKhhmStGXORkpttkaTBj37dh3D/3F2HWBTeLPhZyXyzY3d+VTEtgRubmR7Ummj6
         utRZoa1R9xyuBddiSMjQsuew61t+3aSWXt7/0dZSpK9bT6AXDcrXInXuIxECaSTDUbjj
         DByg==
X-Forwarded-Encrypted: i=1; AFNElJ/RoEqP+7kOGEB20+WKLtAGTdrlv0Ogr9BUJBMMiA8HiJIp//tDhdgskMcJNcsVbAExRGN/xi2+lPjcHm9XWtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHEsQsWJLDtHm8fMZo+Uz0PBYe9bWxOmT+UNNzIHy0Dje/GSg
	8EP2pFs7Mpbg7Px5OKd/xpaEWP0MmEaueMlAcocRlUufCKgwD0YcJtsadjONS5EPg4sye8AM77L
	q2fk10pWBX8NJSaM/l7zwKeswqOKvXNC+3eooma7/
X-Gm-Gg: AeBDievfDGHeTUy3krgcgg7hAy9ILHpDfigqTExUh/7gPiEezioeTonP1opst8wgi9s
	/6SSFcOGQVjrqrAaLdZHZCC7AJpb2wnMa8Kce6XJ+AqdpDDHyafkdfTcmNFexp/KwtQe3PDn3Tc
	R33fqV9PX6uN2uVXAUz3p9d69qqQwXT8IvRPBtRgPhRb4/gDrZ/AOshBCljweJJv0CfbEuGx4dL
	msmsF5jr3TMlTm52XZ/Szo0Jxqa+frpAKEfMA6WQzHIa2s6cxj0Y0asW2GmLqaHC5izYwLxZjQy
	v3zuDpnNOGBWDt66Xg==
X-Received: by 2002:a17:90b:3911:b0:35e:5929:d78d with SMTP id
 98e67ed59e1d1-364c2f0a149mr5141150a91.3.1777588562768; Thu, 30 Apr 2026
 15:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777036497.git.noodles@meta.com> <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com> <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
In-Reply-To: <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 Apr 2026 18:35:51 -0400
X-Gm-Features: AVHnY4LdKYNPArKuQ8yWbQCW6t_Frk0rXn10CBP9XbvLgaV8zkcfCZpOFGUTse8
Message-ID: <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com>
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
X-Rspamd-Queue-Id: D0F564A8958
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9392-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,paul-moore.com:dkim,paul-moore.com:url,mail.gmail.com:mid]

On Thu, Apr 30, 2026 at 5:39=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Thu, 2026-04-30 at 10:48 +0100, Yeoreum Yun wrote:
> > With above change I confirmed there is no meaurement log
> > between boot_aggregate and boot_aggregate_late except "kernel_version"
> > But this is ignorable since this UTS measurement is done in
> > "ima_init_core() (old: ima_init())" and it is part of ima initialisatio=
n.
> >
> > 1. ima_policy=3Dtcb
> >
> >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate
> >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate_late
> >   10 7c23cc970eceec906f7a41bc2fbde770d7092209 ima-ng sha256:72ade6ae3d3=
5cfe5ede7a77b1c0ed1d1782a899445fdcb219c0e994a084a70d5 /bin/busybox
> >   10 17ec669c65c401e5e85875cf2962eb7d8c47595f ima-ng sha256:dc6b013e976=
8d9b13bcd6678470448090138ca831f4771a43ce3988d8e54ffce /lib/ld-linux-aarch64=
.so.1
> >   10 58679a66ac1de17f02595625a8fbeafa259a4c81 ima-ng sha256:494f62bcfb2=
fcf1b427d5092fafa62c8df39a83b4a64402620b28846724f237f /usr/lib/libtirpc.so.=
3.0.0
> >   10 42f74ee200434576e33be153830b3d55bbe6d2bf ima-ng sha256:a18856b4f69=
27bc2b8dd4608c0768b8f98544a161b85bf4a64419131243ad300 /lib/libresolv.so.2
> >   10 626b4f7bd4f123d18d3a3d8719ed0ae19ee5f331 ima-ng sha256:b8d442de5d3=
1c3f9d1bbb98785f04d4a23dc53442b286d85d4b355927cbe9af4 /lib/libc.so.6
> >   10 655a200869696207646377a58cab417fd35b09d2 ima-ng sha256:ad46146b6dd=
32b47213e5327f1bb2f962ef838a4b707ef7445fa2dbc9019b44f /etc/inittab
> >   10 81353202685e022fcd0069a3b2fc4eaa6b1db537 ima-ng sha256:74d698fe0a6=
862050af29083aa591c960ec1f67be960047e96bb6be5fc2bc0c0 /bin/mount
> >   10 ae64184ee607ef8f3aa08ab52cb548318534fd4b ima-ng sha256:27846b57e82=
34c6a9611b00351f581a54ad6f9a1920b9aa18ceb0ae28e4f7564 /lib/libmount.so.1.1.=
0
> >   10 5ea01f34e7705d1bdb936fd576e2aeb5fd78dab9 ima-ng sha256:3d2a414ec03=
55fcf0910224fb4a3c53e13d98731a35241edfdf4fb911ed9b210 /lib/libblkid.so.1.1.=
0
> >   10 22c48b4853594a08a73ad4ae6dbe6f2c2bebc6c5 ima-ng sha256:e3b0c44298f=
c1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 /run/utmp
> >   10 3024ea5021f8a5d9fb4bd519d599bdca43b7fb93 ima-ng sha256:71ea9ffe2b3=
0e5a9bdceff78785cf281cc41544474db8dc4605a06a597ce1edc /etc/fstab
> >   10 2e7530a0f56420991ac7611734cea4774b92b9ef ima-ng sha256:df4697d6994=
42cfe73db7cc8b4c1b37e8a31e75e01f66a0d70134ac812fa683b /bin/mkdir
> >   10 3ad117a863aa1ed7b7c09e1d106f84abf7d2ae96 ima-ng sha256:c19a710989b=
43222431b02399273dba409fe10ca8eefff88eaa936fa695f8324 /bin/ln
> >   10 4141c82cb516ac3c846e0b08abcd6abeee7efa1a ima-ng sha256:b75d7f28772=
f71715a941c77e07e3922815391dd9cc5718ad21f2231c2da09bb /etc/hostname
> >   10 dfcedd3c7dc3ed42e09219804504489ab264e2e3 ima-ng sha256:dc1615df9f2=
012b20b81ffad8e07e16293039ba7fd897854ca3646d6cfea0c0f /etc/init.d/rcS
> >   ...
> >
> > 2. ima_policy=3Dcritical_data
> >
> >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate
> >   10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf sha256:0c907aab32=
61194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2 kernel_version 372e3=
12e302d7263312b // Ignorable since it's generated by ima_init(_core)().
> >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate_late
> >
> > Therefore, init_ima() could move into late_initcall_sync like v1 did:
> >   - https://lore.kernel.org/all/20260417175759.3191279-2-yeoreum.yun@ar=
m.com/
>
> Thanks, Yeoreum.  It's a bit premature to claim it's "safe" to move the
> initcall.  Hopefully others will respond.

Is it not possible to look at the code and determine if it is safe or
not?  Or is the initialization of TPM devices at boot done in a random
order with respect to the initcall levels?

--=20
paul-moore.com

