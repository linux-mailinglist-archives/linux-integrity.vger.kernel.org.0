Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4BC56D213
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Jul 2022 02:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGKACU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Jul 2022 20:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGKACT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Jul 2022 20:02:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64DEE003;
        Sun, 10 Jul 2022 17:02:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B9460FE6;
        Mon, 11 Jul 2022 00:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C67AC3411E;
        Mon, 11 Jul 2022 00:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657497737;
        bh=D1fLsHhzQtsYRlZFh4fxRBKP3QtHCA+Vt/IZDCCRDqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBDcq0mQCr9o4FWdXd3z+DjwbFhv8IBeTbKZzgj+hQdBdDqUlz1Tp0bNRMdoGX8CY
         8atcBcehrFAgXWCkTbWO3ecwZnDvUuCSH4Eyn2AhyD+XQ0dCsbbgytm6E4lzUU1S0y
         XUcCDwXZLheRdfmcrXtUeDReyQ2Z3uB/pxUa9hkzSCBSzMzpuy4cPg5zf8/MhatuQP
         +6JUuvpmoWkXOhaO5S9u4L4FeEwhydLNy3JpA8l7T4RlQLKXgwDTeO2f2i8sz4JSrO
         LHU9++muVx2kszmg2RcRKhDrvPtgdeoYQh5paoOi+5/trZnjADj8KXwErZGZjpEXb3
         H+cKRNSugRrqw==
Date:   Mon, 11 Jul 2022 03:02:11 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tpm: fix platform_no_drv_owner.cocci warning
Message-ID: <Ystog1WaJZ5XgJAP@kernel.org>
References: <20220701091322.59384-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701091322.59384-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 01, 2022 at 05:13:22PM +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/char/tpm/tpm_tis_i2c.c:379:3-8: No need to set .owner here.  The core will do it.
> 
> Remove .owner field if calls are used which set it automatically
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 8e0686fe4eb1..ba0911b1d1ff 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -376,7 +376,6 @@ MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
>  
>  static struct i2c_driver tpm_tis_i2c_driver = {
>  	.driver = {
> -		.owner = THIS_MODULE,
>  		.name = "tpm_tis_i2c",
>  		.pm = &tpm_tis_pm,
>  		.of_match_table = of_match_ptr(of_tis_i2c_match),
> -- 
> 2.20.1.7.g153144c
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
