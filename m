Return-Path: <linux-integrity+bounces-3333-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C420954B48
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 15:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77B51F22EF5
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 13:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937E31B9B2A;
	Fri, 16 Aug 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePoQF/me"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8F1E505;
	Fri, 16 Aug 2024 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815846; cv=none; b=kUNZkntJYQRvnY2vPWrmCiEWLULNVlHph4mOh/BFSDxhjiBzQmOjg9HGgH76r6p5AS1PNkKoJgvDHLB+e64NXCT7WjMyMkjFT50ipzr0ESTSG0vF8wRSl5pEg5XfBy1+zW7gG+qLZll02l0ypi9DzKcL4UwVDlfgMRtzTY5toJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815846; c=relaxed/simple;
	bh=WMrryXEcz553t+mMJqMYz/30Wg6cjJ3h0oW4dFydHhY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=MHHyC0KJe+ii+kaMlYanlhH1e2cSueBhB+3B5CfalYAa8+l0CVvCL6xfFtmNIOg+7liWKdAs5lMqd6rp+QJHzU1WkQSNLzdJ8/9nw76kFzhazVitnNebPnYIc7C2CQTsvOFrrj1JWSUbotecr8Kna67O9/FI1R3Wd7GD6uxL+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePoQF/me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64543C32782;
	Fri, 16 Aug 2024 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723815845;
	bh=WMrryXEcz553t+mMJqMYz/30Wg6cjJ3h0oW4dFydHhY=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=ePoQF/me36mjWxuo6jnjQvpMiEFGywpNuWzHYydVfImZnfCgPZmoacpZ6n1WoVY8w
	 ICEO+ZKVJS4IXnw+h95hIbmJTXSiTBnStuXXVT51d9M2jUb4LLkR5ZOuNvDRF3mzC5
	 caGheBAyrU96V4w+y32isTq97ejDVJDsN4p3pyYRr1srzQArK9ldwrDXM3UlVN7Xgc
	 BKKYnnR40g1PKa5uZROeN849L8fj3w15+Llm74iC58ul3LlLt+8CY9V3WLKP4oFass
	 UXAWD/aJFpb80JHyPb9nnOyFMjin3VIIjIeUwab/zzDsQ1ELmRs9iFHLZ3oH7qwukM
	 bHrzOoxv3tZpw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Aug 2024 16:44:01 +0300
Message-Id: <D3HDPTAXDU8P.5CUQ1ECMIG2X@kernel.org>
Subject: Re: [PATCH v2] tpm: Clean up TPM space after command failure
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jonathan McDowell" <noodles@earth.li>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <ZrzY_LWIXABkqd-S@earth.li>
 <D3GPGYHWPGFL.1S13HXY9ALZCU@kernel.org> <Zr8-QijwOpDLkol3@earth.li>
In-Reply-To: <Zr8-QijwOpDLkol3@earth.li>

On Fri Aug 16, 2024 at 2:55 PM EEST, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
>
> tpm_dev_transmit prepares the TPM space before attempting command
> transmission. However if the command fails no rollback of this
> preparation is done. This can result in transient handles being leaked
> if the device is subsequently closed with no further commands performed.
>
> Fix this by flushing the space in the event of command transmission
> failure.
>
> Fixes: 745b361e989a ("tpm: infrastructure for TPM spaces")
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
> v2:
>  - Add 'Fixes:'
>  - Cc James as one of the original authors
>  - Add space sanity check in tpm2_flush_space
>
>  drivers/char/tpm/tpm-dev-common.c | 2 ++
>  drivers/char/tpm/tpm2-space.c     | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev=
-common.c
> index 30b4c288c1bb..c3fbbf4d3db7 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -47,6 +47,8 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, =
struct tpm_space *space,
> =20
>  	if (!ret)
>  		ret =3D tpm2_commit_space(chip, space, buf, &len);
> +	else
> +		tpm2_flush_space(chip);
> =20
>  out_rc:
>  	return ret ? ret : len;
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.=
c
> index 4892d491da8d..25a66870c165 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -169,6 +169,9 @@ void tpm2_flush_space(struct tpm_chip *chip)
>  	struct tpm_space *space =3D &chip->work_space;
>  	int i;
> =20
> +	if (!space)
> +		return;
> +
>  	for (i =3D 0; i < ARRAY_SIZE(space->context_tbl); i++)
>  		if (space->context_tbl[i] && ~space->context_tbl[i])
>  			tpm2_flush_context(chip, space->context_tbl[i]);

I'll pick this for 6.12: I think it is a legit fix but not worth of
disturbing the in-progress release cycle (which is going almost rc4
already):

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you.

BR, Jarkko

