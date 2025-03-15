Return-Path: <linux-integrity+bounces-5289-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A85A6258E
	for <lists+linux-integrity@lfdr.de>; Sat, 15 Mar 2025 04:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1228317CA3D
	for <lists+linux-integrity@lfdr.de>; Sat, 15 Mar 2025 03:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9215C18A6B5;
	Sat, 15 Mar 2025 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZmATy2V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097263D;
	Sat, 15 Mar 2025 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742010458; cv=none; b=TU12KsMqnLVdTgeHPMSAgMUlgGGmPuHi5GlUd/n9FvhIo7RiLgpE8bDZDZE4Se5RUiiYU5yQmeIrJ4y5/7mYxQVzkfEaFH1rs2Rin3YdBeaSSjQie5pGgme1QvkCxMqUb7v15e4yOUldK+pscec+VnqxRqA6kkIT1G3U/o2IJCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742010458; c=relaxed/simple;
	bh=rEWeaYnOxK4bckSNlu+Vv/KHF5l99ILA6qQvr9xb1f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cF8bRBHr+ZmND1Dg33Rl25Qnm+jFbu+TLvEtjBg0pXe+yFnhOPThHZy2z79/8ioELodt/PpARlrZhm32KCYO9OgFaeTSZy+bkGRIv15Bl6wyuwPbIVf+qV/dGCI0aLp/63Xom8YHDNgsCMKxTZFuFWrajv1OjCjw0txf910g4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZmATy2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0808C4CEE5;
	Sat, 15 Mar 2025 03:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742010457;
	bh=rEWeaYnOxK4bckSNlu+Vv/KHF5l99ILA6qQvr9xb1f4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XZmATy2V4jA6VGT/sLElJ1LtljPOd+eMlN+3pSTx9TkdWNjOqTOOI9C59zL6L1GPP
	 P5FB7egEYgTHxA0nSzRRAd+x5dt1+PRPrxncZJomWwC4zyjGIj9Ns+8o5ijEIb6BN4
	 nVqSLAXI0BR2jC1mtfzPs7F/O/9vk9R7SXrZPV7qP1VtWdlY2tqBFiWFVnyXf0Nsvc
	 YGlbhOQJ+Q0LB/02yr2UavFcSwSECsY5ezmSbNcpzEkSBmX7kVMKkiF8oXbTaHCsLt
	 hRMhxcsbIWEkv5MOx5tNYsl7DJfiwlrrHQkkrSueaAeMRq2ozZ9ZDkuZ8FIAQuVnoO
	 C+FtruHEidFeA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac339f53df9so204733966b.1;
        Fri, 14 Mar 2025 20:47:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU57ja3Itc6gEG6M72lIZnbXV1X+tab07rTjozo6Updzi8qsQeNzKFRv36gIAkK+RkqpD8X/rY6S2BOGEbI@vger.kernel.org, AJvYcCUEYtCYmKmi5j/0Adb09zGKEY6vu4gU4pj1mA/xp5ZgbZuuJkmVSvBUT5cjEgwEVqMc9fBTRR7T2u7g4gw=@vger.kernel.org, AJvYcCVzJzssLLns/Ic7Mx8FkOfqSnUa8yRVy1ahx8IynYF1C1Tdnal2qhsj3Lf5dbLkQEA6qWlCxya3Znhag71jN+MZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4MPIWq+pn0kwu+lIeLJCXT8WmbnOKvXWvPjAS8dYz7UJRCZ7M
	0eRKnjSEn06LXUfPSIb3Btqmh/WLDKnG9LKaRv4I9o2BW+pok7pDVvacRQuxR7mJZb/cPjzzH7f
	p8fJzHfKAACVWlKzVhKc2T0JS5NY=
X-Google-Smtp-Source: AGHT+IGvl7mvBRxnDQZkZr3SyAMYhwpiA8Buk+zLKV2NfxHnF0Ito7phi33hXpbi2pIDDMwgAz/QVCZJ9DiGfYJSMDM=
X-Received: by 2002:a17:907:9712:b0:abf:6e6a:885c with SMTP id
 a640c23a62f3a-ac3301e33b5mr559743866b.23.1742010456183; Fri, 14 Mar 2025
 20:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313090508.21252-1-zhaoqunqin@loongson.cn>
 <CAAhV-H5f1k4_bVybMcK9QXhaVxLOM=b_8n0sA+0r=gyCP4YQRA@mail.gmail.com> <d77a36a3-3b74-76a9-38de-1a40ffb58374@loongson.cn>
