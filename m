Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD85F0DD2
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 16:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiI3Oos (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 10:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiI3Oor (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 10:44:47 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AFD1037;
        Fri, 30 Sep 2022 07:44:40 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-131dda37dddso4708386fac.0;
        Fri, 30 Sep 2022 07:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cvFArS6MbZlp0VEs9+nbM3Zi/QLj8a6RzAmXxUMKqqY=;
        b=zhvj62T0FppdrxfXVw5Hj8PVm/e1fkfTGgkS6KeJMwdGO2/0XC4se2mOTvtHlMLDLP
         gm3ZqnsJ17ZmL7abpKnWU+fzWy/dXpfp4uTfjTuqyze4/2T8TSto1v9W/kH+1PMuRRiD
         /3uA5zMLrez45BdDgf4giuNjc1++0H8GcSnkmqYmR+RZkTSF/A2Fndx9083SmKgYxRCL
         vpH6lGySsGPRf9VG6+Mk54JapIKnH0YHMFwS2hjlk3GROtNZFCaGyhQJQRXYzUVq4PnY
         PwHflYYnuLrnWPRjnYy3bBB4R21nxTNc2jb/lYwVpu9ae0uXo+UqxZETMKXoFSMifQKS
         Y9Mg==
X-Gm-Message-State: ACrzQf0DBg/5Mj6IDELcoKY/nZ9vKlDJ1KdDH0Qo7Sg3env5ZqvD0p5j
        cGT5GVhiCUoSbofTVVw3cA==
X-Google-Smtp-Source: AMsMyM4y7nt+4cE/cnupvOpbwnXeIop/R3L2Xtd4hhCnD0Tm/E/fmzbPA2hVxn+FMX+L9nLirejFdQ==
X-Received: by 2002:a05:6870:e886:b0:131:c8fe:1b60 with SMTP id q6-20020a056870e88600b00131c8fe1b60mr4867995oan.248.1664549079541;
        Fri, 30 Sep 2022 07:44:39 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bx14-20020a0568081b0e00b00342fedaf7d9sm545439oib.43.2022.09.30.07.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:44:39 -0700 (PDT)
Received: (nullmailer pid 289557 invoked by uid 1000);
        Fri, 30 Sep 2022 14:44:38 -0000
Date:   Fri, 30 Sep 2022 09:44:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>,
        eajames@linux.ibm.com
Subject: Re: [PATCH v2 3/3] tpm: tis-i2c: Add more compatible strings
Message-ID: <20220930144438.GA287295-robh@kernel.org>
References: <20220928043957.2636877-1-joel@jms.id.au>
 <20220928043957.2636877-4-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928043957.2636877-4-joel@jms.id.au>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 28, 2022 at 02:09:57PM +0930, Joel Stanley wrote:
> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
> 
> https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
> 
> Add a compatible string for it, and the generic compatible.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 0692510dfcab..4af27b7ec5b1 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -368,6 +368,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>  #ifdef CONFIG_OF
>  static const struct of_device_id of_tis_i2c_match[] = {
>  	{ .compatible = "infineon,slb9673", },
> +	{ .compatible = "nuvoton,npct75x", },
> +	{ .compatible = "tcg,tpm-tis-i2c", },

If there is not currently any distinction that the kernel makes, you 
only need to add "tcg,tpm-tis-i2c".

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> -- 
> 2.35.1
> 
> 
