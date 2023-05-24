Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E471009B
	for <lists+linux-integrity@lfdr.de>; Thu, 25 May 2023 00:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjEXWGL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 18:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXWGK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 18:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C914F10B
        for <linux-integrity@vger.kernel.org>; Wed, 24 May 2023 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684965928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DeqRFv3pTnY1SPjH830J9mOrh/zgCZIygtuFaXvfopU=;
        b=hAn3qw/+6gV4/CNMEDped0XFx45aQ4qFuHL/nOnQH0rXIinvO5qriPsSy3Gu83Oh5yUBex
        BnuQO8/uZ6v7gqswIQjTel9rPWC3LF/KJR2d9PafjJyCIqpNHgTREIGSIspn0NDJoM2k8J
        C6iKsvrYvOFWwdcLVgvqtP191gA2WPs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-Te80-G9QOHmvMn3bJg98rQ-1; Wed, 24 May 2023 18:05:27 -0400
X-MC-Unique: Te80-G9QOHmvMn3bJg98rQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b03d12d38so38179885a.2
        for <linux-integrity@vger.kernel.org>; Wed, 24 May 2023 15:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684965927; x=1687557927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeqRFv3pTnY1SPjH830J9mOrh/zgCZIygtuFaXvfopU=;
        b=bzx+hTlsTiEz7AwTPw9sZ099STb8pZpvHBtcWhvKyabCjTxvSt6X6RjhJcIRyLXeQ+
         Y7hOyCbpcTGY+pabTUFNNyIPfyy9Onb+pGfxCMFl7tK7rau8oh5ne6IvLMDer0ZgCHd6
         j92fWknUxdDGVrIjP0EgOuF7VSxcI7XtvPwe4eMpM0FkIEJymBD+fNuosi0GStYvgumX
         AwgQrZId1CAdsztsOUiPIJ1L3nSJ85U1vFdMOHm00RXhzDO0cVrItSk6OlfTQmoT8Lqd
         xMvwGzkmVVsWIKxQV9vSbNYNgS4BAZDaf894Yf+C5V4quIHaoDKPumcsDTE6iQkjNqGN
         0Gng==
X-Gm-Message-State: AC+VfDyYtz3xTfMWdqRTTgpwI5qd14mT3u/6Mo2dbYMwRXHLWYPLVC74
        XaeXibmcPOrONp2zHfxNtimHW/bhCgXU9gZQkKDMfl6dq7LnHEPGPYVj3uckT5xjmT6DMIosd0k
        WkKWBsf8zcLpOUQl4k0ROZz+2JV2i
X-Received: by 2002:a05:620a:6285:b0:75b:23a1:3676 with SMTP id ov5-20020a05620a628500b0075b23a13676mr8791490qkn.55.1684965927118;
        Wed, 24 May 2023 15:05:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Zr3nHvlIp9QTEWoxtw36XRe1bUW59x6AVZeeOEY/5LF+P/SdaQ9JPkSKVtKUPPQONu3BkYA==
X-Received: by 2002:a05:620a:6285:b0:75b:23a1:3676 with SMTP id ov5-20020a05620a628500b0075b23a13676mr8791475qkn.55.1684965926903;
        Wed, 24 May 2023 15:05:26 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id f25-20020a05620a15b900b0075b196ae392sm2250959qkk.104.2023.05.24.15.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:05:26 -0700 (PDT)
Date:   Wed, 24 May 2023 15:05:24 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Michael Haener <michael.haener@siemens.com>
Subject: Re: [PATCH 2/2] tpm: tis_i2c: Limit write bursts to
 I2C_SMBUS_BLOCK_MAX (32) bytes
Message-ID: <esbihoqenwhejhpzq7tlk3uim22glv76h5742cvinbmb6sswqc@4luuvm5ebwwh>
References: <20230524154040.1204030-1-alexander.sverdlin@siemens.com>
 <20230524154040.1204030-2-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524154040.1204030-2-alexander.sverdlin@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 24, 2023 at 05:40:40PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Underlying I2C bus drivers not always support longer transfers and
> imx-lpi2c for instance doesn't. The fix is symmetric to previous patch
> which fixed the read direction.
> 
> Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
> Tested-by: Michael Haener <michael.haener@siemens.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 106fd20d94e4..82fda488e98b 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -230,19 +230,27 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
>  	struct i2c_msg msg = { .addr = phy->i2c_client->addr };
>  	u8 reg = tpm_tis_i2c_address_to_register(addr);
>  	int ret;
> +	u16 wrote = 0;
>  
>  	if (len > TPM_BUFSIZE - 1)
>  		return -EIO;
>  
> -	/* write register and data in one go */
>  	phy->io_buf[0] = reg;
> -	memcpy(phy->io_buf + sizeof(reg), value, len);
> -
> -	msg.len = sizeof(reg) + len;
>  	msg.buf = phy->io_buf;
> -	ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> -	if (ret < 0)
> -		return ret;
> +	while (wrote < len) {
> +		/* write register and data in one go */
> +		msg.len = sizeof(reg) + len - wrote;
> +		if (msg.len > I2C_SMBUS_BLOCK_MAX)
> +			msg.len = I2C_SMBUS_BLOCK_MAX;
> +
> +		memcpy(phy->io_buf + sizeof(reg), value + wrote,
> +		       msg.len - sizeof(reg));
> +
> +		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> +		if (ret < 0)
> +			return ret;
> +		wrote += msg.len - sizeof(reg);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.40.1
> 

