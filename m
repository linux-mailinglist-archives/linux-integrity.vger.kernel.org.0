Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69BD6EBCB5
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 05:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjDWDk1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 22 Apr 2023 23:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjDWDkU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 22 Apr 2023 23:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4B42D75;
        Sat, 22 Apr 2023 20:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DC8C60C57;
        Sun, 23 Apr 2023 03:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBD5C433D2;
        Sun, 23 Apr 2023 03:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682221213;
        bh=ip5N3wFLOK5YvKQNTgRdaHW+VD3mTbVy4BP+uPsUYug=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=dsGCdYOY9PopwKj3vuTKEaAHOE1vJS9m3n48pRMHGCNnFN2i1Oi9Sd5XV9vJhqsT5
         bAfwLTKAncDT8uqMtay8j+/WicFeCeunm3grUthnwrWJPs6wzs/ksEHikIVQcrlp8r
         fclMLKQOiIFgoTJ419cHux4mNeXJ5mu+hkNx2bzIHQrG24Pm5Jx/ikFYln90VYYNOc
         OYq0n5xws95xzpAIAanXKDRx3AzM5GV3DweTfyTMv2TlIWArEberJGVYe3fpWikLsh
         GFpx+1+7z3DmaHdTtLh8trhudc5023j/x1kYMgKJJ7wyuFs/1j2Ez0PfolSZpPlpDs
         PiTzXsucXBNrQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 23 Apr 2023 06:40:11 +0300
Message-Id: <CS3TNFRU2KAY.NPP2KOSQ46AE@suppilovahvero>
Cc:     <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v4 03/13] tpm: add kernel doc to buffer handling
 functions
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-4-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20230403214003.32093-4-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Apr 4, 2023 at 12:39 AM EEST, James Bottomley wrote:
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm-buf.c | 65 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index baa4866d53a9..3351db515e6b 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -6,6 +6,16 @@
>  #include <linux/module.h>
>  #include <linux/tpm.h>
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
>  int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  {
>  	buf->data =3D (u8 *)__get_free_page(GFP_KERNEL);
> @@ -18,6 +28,16 @@ int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ord=
inal)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_init);
> =20
> +/**
> + * tpm_buf_reset - reset an initialized TPM command buffer
> + * @buf: pointer to a tpm_buf structure (usually on stack)
> + * @tag: command tag
> + * @ordinal: command ordinal
> + *
> + * Repurposes an already allocated @buf for a new command.
> + * Identical to calling tpm_buf_destroy/tpm_buf_init except it keeps
> + * the 4k allocated page and cannot fail.
> + */
>  void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  {
>  	struct tpm_header *head =3D (struct tpm_header *) buf->data;
> @@ -28,12 +48,24 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 =
ordinal)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_reset);
> =20
> +/**
> + * tpm_buf_destroy - destroy an initialized TPM command buffer
> + * @buf: pointer to a tpm_buf structure (usually on stack)
> + *
> + * Frees the memory allocated to @buf.
> + */
>  void tpm_buf_destroy(struct tpm_buf *buf)
>  {
>  	free_page((unsigned long)buf->data);
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_destroy);
> =20
> +/**
> + * tpm_buf_length - get the current length of a TPM command
> + * @buf: pointer to a tpm_buf structure (usually on stack)
> + *
> + * @return: the current length of the @buf.
> + */
>  u32 tpm_buf_length(struct tpm_buf *buf)
>  {
>  	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> @@ -42,6 +74,15 @@ u32 tpm_buf_length(struct tpm_buf *buf)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_length);
> =20
> +/**
> + * tpm_buf_append - append data to an initialized TPM command buffer
> + * @buf: pointer to a tpm_buf structure (usually on stack)
> + * @new_data: pointer to the added data
> + * @new_len: length of the added data
> + *
> + * Appends @new_data to the end of the current @buf and updates the
> + * length.
> + */
>  void tpm_buf_append(struct tpm_buf *buf,
>  		    const unsigned char *new_data,
>  		    unsigned int new_len)
> @@ -64,12 +105,28 @@ void tpm_buf_append(struct tpm_buf *buf,
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_append);
> =20
> +/**
> + * tpm_buf_append_u8 - append u8 data to an initialized TPM command buff=
er
> + * @buf: pointer to a tpm_buf structure (usually on stack)
> + * @value: the value of the data to append
> + *
> + * Appends @value as a byte to the end of the current @buf and updates
> + * the length.
> + */
>  void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
>  {
>  	tpm_buf_append(buf, &value, 1);
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_append_u8);
> =20
> +/**
> + * tpm_buf_append_u16 - append u16 data to an initialized TPM command bu=
ffer
> + * @buf: pointer to a tpm_buf structure (usually on stack)
> + * @value: the value of the data to append
> + *
> + * Appends @value as a big endian short to the end of the current @buf
> + * and updates the length.
> + */
>  void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
>  {
>  	__be16 value2 =3D cpu_to_be16(value);
> @@ -78,6 +135,14 @@ void tpm_buf_append_u16(struct tpm_buf *buf, const u1=
6 value)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_append_u16);
> =20
> +/**
> + * tpm_buf_append_u32 - append u32 data to an initialized TPM command bu=
ffer
> + * @buf: pointer to a tpm_buf structure (usually on stack)
> + * @value: the value of the data to append
> + *
> + * Appends @value as a big endian word to the end of the current @buf
> + * and updates the length.
> + */
>  void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
>  {
>  	__be32 value2 =3D cpu_to_be32(value);
> --=20
> 2.35.3

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
