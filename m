Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6D53B7CB
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jun 2022 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiFBL1Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jun 2022 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiFBL1X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jun 2022 07:27:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509102ACB46;
        Thu,  2 Jun 2022 04:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 395F8B81EFC;
        Thu,  2 Jun 2022 11:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999A9C385A5;
        Thu,  2 Jun 2022 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654169238;
        bh=bkkX8lyw+LlhjrWMM9UPH00U1eomprbT2CFStMN6JTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fec5AsNMHf1/CMW5blwRUqYNKLZZuq8z35ueIPBTc335mfgxSp/pO/sq8yCVBIl+x
         KRrwEzAO/oqKQJzJSceuE7U0nXAZTa6XhRR74WQkJFt5TQJ1NzA3uFStQ7zFY+L1VE
         DvjOUTVC1OoKmh8g7OJMhz4fTRiihbaI3QqEpoTkX/z7Khsq673LGR8LUvQ6T+NaS6
         c9ZT7h0QliTPw7/PoMB2qvrrJ7KWsSk7ZqSxpslIry3PbAyZn/uzMjHxPJvmCmyaYc
         z4WmbM15tFbfKT6P8Wl7n4PchUaqTgJ0poc9Ho1Rc7t0EBlq7N9klGdYDboBpEmbyW
         SOsQmx1Gf9/7g==
Date:   Thu, 2 Jun 2022 14:25:26 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: Add upgrade/reduced mode support for TPM1.2 modules
Message-ID: <YpieJlx511jZUDmn@iki.fi>
References: <20220601083810.330809-1-stefan.mahnke-hartmann@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601083810.330809-1-stefan.mahnke-hartmann@infineon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 01, 2022 at 10:38:11AM +0200, Stefan Mahnke-Hartmann wrote:
> In case a TPM in failure mode is detected, the TPM should be accessible
> through a transparent communication channel for analysing purposes (e.g.
> TPM_GetTestResult) or a field upgrade. Since a TPM in failure mode has
> similar reduced functionality as in field upgrade mode, the flag
> TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE is also valid.
> 
> As described in TCG TPM Main Part1 Design Principles, Revision 116,
> chapter 9.2.1. the TPM also allows an update function in case a TPM is
> in failure mode.
> 
> If the TPM in failure mode is detected, the function tpm1_auto_startup()
> sets TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE flag. This patch simply follows
> the same rationale as TPM2 in field upgrade mode.

"following the rationale" does not give a clue what it does.

Also minor nit: write in imperative from, and please do not say "this
patch". It won't be a patch, once it is in git.

> Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
> ---
> If you have any better suggestions, please let me know.
> 
>  drivers/char/tpm/tpm1-cmd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index f7dc986fa4a0..7a42d74c450c 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -710,8 +710,10 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>  		goto out;
>  	rc = tpm1_do_selftest(chip);
>  	if (rc) {
> -		dev_err(&chip->dev, "TPM self test failed\n");
> -		goto out;
> +		dev_err(&chip->dev, "TPM self test failed, so the TPM has limited functionality\n");
> +		/* A TPM in this state possibly allows or needs a firmware upgrade */
> +		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
> +		rc = 0;
>  	}
>  
>  	return rc;
> -- 
> 2.25.1
> 

Why all error codes trigger this action, e.g. all possible TPM2
errors and -ETIME?

BR, Jarkko
