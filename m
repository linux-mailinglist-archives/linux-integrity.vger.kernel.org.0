Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8E6EBCC9
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 06:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjDWEOg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 00:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWEOg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 00:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AAE19B1;
        Sat, 22 Apr 2023 21:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7F4460DDF;
        Sun, 23 Apr 2023 04:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EDCC433EF;
        Sun, 23 Apr 2023 04:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682223274;
        bh=yke6izOJiVGi9KSDMZ0BYiX41S7UyYnOVuABRhywGYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXE5sewzI+MJ0Z9PU8tM0rsW+3Srl4xxnhEBvo3JXjnKsO0ekDHysgDTVnj974XTP
         06KRHMOSAaHn19A833MWtew3afDd1TMTwG+xnYgyahx9VpkPn9lxJrTmy38pzQHs8w
         eCsU5v/QZZwK+bbQg2Q+pTnCRBaigrmHaYDs4OsywgjllUs/pqhx8Kj6VzYFBo7oyW
         JOm15Ts5Y4N5eNXC0NrmnVT0dBmHG6TAV9ZgOsYZHd6EeBUB26jcrWHazr4P7BzYnJ
         8ITaz1ApVWvQN03RSZlFhhJLF5aLbgCGCH2WOmeDZwmrIj0oNOJnct5598mvTmYMQ9
         JXUqoohYsmZ7w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 23 Apr 2023 07:14:31 +0300
Message-Id: <CS3UDQ7027ML.JW1CH712KCUL@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
Cc:     <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v4 05/13] tpm: add cursor based buffer functions for
 response parsing
X-Mailer: aerc 0.14.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-6-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20230403214003.32093-6-James.Bottomley@HansenPartnership.com>
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
> Extracting values from returned TPM buffers can be hard.  Add cursor
> based (moving poiner) functions that make it easier to extract TPM
> returned values from a buffer.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
> v4: add kernel doc and reword commit
> ---
>  drivers/char/tpm/tpm-buf.c | 48 ++++++++++++++++++++++++++++++++++++++
>  include/linux/tpm.h        |  3 +++
>  2 files changed, 51 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index b7e42fb6266c..da0f6e725c3f 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -6,6 +6,8 @@
>  #include <linux/module.h>
>  #include <linux/tpm.h>
> =20
> +#include <asm/unaligned.h>
> +
>  static int __tpm_buf_init(struct tpm_buf *buf)
>  {
>  	buf->data =3D (u8 *)__get_free_page(GFP_KERNEL);
> @@ -229,3 +231,49 @@ void tpm_buf_append_2b(struct tpm_buf *buf, struct t=
pm_buf *tpm2b)
>  	tpm_buf_reset_int(tpm2b);
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
> +
> +/* functions for unmarshalling data and moving the cursor */
> +
> +/**
> + * tpm_get_inc_u8 - read a u8 and move pointer beyond it
> + * @ptr: pointer to pointer
> + *
> + * @return: value read
> + */
> +u8 tpm_get_inc_u8(const u8 **ptr)
> +{
> +	return *((*ptr)++);
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u8);
> +
> +/**
> + * tpm_get_inc_u16 - read a u16 and move pointer beyond it
> + * @ptr: pointer to pointer
> + *
> + * @return: value read (converted from big endian)
> + */
> +u16 tpm_get_inc_u16(const u8 **ptr)
> +{
> +	u16 val;
> +
> +	val =3D get_unaligned_be16(*ptr);
> +	*ptr +=3D sizeof(val);
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u16);
> +
> +/**
> + * tpm_get_inc_u32 - read a u32 and move pointer beyond it
> + * @ptr: pointer to pointer
> + *
> + * @return: value read (converted from big endian)
> + */
> +u32 tpm_get_inc_u32(const u8 **ptr)
> +{
> +	u32 val;
> +
> +	val =3D get_unaligned_be32(*ptr);
> +	*ptr +=3D sizeof(val);
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u32);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 76d495cb5b08..845eadfed715 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -336,6 +336,9 @@ void tpm_buf_append_u8(struct tpm_buf *buf, const u8 =
value);
>  void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
>  void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
>  void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
> +u8 tpm_get_inc_u8(const u8 **ptr);
> +u16 tpm_get_inc_u16(const u8 **ptr);
> +u32 tpm_get_inc_u32(const u8 **ptr);
> =20
>  /*
>   * Check if TPM device is in the firmware upgrade mode.
> --=20
> 2.35.3

Why not just inline functions?

BR, Jarkko
