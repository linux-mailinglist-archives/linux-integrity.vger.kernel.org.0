Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AD46274D9
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 04:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiKNDQQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 22:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKNDQP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 22:16:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E877DA46C;
        Sun, 13 Nov 2022 19:16:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 129-20020a1c0287000000b003cfe48519a6so5308wmc.0;
        Sun, 13 Nov 2022 19:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IFS/dIJbtJh5TidL+3YZ8qyOFOMNzgN+p4JEU6MF5Ug=;
        b=Rs8ldB2o9083+xLRguIeJ3IEwMBwyhlg4/2HmHjhOFLOY9vUsf9wE65gkkbXVM7Eco
         whinPX9kxkkxN+VdrTYCekCz3yAEtXGgPaZ21y5sDGAs015ca7qeTEhDiPEcJ0FYJCpX
         KPVFquN1XNj5mtG/jQ0Qx6hSAojqKp2JLuGY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFS/dIJbtJh5TidL+3YZ8qyOFOMNzgN+p4JEU6MF5Ug=;
        b=gcvYCGN73EpLlGY3J/s9kHdbcxZ6NbimxHVadP+cbLcjLDIZzLifOvdxveUL+bIhLp
         kfV5jwY3yR+Tk4Bbyh8iIu1ZjxPr2DWCaEZVSZZOYjHNKIxhpslGBSB7j1zzRyB3dsWM
         NdoREY95g5tWCZW5GyN0t8URyR5dXgR2O+OwClXXTqFcGaSaRTHKWG3WqaQZ4+Odc66s
         tihUhW+Tq3Tv5OnNwCYiyUfgpFLZX3WeVhia8E7c0Hq1HnzMQqxTUl3l0TnPC+SdVn2S
         ob7tyyQhekdBWOSYaijnGDR8pi/IybFuoC/AS+jQ9bao9hPfVJAx2ZAHq6mdX1Bmobyd
         GB5A==
X-Gm-Message-State: ANoB5pnA+KZXuKjVPANGTbQpQWyCBZ4QL1vfWbhx1tQHLRPtZADMQUrg
        vpSsETjRSZ+9SlDVWp6DoW4LpbxSCmaXEaYMWBg=
X-Google-Smtp-Source: AA0mqf7Oo498tdMbVinJfRhOvkEEFvb8duzicBhA+Ipy707NIlw7LGeTIT9GHgq7aoYwIO7BsC5x0huvavLS4wONCes=
X-Received: by 2002:a05:600c:a11:b0:3c6:f83e:d1b3 with SMTP id
 z17-20020a05600c0a1100b003c6f83ed1b3mr6902003wmp.190.1668395772303; Sun, 13
 Nov 2022 19:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20220817200333.305264-1-eajames@linux.ibm.com>
In-Reply-To: <20220817200333.305264-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 14 Nov 2022 03:16:00 +0000
Message-ID: <CACPK8XfyOCmr_mRmaGTG6oJUNwU23ZoWam0e-RrQxY38=OnVrQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: tis_i2c: Fix sanity check interrupt enable mask
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander.Steffen@infineon.com, jgg@ziepe.ca, jarkko@kernel.org,
        peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 17 Aug 2022 at 20:03, Eddie James <eajames@linux.ibm.com> wrote:
>
> The sanity check mask for TPM_INT_ENABLE register was off by 8 bits,
> resulting in failure to probe if the TPM_INT_ENABLE register was a
> valid value.
>
> Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Tested-by: Joel Stanley <joel@jms.id.au>
Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")

Jarkko, do you plan on sending this as a fix?

> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 0692510dfcab..635a69dfcbbd 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -49,7 +49,7 @@
>
>  /* Masks with bits that must be read zero */
>  #define TPM_ACCESS_READ_ZERO 0x48
> -#define TPM_INT_ENABLE_ZERO 0x7FFFFF6
> +#define TPM_INT_ENABLE_ZERO 0x7FFFFF60
>  #define TPM_STS_READ_ZERO 0x23
>  #define TPM_INTF_CAPABILITY_ZERO 0x0FFFF000
>  #define TPM_I2C_INTERFACE_CAPABILITY_ZERO 0x80000000
> --
> 2.31.1
>
