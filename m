Return-Path: <linux-integrity+bounces-3821-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D4B99F8D6
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 23:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FDAB22A17
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 21:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A82B1FBF6E;
	Tue, 15 Oct 2024 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trEOH0Zd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F81FBF67;
	Tue, 15 Oct 2024 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026944; cv=none; b=sHaXxTlTnwCC6cuW3nczwD37oJJD7uXOeQ4B5rkFKJmv5+EZcrx3zehYg4KRa5lwcs/ACkUk9+6rjF80Q5uSBxmg/gN82P2avueNNDC+gczemEd67pb6V/89BdgAbXQna0ov8EG0PNSerVR49KSLbkRmiSE5Z2fU1csIs04i0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026944; c=relaxed/simple;
	bh=nQF2Y1FXsj0Px4wn8LQKUfNX9xjpyWpZNQSrnkpLZ6Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bhT61nOfGchv0UyTkZ/jtv71cs7Dp1wZXPw8cHBAaA6ygbD99jjs6LPxFMphbnPnH7lddgCeNNomeqseaoZwYKSA/j+dxNhcPQR4fIc9w82pYU0SfWJcbOU9Mdncrz9mfFOykQdKqRYet+lx/kwcDAww0A/i4NEb1SQKhiC67uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trEOH0Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8ACC4CEC7;
	Tue, 15 Oct 2024 21:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729026943;
	bh=nQF2Y1FXsj0Px4wn8LQKUfNX9xjpyWpZNQSrnkpLZ6Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=trEOH0Zdpqs6HWQC7Q/ezGdyCzVhzjryDzMZ9+YGw/NKH2LbiLWsBuWZEjzIYqHID
	 g2k+MabduCsmg+SE3H1uOFvRmveRjdBn9bT8y44hR0w+ka9YMSpRsg0sdsCdDP7PZP
	 6rR9dora0DN1UCB0rPPJHD/Ou8Z7NruHQG/Mzaa09zgCg5+QpNDIrSOoiWxcU4zQ47
	 8nQGOsALZtdYySytjGgAGemiRi/sbIpQMG3K3VmWoqj55KSeD9nHRvwNvtxzQfJyhc
	 iZpGtjRmYKLeAEe4pQHqYLvYu4uS8BNgu4bRU+J6Eo5hplEl3G1dPfKMO9WUYNLDmZ
	 ZUFaQn7kXcqGQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 00:15:39 +0300
Message-Id: <D4WOWALWYOES.Q12TQS9P30TH@kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Set TPM_OPS_AUTO_STARTUP flag on driver
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.18.2
References: <20241014141643.3101129-1-stefanb@linux.ibm.com>
In-Reply-To: <20241014141643.3101129-1-stefanb@linux.ibm.com>

On Mon Oct 14, 2024 at 5:16 PM EEST, Stefan Berger wrote:
> Set the TPM_OPS_AUTO_STARTUP on the driver so that the ibmvtpm driver now
> uses tpm2_auto_startup and tpm1_auto_startup like many other drivers do.
> Remove tpm_get_timeouts, tpm2_get_cc_attrs_tbl, and tpm2_sessions_init
> calls from it since these will all be called in tpm2_auto_startup and
> tpm1_auto_startup.
>
> The exporting of the tpm2_session_init symbol was only necessary while th=
e
> ibmvtpm driver was calling this function. Since this is not the case
> anymore, remove this symbol from being exported.
>
> What is new for the ibmvtpm driver is that now tpm2_do_selftest and
> tpm1_do_selftest will be called that send commands to the TPM to perform
> or continue its selftest. However, the firmware should already have sent
> these commands so that the TPM will not do much work at this time.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm2-sessions.c |  1 -
>  drivers/char/tpm/tpm_ibmvtpm.c   | 15 +--------------
>  2 files changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index 511c67061728..b1a0a37f14d7 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -1362,5 +1362,4 @@ int tpm2_sessions_init(struct tpm_chip *chip)
> =20
>  	return rc;
>  }
> -EXPORT_SYMBOL(tpm2_sessions_init);
>  #endif /* CONFIG_TCG_TPM2_HMAC */
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtp=
m.c
> index 1e5b107d1f3b..76d048f63d55 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -450,6 +450,7 @@ static bool tpm_ibmvtpm_req_canceled(struct tpm_chip =
*chip, u8 status)
>  }
> =20
>  static const struct tpm_class_ops tpm_ibmvtpm =3D {
> +	.flags =3D TPM_OPS_AUTO_STARTUP,
>  	.recv =3D tpm_ibmvtpm_recv,
>  	.send =3D tpm_ibmvtpm_send,
>  	.cancel =3D tpm_ibmvtpm_cancel,
> @@ -690,20 +691,6 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev=
,
>  	if (!strcmp(id->compat, "IBM,vtpm20"))
>  		chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> =20
> -	rc =3D tpm_get_timeouts(chip);
> -	if (rc)
> -		goto init_irq_cleanup;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		rc =3D tpm2_get_cc_attrs_tbl(chip);
> -		if (rc)
> -			goto init_irq_cleanup;
> -
> -		rc =3D tpm2_sessions_init(chip);
> -		if (rc)
> -			goto init_irq_cleanup;
> -	}
> -
>  	return tpm_chip_register(chip);
>  init_irq_cleanup:
>  	do {

Not much to say about this ;-)

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

