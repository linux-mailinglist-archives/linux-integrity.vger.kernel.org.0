Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D09758B784
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Aug 2022 20:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiHFSLj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 6 Aug 2022 14:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHFSLi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 6 Aug 2022 14:11:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DEADFB5;
        Sat,  6 Aug 2022 11:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 409AB611CD;
        Sat,  6 Aug 2022 18:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437F0C433D6;
        Sat,  6 Aug 2022 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809496;
        bh=QVM9KSZRLYkqpS1ouT+Ij9B/WbZhpHmHOeFMoBrXB7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4CbZDbLAvW0jaxY5dIiN3gUprCx0x/Y0b16YE55fmM+RMwVMDRhVqtQo/Hluv68y
         9D/xWTv+sbFZA6pX/6B3rUW501Eg3eHRMAq9x3dur2nCiSW251rq+LzAU5bfnvcNl0
         21VkLH51jhe7WuNClzrbQ7Trq61Ljs9bfp+ldR/0Q7j8I/nFfpcVGFg/JZ3URBssdM
         FKk2ZWZTu8N0EqHv444pobIbwv0OMhKyzIEgtmPpYk1AjCeeHoi3mTHRLcdhJkYfs6
         8or+KfFwiu0kXrFmERXXMZQlYiv6XrM4DPZu6KkdtHwWLvD0mQGZzyyHofodTUUxrQ
         gHJt4GzLdN7Sg==
Date:   Sat, 6 Aug 2022 21:11:33 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-integrity@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tpm/ppi: fix return type in tpm_show_ppi_response()
Message-ID: <Yu6u1RZb7uZ6rMA6@kernel.org>
References: <YutwPjef/hseEE31@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YutwPjef/hseEE31@kili>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 04, 2022 at 10:07:42AM +0300, Dan Carpenter wrote:
> This "status" is declared as type acpi_status but it is never used to
> store any acpi_statuses, only int.
> 
> The tpm_show_ppi_response() function returns ssize_t (signed long) and
> acpi_status is unsigned int.  That means that negative error codes will
> be type promoted to large positive values.
> 
> Fixes: 84b1667dea23 ("ACPI / TPM: replace open-coded _DSM code with helper functions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/char/tpm/tpm_ppi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index 40018a73b3cb..240df925c38c 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -222,7 +222,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
>  {
> -	acpi_status status = -EINVAL;
> +	int status = -EINVAL;
>  	union acpi_object *obj, *ret_obj;
>  	u64 req, res;
>  	struct tpm_chip *chip = to_tpm_chip(dev);
> -- 
> 2.35.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
