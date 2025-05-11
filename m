Return-Path: <linux-integrity+bounces-6174-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3495CAB277D
	for <lists+linux-integrity@lfdr.de>; Sun, 11 May 2025 11:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 033E07A5358
	for <lists+linux-integrity@lfdr.de>; Sun, 11 May 2025 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD921A3179;
	Sun, 11 May 2025 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGhZZa+6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE311459F6;
	Sun, 11 May 2025 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746956079; cv=none; b=kudhB+z23735fBSnLoA8+NlzS+w+CRORw59xKAOjHOj5nsMeiGnfhQI19l3+2mYSzNoqJiDKtCUvMkfaYpLDbREow99DEESV5XfkpOWXQJCbrBD4GYmcRqF4Fq0OQ/1St323E6yqxDPvYafN7rRwJbyFhc9fhXKv7NkB6dBFzAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746956079; c=relaxed/simple;
	bh=IXTSrniA0F/bUn9kvpa82cCBTV6wX8LPQ4rmehEcxA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oi7XR9NLycO+DBfkSdaIZ6nN8k20OPOajZColEDJCC8HcYgavE1VG0znmQgPu4EOEHuE3ZqUN9ZCn4EWxPJMtukaGLWbmSqxdUX+a2/+UFIlpGgJIwNJTwCc0TlokT6XZzqJeCd6vOIsEjA9TCgOmjK/JayY+TkiPMMnWkZI1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGhZZa+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040B1C4AF0B;
	Sun, 11 May 2025 09:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746956079;
	bh=IXTSrniA0F/bUn9kvpa82cCBTV6wX8LPQ4rmehEcxA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bGhZZa+6l0D52SP+R46iUCCXFQKKJ8Zpg8HBG7B0sCHy6jTfbpHWJvdYkMCQXLE7S
	 1As/XAaT9ziEYJskWUeXDpFOgBpksmCLrjsIZO2ncOzyyWEPSZ/nrzEujAR0EEgVXP
	 MiyNzoJHsJ5MpdlRldp1Dc85qO8T9whw2JdEyzUU1YjW9FJvE0185VenC5j41MoMBL
	 IRgJoBbnPYwME1rpxtKsoqAXOm+CJswQy3LTA9yzJWrwSCdKJCYBeH9ejyVCLWRf8y
	 bdabH/+zWcGCYH0dU4RTdQ7u/VgWlqANJ5AWZ0aUjLVOWUJMCzVsd/jeIP8CC4/N6r
	 W+zlcFSL3YjHg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad24ee085a8so38191766b.0;
        Sun, 11 May 2025 02:34:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHFQUrtqW5FOM1knzV2o25b5s1m7EzqUgN4RfM0fpsZWqjABybV8Ff67HsSqOsG3tHawQrvqO/Ra/csomK@vger.kernel.org, AJvYcCV6IZtDUNMM4hYMikzNznnplckU74VunbPzn9RWsIk/j+Oip0CToeWax1ux5vDo3zEtfZGIInCrgZVwt1vy2DZU@vger.kernel.org, AJvYcCX4LUPABViue0uXiyTGO6/StkIoBejs7vvHAO5atrCJ3VZ41oDjx0g+4lBel6acjLXGVW7SGduqvtLpGMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQN0DNLIsQ6hSaCv+Q+dFl2Jtk6GdEjDBNVVNUwYGTcdP6/tt
	NFw4EqiASdeI0FFgdTt2Zoa7smVRLcPBGY7h0mPXYx5nkKfdq7kdJqhgY7Og7inH6xY0qBMtHqM
	lEyoa2UdatDfZc3X6450IXmQTv7c=
X-Google-Smtp-Source: AGHT+IGTmZ6EF6mEMOjWbqINnWJsCw2wRXE87kMGhAwJ2qS0Md32h3m+YkrG3Wx9y7SkE5DIAuoUoNAFRtWxn6ygHmI=
X-Received: by 2002:a17:906:5415:b0:ad2:1cd7:cefc with SMTP id
 a640c23a62f3a-ad21cd7d3f1mr642121766b.13.1746956077475; Sun, 11 May 2025
 02:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
