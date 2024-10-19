Return-Path: <linux-integrity+bounces-3881-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 289359A5091
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Oct 2024 21:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B821A1F21784
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Oct 2024 19:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9FF19259A;
	Sat, 19 Oct 2024 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozwN2g6X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F2191F9E;
	Sat, 19 Oct 2024 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729367707; cv=none; b=VU8g79KxLS9+k6LEyfSxCOGrIE79MWTj6geyrnByfHzI+vw/GnHVZc4GyTlqB0dEmw2zol/nJ3bgnVF0JWcTncNwqS9OMHbB5HsOq7ote5/HdJrVqY/EbVeJgICwXTA/blI+3BTEZpXobj7iuR3Bz8EQd7hcbG0JWo0amF5rdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729367707; c=relaxed/simple;
	bh=7MAUSRCQnRqnMctSVtXWQsLwh2FgeqZO0xMrp6YRx2c=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=i5e8S7DlQsrlyssvEyXgflMaS2Hz5oGsTHi2NI+Wm7LtV6qdhdyN6zFC0PjqBfqfZseTmvDdxlJWkMC7UyEyt3Vcq/sZrFB1GOz4XIiQFOy8CMuOk9kSvvcgvTKQybFPRnQgOG2JoWlCz390xkA9AyARd4DCie+z8KQCAKeP5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozwN2g6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B967C4CEC7;
	Sat, 19 Oct 2024 19:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729367706;
	bh=7MAUSRCQnRqnMctSVtXWQsLwh2FgeqZO0xMrp6YRx2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozwN2g6XlW+gNLTTYjH9j/AG4n0I4Bqzm+esQeALNDTLMvwEFJf1iJ5by6IohzP+w
	 ZmYlmczutpPxiVOfMsYbllNG/Fw+//t7rrGrKE+HYtUX3EfH3/UN+duGn1hIErOhUN
	 IMPuwVdT+WK1vUMmo7QsIswpsLErf3QCBvAq4n2GYXRvhIseVqviydiTQsnv0edHBz
	 wWqg/Kb8D5KBrFoRzDNARi7nYQjpiwVy/w6mDOIM3lW4e1v+Wyqvq75Jfx2aYfINlR
	 vJDdgrqcseNPqLTRwAoRFRz7GO+guLSALwauEKvOtwdB71Qpq2Ybvby45GcBn9iNJW
	 umvCXcxUPomTw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Oct 2024 22:55:02 +0300
Message-Id: <D501OQWL1TT4.24C0QEV958D75@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: "Stefan Berger" <stefanb@linux.ibm.com>, "Pengyu Ma"
 <mapengyu@gmail.com>, <stable@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 5/5] tpm: flush the auth session only when /dev/tpm0
 is open
X-Mailer: aerc 0.18.2
References: <20241015205842.117300-1-jarkko@kernel.org>
 <20241015205842.117300-6-jarkko@kernel.org>
In-Reply-To: <20241015205842.117300-6-jarkko@kernel.org>

On Tue Oct 15, 2024 at 11:58 PM EEST, Jarkko Sakkinen wrote:
> Instead of flushing and reloading the auth session for every single
> transaction, keep the session open unless /dev/tpm0 is used. In practice
> this means applying TPM2_SA_CONTINUE_SESSION to the session attributes.
> Flush the session always when /dev/tpm0 is written.
>
> Reported-by: Pengyu Ma <mapengyu@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_ses=
sion*()")
> Tested-by: Pengyu Ma <mapengyu@gmail.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v5:
> - No changes.
> v4:
> - Changed as bug.
> v3:
> - Refined the commit message.
> - Removed the conditional for applying TPM2_SA_CONTINUE_SESSION only when
>   /dev/tpm0 is open. It is not required as the auth session is flushed,
>   not saved.
> v2:
> - A new patch.
> ---
>  drivers/char/tpm/tpm-chip.c       | 1 +
>  drivers/char/tpm/tpm-dev-common.c | 1 +
>  drivers/char/tpm/tpm-interface.c  | 1 +
>  drivers/char/tpm/tpm2-sessions.c  | 3 +++
>  4 files changed, 6 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0ea00e32f575..7a6bb30d1f32 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -680,6 +680,7 @@ void tpm_chip_unregister(struct tpm_chip *chip)
>  	rc =3D tpm_try_get_ops(chip);
>  	if (!rc) {
>  		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +			tpm2_end_auth_session(chip);
>  			tpm2_flush_context(chip, chip->null_key);
>  			chip->null_key =3D 0;
>  		}
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev=
-common.c
> index 4bc07963e260..c6fdeb4feaef 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -29,6 +29,7 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, =
struct tpm_space *space,
> =20
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		tpm2_end_auth_session(chip);
>  		tpm2_flush_context(chip, chip->null_key);

The reporter has done already too much so unless someone is willing to
verify these with matching hardware specs patch by patch I'm not into
meking any changes. It makes the flow factors better still what it used
to be and final result is not messy. It is good enough in my books and
performance fixes are sensitive.

BR, Jarkko

