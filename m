Return-Path: <linux-integrity+bounces-6323-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F530AC644D
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 10:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2F33A81A1
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331124DCF7;
	Wed, 28 May 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOd9CpmZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05268242D98;
	Wed, 28 May 2025 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420242; cv=none; b=ltSZnI/dKwuf7Y+XpaqK4oibV/LAgYrnlJ7rg9WoCqZjtsY1iZB0fk7Y720tQPTtTUSWj0/n6hDBc1Pw2F1AQvvpPtNczdHBzuNZaoG1rouWGSNuAqGm2KrVtJ8A1V3uRnI2k7e5QpZkzD41zem03frkvCLxAlwf8RMQqiM1ofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420242; c=relaxed/simple;
	bh=VnaOaI0+0NtHel4oVom/yssIX1THkCXKbXz9EQBzR5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsFJZ6pPWeVGQf60rgbdnwzOyI7Zn30nPRbLCTIyFAdBbaGrxQDb4uuoU7zXtNIP9vfCdBhlJQUb9KREd3jhhApdZs4igg/Ded8HhG/XSimObpaC0m68Uuv+rQSNOjiseaVtj5yMUWX6E1dV+h1YKO29zFgYpNAOUJLi2A6HavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOd9CpmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89880C4CEF0;
	Wed, 28 May 2025 08:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748420241;
	bh=VnaOaI0+0NtHel4oVom/yssIX1THkCXKbXz9EQBzR5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YOd9CpmZUkZ6van6O0glNVQrftPS+aeIgof7ALSYUJCNk2o7GkLyNJCQ+9tlocHiM
	 SYoU+Oa2anYv/epu3VDI4S4E9wOyeTknjZiTNQNLkb3228vdihlNCHqSxevh4dbxo7
	 Q83z3SbSVXh6IBJIm6DOmJNuBAA2skzqVyeRUKAJAt5m7g65/L/+LdqEQS0K9IkJdM
	 A8ui4R0PwNU9RNM3PQQS4vHi5iLvdps4MI5AxFDD9yf34Qxe6tV4ktNIzUnBjzOumN
	 L7uBTzVEdN9f3TslVHcfUQbN07CesyqVdH4JB7NPUXmhMy3Xkffq1HUmNtLdnv76h4
	 H2xvT64PRq+jQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb5ec407b1so716701166b.1;
        Wed, 28 May 2025 01:17:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhC4M9FNUu1tDNWDhaM5Wn0CHz3jigI+xMtEOwYNgZ+F9KDgEsV/sSWY23rmO2s5R6PEQvdo31PsG7NLdm@vger.kernel.org, AJvYcCWpYAUVoZdJGCoHG3NIIv1dwU/+0GlhKBLeeQ3UQpFWlMqiRX4jM46lTpKypK/nhuHkPEKi8oMRrBtaPbk=@vger.kernel.org, AJvYcCXpgljuEJJuhg9rdUJXOI1On7hcwyA2Dz5x+AUF6oYFSJslMaBihu8gqkatdOf0Vx9p56fy1yPHkKMfeC74dHJV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmyr7g1yv9cB1zB6FSVFv3sCixPqbVa0p/Wwx/yKr8k7EDu/bT
	kUErMQmTnx+xFZSRuYoiVxpMp+IU3sl/BDUx/MKaOMm4r65Dy4L4PxqgCJRj/u3cqhlILTs9Dbe
	TRDHhN1CxTQw8hGdiVey+ID5FJLEL/Ks=
X-Google-Smtp-Source: AGHT+IFNjtG99EzUzmmY6OY+rF91HK/pt//1c3i+uFoT3zCr8MD9sPlpSS8mnivTz9CEjNe5tP5bNThd/JntzDu2YOE=
X-Received: by 2002:a17:906:c10e:b0:ad8:9e80:6bb1 with SMTP id
 a640c23a62f3a-ad89e807aeemr176781066b.18.1748420240112; Wed, 28 May 2025
 01:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528065944.4511-1-zhaoqunqin@loongson.cn> <CAAhV-H7hBksA2P+vfMbpDVnbjW1Mo09Out_wOQLgLRXPLaFCfA@mail.gmail.com>
 <cda7ef56-87b3-6594-c2b6-2a4f5a1b63ce@loongson.cn>
