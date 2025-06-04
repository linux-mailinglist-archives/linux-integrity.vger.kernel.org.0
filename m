Return-Path: <linux-integrity+bounces-6360-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED8ACD8CD
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jun 2025 09:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B769F189663E
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jun 2025 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03A149C64;
	Wed,  4 Jun 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvlWTmPD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0131F03D9
	for <linux-integrity@vger.kernel.org>; Wed,  4 Jun 2025 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023277; cv=none; b=kePxlmwZM3qqJeE+jzJ8OAw6Ma9G2e5tCJqh+rFCEVexrOxSf8iKI6mi9f0hs/2oOYv3EIUIwcQaHHfy7VSR3RTA+NN5Oz8A8JNiwW0SBDm/8Jn7ocH4Vyp3jGUEDltmkrKmPWpfGWOS27CeJ/XVxbOi5YfqmIhQOJ1YBCgJSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023277; c=relaxed/simple;
	bh=t2007AxeJCzN8DYFU1TDmOYxveSLIawRFTPoFEFfSlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehNNOSFKfA2taes69He0q1vpis0I7mQsyQ/jfDHpXq1NDcyH5OFk+cHa+17E7tVcqc3nCQSMb/FyB0u6ihlfp9qXJU97LJs+Semc543ANVLrVLBjvrpEGjwybNRehpjGW90HPwbPWl+2v95yKUCJ9Wm0H6E9B/zLZuDds9H9mFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvlWTmPD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749023274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ygmWQWXbYd84BZ22kC3DM6odLW06NCGE4pAVf3jq5k=;
	b=RvlWTmPDymK55iwxv8wYT0bUunm1R3r6lMmXhVA39KxN5fYZ9cMbPx7GjNs5/7iNWR+K6w
	zV5FLFbGgxNpYgmDfol/s9Rqu0m5vGHZ2OgDZjKyPMj3MFNI5Wlahx7y8TKsqoSLZIAsZM
	hfGZHvnC6sAu5eKyNTLob12SQ+dmii8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-v9oQEI-JOFO_vK72vYvlBw-1; Wed, 04 Jun 2025 03:47:52 -0400
X-MC-Unique: v9oQEI-JOFO_vK72vYvlBw-1
X-Mimecast-MFC-AGG-ID: v9oQEI-JOFO_vK72vYvlBw_1749023272
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450de98b28eso2885575e9.0
        for <linux-integrity@vger.kernel.org>; Wed, 04 Jun 2025 00:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749023271; x=1749628071;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ygmWQWXbYd84BZ22kC3DM6odLW06NCGE4pAVf3jq5k=;
        b=axDDylduvj+fxhbfru90/Sf7waDKU4bKxV8BSkVLWpa1p0ER6Nf5de5BBWkmYECVTT
         wsoxMgbWjiE47d3x9SRh7pTS2PwiA9Qpofgn77qr2pJIrKQ1Usu0J0EXQMhWwOdIRiEQ
         fDZCAVbpZv8BjgYgGbvl9zgrbMqlb7QZEBuwDWDUOnJT7KPsejYui9zVzj5NAW0lBKlT
         lIlU5ZkJWBGf6Q1mq7gR5nZxInzbAGQhrfcdvj4C+vDpW3L/Hs65Et5xpDG1Qg8OwWl6
         1hAY9mEmatVlTNuHzx8srB3Joos71IySiXWSRKQ9dWQRhCMlhWEl+dWuCNe9/bKeK0X6
         S4HA==
X-Forwarded-Encrypted: i=1; AJvYcCXMX9SHNg3UKWaVRlZ3qzesvhOD3jqzbC8KzZVrrog1rKvTBatstXUZK4FW+dRhEj+B+Y3ZzWziAiLRGoFYftU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxl6307t7W5HEUYW4RP1pBjJu9JwXZbRXcg6M92WMIGBPTMdRU
	FliEDJtaa5aax092axD7oGJ5UPUR0shysbzG5Zi7Vwx2YVDf6szTZzfPFDbBD7tW7aAv3i64PLm
	9d22gfhVoO9BOCz4qWNeoSxefo8qBo/UnNXKlzamU5zd129OXK+FUPluSnQ15EFNUNVEv8A==
X-Gm-Gg: ASbGncsjUCabebEmIWq/T4sJsfsf9VZmg+tWBKAdIWOH7vA6cDihpnArsWesotaFGyL
	+t9f2hYcZ6yRw0KYvH6HEUDVdN7vnnxBPLpd7TVc6a3TGmHxHddyB8vRaitUEkI8ClN4c6BGgHz
	50z7nTRaUjK3a1hOdxmpwodBC/aDS5ugPP1dlQxPhPXa9PUGft8EoZJUrL42oRZ9GknTwm2jSas
	mBc6PJcl2HKcnlqsDZV+Bz2oeKAxtcywKB2Om935taBvicxhhYGFqyEJPZn9YAepZodR/8cXNf6
	DW40X4c=
X-Received: by 2002:a05:600c:4f46:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-451efeb62edmr16204785e9.13.1749023271457;
        Wed, 04 Jun 2025 00:47:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJk55eb8TjJoA47+XoMh9gAce9YiEwRtdQfUP3XiuiMssBNBDp3zfR4HUA5bIORLwXMaPKeQ==
X-Received: by 2002:a05:600c:4f46:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-451efeb62edmr16204515e9.13.1749023270973;
        Wed, 04 Jun 2025 00:47:50 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d8csm188712405e9.24.2025.06.04.00.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 00:47:50 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Peter Jones <pjones@redhat.com>, Robert Holmes
 <robeholmes@gmail.com>, Jeremy Cline <jcline@redhat.com>, Coiby Xu
 <coxu@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 1/1] module: Make use of platform keyring for module
 signature verify
