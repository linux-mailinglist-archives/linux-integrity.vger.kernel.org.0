Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848826CF5C1
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Mar 2023 23:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjC2V7I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 17:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC2V7I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 17:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C72F4215;
        Wed, 29 Mar 2023 14:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADAF661E30;
        Wed, 29 Mar 2023 21:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C155CC433EF;
        Wed, 29 Mar 2023 21:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680127146;
        bh=iEM/0Fm3C9Mz+VkwKIyILQMrriOXiXAyc5Zvgo+7W14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8XGfUKPdcGGSEWAtahG1IWSCbT1OXW33pR8xCDXoaHTDCzc8wQlwwJ+qIzBP3tsQ
         fMRos4lgbJY2ptbIp2gRxlFblq+1ECVJrlYOKPm4PqnF7LfxaO9BJkpF51eiFmwj6y
         Rs0unKPWq/ylYCcm30+3McqZLildXpd8k/SQ7xRO5WKOtmkEj6dwm6PutWnr9gK7hJ
         kb7LMnPVw4JI8EKrVbpNi69H846oAZorNfa/Xfd2IdNTkHvB31LvW/8nozFVosHW3j
         SLQHQvF3uEMWXiZhcbhIq2n1TwbPndIK0U+aJC6e8u8YxRRubVrgdhJ5FBoBldgYr7
         MBYJHP3bzSZXw==
Date:   Thu, 30 Mar 2023 00:59:03 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] tpm: Fix a possible dereference of ERR_PTR in
 tpm_init()
Message-ID: <20230329215903.632cn3lrkpi3lz2p@kernel.org>
References: <20230321061416.626561-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321061416.626561-1-harshit.m.mogalapalli@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 20, 2023 at 11:14:15PM -0700, Harshit Mogalapalli wrote:
> Smatch reports:
> 	drivers/char/tpm/tpm-interface.c:470 tpm_init() error:
> 	'tpm_class' dereferencing possible ERR_PTR()
> 
> If class_create() returns error pointer, we are dereferencing a possible
> error pointer. Fix this by moving the dereference post error handling.
> 
> Fixes: a010eb881243 ("tpm: fix up the tpm_class shutdown_pre pointer when created")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis, only compile tested.
> ---
>  drivers/char/tpm/tpm-interface.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 43e23a04433a..4463d0018290 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -467,12 +467,13 @@ static int __init tpm_init(void)
>  	int rc;
>  
>  	tpm_class = class_create("tpm");
> -	tpm_class->shutdown_pre = tpm_class_shutdown;
>  	if (IS_ERR(tpm_class)) {
>  		pr_err("couldn't create tpm class\n");
>  		return PTR_ERR(tpm_class);
>  	}
>  
> +	tpm_class->shutdown_pre = tpm_class_shutdown;
> +
>  	tpmrm_class = class_create("tpmrm");
>  	if (IS_ERR(tpmrm_class)) {
>  		pr_err("couldn't create tpmrm class\n");
> -- 
> 2.38.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
