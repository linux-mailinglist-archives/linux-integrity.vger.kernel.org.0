Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249F06A3C2F
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 09:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjB0ISR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 03:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjB0ISR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 03:18:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CEDB765;
        Mon, 27 Feb 2023 00:18:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80BC4B80861;
        Mon, 27 Feb 2023 08:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6FFC433EF;
        Mon, 27 Feb 2023 08:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677485886;
        bh=mRuYLD4MrrwNXLIUHSbZL7HuvgQLG7iQAPukbwrWhWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kOtqlS3uqBaLjqEBPWFIe7PvsS8hb/IeGryepmaPXU8gD+qEq/5j5nX+g0/iQ34pL
         OGmoYuWfmSFb7tOmk38u7VfL3efniCTpROLphcZAYi2dMyh01Sv6jItdh6jw9D86BV
         mPiJfofDcBCyIvTcyReXv6s7erG27D86xb0A05LKOHsKR6Ja3T92UYB3BJKPcjdRRz
         yKUYjlZnfg7pgeWtHMOiaSrDqzrFN+f1OEJT/OagS9H+lYiJBVDVsrrh0ZU6NyZxA1
         fJk6DyGZ8LfN1S7c6ZTusoGqkTbc/2DEdKMPThz/OgKK9V6P0sgZx3z8tghrixxg6F
         Nev/7WOdaivpQ==
Date:   Mon, 27 Feb 2023 10:18:03 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 02/12] tpm: move buffer handling from static inlines to
 real functions
Message-ID: <Y/xnO1TwwFqxKpy3@kernel.org>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
 <20230216201410.15010-3-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216201410.15010-3-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 16, 2023 at 03:14:00PM -0500, James Bottomley wrote:
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
> ---
>  drivers/char/tpm/Makefile  |  1 +
>  drivers/char/tpm/tpm-buf.c | 95 ++++++++++++++++++++++++++++++++++++++
>  include/linux/tpm.h        | 86 ++++------------------------------
>  3 files changed, 105 insertions(+), 77 deletions(-)
>  create mode 100644 drivers/char/tpm/tpm-buf.c
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 0222b1ddb310..ad3594e383e1 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -15,6 +15,7 @@ tpm-y += tpm-sysfs.o
>  tpm-y += eventlog/common.o
>  tpm-y += eventlog/tpm1.o
>  tpm-y += eventlog/tpm2.o
> +tpm-y += tpm-buf.o
>  
>  tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
>  tpm-$(CONFIG_EFI) += eventlog/efi.o
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> new file mode 100644
> index 000000000000..ca59b92e0f95
> --- /dev/null
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +

This empty line should be removed.

> +/*
> + * Handing for tpm_buf structures to facilitate the building of commands
> + */
> +
> +#include <linux/module.h>
> +#include <linux/tpm.h>
> +

Now that symbols are compiled and also exported, it would be good to add
also kdoc's while at it, e.g.

/*
 * tpm_buf_init - Init a buffer for a TPM command
 * @buf:        uninitialized buffer
 * @tag:        tag of a TPM command
 * @ordinal:    number of a TPM command
 *
 * Allocate a page sized buffer from heap for a TPM command, and initialize
 * the command header.
 */

It is probably better to have an additional patch for this, as this one
should just move code around.

> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> +	if (!buf->data)
> +		return -ENOMEM;
> +
> +	buf->flags = 0;
> +	tpm_buf_reset(buf, tag, ordinal);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init);
> +
> +void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)

Ditto.

I guess you can fill these out. I just put an example to give a rough
idea what to put.

> +{
> +	struct tpm_header *head = (struct tpm_header *) buf->data;
> +
> +	head->tag = cpu_to_be16(tag);
> +	head->length = cpu_to_be32(sizeof(*head));
> +	head->ordinal = cpu_to_be32(ordinal);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_reset);
> +
> +void tpm_buf_destroy(struct tpm_buf *buf)

Ditto.

> +{
> +	free_page((unsigned long)buf->data);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_destroy);
> +
> +u32 tpm_buf_length(struct tpm_buf *buf)

Ditto.

> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +
> +	return be32_to_cpu(head->length);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_length);
> +
> +static u16 tpm_buf_tag(struct tpm_buf *buf)

Ditto.

> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +
> +	return be16_to_cpu(head->tag);
> +}
> +
> +void tpm_buf_append(struct tpm_buf *buf,
> +		    const unsigned char *new_data,
> +		    unsigned int new_len)
> +{
> +	struct tpm_header *head = (struct tpm_header *) buf->data;
> +	u32 len = tpm_buf_length(buf);
> +
> +	/* Return silently if overflow has already happened. */
> +	if (buf->flags & TPM_BUF_OVERFLOW)
> +		return;
> +
> +	if ((len + new_len) > PAGE_SIZE) {
> +		WARN(1, "tpm_buf: overflow\n");
> +		buf->flags |= TPM_BUF_OVERFLOW;
> +		return;
> +	}
> +
> +	memcpy(&buf->data[len], new_data, new_len);
> +	head->length = cpu_to_be32(len + new_len);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append);
> +
> +void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)

Ditto.

> +{
> +	tpm_buf_append(buf, &value, 1);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u8);
> +
> +void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)

Ditto.

> +{
> +	__be16 value2 = cpu_to_be16(value);
> +
> +	tpm_buf_append(buf, (u8 *) &value2, 2);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u16);
> +
> +void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)

Ditto.

> +{
> +	__be32 value2 = cpu_to_be32(value);
> +
> +	tpm_buf_append(buf, (u8 *) &value2, 4);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index dfeb25a0362d..150b39b6190e 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -322,84 +322,16 @@ struct tpm2_hash {
>  	unsigned int tpm_id;
>  };
>  
> -static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> -{
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -
> -	head->tag = cpu_to_be16(tag);
> -	head->length = cpu_to_be32(sizeof(*head));
> -	head->ordinal = cpu_to_be32(ordinal);
> -}
> -
> -static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> -{
> -	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> -	if (!buf->data)
> -		return -ENOMEM;
> -
> -	buf->flags = 0;
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
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -
> -	return be32_to_cpu(head->length);
> -}
> -
> -static inline u16 tpm_buf_tag(struct tpm_buf *buf)
> -{
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -
> -	return be16_to_cpu(head->tag);
> -}
> -
> -static inline void tpm_buf_append(struct tpm_buf *buf,
> -				  const unsigned char *new_data,
> -				  unsigned int new_len)
> -{
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -	u32 len = tpm_buf_length(buf);
> -
> -	/* Return silently if overflow has already happened. */
> -	if (buf->flags & TPM_BUF_OVERFLOW)
> -		return;
> -
> -	if ((len + new_len) > PAGE_SIZE) {
> -		WARN(1, "tpm_buf: overflow\n");
> -		buf->flags |= TPM_BUF_OVERFLOW;
> -		return;
> -	}
>  
> -	memcpy(&buf->data[len], new_data, new_len);
> -	head->length = cpu_to_be32(len + new_len);
> -}
> -
> -static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
> -{
> -	tpm_buf_append(buf, &value, 1);
> -}
> -
> -static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
> -{
> -	__be16 value2 = cpu_to_be16(value);
> -
> -	tpm_buf_append(buf, (u8 *) &value2, 2);
> -}
> -
> -static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
> -{
> -	__be32 value2 = cpu_to_be32(value);
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
>  
>  /*
>   * Check if TPM device is in the firmware upgrade mode.
> -- 
> 2.35.3
> 

Since you are now moving things around, I think we should make best of it.

I'd consider a subsequent patch after this to further clean up the flow:

struct tpm_buf *tpm_buf_init(u16 tag, u32 ordinal)
{
        struct tpm_buf *buf;

        buf = kzalloc(sizeof(*buf), GFP_KERNEL);
        if (!buf)
                goto err_alloc_buf;

	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
	if (!buf->data)
                goto err_alloc_page;

	buf->flags = 0;
	tpm_buf_reset(buf, tag, ordinal);

	return 0;
        
err_alloc_page:
        kfree(buf);

err_alloc_buf:
        return ERR_PTR(-ENOMEM);
}
EXPORT_SYMBOL_GPL(tpm_buf_init);

void tpm_buf_destroy(struct tpm_buf *buf)
{
	free_page((unsigned long)buf->data);
        kfree(buf);
}

There is 28 call sites for tpm_buf_init() buf the change is
fairly trival as tpm_buf_destroy() calls can stay as they are.

BR, Jarkko
