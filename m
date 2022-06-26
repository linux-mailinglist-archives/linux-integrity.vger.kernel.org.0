Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8349355AF72
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Jun 2022 08:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiFZGVL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jun 2022 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiFZGVK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jun 2022 02:21:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7FCBC88
        for <linux-integrity@vger.kernel.org>; Sat, 25 Jun 2022 23:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7ABDB80CF8
        for <linux-integrity@vger.kernel.org>; Sun, 26 Jun 2022 06:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D27DC34114;
        Sun, 26 Jun 2022 06:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656224466;
        bh=maQ1tz3knugLh6rY37HB6Ytf9wOoI1CuWwnu21EHD0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkFe5MhpzuHfO+xUvSJBOIWvRK2HxYVkAcO0NFeXQovMZaM4T5cuP8EiRx0AMsFeO
         LCc5vWfGLd3i15uvYCsOhzRyiVbORxNTWtO3seaxwgMkW+rziz7WFKyoCoK0AJOmPB
         vwTu3GTbjkT2fDUDupOFz7MCskVCHKTUYHlr9KuyHUlcHd2g5s6T/Fna3GtXKjULPD
         DjiHn/0sS7FFK0bvS8nrc3pXrnyZfe7zi+HcwcBiuTHovocVEemAsew/hK7xjaxYjP
         qX3L84ttKQn2z0KM+L91fGJbuE4FaYJy+Vs8IBAzEzOGLJD1Vi4JaG++3v9QWPtqF8
         YBLlA4iYcfwsQ==
Date:   Sun, 26 Jun 2022 09:21:03 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2] tpm: Add check for Failure mode for TPM2 modules
Message-ID: <Yrf6z8ChB0XYOmuQ@kernel.org>
References: <20220620152129.551199-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620152129.551199-1-marten.lindahl@axis.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 20, 2022 at 05:21:29PM +0200, Mårten Lindahl wrote:
> In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
> TPM2 modules") it was said that:
> 
> "If the TPM is in Failure mode, it will successfully respond to both
> tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM
> is in Failure mode."
> 
> But a check was never added in the commit when calling
> tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode.
> This commit corrects this by adding a check.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
> 
> v2:
>  - Add missed check for TPM error code.
> 
>  drivers/char/tpm/tpm2-cmd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index c1eb5d223839..65d03867e114 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -752,6 +752,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  	}
>  
>  	rc = tpm2_get_cc_attrs_tbl(chip);
> +	if (rc == TPM2_RC_FAILURE || (rc < 0 && rc != -ENOMEM)) {
> +		dev_info(&chip->dev,
> +			 "TPM in field failure mode, requires firmware upgrade\n");
> +		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
> +		rc = 0;
> +	}
>  
>  out:
>  	/*
> -- 
> 2.30.2
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Shouldn't this have:

Cc: stable@vger.kernel.org # v5.17
Fixes: 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for TPM2 modules")

BR, Jarkko
