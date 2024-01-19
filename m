Return-Path: <linux-integrity+bounces-840-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20E83306B
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jan 2024 22:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141111F225B9
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jan 2024 21:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3775821A;
	Fri, 19 Jan 2024 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoAso2Im"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485D58123;
	Fri, 19 Jan 2024 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700866; cv=none; b=krtWdLckrTY6QbTw7hgztfUsoFaU+W91/slaR/9flFKtW0hbs9U5xlp8Gn83nR3JexdmxLscnCSwAJj7jbSDCLrbRsIK7/5dnNZh8upUDWKvRl6Qzs5oCLRM5vTQAO+RYdXHjyVq1rrEV41jgYcSD4RWBlWQwgzgieeiAIAv8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700866; c=relaxed/simple;
	bh=nHLgtBAhSg8XOTkKBOpQXz866fOfPjAISCWJqDJ2jRs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JWOFrGRjCBSmsfg67qIUx447jPcVR+uzgLwiLfQvWu7K7zrLTF4l98ACMDLdJpbdmUF/y5DpFitMv98Sae5RTrQLXyVH+uv8rrdUPaAP3BpvsPpFlCj8Rlub8Ge12UeOP0xbfLvgtOKsKf9RDwKtAMm39G8OXpt52UmZmUKk3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoAso2Im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047CCC433F1;
	Fri, 19 Jan 2024 21:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705700866;
	bh=nHLgtBAhSg8XOTkKBOpQXz866fOfPjAISCWJqDJ2jRs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DoAso2ImRH4dzU3wnYl5DsQpjaNS9P3ZWIiWyEZKIinJzq1eiTfHqfR6BTYdC1qNU
	 iY8qvZtrgZlH9bLSAj5z6Nis73tLHPIad+8DLqrp/u8Mn94K6MwTfIgPkme0i9Nnc6
	 Cqqp0rCw8wlqrEUAhrG8CwRRU4cyMxI7Fs7tWl37yOjVQFh84Vc5auHuFhXBBP9FhP
	 iUvb3l8pZnhq3L+1Ct6paN/C81Rpnk/uesFGEdmEsqfTEAPTPdrUJRzGQ7+kWA+WB7
	 H1e7AQttgxfp/RTM+ntbxtkbNV9DhPnmgrZxozKiqoGOpDXGwV/WlqO0yul9qAaP+F
	 i3mn8jXx2YfJw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jan 2024 21:47:42 +0000
Message-Id: <CYJ0HQTT1R88.1MZFUE1URTELJ@seitikki>
Cc: "Thirupathaiah Annapureddy" <thiruan@microsoft.com>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: fix all kernel-doc warnings
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Randy Dunlap" <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240115192447.26481-1-rdunlap@infradead.org>
In-Reply-To: <20240115192447.26481-1-rdunlap@infradead.org>

On Mon Jan 15, 2024 at 7:24 PM UTC, Randy Dunlap wrote:
> Change @pdev to @dev in 2 places to match the function parameters.
> Correct one function name in kernel-doc comment to match the function
> implementation.
>
> This prevents these warnings:
>
> tpm_ftpm_tee.c:217: warning: Function parameter or struct member 'dev' no=
t described in 'ftpm_tee_probe'
> tpm_ftpm_tee.c:217: warning: Excess function parameter 'pdev' description=
 in 'ftpm_tee_probe'
> tpm_ftpm_tee.c:313: warning: Function parameter or struct member 'dev' no=
t described in 'ftpm_tee_remove'
> tpm_ftpm_tee.c:313: warning: Excess function parameter 'pdev' description=
 in 'ftpm_tee_remove'
> tpm_ftpm_tee.c:348: warning: expecting prototype for ftpm_tee_shutdown().=
 Prototype was for ftpm_plat_tee_shutdown() instead
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-integrity@vger.kernel.org
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff -- a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee=
.c
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -208,7 +208,7 @@ static int ftpm_tee_match(struct tee_ioc
> =20
>  /**
>   * ftpm_tee_probe() - initialize the fTPM
> - * @pdev: the platform_device description.
> + * @dev: the device description.
>   *
>   * Return:
>   *	On success, 0. On failure, -errno.
> @@ -304,7 +304,7 @@ static int ftpm_plat_tee_probe(struct pl
> =20
>  /**
>   * ftpm_tee_remove() - remove the TPM device
> - * @pdev: the platform_device description.
> + * @dev: the device description.
>   *
>   * Return:
>   *	0 always.
> @@ -341,7 +341,7 @@ static void ftpm_plat_tee_remove(struct
>  }
> =20
>  /**
> - * ftpm_tee_shutdown() - shutdown the TPM device
> + * ftpm_plat_tee_shutdown() - shutdown the TPM device
>   * @pdev: the platform_device description.
>   */
>  static void ftpm_plat_tee_shutdown(struct platform_device *pdev)

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

