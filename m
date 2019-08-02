Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7FD7FD8E
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 17:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbfHBPaq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 11:30:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57690 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733136AbfHBPap (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 11:30:45 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1htZVr-0001Mo-Ax; Fri, 02 Aug 2019 15:30:35 +0000
Date:   Fri, 2 Aug 2019 10:30:30 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v2] KEYS: trusted: allow module init if TPM is inactive
 or deactivated
Message-ID: <20190802153030.GB26616@elm>
References: <20190802150733.1972-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802150733.1972-1-roberto.sassu@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019-08-02 17:07:33, Roberto Sassu wrote:
> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
> TPM") allows the trusted module to be loaded even a TPM is not found to
                                                   ^ if

> avoid module dependency problems.
> 
> However, trusted module initialization can still fail if the TPM is
> inactive or deactivated. This patch ignores tpm_get_random() errors in
> init_digests() and returns -EFAULT in pcrlock() if the TPM didn't return
> random data.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

The code changes look correct to me.

  Reviewed-by: Tyler Hicks <tyhicks@canonical.com>

For whoever takes this patch through their tree, I think that adding the
following Fixes tag would be useful (as well as cc'ing stable):

  Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")

I think it is also worth leaving a short note, in the commit message,
for backporters that commit 782779b60faa ("tpm: Actually fail on TPM
errors during "get random"") should be included with any backports of
this patch.

Thanks!

Tyler

> ---
>  security/keys/trusted.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index 9a94672e7adc..34f04ffcf2e5 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -389,6 +389,10 @@ static int pcrlock(const int pcrnum)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	/* This happens if the TPM didn't return random data */
> +	if (!digests)
> +		return -EFAULT;
> +
>  	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
>  }
>  
> @@ -1233,10 +1237,8 @@ static int __init init_digests(void)
>  	int i;
>  
>  	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
> -	if (ret < 0)
> -		return ret;
> -	if (ret < TPM_MAX_DIGEST_SIZE)
> -		return -EFAULT;
> +	if (ret < 0 || ret < TPM_MAX_DIGEST_SIZE)
> +		return 0;
>  
>  	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
>  			  GFP_KERNEL);
> -- 
> 2.17.1
> 