In-Reply-To: <d34555e2b0c4746fc01d5295959a434befcf8b18.camel@HansenPartnership.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <20250602132535.897944-2-vkuznets@redhat.com>
 <948f5567fe4d9ae39aa2528965f123e42bf82b46.camel@HansenPartnership.com>
 <87r001yzob.fsf@redhat.com>
 <d34555e2b0c4746fc01d5295959a434befcf8b18.camel@HansenPartnership.com>
Date: Wed, 04 Jun 2025 09:47:48 +0200
Message-ID: <8734cgosm3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Tue, 2025-06-03 at 10:52 +0200, Vitaly Kuznetsov wrote:
>> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> [...]
>> > Also, are you sure a config option is the right thing?=C2=A0 Presumably
>> > Red Hat wants to limit its number of kernels and the design of just
>> > linking the machine keyring (i.e. MoK) was for the use case where
>> > trust is being pivoted away from db by shim, so users don't want to
>> > trust the db keys they don't control.=C2=A0 If the same kernel gets us=
ed
>> > for both situations (trusted and untrusted db) you might want a
>> > runtime means to distinguish them.
>>=20
>> I was not personally involved when RH put the patch downstream (and
>> wasn't very successful in getting the background story) but it
>> doesn't even have an additional Kconfig, e.g.:
>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/co=
mmit/03d4694fa6511132989bac0da11fa677ea5d29f6
>> so apparently there's no desire to limit anything, basically,
>> .platform is always trusted on Fedora/RHEL systems (for a long time
>> already).
>
> It sounds like that's just distro politics:  RH wants to enable binary
> modules (by allowing them to be signed) but doesn't want to be seen to
> be signing them (so they can't be signed with the embedded RH key) so
> that gamers can have performant graphics drivers and the like.  Thus it
> mixes in the db keyring, which usually contains several Microsoft
> certificates and also one from the ODM manufacturer, so now it can send
> would be shippers of binary modules to those groups to get them signed.
> If you only have the built in and MoK keyrings, the only possible
> signers are either RH or the machine owner ... who isn't a single
> entity to deal with.  Personally I think this is a bit daft: Debian
> manages an out of tree module infrastructure using DKMS and MoK
> signing, so I can't see why RH can't get it to work in the same way.
>

I guess such approach can be used with some limitations: the out-of-tree
module must be open source, the vendor of the module must commit to
fixing (inevitable) module build issues when the distro updates its
kernel and so on. It, however, doesn't help the users which want to
build and sign their own modules themselves.

>> As part of the RFC, I'd like to try to understand under which
>> conditions people may not want to trust 'db'. In the most common use
>> case, 'db' is used to authorize shim and the kernel is signed by a
>> cert from shim's vendor_db, not trusting 'db' for modules after that
>> seems somawhat silly. Maybe we can detect the fact that the user took
>> control over the system with MOK and untrust .platform only then
>> (while trusting it by default)?
>
> Well, I think it's pretty obvious that in a standard secure boot system
> most people wouldn't want either Microsoft or the ODM manufacturer
> being in a position to sign module code for their systems.  Indeed,
> when this was first mooted by Red Hat years ago, I thought Microsoft
> refused to be the CA for our modules anyway.  From a security point of
> view, it's separation of concerns: the standard secure boot database
> guards access to the UEFI boot time before ExitBootServices.  The
> kernel is a completely separate security domain and should be guarded
> by different keys.
>
>> A runtime toggle is not something I thought much about: the sole
>> purpose of this part of 'lockdown' (limitimg unsigned modules load)
>> seems to be to prevent someone who already has 'root' on the system
>> to gain kernel level access to e.g. hide its activities. In case root
>> can decide which keys are trusted, isn't it all in vain?
>
> Not exactly, the purpose of lockdown is to make root less privileged
> than ring 0 (the kernel), so that a user space privilege escalation
> does less damage.  The gold standard for all of this is supposed to be
> to foil an Evil Maid attack (physical access) but I don't think we're
> quite there yet.  From the point of view of the keyrings a lot of
> others (like .ima) have trusted signing requirements meaning root can't
> simply add keys, they have to be signed by keys in the existing trusted
> keyring as well.
>
>>  Or maybe if the toggle is to just trust/not trust .platform (and not
>> e.g. disable signatures verification completely, inject a new
>> key,...) this is acceptable? Another option is to have a kernel
>> command line parameter but this is complicated for users.
>
> I was thinking that if the goal is simply to enable cloud db then the
> toggle could be detecting the presence of the MoK variables.  However,
> if the distro politics thought above is correct, that won't work for
> the RH use case of enabling additional binary modules by getting others
> to sign them.  Until we have UKI signing of the kernel command line,
> it's not such a safe vector to use for switches like this because it
> makes the Evil Maid problem worse (and they're hard for users to manage
> anyway as you say).

(FWIW, RH-signed UKI is already present in RHEL/Fedora/derivatives along
with a set of good known UKI cmdline extentions ('fips=3D1',
'crashkernel=3D...',...) so adding e.g. 'platform_is_trusted=3D1' extension
*is* possible).

So if we consider trusting/not trusing platform to be a distro choice
("politics"), then I guess the suggested Kconfig approach may make
sense? I, however, quite like the idea to complement it with an
automatic toggle based on the MOK status: we can make the Kconfig a
tristate:
- Platform is never trusted (current approach)
- Platform is always trusted
- Platform is trused when MOK is not used
To me, this third option makes sense: if a user wants to take ownership
over the system, they can use MOK and sign the kernel itself and/or
out-of-tree modules with it. If the user doesn't care, then there's no
reason to not trust 'db'.

--=20
Vitaly