In-Reply-To: <d77a36a3-3b74-76a9-38de-1a40ffb58374@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 15 Mar 2025 11:47:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5hpzrCGHwhbReZXQ-UQN4AT0rz_goSjpDqkeKg+Sp+zg@mail.gmail.com>
X-Gm-Features: AQ5f1JrsaQ0ze5L39vZJ4UNTSJ5wNo2PbJgVk6RhtobyxG7H5c28H6M_WtQqkjc
Message-ID: <CAAhV-H5hpzrCGHwhbReZXQ-UQN4AT0rz_goSjpDqkeKg+Sp+zg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Drivers for Loongson security engine
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 5:59=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongson.cn=
> wrote:
>
>
> =E5=9C=A8 2025/3/13 =E4=B8=8B=E5=8D=885:26, Huacai Chen =E5=86=99=E9=81=
=93:
> > You haven't seen my comments in previous version?
> >
> > https://lore.kernel.org/loongarch/CAAhV-H5xyRrF1_=3DE7rLM3dHeYAEBdMufYQ=
vgoxAq6+d6s5U4Eg@mail.gmail.com/
>
> I am very sorry that I didn't notice your reply.
>
> I don't think it is necessary to change the driver file name. But if you
> insist, I will do the change below  in  next revision .
Changing them is a little better, but you needn't do it only for
renaming. There may be other comments for this series, you can do them
together.


Huacai

>
> "MFD_LS6000SE -> MFD_LOONGSON_SE,  ls6000se.c -> loongson-se.c
> CRYPTO_DEV_LS6000SE_RNG -> CRYPTO_DEV_LOONGSON_RNG, ls6000se-rng.c
> ->loongson-rng.c
> TCG_LSSE -> TCG_LOONGSON, tpm_lsse.c ->tpm_loongson.c"
>
>
> BR, Qunqin.
>
> >
> > Huacai
> >
> > On Thu, Mar 13, 2025 at 5:05=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongso=
n.cn> wrote:
> >> Loongson security engine supports random number generation, hash,
> >> symmetric encryption and asymmetric encryption. Based on these
> >> encryption functions, TPM2 have been implemented in it.
> >>
> >> mfd is the baser driver, crypto and tpm are users.
> >>
> >> v5: Registered "ls6000se-rng" device in mfd driver.
> >> v4: Please look at changelog in tpm and MAINTAINERS. No changes to mfd
> >>      and crypto.
> >> v3: Put the updates to the MAINTAINERS in a separate patch.
> >> v2: Removed misc driver. Added tpm driver.
> >>
> >> Qunqin Zhao (6):
> >>    mfd: Add support for Loongson Security Module
> >>    MAINTAINERS: Add entry for Loongson Security Module driver
> >>    crypto: loongson - add Loongson RNG driver support
> >>    MAINTAINERS: Add entry for Loongson RNG driver
> >>    tpm: Add a driver for Loongson TPM device
> >>    MAINTAINERS: Add tpm_lsse.c to LOONGSON CRYPTO DRIVER entry
> >>
> >>   MAINTAINERS                            |  14 +
> >>   drivers/char/tpm/Kconfig               |   9 +
> >>   drivers/char/tpm/Makefile              |   1 +
> >>   drivers/char/tpm/tpm_lsse.c            | 103 +++++++
> >>   drivers/crypto/Kconfig                 |   1 +
> >>   drivers/crypto/Makefile                |   1 +
> >>   drivers/crypto/loongson/Kconfig        |   6 +
> >>   drivers/crypto/loongson/Makefile       |   2 +
> >>   drivers/crypto/loongson/ls6000se-rng.c | 190 +++++++++++++
> >>   drivers/mfd/Kconfig                    |  10 +
> >>   drivers/mfd/Makefile                   |   2 +
> >>   drivers/mfd/ls6000se.c                 | 374 +++++++++++++++++++++++=
++
> >>   include/linux/mfd/ls6000se.h           |  75 +++++
> >>   13 files changed, 788 insertions(+)
> >>   create mode 100644 drivers/char/tpm/tpm_lsse.c
> >>   create mode 100644 drivers/crypto/loongson/Kconfig
> >>   create mode 100644 drivers/crypto/loongson/Makefile
> >>   create mode 100644 drivers/crypto/loongson/ls6000se-rng.c
> >>   create mode 100644 drivers/mfd/ls6000se.c
> >>   create mode 100644 include/linux/mfd/ls6000se.h
> >>
> >>
> >> base-commit: 6a8f122c5f073c8610c32636663f2512514b1270
> >> --
> >> 2.43.0
> >>
> >>
>
>