In-Reply-To: <cda7ef56-87b3-6594-c2b6-2a4f5a1b63ce@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 28 May 2025 16:17:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H557CLtoF23nbRQaoDPdzuM5xgsS-+-1p_VeX0OreG2vQ@mail.gmail.com>
X-Gm-Features: AX0GCFtB9i9vI4aMVSiZAQ7D67ic6L8sSLEvjMA1XGh1pdV0LO7QWr1VhMzf8E0
Message-ID: <CAAhV-H557CLtoF23nbRQaoDPdzuM5xgsS-+-1p_VeX0OreG2vQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Add Loongson Security Engine chip driver
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 4:06=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongson.cn=
> wrote:
>
>
> =E5=9C=A8 2025/5/28 =E4=B8=8B=E5=8D=883:17, Huacai Chen =E5=86=99=E9=81=
=93:
> > Hi, Qunqin,
> >
> > As I said before, why the patch "MAINTAINERS: Add entry for Loongson
> > Security Module driver" is missing?
>
> Hi, Huacai
>
> https://lore.kernel.org/all/8e55801a-a46e-58d5-cf84-2ee8a733df9a@loongson=
.cn/
Sorry, I missed this email. But if you put all files in one entry, you
can merge Patch-3 and Patch-5 as the last patch (then you will also
not meet the 5 patches limit).

Huacai

>
> Thanks,
>
> Qunqin.
>
> >
> > Huacai
> >
> > On Wed, May 28, 2025 at 2:59=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongso=
n.cn> wrote:
> >> The Loongson Security Engine chip supports RNG, SM2, SM3 and SM4
> >> accelerator engines. Each engine have its own DMA buffer provided
> >> by the controller. The kernel cannot directly send commands to the
> >> engine and must first send them to the controller, which will
> >> forward them to the corresponding engine. Based on these engines,
> >> TPM2 have been implemented in the chip, then let's treat TPM2 itself
> >> as an engine.
> >>
> >> v10: mfd: Cleanned up coding style.
> >>       crypto: Unlimited tfm
> >>       tpm: Added error check
> >>
> >> v9: Moved the base driver back to drivers/mfd. Cleanned up coding styl=
e.
> >>
> >> v8: Like Lee said, the base driver goes beyond MFD scope. Since these
> >>      are all encryption related drivers and SM2, SM3, and SM4 drivers
> >>      will be added to the crypto subsystem in the future, the base dri=
ver
> >>      need to be changed when adding these drivers. Therefore, it may b=
e
> >>      more appropriate to place the base driver within the crypto
> >>      subsystem.
> >>
> >>      Removed complete callback in all driver. Removed the concepts of
> >>      "channel", "msg" and "request" as they may be confusing. Used
> >>
> >> v7: Addressed Huacai's comments.
> >>
> >> v6: mfd :MFD_LS6000SE -> MFD_LOONGSON_SE,  ls6000se.c -> loongson-se.c
> >>
> >>      crypto :CRYPTO_DEV_LS6000SE_RNG -> CRYPTO_DEV_LOONGSON_RNG,
> >>      ls6000se-rng.c ->loongson-rng.c
> >>
> >>      tpm: TCG_LSSE -> TCG_LOONGSON, tpm_lsse.c ->tpm_loongson.c
> >>
> >> v5: Registered "ls6000se-rng" device in mfd driver
> >>
> >>
> >> Qunqin Zhao (5):
> >>    mfd: Add support for Loongson Security Engine chip controller
> >>    crypto: loongson - add Loongson RNG driver support
> >>    MAINTAINERS: Add entry for Loongson crypto driver
> >>    tpm: Add a driver for Loongson TPM device
> >>    MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO DRIVER entry
> >>
> >>   MAINTAINERS                            |   9 +
> >>   drivers/char/tpm/Kconfig               |   9 +
> >>   drivers/char/tpm/Makefile              |   1 +
> >>   drivers/char/tpm/tpm_loongson.c        |  84 ++++++++
> >>   drivers/crypto/Kconfig                 |   1 +
> >>   drivers/crypto/Makefile                |   1 +
> >>   drivers/crypto/loongson/Kconfig        |   5 +
> >>   drivers/crypto/loongson/Makefile       |   1 +
> >>   drivers/crypto/loongson/loongson-rng.c | 211 +++++++++++++++++++++
> >>   drivers/mfd/Kconfig                    |  11 ++
> >>   drivers/mfd/Makefile                   |   2 +
> >>   drivers/mfd/loongson-se.c              | 253 +++++++++++++++++++++++=
++
> >>   include/linux/mfd/loongson-se.h        |  53 ++++++
> >>   13 files changed, 641 insertions(+)
> >>   create mode 100644 drivers/char/tpm/tpm_loongson.c
> >>   create mode 100644 drivers/crypto/loongson/Kconfig
> >>   create mode 100644 drivers/crypto/loongson/Makefile
> >>   create mode 100644 drivers/crypto/loongson/loongson-rng.c
> >>   create mode 100644 drivers/mfd/loongson-se.c
> >>   create mode 100644 include/linux/mfd/loongson-se.h
> >>
> >>
> >> base-commit: c89756bcf406af313d191cfe3709e7c175c5b0cd
> >> --
> >> 2.45.2
> >>
> >>
>

