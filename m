Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7066EBCC7
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 06:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjDWEMu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 00:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWEMt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 00:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE3E1736;
        Sat, 22 Apr 2023 21:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D6AD60E06;
        Sun, 23 Apr 2023 04:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F76C433D2;
        Sun, 23 Apr 2023 04:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682223167;
        bh=NoNG6TXwp3KKHp+X5a14l8OspWw9SI2H6o+OAQh714c=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=BpyXUZNgCU4Gt3RyGFm3g2anTBrJYdrNJ/nKGzSWoIZnCCMTUkTFE/LTTNw8xsewx
         nTfkX/HcBgcGSlpDaxRM3HnFa0cTx9fSeQDWto1L0PuiRHzqXd/A0D/4h2hYDjeyMt
         /QKSGP8qJ3vGp9wHX/n7mQnL/A0g/69VIZYqFi4RgKAhY+yROHF+kld+3KeepwMHNq
         lnTvhl2nl00ZO0O7D7BgVHYz8XZGOdCsu7NLwDCFFDlTFHmldFM2tBqy6OLnaRj86d
         1p0vursVb53HIRuNof+akIB0Bc6AGFjgco4Flj/4tBTeON3U3RSUUurR+L/vjFSRP/
         4GCZJHn9xBEOw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 23 Apr 2023 07:12:43 +0300
Message-Id: <CS3UCCTJD2WS.2IRS8I76S4MXC@suppilovahvero>
To:     "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
Cc:     <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v4 04/13] tpm: add buffer handling for TPM2B types
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-5-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20230403214003.32093-5-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Apr 4, 2023 at 12:39 AM EEST, James Bottomley wrote:
> Most complex TPM commands require appending TPM2B buffers to the
> command body.  TPM2B types are variable size arrays, making it
> difficult to represent them as structures.  Introduce primitives to

"TPM2B is a buffer defined 16-bit size field followed by the blob."

Just state what it is, as "variable sized array" is ambiguous
terminology.

