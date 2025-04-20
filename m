Return-Path: <linux-integrity+bounces-5942-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA0A94705
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 09:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C0D17529A
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 07:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386F5202981;
	Sun, 20 Apr 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzeff6/y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C778F3E;
	Sun, 20 Apr 2025 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745133458; cv=none; b=Q1sjTgqrsK4BGSM3oCGg9Kjyxf1KpdVNS+M/jPhIhkJqUFXRe+JuIs3hmh5j6+pTarMBYMKNeSybVkUto9VNmLG0z+Mlb9e750O9PqPhBHBI8lerkumvvTy1c4zXku0oRxhJEn+mMxAfl/olxUC0quGDEnjPqBE1BwVaqc3wLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745133458; c=relaxed/simple;
	bh=kAbt2L4kg671pYS37gU/fZtxIXbvKl2K/RxKTomXmT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPVLWQ0OuV4AR+Wjxt9EppJqlWTU/qssA1/jxFPm3ycDRk6H2tNn+a0eMX916rYpB69Mo4J4snczAXFsLsHTGlZ4cYjBffxJ7nX2hCFpy8ebg/iJrrPBeZ9+x2AK0izkRweGIM2aNYMksb5ab46bHvtWdAfj/uRDh3XO2VSRVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzeff6/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C07C4AF09;
	Sun, 20 Apr 2025 07:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745133457;
	bh=kAbt2L4kg671pYS37gU/fZtxIXbvKl2K/RxKTomXmT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nzeff6/yynvStEnBnW35r39G49OQu2MTljTONZkQieNcZu3kPYn+FWKKIWC8yINQr
	 Djq3eXpij4bDEhrg4Uno68L14b9SdWuKGFPuemZEvIpIePvODTaxwRUXzCldwwm7AO
	 jKSXJBrafY59LbaFu6aOkW2IyCbqHKqlw47DYOqc8BNg4R5lpqaM/XyJW+ICqLTY8b
	 61RRSATkXLuns755feYrs50Hx8NC7fXRZcLJOVC/jIfod3kIWv2BvFan6XFjr8rYJN
	 qorGd8x03AwlQjNYyO6QGy37M46EC/iGpoqKKdlAmIF9RyqCNfBnYWRhxWhqnpYl15
	 0S2Z6UTAahA0g==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so2205750a12.1;
        Sun, 20 Apr 2025 00:17:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/FlsEIzzSlIe5peNoLndX1hsPsjuAWGMAO5ydQoU1iFE2dCJIZFKUpwTf4f6WILtVThESdfQn7b7uiaLSlUeF@vger.kernel.org, AJvYcCVfZVdbcoMPLGF+A5d0pqZCh3lNrgxjkMzx7RRvN8I793Hs4ZLfAX0NFMUqea+AorWWen7uo9y2UZQbDMI=@vger.kernel.org, AJvYcCWG5HLaTkaaeL5/GtYI3+Bz603oHVIrlg5RTGHmRw1+CXBOQ81tGERectQFx3jdq2zleFEp+r+GYiayeI0t@vger.kernel.org
X-Gm-Message-State: AOJu0YzKo8I2t70HIlzO86AS19Ir5Ksp77tX5VXKuofANi6HYtGoG/dv
	e2v/cKPT90QczVzv1EC+FTKx4FjHqvu91/dwdnUD/I00UtCB1FsUvLEuPbENFmTYfCM6f6wQLEK
	4rIy+vAzadRVuaeeA2seZgVUzDWE=
X-Google-Smtp-Source: AGHT+IFipSDphqQejDTjEHb6w0t3D9Mrp3gh/Gk2d+8YbuuQI2ckZv0Gh3jPFkzypUkadOvfGgfov6bhfBarLFeSYpA=
X-Received: by 2002:a17:907:7d90:b0:aca:c864:369a with SMTP id
 a640c23a62f3a-acb74b36c86mr707209566b.18.1745133455991; Sun, 20 Apr 2025
 00:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418093506.1349-1-zhaoqunqin@loongson.cn>
In-Reply-To: <20250418093506.1349-1-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 20 Apr 2025 15:17:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H608_ddH0g0gyFCZSTVxYHOBqLXrtGYxZ1eoXX6eCcEuA@mail.gmail.com>
X-Gm-Features: ATxdqUHeiIpaROzGe_pe_P3wq4_tDyoL2Q2Sk3RB0jlyT4bmdmtQNL857Drp9PY
Message-ID: <CAAhV-H608_ddH0g0gyFCZSTVxYHOBqLXrtGYxZ1eoXX6eCcEuA@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Add Loongson Security Engine chip driver
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de, 
	jarkko@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

On Fri, Apr 18, 2025 at 5:33=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongson.cn=
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
> v8: Like Lee said, the base driver goes beyond MFD scope. Since these
>     are all encryption related drivers and SM2, SM3, and SM4 drivers
>     will be added to the crypto subsystem in the future, the base driver
>     need to be changed when adding these drivers. Therefore, it may be
>     more appropriate to place the base driver within the crypto subsystem=
.
I don't know what Lee Jones exactly means. But I don't think this
version is what he wants. You move the SE driver from drivers/mfd to
drivers/crypto, but it is still a mfd driver because of "struct
mfd_cell engines".

Huacai

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
> v5: Registered "ls6000se-rng" device in mfd driver.
> v4: Please look at changelog in tpm and MAINTAINERS. No changes to mfd
>     and crypto.
> v3: Put the updates to the MAINTAINERS in a separate patch.
>
> Qunqin Zhao (5):
>   crypto: loongson - Add Loongson Security Engine chip controller driver
>   crypto: loongson - add Loongson RNG driver support
>   MAINTAINERS: Add entry for Loongson crypto driver
>   tpm: Add a driver for Loongson TPM device
>   MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO DRIVER entry
>
>  MAINTAINERS                            |   7 +
>  drivers/char/tpm/Kconfig               |   9 +
>  drivers/char/tpm/Makefile              |   1 +
>  drivers/char/tpm/tpm_loongson.c        |  78 ++++++++
>  drivers/crypto/Kconfig                 |   1 +
>  drivers/crypto/Makefile                |   1 +
>  drivers/crypto/loongson/Kconfig        |  17 ++
>  drivers/crypto/loongson/Makefile       |   3 +
>  drivers/crypto/loongson/loongson-rng.c | 198 ++++++++++++++++++++
>  drivers/crypto/loongson/loongson-se.c  | 239 +++++++++++++++++++++++++
>  drivers/crypto/loongson/loongson-se.h  |  52 ++++++
>  11 files changed, 606 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_loongson.c
>  create mode 100644 drivers/crypto/loongson/Kconfig
>  create mode 100644 drivers/crypto/loongson/Makefile
>  create mode 100644 drivers/crypto/loongson/loongson-rng.c
>  create mode 100644 drivers/crypto/loongson/loongson-se.c
>  create mode 100644 drivers/crypto/loongson/loongson-se.h
>
>
> base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
> --
> 2.45.2
>
>

