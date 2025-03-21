Return-Path: <linux-integrity+bounces-5353-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBCEA6B4B9
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 08:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E61189402D
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9171E7C27;
	Fri, 21 Mar 2025 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL8FXkNz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A63C2F;
	Fri, 21 Mar 2025 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742541232; cv=none; b=m74CMl6ZaOnJN3HEpG2J9ZDixPjWi4aZP7c+O0XZPwZ91taBVPa31OdTsr2Zug/hfIFeR2isuVqCGTCbnc4R+jQLhfLhz1xJJo0sJmNCa8gYsIN6WlCT9Imh7fV2GQ4ib/SKryxaNqLjixBaVHM6LVY2NhRE4A3zaDB9tbZmtuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742541232; c=relaxed/simple;
	bh=llWQSaJX461Ac3vxR4eI74crTkiWJpStgDPJxpYRSew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVDVvJWdheWIYVKuOdYjZE9PbucwsSVWdjPQ1XlQSMROzx5EF73457HVPjstNfoUskHl6tUzhf1MHLcZk+3pfwC/HbJ4hbympR/rsXw/FfPhamp+nsTnA4iZYf5oHGyUq87pXJ+M+bM0UVH+NOSHLrTIHzribIR1YkVJcr7QwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL8FXkNz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so1974912e87.2;
        Fri, 21 Mar 2025 00:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742541229; x=1743146029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heGPoqqPa6u/5qcPg0ol9yM9/AhPatzE6Jm/W/HY1hw=;
        b=KL8FXkNzFUgLmn59BhGiVXsOja+ylK5K/HculxidAZSKTjbvJFZwsyJF2/UWy0n22m
         EOwfx6qRQLOa0Hkyxkg/bD5ScbE6vTfAQ1RpJtsYOaszRPl9tkr0WuRxcyvCrez24RRm
         QguJFXZ+Ugbvf1J0hqOwc7fVqpdc7mPX44d6ngQpi+ywG2V7z1J/c1Y1AAw8n+AeZd1c
         9Ftqpc1ejOW7VhHnjL6WTH7pWvAZKnbO4dzmNA6+EIGNX6JvcugTkD9Bli2eobaH94AM
         pSnxO+j3UTCHRBfl919XHzZaxGWhhr9BPVWq5W4tA+jnftsPZhp+KDA29I/DF8jHjZz5
         tqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742541229; x=1743146029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heGPoqqPa6u/5qcPg0ol9yM9/AhPatzE6Jm/W/HY1hw=;
        b=wBNQ6Zmp0yBiG4qbclMW6erTFASckzVD4c9IyagmjuAFNlb6/0frds8yZYUu2J98No
         SJ39lRAVPJZO8TJYa1WFFpN3uCbK17y1UJqOqB8ZUJIhxjMy6RHQFX4mgQhUBSmw/b2w
         pKAw9IScnQ5taY2wC+EVkkyH61/NYoT4OA4Q+0+yTF2ktbYB04MPxMsmjghbNjlG7YJs
         ACHr/JdKvWgneRjN18wyfRomxaJGH4b7+TGWramWQ/Shhy4nKKIpmouxLcvp9UygG0Tc
         N95QNNGO3t8LKv61m3L5z6Mry8nsQUAqOCd1SxTGVYUuFj1EDsB4o/leHj8AcIMfCl9s
         OM+A==
X-Forwarded-Encrypted: i=1; AJvYcCV8SdRLeTatwq0NNwPR/njHNKVEdGjwQPKkjRMGqfNKwiKV1+drBH550g9eSv1EbHN8Ke/lbZJNzA==@vger.kernel.org, AJvYcCVSNzQp4FfF0C37Uw/w21J6y/89GUnXrRsHn2/C4+lZfDJhIKXpWnb17Kb2ghWyUZXQ3v2+6nWPhRKzB4/d@vger.kernel.org, AJvYcCVyLTsa5ZpkoCpLVL+9wLWLeCXUSma1SPdvR5JWSRJ1towanDE0tRPOmivEPaSWrvku8woqKpptdmo7WzCJq0OY@vger.kernel.org, AJvYcCXTEMsNYp6AA2pGboe+I8JhDnj0gXI8kNeAfYj9oxm02tOTrKRyO9q2/UM3IP97NPkUGMQqIMqY5+DaixptCsDUFoWcmylq@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+9tqBmkXu9KrdFDxJcAoTTyMBQ2mEnrjYvkLdrez4Cnl2v1E
	7tohDdwWBhyWu/ob8zRAXM/rkn4i+2jxdvjt/EJsfHOzDccmSkLMo4kF6TDd3/LxnYQVA2e9kzA
	dC+oCKES2M7d0gKmQBhyluXao9SM=
