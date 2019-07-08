Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0F629EF
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 21:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfGHTzq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 15:55:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54335 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfGHTzp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 15:55:45 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1hkZjd-0008Dn-Ik; Mon, 08 Jul 2019 19:55:37 +0000
Date:   Mon, 8 Jul 2019 14:55:32 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
Message-ID: <20190708195532.GB5292@elm>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705163735.11539-1-roberto.sassu@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019-07-05 18:37:35, Roberto Sassu wrote:
> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
> TPM") allows the trusted module to be loaded even a TPM is not found to
> avoid module dependency problems.
> 
> Unfortunately, this does not completely solve the issue, as there could be
> a case where a TPM is found but is not functional (the TPM commands return
> an error). Specifically, after the tpm_chip structure is returned by
> tpm_default_chip() in init_trusted(), the execution terminates after
> init_digests() returns -EFAULT (due to the fact that tpm_get_random()
> returns a positive value, but less than TPM_MAX_DIGEST_SIZE).
> 
> This patch fixes the issue by ignoring the TPM_ERR_DEACTIVATED and
> TPM_ERR_DISABLED errors.
> 
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  drivers/char/tpm/tpm.h  | 2 --
>  include/linux/tpm.h     | 3 +++
>  security/keys/trusted.c | 6 +++++-
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index e503ffc3aa39..a216ac396711 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -54,8 +54,6 @@ enum tpm_addr {
>  
>  #define TPM_WARN_RETRY          0x800
>  #define TPM_WARN_DOING_SELFTEST 0x802
> -#define TPM_ERR_DEACTIVATED     0x6
> -#define TPM_ERR_DISABLED        0x7
>  #define TPM_ERR_INVALID_POSTINIT 38
>  
>  #define TPM_HEADER_SIZE		10
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 53c0ea9ec9df..efd3ccbb6aee 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -26,6 +26,9 @@
>  #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
>  #define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
>  
> +#define TPM_ERR_DEACTIVATED     0x6
> +#define TPM_ERR_DISABLED        0x7
> +
>  struct tpm_chip;
>  struct trusted_key_payload;
>  struct trusted_key_options;
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index 9a94672e7adc..430d85090b3b 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -389,6 +389,10 @@ static int pcrlock(const int pcrnum)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	/* This can happen if the TPM is inactive. */
> +	if (!digests)
> +		return -EINVAL;
> +
>  	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
>  }
>  
> @@ -1233,7 +1237,7 @@ static int __init init_digests(void)
>  	int i;
>  
>  	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
> -	if (ret < 0)
> +	if (ret < 0 || ret == TPM_ERR_DEACTIVATED || ret == TPM_ERR_DISABLED)
>  		return ret;

As someone who hasn't looked at much of the TPM code, I would have
expected tpm_get_random() to return a positive value that only ever
indicates the number of random bytes saved to the buffer. From the
function documentation:

  Return: number of random bytes read or a negative error value.

Despite the function documentation and as your patch suggests, I can
see that it is possible for tpm_transmit_cmd() to return
a positive value that's also returned by tpm_get_random() even though it
may not have filled the buffer when the TPM is in an
inactive/deactivated state.

I think there are other callers which are not prepared for positive
return values that indicate a failure to fill the buffer with random
data. For instance, the way that tpm_hwrng_read() is calling
tpm_get_random() looks a little worrisome.

This patch would likely fix the bug reported against eCryptfs
(https://bugzilla.kernel.org/show_bug.cgi?id=203953) but I can't help to
think that callers of tpm_get_random() would benefit from a more
consolidated approach of handling TPM_ERR_* return values rather than
handling them at this single call site.

Tyler

>  	if (ret < TPM_MAX_DIGEST_SIZE)
>  		return -EFAULT;
> -- 
> 2.17.1
> 
