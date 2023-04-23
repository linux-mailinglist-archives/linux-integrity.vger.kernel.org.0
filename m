Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89E36EBCAD
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 05:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDWDgP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 22 Apr 2023 23:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWDgO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 22 Apr 2023 23:36:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552921997;
        Sat, 22 Apr 2023 20:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA6F460B47;
        Sun, 23 Apr 2023 03:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F86C433EF;
        Sun, 23 Apr 2023 03:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682220972;
        bh=hPL+hHZDxBrEcBjTBni8O0/WT95TyeGdj9wSj/sqdns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diWKXUj27sFmD45HskDtfa0YxJgeEyqjnH7qFayD6BMqTWnU3hCHIRb4byrok9t+1
         ac4K+d6kJ55iPRDKJp74wZyshKTTV3rd4ik3dgH2nfWDlYyZ9RmZ6MkkBvK9pZ8MnB
         cedmMK6Sl4FioYn6oQzRAop1tr1nVFdZJO0M5N+ewejMmtGd6z+gzjKcWgWSiy4oui
         JxuOPiDkmosNnLrgQzJlPLUGfbXfk42ipyPAGPlYJLYPtMg4w6mSvywkpWOgupn1eU
         dJ0V1ft/dCZgJ552TVHTv+bwfIO/1Pw+xCU1SYpzgKqBTknG7AGf4OO3tq/P5Bf4Oa
         1dugoljrnmyuw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 23 Apr 2023 06:36:09 +0300
Message-Id: <CS3TKCK02YD7.2AN6AEUJM5RNH@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
Cc:     <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v4 02/13] tpm: move buffer handling from static inlines
 to real functions