X-Gm-Gg: ASbGncvAid0OoMQ9g3aU5id1wLxtqW+3j5O1PjjxjKCWG4AyjIFpdJhHMa5lmXnYb6r
	61NoaT5LnfIX/QjepsSuUlwX7jWoTmMCEFplnf5BaExkwBWpAy+SPaJLcPpSLE7IfH7O+qwQFQP
	S845CSlByAwVtWRXa3SLUAbXsbNw==
X-Google-Smtp-Source: AGHT+IGkbTk/3e71jsvn2jwc+kw1qMAotmEnV7AOPjn2CJqOlIkWPJkgfNEZsDIShq/OmrT5K/C8Sx6C1PLfsQPfczo=
X-Received: by 2002:a05:6512:3d8c:b0:549:7c13:e88f with SMTP id
 2adb3069b0e04-54ad64a7d9amr760870e87.30.1742541228562; Fri, 21 Mar 2025
 00:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z9wDxeRQPhTi1EIS@gardel-login>
In-Reply-To: <Z9wDxeRQPhTi1EIS@gardel-login>
From: lee joey <joeyli.kernel@gmail.com>
Date: Fri, 21 Mar 2025 15:13:36 +0800
X-Gm-Features: AQ5f1JpcglorSCIQZ3ga4nErVbrW_wUFKUBU3r0b_G8JKAQwueG5DBMB3wiuslw
Message-ID: <CAGLnvc_eyLEasc4tKYnYp2c1M+YYRxaoXt2BmJ3kgAec6YTmzg@mail.gmail.com>
Subject: Re: [PATCH] Revert "integrity: Do not load MOK and MOKx when secure
 boot be disabled"
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joeyli <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lennart,

Lennart Poettering <mzxreary@0pointer.de> =E6=96=BC 2025=E5=B9=B43=E6=9C=88=
20=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:02=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> This reverts commit 92ad19559ea9a8ec6f158480934ae26ebfe2c14f.
>
> This original commit this reverts creates a strange situation: it
> ensures more restrictive behaviour if SecureBoot is off then when it
> is on, which is the opposite of what one would expect.
>
> Typically, one would expect that if SB is off the validation of
> resources during the pre-kernel and kernel initialization is less
> restrictive, not more restrictive. But this check turned the world on
> its head.
>

SB off means that the chain of trust is broken. Which means that all
mechanisms rely on SB are non-secure. Meanwhile, if the integrity of kernel
can be guaranteed by other mechanism (e.g. TPM), then mok should not
be loaded when SB off.

> I'd like to ask for this commit to be reverted. If SB is on all bets are
> off regarding integrity of boot loaders and stuff, hence it makes no
> sense to be restrictive here: you cannot regain integrity once you gave
> it up once, hence if all bets are off anyway we might as well import any
> Mok keys passed to us into the kernel keyring.
>
> Or to say this differently: if an attacker got control of the pre-kernel
> boot phase they might as well patch around in the firmware apis to make
> the kernel believe it is in SB mode even if it is not. Hence the check
> carries no value. It doesn't protect anything in any effective way.
>

If this is the case, the check of MokListTrustedRT can also be removed.
All mok can directly be added to machine keyring then link with
secondary keyring.
Because attacker can create MokListTrusted/MokListTrusted variables to chea=
t
bootloader or kernel. The check of MokListTrustedRT is useless.

> The reason i'd like this check to go is that I'd like a nice way to
> insert keys from pre-boot into into the kernel keyring for use with
> signed dm-verity, without requiring recompilation of the kernel, and
> without SB database games. i.e. i'd like to use a regular, signed
> distro kernel, and pass to it additional keys to insert into the
> kernel keyring in a reasonable way. The mok stuff would be great for that=
,
> except it all falls apart once SB is off.
>
> You might wonder what signed dm-verity gives me if I have SB off. If
> we authenticate the boot phase up to Linux userspace via TPM-based PCR
> policies (i.e. measured boot) we can be sure of the boot integrity
> without having to rely on SB. But then we'd still like to use
> dm-verity based code signing for userspace.

hm... I am a bit confused. So, this patch can help the above scenario?

> ---
>  security/integrity/platform_certs/load_uefi.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/int=
egrity/platform_certs/load_uefi.c
> index d1fdd113450a..7783bcacd26c 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -7,7 +7,6 @@
>  #include <linux/err.h>
>  #include <linux/efi.h>
>  #include <linux/slab.h>
> -#include <linux/ima.h>
>  #include <keys/asymmetric-type.h>
>  #include <keys/system_keyring.h>
>  #include "../integrity.h"
> @@ -211,10 +210,6 @@ static int __init load_uefi_certs(void)
>                 kfree(dbx);
>         }
>
> -       /* the MOK/MOKx can not be trusted when secure boot is disabled *=
/
> -       if (!arch_ima_get_secureboot())
> -               return 0;
> -
>         mokx =3D get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &statu=
s);
>         if (!mokx) {
>                 if (status =3D=3D EFI_NOT_FOUND)
> --
> 2.48.1

Thanks
Joey Lee

