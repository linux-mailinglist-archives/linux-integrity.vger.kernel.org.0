Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350186A3D68
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 09:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjB0Ise (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 03:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjB0IsH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 03:48:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A67252A6;
        Mon, 27 Feb 2023 00:40:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DD33B80BE8;
        Mon, 27 Feb 2023 08:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC76C433EF;
        Mon, 27 Feb 2023 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677486842;
        bh=daN4vxGRyKHsdZInFbqx1YolKOv5AHiq+a5Oe5Jn9Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQH+P69bpThkbkW+NT0Sdt+nxbeE+/RtDKCuENW1QCHhHQIPLQVh6Hd7QoXd2eshH
         SCkOxOyrbotUisEQnX2LZ6Cyb50BO9lnQxmI1UQCKTBZ2BjupWltSAZhIlxekF3Yej
         5mqp8H1FxwTE/UtwO4YuSHGep9rdyZRzgSx8mO0bdIJML49R5nfz40EmNnwNT/S9Ue
         jvnQCI2AwOJ/RM6W1bR79JgULY+QHhYONcf0qA987cCNvv0w8i5R1N/LtVGRY+j4zU
         u33zAf2htQLKzOLzs2LMFtXgotqOLP1s6doV5mTqogx1S7zu3nCPPI+tRSRHxdTRHo
         SQgtiL1HdDIVg==
Date:   Mon, 27 Feb 2023 10:34:00 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 04/12] tpm: add cursor based buffer functions for
 response parsing
Message-ID: <Y/xq+MgLgJequlOk@kernel.org>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
 <20230216201410.15010-5-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216201410.15010-5-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 16, 2023 at 03:14:02PM -0500, James Bottomley wrote:
> Once we have encryption and authentication, marshalling and
> unmarshalling sessions becomes hugely complex.  Add cursor based
> functions which update the current pointer to make response parsing
> easier.

You need to properly introduce the concept of cursor based function,
and how that maps into implementation.

I understand absolutely nothing of the change just by reading the
commit message, it is pretty much useless peace of text.

> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm-buf.c | 29 +++++++++++++++++++++++++++++
>  include/linux/tpm.h        |  3 +++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 292c6f14f72c..b76158f9bcd0 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -7,6 +7,8 @@
>  #include <linux/module.h>
>  #include <linux/tpm.h>
>  
> +#include <asm/unaligned.h>
> +
>  static int __tpm_buf_init(struct tpm_buf *buf)
>  {
>  	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> @@ -154,3 +156,30 @@ void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
>  	tpm_buf_reset_int(tpm2b);
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
> +
> +/* functions for unmarshalling data and moving the cursor */
> +u8 tpm_get_inc_u8(const u8 **ptr)
> +{
> +	return *((*ptr)++);
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u8);
> +
> +u16 tpm_get_inc_u16(const u8 **ptr)
> +{
> +	u16 val;
> +
> +	val = get_unaligned_be16(*ptr);
> +	*ptr += sizeof(val);
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u16);
> +
> +u32 tpm_get_inc_u32(const u8 **ptr)
> +{
> +	u32 val;
> +
> +	val = get_unaligned_be32(*ptr);
> +	*ptr += sizeof(val);
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u32);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index f2d4dab6d832..f7cff1d114b0 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -335,6 +335,9 @@ void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
>  void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
>  void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
>  void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
> +u8 tpm_get_inc_u8(const u8 **ptr);
> +u16 tpm_get_inc_u16(const u8 **ptr);
> +u32 tpm_get_inc_u32(const u8 **ptr);
>  
>  /*
>   * Check if TPM device is in the firmware upgrade mode.
> -- 
> 2.35.3
> 

BR, Jarkko