X-Mailer: aerc 0.14.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-3-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20230403214003.32093-3-James.Bottomley@HansenPartnership.com>
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
> separate out the tpm_buf_... handling functions from static inlines in
> tpm.h and move them to their own tpm-buf.c file.  This is a precursor
> to adding new functions for other TPM type handling because the amount
> of code will grow from the current 70 lines in tpm.h to about 200
> lines when the additions are done.  200 lines of inline functions is a
> bit too much to keep in a header file.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
> v3: make tpm_buf_tag static
> v4: remove space after spdx tag
> ---
>  drivers/char/tpm/Makefile  |  1 +
>  drivers/char/tpm/tpm-buf.c | 87 ++++++++++++++++++++++++++++++++++++++
>  include/linux/tpm.h        | 86 ++++---------------------------------
>  3 files changed, 97 insertions(+), 77 deletions(-)
>  create mode 100644 drivers/char/tpm/tpm-buf.c
>
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 0222b1ddb310..ad3594e383e1 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -15,6 +15,7 @@ tpm-y +=3D tpm-sysfs.o
>  tpm-y +=3D eventlog/common.o
>  tpm-y +=3D eventlog/tpm1.o
>  tpm-y +=3D eventlog/tpm2.o
> +tpm-y +=3D tpm-buf.o
> =20
>  tpm-$(CONFIG_ACPI) +=3D tpm_ppi.o eventlog/acpi.o
>  tpm-$(CONFIG_EFI) +=3D eventlog/efi.o
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> new file mode 100644
> index 000000000000..baa4866d53a9
> --- /dev/null
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Handing for tpm_buf structures to facilitate the building of commands
> + */
> +
> +#include <linux/module.h>
> +#include <linux/tpm.h>
> +
> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	buf->data =3D (u8 *)__get_free_page(GFP_KERNEL);
> +	if (!buf->data)
> +		return -ENOMEM;
> +
> +	buf->flags =3D 0;
> +	tpm_buf_reset(buf, tag, ordinal);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init);
> +
> +void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	struct tpm_header *head =3D (struct tpm_header *) buf->data;
> +
> +	head->tag =3D cpu_to_be16(tag);
> +	head->length =3D cpu_to_be32(sizeof(*head));
> +	head->ordinal =3D cpu_to_be32(ordinal);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_reset);
> +
> +void tpm_buf_destroy(struct tpm_buf *buf)
> +{
> +	free_page((unsigned long)buf->data);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_destroy);
> +
> +u32 tpm_buf_length(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> +
> +	return be32_to_cpu(head->length);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_length);
> +
> +void tpm_buf_append(struct tpm_buf *buf,
> +		    const unsigned char *new_data,
> +		    unsigned int new_len)
> +{
> +	struct tpm_header *head =3D (struct tpm_header *) buf->data;
> +	u32 len =3D tpm_buf_length(buf);
> +
> +	/* Return silently if overflow has already happened. */
> +	if (buf->flags & TPM_BUF_OVERFLOW)
> +		return;
> +
> +	if ((len + new_len) > PAGE_SIZE) {
> +		WARN(1, "tpm_buf: overflow\n");
> +		buf->flags |=3D TPM_BUF_OVERFLOW;
> +		return;
> +	}
> +
> +	memcpy(&buf->data[len], new_data, new_len);
> +	head->length =3D cpu_to_be32(len + new_len);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append);
> +
> +void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
> +{
> +	tpm_buf_append(buf, &value, 1);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u8);
> +
> +void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
> +{
> +	__be16 value2 =3D cpu_to_be16(value);
> +
> +	tpm_buf_append(buf, (u8 *) &value2, 2);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u16);
> +
> +void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
> +{
> +	__be32 value2 =3D cpu_to_be32(value);
> +
> +	tpm_buf_append(buf, (u8 *) &value2, 4);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4dc97b9f65fb..9c9b5760b412 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -323,84 +323,16 @@ struct tpm2_hash {
>  	unsigned int tpm_id;
>  };
> =20
> -static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordin=
al)
> -{
> -	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> -
> -	head->tag =3D cpu_to_be16(tag);
> -	head->length =3D cpu_to_be32(sizeof(*head));
> -	head->ordinal =3D cpu_to_be32(ordinal);
> -}
> -
> -static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal=
)
> -{
> -	buf->data =3D (u8 *)__get_free_page(GFP_KERNEL);
> -	if (!buf->data)
> -		return -ENOMEM;
> -
> -	buf->flags =3D 0;
> -	tpm_buf_reset(buf, tag, ordinal);
> -	return 0;
> -}
> -
> -static inline void tpm_buf_destroy(struct tpm_buf *buf)
> -{
> -	free_page((unsigned long)buf->data);
> -}
> -
> -static inline u32 tpm_buf_length(struct tpm_buf *buf)
> -{
> -	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> -
> -	return be32_to_cpu(head->length);
> -}
> -
> -static inline u16 tpm_buf_tag(struct tpm_buf *buf)
> -{
> -	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> -
> -	return be16_to_cpu(head->tag);
> -}
> -
> -static inline void tpm_buf_append(struct tpm_buf *buf,
> -				  const unsigned char *new_data,
> -				  unsigned int new_len)
> -{
> -	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> -	u32 len =3D tpm_buf_length(buf);
> -
> -	/* Return silently if overflow has already happened. */
> -	if (buf->flags & TPM_BUF_OVERFLOW)
> -		return;
> -
> -	if ((len + new_len) > PAGE_SIZE) {
> -		WARN(1, "tpm_buf: overflow\n");
> -		buf->flags |=3D TPM_BUF_OVERFLOW;
> -		return;
> -	}
> =20
> -	memcpy(&buf->data[len], new_data, new_len);
> -	head->length =3D cpu_to_be32(len + new_len);
> -}
> -
> -static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value=
)
> -{
> -	tpm_buf_append(buf, &value, 1);
> -}
> -
> -static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 val=
ue)
> -{
> -	__be16 value2 =3D cpu_to_be16(value);
> -
> -	tpm_buf_append(buf, (u8 *) &value2, 2);
> -}
> -
> -static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 val=
ue)
> -{
> -	__be32 value2 =3D cpu_to_be32(value);
> -
> -	tpm_buf_append(buf, (u8 *) &value2, 4);
> -}
> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
> +void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
> +void tpm_buf_destroy(struct tpm_buf *buf);
> +u32 tpm_buf_length(struct tpm_buf *buf);
> +void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
> +		    unsigned int new_len);
> +void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
> +void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
> +void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
> =20
>  /*
>   * Check if TPM device is in the firmware upgrade mode.
> --=20
> 2.35.3

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
