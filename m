Return-Path: <linux-integrity+bounces-6353-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8764ACC278
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Jun 2025 10:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF20F18918E2
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Jun 2025 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399B02690EA;
	Tue,  3 Jun 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VO5Miahl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40745223DCC
	for <linux-integrity@vger.kernel.org>; Tue,  3 Jun 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748940781; cv=none; b=m6ACzi09HyDEHsrYjzZ5Q1rjFBKl+PErM3JS8DG8xTIX/hJY5v1FRnOdUsYQskLQsr8jRjIqfmCUNfN6+MRr7nub6pbD9PqcUqMJxYF1qF6c1CpPH52bBhzR6CjHkp3pHV8QX4+k/eY9f/2ZDbhF810h6bZsFtdx+TEiQ9SXAKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748940781; c=relaxed/simple;
	bh=9/C2MTtGy92Vv0hPG8laZGxliqByuslaG4nla4YUdig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cD5zd/h4Ek1csPJlfNhiE39ZyajKEG0nm+8V62ei1xoaqVc1K3SJCyvE++JNMq1R+QcsBLnnEp0HPrBheHX+QlOzTgzBvJbYG/y8Ka8PONiGEzYI70fM62dG2wDNW4WidgW13ePzuWWDAroVMR/0EBuVZJCbQ9IxapvNt1jYC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VO5Miahl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748940777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fokWVoE1/UZZzyISn1y7Db8mSF3EnEdFgZvjp1rn9Hg=;
	b=VO5Miahlqqj311drb25ZuizB7Dlf6lnnbXzn72Bn9CdWLbwB7ss7EhAl8I1oM0Yrk5zsNI
	kf70S+Yv8qrQysBpxatzzC/2eOb5CUeXgJvIblRjQ+vuqdNuhWizxGOxO3hDUpjrdRZGUU
	sBrhq252EL8XT/nAxOHJe9IAPG83k+w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-PcbBkAA0NoajN9J-ncwf8g-1; Tue, 03 Jun 2025 04:52:56 -0400
X-MC-Unique: PcbBkAA0NoajN9J-ncwf8g-1
X-Mimecast-MFC-AGG-ID: PcbBkAA0NoajN9J-ncwf8g_1748940775
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f6cc5332so2755221f8f.2
        for <linux-integrity@vger.kernel.org>; Tue, 03 Jun 2025 01:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748940775; x=1749545575;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fokWVoE1/UZZzyISn1y7Db8mSF3EnEdFgZvjp1rn9Hg=;
        b=p+lSvHRVYQoH266vTDUeGGN0eLZR0AiUlvfXhR1h2RXFI1GNBVmaTYZPoblTTaJQ8o
         dHRIYNnO0+ahdmlzOhtPmed+n4DKexZUYm4kHD8r8jsDaNHJPWMpT67Wz3OACN4+ANoL
         a+JghhVGnZc6H3ApuPmMxnWtDwRsO+bm8fy7KSE2RsnJKWhVothyHccT1OIIETRKMs1A
         dsDfEslGp7cFwPo5QDqlamqbsuQGUtBaW04EggfWsR0twyjY/O5kErLSEUWXyDwcAXHO
         O3fhCWVdXOwD5CaQ8Tox+2aJXx1YE7sCFDA71/WACnDpSFgr/bMTuKemXD+A2wOtWxaG
         +B9g==
X-Forwarded-Encrypted: i=1; AJvYcCVi3wWokzudtgZSbHrHH8r9pdeD3CNvRiyzr+enJp2UKoNFmf7Xoj85X2iZ4p+yKItFIaKJ7LlkB4fwxPqh5no=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxzOFDR8sLznB61iS8trdv64sVnPnSnVZDWWaBPv7h4KzhM9gs
	whB6R7b/Zh0C/y0uhifeBYAsTTdmuYAQqcWvqC++WuOO1yf7UudQ0ig7aXtEzK2vAdwNSKWAfPQ
	TOwvJ21Y7QBNb5mVOjPCfXg1yrjRWpKqGxW6isZqMTR5qe2AkKrBcfP4nSR6Hb6eCxQSH+A==
