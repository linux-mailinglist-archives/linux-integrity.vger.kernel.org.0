Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562AB70FDBF
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 20:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjEXSUw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 14:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbjEXSUw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 14:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463CAD3
        for <linux-integrity@vger.kernel.org>; Wed, 24 May 2023 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684952404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ZTQVTNtbSjFralO95zP3DggQ38BxzblGXjifW+msbk=;
        b=Wz3i/Ahi0toLuSugV1LHClZ8bvmJU04cqIoJnjuGHyKyIjnVJ+vMQtJV5fm8cXJdwGedov
        xbd+Ed/3FtA++SPIIeyobHlr2XMnl5pXWWRaDF/D/632dXB7e9EKUKr50w8pKfeTvA6Rzg
        XKNSUaIsRSH9yicftF93IcZdy6zaSLo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-6zTKrFynN0uEhpGBroltKQ-1; Wed, 24 May 2023 14:20:02 -0400
X-MC-Unique: 6zTKrFynN0uEhpGBroltKQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62382e86f83so636516d6.0
        for <linux-integrity@vger.kernel.org>; Wed, 24 May 2023 11:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684952401; x=1687544401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZTQVTNtbSjFralO95zP3DggQ38BxzblGXjifW+msbk=;
        b=QurI5BTgRi0UIAv7DqLper7k1D8uXFjy3F9098HYOo87BcpuDtvvQX0BMAD0hhP1xm
         mMb7NA1YNpwiCZgh+5/Z2BVSYRhR0Q/0XeTaxkkyw3kV4gyy2KuqwOcUTCxciXMe3u7a
         06Ifq9giboSBL6DM+Rmr9GFOqrutVNVVHuAm+Yp9ypkP2x+hNDPGyVBXKZkt5mYQQ3Ek
         Jh8E3Kw+jTv3xEqQ35D0Cp0CuxjYaGzdY5wEFk92sKsh/NWLVDc0fmL4kp6XqfMFHLV0
         PyQKkCZj9USV0AWiz3sYKg9OkW5DYzviVjXuJ4wjoSQrFcN3SepJQ8ZGjR8wNhegqaWp
         QqBQ==
X-Gm-Message-State: AC+VfDy7FBXBxC0ye86kMXNNYt4hG98p+7G6Chy/nyHykHFdEqEVjczP
        YLOo9Sehjy5Z/od9x/8o2q/NKSdiEPWcnITfCr+cEKAG/gCoETO+2xylHMqYvG9gg2O04n3O3VU
        aUQI2JE25oi6WtcJBB+aJT3f76YuM
X-Received: by 2002:a05:6214:1247:b0:621:65de:f5fa with SMTP id r7-20020a056214124700b0062165def5famr27747454qvv.15.1684952401600;
        Wed, 24 May 2023 11:20:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7f3Vt+J1XtSPftvonejF4syJO11uEZJU7VnSKTfSx/HrkvpsDniAGelrWceaGNtfjLcIO5aw==
X-Received: by 2002:a05:6214:1247:b0:621:65de:f5fa with SMTP id r7-20020a056214124700b0062165def5famr27747441qvv.15.1684952401391;
        Wed, 24 May 2023 11:20:01 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g3-20020a0cf083000000b0062594434760sm1763829qvk.21.2023.05.24.11.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 11:20:00 -0700 (PDT)
Date:   Wed, 24 May 2023 11:19:59 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Michael Haener <michael.haener@siemens.com>
Subject: Re: [PATCH 1/2] tpm: tis_i2c: Limit read bursts to
 I2C_SMBUS_BLOCK_MAX (32) bytes
Message-ID: <2cuk33wgfakjzzjtm2qhr4i34v4qst46pe5zk3n2szq534sggj@qvmj53emcg76>
References: <20230524154040.1204030-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524154040.1204030-1-alexander.sverdlin@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 24, 2023 at 05:40:39PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Underlying I2C bus drivers not always support longer transfers and
> imx-lpi2c for instance doesn't. SLB 9673 offers 427-bytes packets.
> 
> Visible symptoms are:
> 
> tpm tpm0: Error left over data
> tpm tpm0: tpm_transmit: tpm_recv: error -5
> tpm_tis_i2c: probe of 1-002e failed with error -5
> 
> Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
> Tested-by: Michael Haener <michael.haener@siemens.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 37 ++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index c8c34adc14c0..106fd20d94e4 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -189,21 +189,28 @@ static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
>  	int ret;
>  
>  	for (i = 0; i < TPM_RETRY; i++) {
> -		/* write register */
> -		msg.len = sizeof(reg);
> -		msg.buf = &reg;
> -		msg.flags = 0;
> -		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> -		if (ret < 0)
> -			return ret;
> -
> -		/* read data */
> -		msg.buf = result;
> -		msg.len = len;
> -		msg.flags = I2C_M_RD;
> -		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> -		if (ret < 0)
> -			return ret;
> +		u16 read = 0;
> +
> +		while (read < len) {
> +			/* write register */
> +			msg.len = sizeof(reg);
> +			msg.buf = &reg;
> +			msg.flags = 0;
> +			ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> +			if (ret < 0)
> +				return ret;
> +
> +			/* read data */
> +			msg.buf = result + read;
> +			msg.len = len - read;
> +			msg.flags = I2C_M_RD;
> +			if (msg.len > I2C_SMBUS_BLOCK_MAX)
> +				msg.len = I2C_SMBUS_BLOCK_MAX;
> +			ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
> +			if (ret < 0)
> +				return ret;
> +			read += msg.len;
> +		}
>  
>  		ret = tpm_tis_i2c_sanity_check_read(reg, len, result);
>  		if (ret == 0)
> -- 
> 2.40.1
> 

