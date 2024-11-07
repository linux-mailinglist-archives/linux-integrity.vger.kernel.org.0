Return-Path: <linux-integrity+bounces-4044-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654AC9BFAF0
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 01:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69AE1F2274E
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 00:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE72A610C;
	Thu,  7 Nov 2024 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lun9GOBT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818754C7D;
	Thu,  7 Nov 2024 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940721; cv=none; b=Y1IGyo/qu11Mjn/wA71EJMCDitpYGj/ck/C61MPEsbhq3chP27qxDsucwanCWxh93bKj34lXpO++9xayKhxHGmma6NMBXoBnzL7Cr6l9VteoGMI3kzfsoaXhJLWgxBQwZ3JlH3EmZD6aiZfylAYmJC7YbKUBA1VBl7No3rYAECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940721; c=relaxed/simple;
	bh=hU987Sf5eZ+0DmQup+RdtNrqG3SHoFUU0Kwu4CfzrVo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=hrng2J4V8XQn4/RIXk+VelHK5W9r0zLSn1tnvc3Jsb9RK9wmmfdNXtqchJdWF+3Fa7Oq9JWovZb0YfgcXvWjJiWcGWzZ7O9qp20B9M9dgnxtz3zHcOspqjTqzKmFq/7gnojoZtjyOk02TykPUGZePyvhBTr/20dMHDyNIXtpDEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lun9GOBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FC6C4CEC6;
	Thu,  7 Nov 2024 00:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730940721;
	bh=hU987Sf5eZ+0DmQup+RdtNrqG3SHoFUU0Kwu4CfzrVo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Lun9GOBTa/ft2NFRUCWvMaPzmYe7VKRKGHWQOnMifNMSMtgcE3hNteEojno25yChH
	 9CBLzZ57PjukimQsFzzhW8wpnrHIrn+j888pcKdu1O70vuopLXVRAPNvwWx+yqk5Yc
	 HLn3X+j8xkvsAaDbQ+7nQee9yg9vU6ZsbDWTV1DTpGYrTw3Xim9hrHOep6kM8uBgOA
	 cMLH6hrYUJ2V5A6JOgMv/qvOeauEOrEF7hGIiWswv2sABz1YC/OBDybi0EAMjK5a4i
	 dLfMfdEqc7ZPyk1XnasQxLp/qFFJn4iXUaT9abKS1AAherdYvvI/3r+OTF/PtrfwSm
	 M5qYJzRNu4ONA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 02:51:56 +0200
Message-Id: <D5FJ9VCD1JBL.22MQYQHUYJLJ8@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>,
 <linux-integrity@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Opt-in in disable PCR encryption on TPM2 chips
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241107004708.108667-1-jarkko@kernel.org>
In-Reply-To: <20241107004708.108667-1-jarkko@kernel.org>

On Thu Nov 7, 2024 at 2:47 AM EET, Jarkko Sakkinen wrote:
> From: Mimi Zohar <zohar@linux.ibm.com>
>
> The initial encrypted HMAC session feature added TPM bus encryption to
> various in-kernel TPM operations. This can cause performance bottlenecks
> with IMA, as it heavily utilizes PCR extend operations.
>
> In order to address this performance issue, introduce disable_encrypt_pcr=
s
> kernel command-line parameter to the TPM driver.
>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Link: https://lore.kernel.org/linux-integrity/20241015193916.59964-1-zoha=
r@linux.ibm.com/
> Fixes: 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()")
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v1:
> - Derived from the earlier RFC patch with a different parameter scope,
>   cleaner commit message and some other tweaks. I decided to create
>   something because I did not noticed any progress. Note only compile
>   tested as I wanted to get something quickly out.
> ---

Noticed a couple of things I missed after sending this (see below).

>  .../admin-guide/kernel-parameters.txt         | 10 ++++
>  drivers/char/tpm/tpm2-cmd.c                   | 33 ++++++++---
>  drivers/char/tpm/tpm2-sessions.c              | 59 +++++++++++--------
>  include/linux/tpm.h                           |  4 ++
>  4 files changed, 74 insertions(+), 32 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 1518343bbe22..e27517e1a26f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6727,6 +6727,16 @@
>  	torture.verbose_sleep_duration=3D [KNL]
>  			Duration of each verbose-printk() sleep in jiffies.
> =20
> +	tpm.disable_encrypt_pcrs=3D [HW,TPM]
> +			Do not protect PCR registers from unintended physical
> +			access, or interposers in the bus by the means of
> +			having an encrypted and integrity protected session
> +			wrapped around TPM2_PCR_Extend command. Consider this
> +			in a situation where TPM is heavily utilized by
> +			IMA, thus protection causing a major performance hit,
> +			and the space where machines are deployed is by other
> +			means guarded.
> +
>  	tpm_suspend_pcr=3D[HW,TPM]
>  			Format: integer pcr id
>  			Specify that at suspend time, the tpm driver
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 1e856259219e..6ec307b1cb99 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -14,6 +14,10 @@
>  #include "tpm.h"
>  #include <crypto/hash_info.h>
> =20
> +static bool disable_encrypt_pcrs;
> +module_param(disable_encrypt_pcrs, bool, 0444);
> +MODULE_PARM_DESC(disable_encrypt_pcrs, "Disable TPM2_PCR_Extend encrypti=
on");
> +
>  static struct tpm2_hash tpm2_hash_map[] =3D {
>  	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
>  	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> @@ -232,18 +236,26 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_=
idx,
>  	int rc;
>  	int i;
> =20
> -	rc =3D tpm2_start_auth_session(chip);
> -	if (rc)
> -		return rc;
> +	if (!disable_encrypt_pcrs) {
> +		rc =3D tpm2_start_auth_session(chip);
> +		if (rc)
> +			return rc;
> +	}
> =20
>  	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
>  	if (rc) {
> -		tpm2_end_auth_session(chip);
> +		if (!disable_encrypt_pcrs)
> +			tpm2_end_auth_session(chip);
>  		return rc;
>  	}
> =20
> -	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> -	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> +	if (!disable_encrypt_pcrs) {
> +		tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> +		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> +	} else {
> +		tpm_buf_append_handle(chip, &buf, pcr_idx, NULL);
> +		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
> +	}
> =20
>  	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> =20
> @@ -253,9 +265,12 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_i=
dx,
>  			       chip->allocated_banks[i].digest_size);
>  	}
> =20
> -	tpm_buf_fill_hmac_session(chip, &buf);
> -	rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value")=
;
> -	rc =3D tpm_buf_check_hmac_response(chip, &buf, rc);
> +	if (!disable_encrypt_pcrs)
> +		tpm_buf_fill_hmac_session(chip, &buf);
> +	rc =3D tpm_transmit_cmd(chip, &buf, 0,
> +			      "attempting extend a PCR value");