X-Gm-Gg: ASbGncvDl/Xce1OvCh3ltb9eH3APn6NdMgKMQD7l8jY+HShOcXz2gE4jeP28llaHzx2
	26Z4JeqJVaOy8MynaQDooftpIi11l1UYZOwgHwb0XAGuZQulf0qzsera379u6ZKZaRW3JcF+Z/A
	EPazJp9dAUuzG+NPIinmlQVJbNYyPWnDZMA6dxailElKwdGqqKMOO/pgTpKPiSRKG44si5PdG2C
	Sj6dMStrk+4VseSMRDCyf00PY2+M2yDNzcRcWLyK8v5/nuaRvdz78Cd9ViE2VW8TNbWO5dQzy5O
	02Dwl0lfTZtp7u5Eww==
X-Received: by 2002:a5d:5f50:0:b0:3a4:d994:be4b with SMTP id ffacd0b85a97d-3a4f89a47a7mr12821662f8f.1.1748940774719;
        Tue, 03 Jun 2025 01:52:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGEHrNubrNeaL99rs9CvcijC7m6ROFlnCc2yKxqiTtySjgF89euRWCZceONTzwb++Fm8VsBg==
X-Received: by 2002:a5d:5f50:0:b0:3a4:d994:be4b with SMTP id ffacd0b85a97d-3a4f89a47a7mr12821635f8f.1.1748940774311;
        Tue, 03 Jun 2025 01:52:54 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c842sm17289467f8f.29.2025.06.03.01.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 01:52:53 -0700 (PDT)
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
In-Reply-To: <948f5567fe4d9ae39aa2528965f123e42bf82b46.camel@HansenPartnership.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <20250602132535.897944-2-vkuznets@redhat.com>
 <948f5567fe4d9ae39aa2528965f123e42bf82b46.camel@HansenPartnership.com>
