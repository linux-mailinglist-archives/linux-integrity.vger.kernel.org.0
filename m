Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954E5648C76
	for <lists+linux-integrity@lfdr.de>; Sat, 10 Dec 2022 03:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLJCJR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Dec 2022 21:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLJCJQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Dec 2022 21:09:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7B39767C;
        Fri,  9 Dec 2022 18:09:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A89CB82A0C;
        Sat, 10 Dec 2022 02:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF80FC433D2;
        Sat, 10 Dec 2022 02:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670638152;
        bh=FvIOcP7o3frcG+1GsWkjxk7rZHNpEQNgHwfmvgtg9WI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDhLhVX4V9CpZbo4P2b9es0BbhklyVy5SO9gILRVH8e1ncra56CdFcaaizN40UKMB
         D/b7+/QVlYJqrn7EuYXU+FAPG44njJdlu4fpKZvp79JzKdre2r4N3ckg9/IS9ppJZg
         68nysr0o69V5mpmAbHP/D1xVbBwa5p6HFwlIxh7Aoi6QNxUwriic9ZTmZB1RzJHDbN
         CwvVB5NmWot6BC4gisN3SBGKBOO5E8TpZrOG2rlho+uBB/m49aRU5TD+uFYpvtCDJF
         mior3L0rZ2i21spOyPE5wKUb3UYGZx32wB7pOhRNrQ0P34giljtwAAuRuL6BGbE/23
         jwWcJ5V/Vyhbg==
Date:   Sat, 10 Dec 2022 02:09:09 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        keyrings@vger.kernel.org
Subject: Re: [PATCH 01/11] tpm: move buffer handling from static inlines to
 real functions
Message-ID: <Y5PqRdlEdBjj72KM@kernel.org>
References: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
 <20221209160611.30207-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209160611.30207-2-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 09, 2022 at 11:06:01AM -0500, James Bottomley wrote:
> This separates out the old tpm_buf_... handling functions from static
> inlines in tpm.h and makes them their own tpm-buf.c file.  This is a
> precursor so we can add new functions for other TPM type handling
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

I don't comprehend that explanation at all.

Please, add a bit more detail why this precursory change is required.

> ---
>  drivers/char/tpm/Makefile  |  1 +
>  drivers/char/tpm/tpm-buf.c | 96 ++++++++++++++++++++++++++++++++++++++
>  include/linux/tpm.h        | 86 ++++------------------------------
>  3 files changed, 106 insertions(+), 77 deletions(-)
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
> index 000000000000..4e6e8b281f6a
> --- /dev/null
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Handing for tpm_buf structures to facilitate the building of commands
> + */
> +
> +#include <linux/module.h>
> +#include <linux/tpm.h>
> +
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
> +{
> +	free_page((unsigned long)buf->data);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_destroy);
> +
> +u32 tpm_buf_length(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +
> +	return be32_to_cpu(head->length);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_length);
> +
> +u16 tpm_buf_tag(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +
> +	return be16_to_cpu(head->tag);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_tag);
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
> +{
> +	tpm_buf_append(buf, &value, 1);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u8);
> +
> +void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
> +{
> +	__be16 value2 = cpu_to_be16(value);
> +
> +	tpm_buf_append(buf, (u8 *) &value2, 2);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u16);
> +
> +void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
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

BR, Jarkko
