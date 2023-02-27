Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205BB6A3D5C
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 09:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjB0Iih (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 03:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjB0IiM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 03:38:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4089755;
        Mon, 27 Feb 2023 00:33:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F6160DC4;
        Mon, 27 Feb 2023 08:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E8BC4339C;
        Mon, 27 Feb 2023 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677486703;
        bh=gdg9RUQ+0dn+UKr5UGRdJ4g1625WFoipyqIstYrZ4vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQa51uFUY+1YsDw5JtU18QmLNuR6d5suyNE8nn6rDmzWErytbcoZufejANP4cixUH
         1ctpdP/9MZ+OBaFDOq+HldakBGwaSQNFNhIM2TtsiSVDcW2QzyGfvHNK5cpyNzZWiA
         RJQNFdQitTCBBn8wSqFEz+Cx36cGEzSDnWgR/zGwrrvRxlG4XfF8iwtmMGjToFsiSB
         Fr6Z0WUSDgimmgSxNN2y5g0EciswgT2K+sy7LlMjJAnwfFMN1M78afKAUpfaKf0/JM
         8v8PEEZHYnfsxvCvy8h8Y3J/VbGdw3nmCtEo0/GbvYOqa+S42xmrTRWGYQyVUGLenC
         QhmoSVIu7FlSA==
Date:   Mon, 27 Feb 2023 10:31:40 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 03/12] tpm: add buffer handling for TPM2B types
Message-ID: <Y/xqbCwh+VBmJ1ZL@kernel.org>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
 <20230216201410.15010-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216201410.15010-4-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 16, 2023 at 03:14:01PM -0500, James Bottomley wrote:
> Most complex TPM commands require appending TPM2B buffers to the
> command body.  Since TPM2B types are essentially variable size arrays,
> it makes it impossible to represent these complex command arguments as
> structures and we simply have to build them up using append primitives
> like these.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm-buf.c | 71 +++++++++++++++++++++++++++++++++++---
>  include/linux/tpm.h        |  3 ++
>  2 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index ca59b92e0f95..292c6f14f72c 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -7,17 +7,16 @@
>  #include <linux/module.h>
>  #include <linux/tpm.h>
>  
> -int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +static int __tpm_buf_init(struct tpm_buf *buf)
>  {
>  	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
>  	if (!buf->data)
>  		return -ENOMEM;
>  
>  	buf->flags = 0;
> -	tpm_buf_reset(buf, tag, ordinal);
> +
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(tpm_buf_init);
>  
>  void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  {
> @@ -29,17 +28,60 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_reset);
>  
> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	int rc;
> +
> +	rc = __tpm_buf_init(buf);
> +	if (rc)
> +		return rc;
> +
> +	tpm_buf_reset(buf, tag, ordinal);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init);
> +
> +int tpm_buf_init_2b(struct tpm_buf *buf)

kdoc

> +{
> +	struct tpm_header *head;
> +	int rc;
> +
> +	rc = __tpm_buf_init(buf);
> +	if (rc)
> +		return rc;
> +
> +	head = (struct tpm_header *) buf->data;
> +
> +	head->length = cpu_to_be32(sizeof(*head));
> +
> +	buf->flags = TPM_BUF_2B;

Please make tpm_buf_init() and tpm_buf_reset() to work for both cases.

This explodes the whole thing into an unmaintainable mess. It is better
to have a type as a parameter for tpm_buf_init() and have only single
flow instead of open coded and patched variation.

I'd simply just put it as:

struct tpm_buf *tpm_buf_init(u16 tag, u32 ordinal, bool tpm2b)

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init_2b);
> +
>  void tpm_buf_destroy(struct tpm_buf *buf)
>  {
>  	free_page((unsigned long)buf->data);
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>  
> +static void *tpm_buf_data(struct tpm_buf *buf)
> +{
> +	if (buf->flags & TPM_BUF_2B)
> +		return buf->data + TPM_HEADER_SIZE;
> +	return buf->data;
> +}
> +
>  u32 tpm_buf_length(struct tpm_buf *buf)
>  {
>  	struct tpm_header *head = (struct tpm_header *)buf->data;
> +	u32 len;
>  
> -	return be32_to_cpu(head->length);
> +	len = be32_to_cpu(head->length);
> +	if (buf->flags & TPM_BUF_2B)
> +		len -= sizeof(*head);
> +	return len;
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_length);
>  
> @@ -55,7 +97,7 @@ void tpm_buf_append(struct tpm_buf *buf,
>  		    unsigned int new_len)
>  {
>  	struct tpm_header *head = (struct tpm_header *) buf->data;
> -	u32 len = tpm_buf_length(buf);
> +	u32 len = be32_to_cpu(head->length);
>  
>  	/* Return silently if overflow has already happened. */
>  	if (buf->flags & TPM_BUF_OVERFLOW)
> @@ -93,3 +135,22 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
>  	tpm_buf_append(buf, (u8 *) &value2, 4);
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> +
> +static void tpm_buf_reset_int(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head;
> +
> +	head = (struct tpm_header *)buf->data;
> +	head->length = cpu_to_be32(sizeof(*head));
> +}
> +
> +void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
> +{
> +	u16 len = tpm_buf_length(tpm2b);
> +
> +	tpm_buf_append_u16(buf, len);
> +	tpm_buf_append(buf, tpm_buf_data(tpm2b), len);
> +	/* clear the buf for reuse */
> +	tpm_buf_reset_int(tpm2b);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 150b39b6190e..f2d4dab6d832 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -300,6 +300,7 @@ struct tpm_header {
>  
>  enum tpm_buf_flags {
>  	TPM_BUF_OVERFLOW	= BIT(0),
> +	TPM_BUF_2B		= BIT(1),
>  };


This is IMHO unnecessary complex.

I think we could just have two bools:

        bool overflow;
        bool tpm2b;

>  
>  struct tpm_buf {
> @@ -324,6 +325,7 @@ struct tpm2_hash {
>  
>  
>  int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
> +int tpm_buf_init_2b(struct tpm_buf *buf);
>  void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
>  void tpm_buf_destroy(struct tpm_buf *buf);
>  u32 tpm_buf_length(struct tpm_buf *buf);
> @@ -332,6 +334,7 @@ void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
>  void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
>  void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
>  void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
> +void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
>  
>  /*
>   * Check if TPM device is in the firmware upgrade mode.
> -- 
> 2.35.3
> 

BR, Jarkko