Date: Tue, 03 Jun 2025 10:52:52 +0200
Message-ID: <87r001yzob.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Mon, 2025-06-02 at 15:25 +0200, Vitaly Kuznetsov wrote:
>> This patch complements commit 278311e417be ("kexec, KEYS: Make use of
>> platform keyring for signature verify") and commit 6fce1f40e951
>> ("dm verity: add support for signature verification with platform
>> keyring")
>> and allows for signing modules using keys from SecureBoot 'db'. This
>> may
>> come handy when the user has control over it, e.g. in a virtualized
>> or a
>> cloud environment.
>>=20
>> Suggested-by: Robert Holmes <robeholmes@gmail.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> =C2=A0Documentation/admin-guide/module-signing.rst |=C2=A0 6 ++++++
>> =C2=A0kernel/module/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 11 +++++++++++
>> =C2=A0kernel/module/signing.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 9 ++++++++-
>> =C2=A0security/integrity/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
>> =C2=A04 files changed, 26 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/admin-guide/module-signing.rst
>> b/Documentation/admin-guide/module-signing.rst
>> index a8667a777490..44ed93e586b9 100644
>> --- a/Documentation/admin-guide/module-signing.rst
>> +++ b/Documentation/admin-guide/module-signing.rst
>> @@ -118,6 +118,12 @@ This has a number of options available:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 additional certificates which will be inc=
luded in the system
>> keyring by
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default.
>> =C2=A0
>> + (5) :menuselection:`Use .platform keyring for verifying kernel
>> modules signatures`
>> +=C2=A0=C2=A0=C2=A0=C2=A0 (``CONFIG_MODULE_SIG_PLATFORM``)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 This option additionally allows modules to be =
signed with a key
>> present
>> +=C2=A0=C2=A0=C2=A0=C2=A0 in ``.platform`` keyring, e.g. a SecureBoot 'd=
b' key.
>> +
>> =C2=A0Note that enabling module signing adds a dependency on the OpenSSL
>> devel
>> =C2=A0packages to the kernel build processes for the tool that does the
>> signing.
>> =C2=A0
>> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
>> index 39278737bb68..f1b85c14548a 100644
>> --- a/kernel/module/Kconfig
>> +++ b/kernel/module/Kconfig
>> @@ -340,6 +340,17 @@ config MODULE_SIG_HASH
>> =C2=A0	default "sha3-384" if MODULE_SIG_SHA3_384
>> =C2=A0	default "sha3-512" if MODULE_SIG_SHA3_512
>> =C2=A0
>> +config MODULE_SIG_PLATFORM
>> +	bool "Use .platform keyring for verifying kernel modules
>> signatures"
>> +	depends on INTEGRITY_PLATFORM_KEYRING
>> +	depends on MODULE_SIG
>> +	help
>> +	=C2=A0 When selected, keys from .platform keyring can be used for
>> verifying
>> +	=C2=A0 modules signatures. In particular, this allows to use UEFI
>> SecureBoot
>> +	=C2=A0 'db' for verification.
>> +
>> +	=C2=A0 If unsure, say N.
>> +
>> =C2=A0config MODULE_COMPRESS
>> =C2=A0	bool "Module compression"
>> =C2=A0	help
>> diff --git a/kernel/module/signing.c b/kernel/module/signing.c
>> index a2ff4242e623..3327e7243211 100644
>> --- a/kernel/module/signing.c
>> +++ b/kernel/module/signing.c
>> @@ -61,10 +61,17 @@ int mod_verify_sig(const void *mod, struct
>> load_info *info)
>> =C2=A0	modlen -=3D sig_len + sizeof(ms);
>> =C2=A0	info->len =3D modlen;
>> =C2=A0
>> -	return verify_pkcs7_signature(mod, modlen, mod + modlen,
>> sig_len,
>> +	ret =3D verify_pkcs7_signature(mod, modlen, mod + modlen,
>> sig_len,
>> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VERIFY_USE_SECONDARY_KEYRING,
>> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VERIFYING_MODULE_SIGNATURE,
>> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL);
>> +	if (ret =3D=3D -ENOKEY &&
>> IS_ENABLED(CONFIG_MODULE_SIG_PLATFORM)) {
>> +		ret =3D verify_pkcs7_signature(mod, modlen, mod +
>> modlen, sig_len,
>> +				VERIFY_USE_PLATFORM_KEYRING,
>> +				VERIFYING_MODULE_SIGNATURE,
>> +				NULL, NULL);
>> +	}
>> +	return ret;
>> =C2=A0}
>
> I don't think this is the correct way to do it.  If, as you say, db is
> controlled by the end user and therefore has trusted contents, then I
> think you want to update certs/system_keyring.c to link the platform
> keyring into the secondary trusted one (like it does today for the
> machine keyring), so it can be used by *every* application that checks
> keyrings rather than just modules.

Yea, that would be the solution I allude to at the end of my cover
letter: make .platform globally trusted so we don't need the 'trusted
for kexec', 'trusted for dm-verity' zoo we already have.

>
> Also, are you sure a config option is the right thing?  Presumably Red
> Hat wants to limit its number of kernels and the design of just linking
> the machine keyring (i.e. MoK) was for the use case where trust is
> being pivoted away from db by shim, so users don't want to trust the db
> keys they don't control.  If the same kernel gets used for both
> situations (trusted and untrusted db) you might want a runtime means to
> distinguish them.

I was not personally involved when RH put the patch downstream (and
wasn't very successful in getting the background story) but it doesn't
even have an additional Kconfig, e.g.:
https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/commi=
t/03d4694fa6511132989bac0da11fa677ea5d29f6
so apparently there's no desire to limit anything, basically, .platform
is always trusted on Fedora/RHEL systems (for a long time already).

As part of the RFC, I'd like to try to understand under which conditions
people may not want to trust 'db'. In the most common use case, 'db' is
used to authorize shim and the kernel is signed by a cert from shim's
vendor_db, not trusting 'db' for modules after that seems somawhat
silly. Maybe we can detect the fact that the user took control over the
system with MOK and untrust .platform only then (while trusting it by
default)?

A runtime toggle is not something I thought much about: the sole purpose
of this part of 'lockdown' (limitimg unsigned modules load) seems to be
to prevent someone who already has 'root' on the system to gain kernel
level access to e.g. hide its activities. In case root can decide which
keys are trusted, isn't it all in vain? Or maybe if the toggle is to
just trust/not trust .platform (and not e.g. disable signatures
verification completely, inject a new key,...) this is acceptable?
Another option is to have a kernel command line parameter but this is
complicated for users.

--=20
Vitaly


