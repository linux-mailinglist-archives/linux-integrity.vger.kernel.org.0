Return-Path: <linux-integrity+bounces-7098-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B803FB58FC1
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 09:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AD9520D71
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 07:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626F283FCF;
	Tue, 16 Sep 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc2yz7jh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF1E283FC2;
	Tue, 16 Sep 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009521; cv=none; b=TBzw2p8jmpVyRoLMnh3EN/CUzvJYzrawGb0nQr5GTt8aXswDmDVyn9z4wiE+LK2bIcbBcphgj6vh+kd0w0NBF+LOTPSdntvZC+yOcA0B0LF0xIFwG13HS+eVG69+O9slZFR+2lMnFzt97Dlp9ZKRT1cqf1e6IP8TBRNqafgzxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009521; c=relaxed/simple;
	bh=GBJTe966qxl6JOg8SL0p01t9RBTp5Jak3avWFwimx7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQPvXN1LHhl869KkY9LNV6iBFJGR+D/mNTh/+1m09uaua0YibYtoVbFUSqAf5xkYcCiWvbUdlSbYc5pc1LjZ/Q3tUVfZT2lg3VJNRAJ/33Kka804kDH7aR5ucgr0PBpwMIwVlkuOmSyjcZucZoIJkPfBxI/RcU+DsMJ+WNWthdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc2yz7jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54175C4CEEB;
	Tue, 16 Sep 2025 07:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758009520;
	bh=GBJTe966qxl6JOg8SL0p01t9RBTp5Jak3avWFwimx7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nc2yz7jhn/xR1SgcJ+clcK2J1T1D+vTGnYAn0dB5ZoPAI/BdRWF969bmgPynTMM+/
	 X7L81sGiNzIE+bZaJqfdqCFQvBNxzC3VOahdtZGEfKQNkOwyKtF5p7VT7JleoTT1dt
	 icTvJDCI+A9pHVLpa99I1neYx5BpHVQUWFR8SJ0MzKrYK8ykhHMmGvES4JqYadu4UV
	 JjPcCZoc1zVv41ZDWI89LJ9lQeCLyim5B5Fh/evAVClXTaR74ZpsIktp5tZ25a9k4f
	 1/OfV40QHwZYaiSd7kcaM7lATEXey3qA925OPI7xePQPBCOJ7eyKWZhJd7XUyQB4xT
	 Xc8KsepWxMQyA==
Date: Tue, 16 Sep 2025 08:58:35 +0100
From: Lee Jones <lee@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, herbert@gondor.apana.org.au,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, davem@davemloft.net,
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, sgarzare@redhat.com
Subject: Re: [GIT PULL] Immutable branch between MFD, Char and Crypto due for
 the v6.18 merge window
Message-ID: <20250916075835.GB1637058@google.com>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
 <20250902124205.GL2163762@google.com>
 <20250912213256.GA3062565@ax162>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912213256.GA3062565@ax162>

On Fri, 12 Sep 2025, Nathan Chancellor wrote:

> Hi Lee,
> 
> On Tue, Sep 02, 2025 at 01:42:05PM +0100, Lee Jones wrote:
> > Enjoy!
> > 
> > The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> > 
> >   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-char-crypto-v6.18
> > 
> > for you to fetch changes up to 74fddd5fbab879a7d039d9fb49af923927a64811:
> > 
> >   MAINTAINERS: Add entry for Loongson Security Engine drivers (2025-09-02 12:29:57 +0100)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between MFD, Char and Crypto due for the v6.18 merge window
> > 
> > ----------------------------------------------------------------
> > Qunqin Zhao (4):
> ...
> >       tpm: Add a driver for Loongson TPM device
> 
> This one needs a fix up due to commit 07d8004d6fb9 ("tpm: add bufsiz
> parameter in the .send callback") in 6.17-rc1, as I am seeing the
> following error in next-20250912.
> 
>   drivers/char/tpm/tpm_loongson.c:48:17: error: initialization of 'int (*)(struct tpm_chip *, u8 *, size_t,  size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int,  long unsigned int)'} from incompatible pointer type 'int (*)(struct tpm_chip *, u8 *, size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int)'} [-Wincompatible-pointer-types]
>      48 |         .send = tpm_loongson_send,
>         |                 ^~~~~~~~~~~~~~~~~
>   drivers/char/tpm/tpm_loongson.c:48:17: note: (near initialization for 'tpm_loongson_ops.send')
>   drivers/char/tpm/tpm_loongson.c:31:12: note: 'tpm_loongson_send' declared here
>      31 | static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
>         |            ^~~~~~~~~~~~~~~~~
> 
> Can you squash it or do you want a separate patch?
> 
> Cheers,
> Nathan
> 
> diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
> index a4ec23639911..9e50250763d1 100644
> --- a/drivers/char/tpm/tpm_loongson.c
> +++ b/drivers/char/tpm/tpm_loongson.c
> @@ -28,7 +28,7 @@ static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  	return cmd_ret->data_len;
>  }
>  
> -static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t count)
>  {
>  	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
>  	struct tpm_loongson_cmd *cmd = tpm_engine->command;

This will break my local branch.

Any chance of an immutable pull-request for:

  07d8004d6fb9 ("tpm: add bufsiz parameter in the .send callback")

-- 
Lee Jones [李琼斯]

