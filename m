Return-Path: <linux-integrity+bounces-1426-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C058618E7
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 18:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90DF283516
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535D12B168;
	Fri, 23 Feb 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq1FWN87"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFFC84FB0;
	Fri, 23 Feb 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708246; cv=none; b=OcUYgQZ6xSnidCQfgTt49TYAhUgwVf/P+S4xUNRWi36YAlw+A1M9NKQ/IABZlUD8RcOWQ/zqfon5ZDej0rLT0U2M2/SLDNHp8F7SWxTaOQjLb+i3Dd6f+A11j/ZwLNZ2S2xtrRT+o7OQ+8W0C9XZpLB0UqtnRumWGkwvfIqn4eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708246; c=relaxed/simple;
	bh=49yQUg0yjZnxVmhsJ1dfFQOU7ZaOhz58gpN3TjS3aHw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iUbxavLOjynNuya5iLb7SA+9nBoK/ytEqZrLtpplTS0XlnCr/0JOT4zXBhi4+aSmV2wfOlPfE2ncErqd9++gatARODgmF55GVvE7K2lD3TGCf/sN233vVgYDF6V/7k86CVC8/Y0GHsPBwAXkmYUlQWY2Mo1KlN0ymCtLINuL1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq1FWN87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69913C433C7;
	Fri, 23 Feb 2024 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708246;
	bh=49yQUg0yjZnxVmhsJ1dfFQOU7ZaOhz58gpN3TjS3aHw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Gq1FWN87e4g59UNwbHwlnew5uM/1rIISLnNCcVD+ERySem3bcQprKIZaZcTfYfcV3
	 +T08DrQToKKL/eEmkl3r39O587hWxGKfxLjJo7Z5XhE6oHzMbDODAFckk784fA6Zje
	 17PZDx7kcrx9XEMHswzXv7Mpgw+AOLeRctMRBf9YvtS3L+jI//pZUqtQ7whta98jLN
	 wRV3VJToYXJf6+gPE0jiYaHL+Wf5Ve80uhtJscVSHxeu+Y01y95ttRMvS/VEx2aYM5
	 wvLO+Ph2VbcCHP7/uhuRsbXPQHUN56d0kTZ1okGEEW4+BWjxVnVdn6DWJN+2rV9m2Y
	 1qukuov3rMb9A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 19:10:43 +0200
Message-Id: <CZCMIQIK68AN.1HLO4IRBHHDK4@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 16/21] tpm: add hmac checks to tpm2_pcr_extend()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-17-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240213171334.30479-17-James.Bottomley@HansenPartnership.com>

On Tue Feb 13, 2024 at 7:13 PM EET, James Bottomley wrote:
> tpm2_pcr_extend() is used by trusted keys to extend a PCR to prevent a
> key from being re-loaded until the next reboot.  To use this
> functionality securely, that extend must be protected by a session
> hmac.  This patch adds HMAC protection so tampering with the
> tpm2_pcr_extend() command in flight is detected.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> ---
> v7: add review
> ---
>  drivers/char/tpm/tpm2-cmd.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index b0e72fb563d9..a53a843294ed 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -216,13 +216,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx=
,
>  	return rc;
>  }
> =20
> -struct tpm2_null_auth_area {
> -	__be32  handle;
> -	__be16  nonce_size;
> -	u8  attributes;
> -	__be16  auth_size;
> -} __packed;
> -
>  /**
>   * tpm2_pcr_extend() - extend a PCR value
>   *
> @@ -236,24 +229,22 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_=
idx,
>  		    struct tpm_digest *digests)
>  {
>  	struct tpm_buf buf;
> -	struct tpm2_null_auth_area auth_area;
>  	int rc;
>  	int i;
> =20
> -	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> +	rc =3D tpm2_start_auth_session(chip);
>  	if (rc)
>  		return rc;
> =20
> -	tpm_buf_append_u32(&buf, pcr_idx);
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> +	if (rc) {
> +		tpm2_end_auth_session(chip);
> +		return rc;
> +	}
> =20
> -	auth_area.handle =3D cpu_to_be32(TPM2_RS_PW);
> -	auth_area.nonce_size =3D 0;
> -	auth_area.attributes =3D 0;
> -	auth_area.auth_size =3D 0;
> +	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> +	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> =20
> -	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
> -	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
> -		       sizeof(auth_area));
>  	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> =20
>  	for (i =3D 0; i < chip->nr_allocated_banks; i++) {
> @@ -262,7 +253,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_id=
x,
>  			       chip->allocated_banks[i].digest_size);
>  	}
> =20
> +	tpm_buf_fill_hmac_session(chip, &buf);
>  	rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value")=
;
> +	rc =3D tpm_buf_check_hmac_response(chip, &buf, rc);
> =20
>  	tpm_buf_destroy(&buf);
> =20


reviewed-by still applies

BR, Jarkko