In-Reply-To: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 11 May 2025 17:34:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H58WqEnqG3gJ1iJMrVaJ-okPJweLYwS1odJx4zAP41XpA@mail.gmail.com>
X-Gm-Features: AX0GCFs1xOMk2kKU9flskV20SeyFaYR6PfUyE9kYaPhzNcBNUwhaCNzouF6DfsI
Message-ID: <CAAhV-H58WqEnqG3gJ1iJMrVaJ-okPJweLYwS1odJx4zAP41XpA@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Add Loongson Security Engine chip driver
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

Where is the 2nd patch in V7?

Huacai

On Tue, May 6, 2025 at 12:33=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongson.cn=
> wrote:
>
> The Loongson Security Engine chip supports RNG, SM2, SM3 and SM4
> accelerator engines. Each engine have its own DMA buffer provided
> by the controller. The kernel cannot directly send commands to the
> engine and must first send them to the controller, which will
> forward them to the corresponding engine. Based on these engines,
> TPM2 have been implemented in the chip, then let's treat TPM2 itself
> as an engine.
>
> v9: Moved the base driver back to drivers/mfd. Cleanned up coding style.
>
> v8: Like Lee said, the base driver goes beyond MFD scope. Since these
>     are all encryption related drivers and SM2, SM3, and SM4 drivers
>     will be added to the crypto subsystem in the future, the base driver
>     need to be changed when adding these drivers. Therefore, it may be
>     more appropriate to place the base driver within the crypto
>     subsystem.
>
>     Removed complete callback in all drivers. Removed the concepts of
>     "channel", "msg" and "request" as they may be confusing. Used the
>     concepts of "egnine" and "command" may be better.
>
> v7: Addressed Huacai's comments.
>
> v6: mfd :MFD_LS6000SE -> MFD_LOONGSON_SE,  ls6000se.c -> loongson-se.c
>
>     crypto :CRYPTO_DEV_LS6000SE_RNG -> CRYPTO_DEV_LOONGSON_RNG,
>     ls6000se-rng.c ->loongson-rng.c
>
>     tpm: TCG_LSSE -> TCG_LOONGSON, tpm_lsse.c ->tpm_loongson.c
>
> v5: Registered "ls6000se-rng" device in mfd driver
>
> Qunqin Zhao (5):
>   mfd: Add support for Loongson Security Engine chip controller
>   crypto: loongson - add Loongson RNG driver support
>   MAINTAINERS: Add entry for Loongson crypto driver
>   tpm: Add a driver for Loongson TPM device
>   MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO DRIVER entry
>
>  MAINTAINERS                            |   9 +
>  drivers/char/tpm/Kconfig               |   9 +
>  drivers/char/tpm/Makefile              |   1 +
>  drivers/char/tpm/tpm_loongson.c        |  78 ++++++++
>  drivers/crypto/Kconfig                 |   1 +
>  drivers/crypto/Makefile                |   1 +
>  drivers/crypto/loongson/Kconfig        |   5 +
>  drivers/crypto/loongson/Makefile       |   1 +
>  drivers/crypto/loongson/loongson-rng.c | 197 +++++++++++++++++++++
>  drivers/mfd/Kconfig                    |  11 ++
>  drivers/mfd/Makefile                   |   2 +
>  drivers/mfd/loongson-se.c              | 235 +++++++++++++++++++++++++
>  include/linux/mfd/loongson-se.h        |  52 ++++++
>  13 files changed, 602 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_loongson.c
>  create mode 100644 drivers/crypto/loongson/Kconfig
>  create mode 100644 drivers/crypto/loongson/Makefile
>  create mode 100644 drivers/crypto/loongson/loongson-rng.c
>  create mode 100644 drivers/mfd/loongson-se.c
>  create mode 100644 include/linux/mfd/loongson-se.h
>
>
> base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
> --
> 2.45.2
>
>

