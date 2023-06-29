Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1EE742AE8
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jun 2023 18:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjF2Q7u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jun 2023 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF2Q7n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jun 2023 12:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF943595
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jun 2023 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688057935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swdMiA1r9t+az8w+QR1JvmbiMrBSFzQ6KVm/MzBCuOU=;
        b=TXhT2gepLuJ4L+ZQW5RCH82AgvKmtvqdb98/I2Ilss9vgvza2TnG0B/JTdIQjV3+33vW/1
        nPpKhTkaXIh7d/vT2rXALE7emTB5NpSPrHX3A+D9ojioQl+zI89NSR3rjXiUmk3LiYIABm
        2RF6T7TiWLgUOATuLp/k7Kt1q3GcvYk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-LhGnAAmCPyizHOcuSeEM6A-1; Thu, 29 Jun 2023 12:58:53 -0400
X-MC-Unique: LhGnAAmCPyizHOcuSeEM6A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e664d2f8so9702296d6.3
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jun 2023 09:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688057933; x=1690649933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swdMiA1r9t+az8w+QR1JvmbiMrBSFzQ6KVm/MzBCuOU=;
        b=O2NPbyxSuBtd+zOhzQ2O6d70bNom3BMtm4bjBHCeKp4hyqa9PP7Mglg2fEWg6pRR43
         H9EK35HeYfmpTxyHOi+5fYnSjrYUoH7UHoNKtYXQnKXJAgT5TC8tYhQ8kDi34FE/hnPw
         qfYMpZj5twMnjgcev1xU/NtzgbFRQcDzFI+N49AQrzD01/Z8e9gWk5zKY92VhRgL/XUW
         tVOXJHJCeBTduphsv0z09ACGEo6jl4Yi/SaUXm+VYhwCYaNDJGHJB2QtY4QmzL4CoI4k
         sA2Px67+mjHusy1bd0l+TTZmlxTXgOatwobASr19x03GNfRfeYz4n4Y2vclAD7fwLFVH
         MSjg==
X-Gm-Message-State: ABy/qLYW60WNyHcdvb+Mbvo5sK8lKUP82jdYFppWknbTJUGA8fLdLVVC
        KrPNT+iwWOG1rQ2OBLPlnRIS7sFm/gLJ9sJEic5pwlGAOZDxRqbYystbkxNCutdWcpwoOi6FU5I
        UiS5aFsEiIJU90vE1rQY/wfD9K5rswhCvvpUy
X-Received: by 2002:a05:6214:4110:b0:635:e0dd:db42 with SMTP id kc16-20020a056214411000b00635e0dddb42mr216414qvb.27.1688057933216;
        Thu, 29 Jun 2023 09:58:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEZh6c5lPlscLNAkoheXBIabQY3I2vBrGKgWcc7orFQAecMaAR78/iF4k9GfBYMHfhVZAMJ9g==
X-Received: by 2002:a05:6214:4110:b0:635:e0dd:db42 with SMTP id kc16-20020a056214411000b00635e0dddb42mr216401qvb.27.1688057932994;
        Thu, 29 Jun 2023 09:58:52 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id y11-20020ad457cb000000b00631eb444e6esm7108198qvx.51.2023.06.29.09.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:58:52 -0700 (PDT)
Date:   Thu, 29 Jun 2023 09:58:51 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Florian Bezdeka <florian@bezdeka.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo L590 devices
Message-ID: <qaghyyi3wd6sfppfkbf2d6spsnfafalseeznyjf5bgdj5nikdy@mz4t52hjkuus>
References: <20230620-flo-lenovo-l590-tpm-fix-v1-1-16032a8b5a1d@bezdeka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-flo-lenovo-l590-tpm-fix-v1-1-16032a8b5a1d@bezdeka.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 20, 2023 at 01:11:01PM +0200, Florian Bezdeka wrote:
> The Lenovo L590 suffers from an irq storm issue like the T490, T490s
> and P360 Tiny, so add an entry for it to tpm_tis_dmi_table and force
> polling.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2214069#c0
> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Signed-off-by: Florian Bezdeka <florian@bezdeka.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/char/tpm/tpm_tis.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 7db3593941ea..2771abb5628f 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -138,6 +138,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
>  		},
>  	},
> +	{
> +		.callback = tpm_tis_disable_irq,
> +		.ident = "ThinkPad L590",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
> +		},
> +	},
>  	{
>  		.callback = tpm_tis_disable_irq,
>  		.ident = "UPX-TGL",
> 
> ---
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> change-id: 20230620-flo-lenovo-l590-tpm-fix-4aeb6aa25667
> 
> Best regards,
> -- 
> Florian Bezdeka <florian@bezdeka.de>
> 