> build them up using in place buffer append operations.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
> v4: add kernel doc
> ---
>  drivers/char/tpm/tpm-buf.c | 109 ++++++++++++++++++++++++++++++++-----
>  include/linux/tpm.h        |   3 +
>  2 files changed, 97 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 3351db515e6b..b7e42fb6266c 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -6,27 +6,16 @@
>  #include <linux/module.h>
>  #include <linux/tpm.h>
> =20
> -/**
> - * tpm_buf_init - initialize a TPM command buffer
> - * @buf: pointer to a tpm_buf structure (usually on stack)
> - * @tag: command tag
> - * @ordinal: command ordinal
> - *
> - * Allocates a 4k buffer to hold the command structure.
> - *
> - * @return: 0 on success or -ENOMEM
> - */
> -int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +static int __tpm_buf_init(struct tpm_buf *buf)
>  {
>  	buf->data =3D (u8 *)__get_free_page(GFP_KERNEL);
>  	if (!buf->data)
>  		return -ENOMEM;
> =20
>  	buf->flags =3D 0;
> -	tpm_buf_reset(buf, tag, ordinal);
> +
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(tpm_buf_init);
> =20
>  /**
>   * tpm_buf_reset - reset an initialized TPM command buffer
> @@ -48,6 +37,58 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 o=
rdinal)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_reset);
> =20
> +/**
> + * tpm_buf_init - initialize a TPM command buffer
> + * @buf: pointer to a tpm_buf structure (usually on stack)
> + * @tag: command tag
> + * @ordinal: command ordinal
> + *
> + * Allocates a 4k buffer to hold the command structure.
> + *
> + * @return: 0 on success or -ENOMEM
> + */
> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	int rc;
> +
> +	rc =3D __tpm_buf_init(buf);
> +	if (rc)
> +		return rc;
> +
> +	tpm_buf_reset(buf, tag, ordinal);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init);
> +
> +/**
> + * tpm_buf_init_2b - initialize a TPM command buffer for 2B data
> + *
> + * TPM commands are often composed of sets of TPM2B data.  This

Two undescriptive terms used for the same thing:

* 2B data
* TPM2B data

I'd pick only one, and something that is understable by common sense
instead of this gibberish.

I'd suggest along the lines of:

/*
 * tpm_buf_init_data - initialize a TPM data buffer
 *
 * TPM2 protocol uses data buffers (TPM2B_*) to carry blobs of different ty=
pes.
 * Each buffer starts with 16-bit unsigned integer defining the size of the
 * blob that follows it.
 * ...

> + * function initializes a tpm_buf (@buf) as a holder of TPM2B data,
> + * which allows all the current tpm2_buf_appendX functions to work on it=
.

I don't understand what I'm reading, i.e. what literally happens
when something is initialized as a holder of something else...

Please make this understandable.

> + *
> + * @return: 0 on success or -ENOMEM
> + */
> +int tpm_buf_init_2b(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head;
> +	int rc;
> +
> +	rc =3D __tpm_buf_init(buf);
> +	if (rc)
> +		return rc;
> +
> +	head =3D (struct tpm_header *) buf->data;
> +

I'd remove this empty line.
i
> +	head->length =3D cpu_to_be32(sizeof(*head));
> +

I'd remove this empty line.

I'm missing (not described here or in the commit message) how
can you use command header here? AFAIK, header for TPM2B_*
is 16-bit number.

Please document if something weird is done. I don't understand
this.

> +	buf->flags =3D TPM_BUF_2B;

empty line here

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init_2b);
> +
>  /**
>   * tpm_buf_destroy - destroy an initialized TPM command buffer
>   * @buf: pointer to a tpm_buf structure (usually on stack)
> @@ -60,6 +101,13 @@ void tpm_buf_destroy(struct tpm_buf *buf)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_destroy);
> =20
> +static void *tpm_buf_data(struct tpm_buf *buf)
> +{
> +	if (buf->flags & TPM_BUF_2B)
> +		return buf->data + TPM_HEADER_SIZE;

empty line here

> +	return buf->data;
> +}
> +
>  /**
>   * tpm_buf_length - get the current length of a TPM command
>   * @buf: pointer to a tpm_buf structure (usually on stack)
> @@ -69,8 +117,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>  u32 tpm_buf_length(struct tpm_buf *buf)
>  {
>  	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> +	u32 len;
> =20
> -	return be32_to_cpu(head->length);
> +	len =3D be32_to_cpu(head->length);
> +	if (buf->flags & TPM_BUF_2B)
> +		len -=3D sizeof(*head);

empty line here

> +	return len;
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_length);
> =20
> @@ -88,7 +140,7 @@ void tpm_buf_append(struct tpm_buf *buf,
>  		    unsigned int new_len)
>  {
>  	struct tpm_header *head =3D (struct tpm_header *) buf->data;
> -	u32 len =3D tpm_buf_length(buf);
> +	u32 len =3D be32_to_cpu(head->length);
> =20
>  	/* Return silently if overflow has already happened. */
>  	if (buf->flags & TPM_BUF_OVERFLOW)
> @@ -150,3 +202,30 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u=
32 value)
>  	tpm_buf_append(buf, (u8 *) &value2, 4);
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> +
> +static void tpm_buf_reset_int(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head;
> +
> +	head =3D (struct tpm_header *)buf->data;
> +	head->length =3D cpu_to_be32(sizeof(*head));
> +}
> +
> +/**
> + * tpm_buf_append_2b - append TPM2B data to an initialized TPM command b=
uffer
> + * @tpm2b: pointer to a tpm_buf structure containing the TPM2B data.
> + *
> + * Appends @tpm2b as a correct TPM2B structure (big endian short
> + * length) followed by data of that length.  @tpm2b is then emptied to
> + * allow reuse.
> + */
> +void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
> +{
> +	u16 len =3D tpm_buf_length(tpm2b);
> +
> +	tpm_buf_append_u16(buf, len);
> +	tpm_buf_append(buf, tpm_buf_data(tpm2b), len);
> +	/* clear the buf for reuse */
> +	tpm_buf_reset_int(tpm2b);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 9c9b5760b412..76d495cb5b08 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -301,6 +301,7 @@ struct tpm_header {
> =20
>  enum tpm_buf_flags {
>  	TPM_BUF_OVERFLOW	=3D BIT(0),
> +	TPM_BUF_2B		=3D BIT(1),
>  };
> =20
>  struct tpm_buf {
> @@ -325,6 +326,7 @@ struct tpm2_hash {
> =20
> =20
>  int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
> +int tpm_buf_init_2b(struct tpm_buf *buf);
>  void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
>  void tpm_buf_destroy(struct tpm_buf *buf);
>  u32 tpm_buf_length(struct tpm_buf *buf);
> @@ -333,6 +335,7 @@ void tpm_buf_append(struct tpm_buf *buf, const unsign=
ed char *new_data,
>  void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
>  void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
>  void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
> +void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
> =20
>  /*
>   * Check if TPM device is in the firmware upgrade mode.
> --=20
> 2.35.3

BR, Jarkko
