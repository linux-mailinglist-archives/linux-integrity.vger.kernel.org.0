Return-Path: <linux-integrity+bounces-621-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D21E82302D
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36351B23312
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500791A71B;
	Wed,  3 Jan 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKf1eBwu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C511A713;
	Wed,  3 Jan 2024 15:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA150C433C7;
	Wed,  3 Jan 2024 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704294049;
	bh=vAK1Sh0DbKy6/X6fAzZ11mqPyxckbMaZ8+h9mlftBMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKf1eBwuX/yf+oYYd50yizWU029gfp7FYmCTOjVWYjMe9AKIW0nWuAG7MoI5J6+yX
	 0PX0RCxwp2jxMslbegMwzpoWvkaTjvxClgG+g+Siwhc0jQys1RBiJaoCChBEnTpE09
	 ZsduHT9HJ5FeXCM/b+AhWyP+qRUDdsy66Q/V/SI0zF1ZAeQAW71J/iu3CBqf/jnLUS
	 xNWcJgzalVLkkzlhA9I/eZv35H4ykQ+ituBhTpjhHIMXJ8XOYqxd56ytesvKIMyA2e
	 GalQMFUKOvqQtSHdOblaYKg1YNtGH16sE8DImMqd7YCtwHrYM8oU5ks4xOVmVI/Rat
	 Qaax9EfUTHJlQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 17:00:46 +0200
Message-Id: <CY55TGHBQYB2.2CZ9B5QJFWJN5@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v6 10/20] tpm: add buffer function to point to returned
 parameters
X-Mailer: aerc 0.15.2
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
 <20240102170408.21969-11-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240102170408.21969-11-James.Bottomley@HansenPartnership.com>

On Tue Jan 2, 2024 at 7:03 PM EET, James Bottomley wrote:
> Replace all instances of &buf.data[TPM_HEADER_SIZE] with a new
> function tpm_buf_parameters() because encryption sessions change
> where the return parameters are located in the buffer since if a
> return session is present they're 4 bytes beyond the header with those
> 4 bytes giving the parameter length.  If there is no return session,
> then they're in the usual place immediately after the header.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
> ---
> v4: add kdoc
> v5: update kdoc add review
> ---
>  drivers/char/tpm/tpm-buf.c | 28 ++++++++++++++++++++++++++++
>  include/linux/tpm.h        |  2 ++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 32619e9ab4fa..bb81180495d1 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -220,3 +220,31 @@ u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *off=
set)
>  	return be32_to_cpu(value);
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_read_u32);
> +
> +static u16 tpm_buf_tag(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> +
> +	return be16_to_cpu(head->tag);
> +}
> +
> +/**
> + * tpm_buf_parameters - return the TPM response parameters area of the t=
pm_buf
> + * @buf: tpm_buf to use
> + *
> + * Where the parameters are located depends on the tag of a TPM
> + * command (it's immediately after the header for TPM_ST_NO_SESSIONS
> + * or 4 bytes after for TPM_ST_SESSIONS). Evaluate this and return a
> + * pointer to the first byte of the parameters area.
> + *
> + * @return: pointer to parameters area
> + */
> +u8 *tpm_buf_parameters(struct tpm_buf *buf)

Not sure about the name but neither have any better suggestion. It
will do.

> +{
> +	int offset =3D TPM_HEADER_SIZE;
> +
> +	if (tpm_buf_tag(buf) =3D=3D TPM2_ST_SESSIONS)
> +		offset +=3D 4;
> +
> +	return &buf->data[offset];
> +}
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index e8172f81c562..6be263509e81 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -344,6 +344,8 @@ u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset=
);
>  u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
>  u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
> =20
> +u8 *tpm_buf_parameters(struct tpm_buf *buf);
> +
>  /*
>   * Check if TPM device is in the firmware upgrade mode.
>   */

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

