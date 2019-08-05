Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09FF2823E3
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2019 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfHERU2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Aug 2019 13:20:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42062 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHERU2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Aug 2019 13:20:28 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1hugeh-000388-CP; Mon, 05 Aug 2019 17:20:19 +0000
Date:   Mon, 5 Aug 2019 12:20:14 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v3] KEYS: trusted: allow module init if TPM is inactive
 or deactivated
Message-ID: <20190805172014.GE3449@elm>
References: <20190805164427.17408-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805164427.17408-1-roberto.sassu@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019-08-05 18:44:27, Roberto Sassu wrote:
> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
> TPM") allows the trusted module to be loaded even if a TPM is not found, to
> avoid module dependency problems.
> 
> However, trusted module initialization can still fail if the TPM is
> inactive or deactivated. tpm_get_random() returns an error.
> 
> This patch removes the call to tpm_get_random() and instead extends the PCR
> specified by the user with zeros. The security of this alternative is
> equivalent to the previous one, as either option prevents with a PCR update
> unsealing and misuse of sealed data by a user space process.
> 
> Even if a PCR is extended with zeros, instead of random data, it is still
> computationally infeasible to find a value as input for a new PCR extend
> operation, to obtain again the PCR value that would allow unsealing.
> 
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Tyler Hicks <tyhicks@canonical.com>

The approach changed a fair bit from v2 to v3 so I'll confirm that my
Reviewed-by still stands.

Also, we have positive test results from an affected user:

 https://bugzilla.kernel.org/show_bug.cgi?id=203953#c10

Tyler

> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/keys/trusted.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index 9a94672e7adc..ade699131065 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -1228,24 +1228,11 @@ static int __init trusted_shash_alloc(void)
>  
>  static int __init init_digests(void)
>  {
> -	u8 digest[TPM_MAX_DIGEST_SIZE];
> -	int ret;
> -	int i;
> -
> -	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
> -	if (ret < 0)
> -		return ret;
> -	if (ret < TPM_MAX_DIGEST_SIZE)
> -		return -EFAULT;
> -
>  	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
>  			  GFP_KERNEL);
>  	if (!digests)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < chip->nr_allocated_banks; i++)
> -		memcpy(digests[i].digest, digest, TPM_MAX_DIGEST_SIZE);
> -
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 
