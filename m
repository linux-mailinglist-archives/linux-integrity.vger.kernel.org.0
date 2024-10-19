Return-Path: <linux-integrity+bounces-3880-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004C79A5086
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Oct 2024 21:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA981C21965
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Oct 2024 19:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E8A191496;
	Sat, 19 Oct 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBLm898K"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A885137E;
	Sat, 19 Oct 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729366789; cv=none; b=Pq7tGXxf68jlG03oefoVuOt6ResjTGYzQUNSw0XKEPIdXIgPaW2+0kmIKyyGNalAUoCKu6UqlHXD25eyeuS6mfjOhP0a94ejYgda1B1cnPowNBxSsBdL9tgttD/A99LE3XAr6kr4k/Vn/G8pQPNsdXuiZ5ilBwlEGk5Pbv+Xt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729366789; c=relaxed/simple;
	bh=ragpIrEdAyO35aZulTfOlu6tsbgCh54s8FJ34474VOc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=LbCYqCq1Z9d2joaXc5Z36aFBRMLTj00A2MlnmaH9G423+Z9cJjGkz1i1TnrIFfLQzATrrnXHNBSU1uLv1B1sGOBpn500rHraKHZuv28SJqGYgGLOJxq1JsxqgEQ150FGQabL9trV/VL2vHfI4d1sgofFu0vzoiEOZ78BrJ3Kab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBLm898K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C07C4CEC5;
	Sat, 19 Oct 2024 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729366789;
	bh=ragpIrEdAyO35aZulTfOlu6tsbgCh54s8FJ34474VOc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=LBLm898K3Wd3/r+7PbTixYoUiH+QiBr+DMMZ66UlaNQ1WF6152dHtHGFn+1Wv0OT3
	 RbbQ+drx/kjt9Z8pHY/ai2nScD9Y7o42TF7kPzmsIj70xWgY1DcMx4oLUmx60ObKks
	 IGKqzISLzNeTae6EoWQwi+cznW5eCY14NtXzB1jyZn9PeVResrsicIRlwvxnsh56np
	 J60InhOOauS58Qq22QKdyG8tEFGy2g0t4HD+jS8vuIOSdqUXsZ7ekBSi0E7iSs4KMe
	 iXTK2AYxZAgMOqvAtxFJ8q6XBQ8IVf64zPLVIxDWDWhDNcB0ZR2/WaLBE1gcXDyb3T
	 tF9HN/Cwf7lFQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Oct 2024 22:39:44 +0300
Message-Id: <D501D1CY5SJ4.SUKXHV680B30@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
Cc: "Stefan Berger" <stefanb@linux.ibm.com>, <stable@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/5] tpm: Return on tpm2_create_null_primary()
 failure
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241015205842.117300-1-jarkko@kernel.org>
 <20241015205842.117300-2-jarkko@kernel.org>
In-Reply-To: <20241015205842.117300-2-jarkko@kernel.org>

On Tue Oct 15, 2024 at 11:58 PM EEST, Jarkko Sakkinen wrote:
> tpm2_sessions_init() does not ignore the result of
> tpm2_create_null_primary(). Address this by returning -ENODEV to the
> caller. Given that upper layers cannot help healing the situation
> further, deal with the TPM error here by
>
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v6:
> - Address:
>   https://lore.kernel.org/linux-integrity/69c893e7-6b87-4daa-80db-44d1120=
e80fe@linux.ibm.com/
>   as TPM RC is taken care of at the call site. Add also the missing
>   documentation for the return values.
> v5:
> - Do not print klog messages on error, as tpm2_save_context() already
>   takes care of this.
> v4:
> - Fixed up stable version.
> v3:
> - Handle TPM and POSIX error separately and return -ENODEV always back
>   to the caller.
> v2:
> - Refined the commit message.
> ---
>  drivers/char/tpm/tpm2-sessions.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index 511c67061728..253639767c1e 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -1347,6 +1347,11 @@ static int tpm2_create_null_primary(struct tpm_chi=
p *chip)
>   *
>   * Derive and context save the null primary and allocate memory in the
>   * struct tpm_chip for the authorizations.
> + *
> + * Return:
> + * * 0		- OK
> + * * -errno	- A system error
> + * * TPM_RC	- A TPM error
>   */
>  int tpm2_sessions_init(struct tpm_chip *chip)
>  {
> @@ -1354,7 +1359,7 @@ int tpm2_sessions_init(struct tpm_chip *chip)
> =20
>  	rc =3D tpm2_create_null_primary(chip);
>  	if (rc)
> -		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n=
", rc);

I can fixup this message back before sending PR.

> +		return rc;
> =20
>  	chip->auth =3D kmalloc(sizeof(*chip->auth), GFP_KERNEL);
>  	if (!chip->auth)

I don't know what happened to the cover letter but this version is only
major tweaks to the previous version.

BR, Jarkko

