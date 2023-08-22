Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8979783EA1
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Aug 2023 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjHVLPp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Aug 2023 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjHVLPp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Aug 2023 07:15:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0544F1BE;
        Tue, 22 Aug 2023 04:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86A5B630A5;
        Tue, 22 Aug 2023 11:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF08EC433C8;
        Tue, 22 Aug 2023 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692702942;
        bh=WWnUFRYYCqhoHCdpIcwCf3PPBW7vB8AWGZIXDAYxm98=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=YnQve18rwGbzuAttWAm+Lwf2wQFEjJxBYepCCmXdhF+jkedf4dSVXocWFM8dDcRkU
         FxBdBrbIRL1Zt7AqUeu63+iONh0pWn3dQJwqYpuUF87j9c5kOLgKBS+pc4kVn3iaLs
         67X1JiOr8RSeAje3LixsAZ6LdGuaKd5vBHtFp23JTpzrpvcbi2Eyn+rdR0mIRgP73Z
         FabjzNxwtCiiOEEqCO/6iDuonrVifUDjss5BG/MPP0iYyoFq6GCUJkmOc+v8hlSvUF
         YVTdfhxQbUDheOMjmHc3GgEtgBRfGf5+h5l68T3mrT+rOrB7jR2AUE3D4O//68Ln8g
         JO5jWoL6RQn+g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 14:15:39 +0300
Message-Id: <CUZ143E6EP2G.2V9A6YWYBSXJX@suppilovahvero>
To:     "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
Cc:     <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v4 05/13] tpm: add cursor based buffer functions for
 response parsing
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-6-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20230403214003.32093-6-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

No overflow check, and these should be static inlines.

Please consider this:

/**
 * tpm_buf_read_u8() - Read a byte from a TPM buffer
 * @buf:	&tpm_buf instance
 * @offset:	offset within the consumed part of the buffer
 */
static inline int tpm_buf_read_u8(const struct tpm_buf *buf, offs_t *offset=
)
{
	if (*offset++ >=3D buf->length)
		return -EINVAL;
=09
	return buf->data[*offset - 1];	=09
}

Depends on:

https://lore.kernel.org/linux-integrity/20230821033630.1039527-1-jarkko@ker=
nel.org/

No motivation for weird cursor concept, when the reality is just
a read from a buffer.

BR, Jarkko
