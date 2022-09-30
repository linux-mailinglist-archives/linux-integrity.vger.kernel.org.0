Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853135F152B
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 23:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiI3Vrt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 17:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiI3Vro (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 17:47:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA31739FC;
        Fri, 30 Sep 2022 14:47:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65931B82A3A;
        Fri, 30 Sep 2022 21:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4375C433D6;
        Fri, 30 Sep 2022 21:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664574461;
        bh=ZBPfrNTJBRVcJdB24Bc1rFKtYjikX2m+0l3SbMey3u0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qI70m1e/n6B623II9prtzkwUhhXUX/1wlqX1uJxY0lQK48nzDDXSWDg/UaB4LyFWz
         3NCllbjJR9YIMG/F+YodnoR16MYOU16aWDxx5EIpZzore/g9qDTv325jULFMFKkxz9
         q4LlynuKJjtrTLvjv4oXAhUPe1vGW2mIYoTuz4WbM1Sct/BM4UTR1vghoPlCXJkB5i
         cW2Bw/6vR/kJNlIobPoqIMg8/QNk+spJN7OBYTVyNUxD0Np5k3L8LkmwjlyY5dNV/6
         riYv2m24EW3VcHxCB02c4g40HkF8MJLst1gXd7NEWhg1fIu1uW4Dq8cJZiwkFZPefX
         8H3H8LJQGTUjQ==
Date:   Sat, 1 Oct 2022 00:47:38 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>,
        eajames@linux.ibm.com
Subject: Re: [PATCH v2 3/3] tpm: tis-i2c: Add more compatible strings
Message-ID: <Yzdj+tRONyNFnPOw@kernel.org>
References: <20220928043957.2636877-1-joel@jms.id.au>
 <20220928043957.2636877-4-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928043957.2636877-4-joel@jms.id.au>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> -- 
> 2.35.1
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

IMHO could be picked to the same tree with DT changes instead
of my tree.

BR, Jarkko