Should be in a single line in order to minimize the diff.

> +	if (!disable_encrypt_pcrs)
> +		rc =3D tpm_buf_check_hmac_response(chip, &buf, rc);
> =20
>  	tpm_buf_destroy(&buf);
> =20
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index 42df980168b6..02897debc3fa 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -205,6 +205,14 @@ static int tpm2_read_public(struct tpm_chip *chip, u=
32 handle, char *name)
>  }
>  #endif /* CONFIG_TCG_TPM2_HMAC */
> =20
> +void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf,
> +			   u32 handle, u8 *name)
> +{
> +	tpm_buf_append_u32(buf, handle);
> +	/* count the number of handles in the upper bits of flags */
> +	buf->handles++;
> +}
> +
>  /**
>   * tpm_buf_append_name() - add a handle area to the buffer
>   * @chip: the TPM chip structure
> @@ -237,9 +245,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struc=
t tpm_buf *buf,
>  #endif
> =20
>  	if (!tpm2_chip_auth(chip)) {
> -		tpm_buf_append_u32(buf, handle);
> -		/* count the number of handles in the upper bits of flags */
> -		buf->handles++;
> +		tpm_buf_append_handle(chip, buf, handle, name);
>  		return;
>  	}
> =20
> @@ -272,6 +278,31 @@ void tpm_buf_append_name(struct tpm_chip *chip, stru=
ct tpm_buf *buf,
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_append_name);
> =20
> +void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> +			 u8 attributes, u8 *passphrase, int passphrase_len)
> +{
> +	/* offset tells us where the sessions area begins */
> +	int offset =3D buf->handles * 4 + TPM_HEADER_SIZE;
> +	u32 len =3D 9 + passphrase_len;
> +
> +	if (tpm_buf_length(buf) !=3D offset) {
> +		/* not the first session so update the existing length */
> +		len +=3D get_unaligned_be32(&buf->data[offset]);
> +		put_unaligned_be32(len, &buf->data[offset]);
> +	} else {
> +		tpm_buf_append_u32(buf, len);
> +	}
> +	/* auth handle */
> +	tpm_buf_append_u32(buf, TPM2_RS_PW);
> +	/* nonce */
> +	tpm_buf_append_u16(buf, 0);
> +	/* attributes */
> +	tpm_buf_append_u8(buf, 0);
> +	/* passphrase */
> +	tpm_buf_append_u16(buf, passphrase_len);
> +	tpm_buf_append(buf, passphrase, passphrase_len);
> +}
> +
>  /**
>   * tpm_buf_append_hmac_session() - Append a TPM session element
>   * @chip: the TPM chip structure
> @@ -309,26 +340,8 @@ void tpm_buf_append_hmac_session(struct tpm_chip *ch=
ip, struct tpm_buf *buf,
>  #endif
> =20
>  	if (!tpm2_chip_auth(chip)) {
> -		/* offset tells us where the sessions area begins */
> -		int offset =3D buf->handles * 4 + TPM_HEADER_SIZE;
> -		u32 len =3D 9 + passphrase_len;
> -
> -		if (tpm_buf_length(buf) !=3D offset) {
> -			/* not the first session so update the existing length */
> -			len +=3D get_unaligned_be32(&buf->data[offset]);
> -			put_unaligned_be32(len, &buf->data[offset]);
> -		} else {
> -			tpm_buf_append_u32(buf, len);
> -		}
> -		/* auth handle */
> -		tpm_buf_append_u32(buf, TPM2_RS_PW);
> -		/* nonce */
> -		tpm_buf_append_u16(buf, 0);
> -		/* attributes */
> -		tpm_buf_append_u8(buf, 0);
> -		/* passphrase */
> -		tpm_buf_append_u16(buf, passphrase_len);
> -		tpm_buf_append(buf, passphrase, passphrase_len);
> +		tpm_buf_append_auth(chip, buf, attributes, passphrase,
> +				    passphrase_len);
>  		return;
>  	}
> =20
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 587b96b4418e..4892cd004530 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -502,9 +502,13 @@ static inline struct tpm2_auth *tpm2_chip_auth(struc=
t tpm_chip *chip)
> =20
>  void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>  			 u32 handle, u8 *name);
> +void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf,
> +			   u32 handle, u8 *name);
>  void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *=
buf,
>  				 u8 attributes, u8 *passphrase,
>  				 int passphraselen);
> +void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> +			 u8 attributes, u8 *passphrase, int passphraselen);

This is declared in wrong place as it has no outside callers. So I will
move it to drivers/char/tpm/tpm.h instead. Please correct if I'm
overlooking something.

>  static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip=
,
>  						   struct tpm_buf *buf,
>  						   u8 attributes,


BR, Jarkko

