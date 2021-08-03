Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144843DF1F4
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Aug 2021 17:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhHCQAG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 12:00:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42452 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbhHCQAG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 12:00:06 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id E408D20B36E0;
        Tue,  3 Aug 2021 08:59:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E408D20B36E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628006395;
        bh=7BME2DjyoaVMcl4ayiSniontJyv35UPbmazf7dDn4wY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=HLWAMiS5ALFrZ5WKxpyKs4W/yZfiAWz8ZVJWJrCHxV7Q0XtbCYjmdEksvLdGBKSaC
         Z8GzUvBME2zReVG5PHY8qyZUiVoYfw9trBL0olSQXWcinypEqBw8RDMU8QC2aloVbH
         Hv2ovzkhQDdl2kDe7C/XtHYz4it3QgvU0JLBLABI=
Subject: Re: [PATCH v5 1/5] IMA: remove the dependency on CRYPTO_MD5
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
 <20210728132112.258606-2-simon.thoby@viveris.fr>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <01d8089b-9d4f-9136-ff32-cc02ffa95a81@linux.microsoft.com>
Date:   Tue, 3 Aug 2021 09:01:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728132112.258606-2-simon.thoby@viveris.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On 7/28/2021 6:21 AM, THOBY Simon wrote:
> Remove the CRYPTO_MD5 dependency for IMA, as it is not necessary
> and it hinders the efficiency of a patchset that limit the digests
> allowed for the security.ima xattr.

In the patch description state the problem first and then describe how 
it is addressed in the patch. Maybe, something like the following:

MD5 is a weak digest algorithm. It hinders the efficiency of a patch set 
that aims to limit the digests allowed for the extended file attribute 
namely security.ima. MD5 should not be used for any crypto operations in 
IMA.

Remove the CRYPTO_MD5 dependency for IMA.

> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>   security/integrity/ima/Kconfig    | 1 -
>   security/integrity/ima/ima_main.c | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index d0ceada99243..f3a9cc201c8c 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -6,7 +6,6 @@ config IMA
>   	select SECURITYFS
>   	select CRYPTO
>   	select CRYPTO_HMAC
> -	select CRYPTO_MD5
>   	select CRYPTO_SHA1
>   	select CRYPTO_HASH_INFO
>   	select TCG_TPM if HAS_IOMEM && !UML
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 287b90509006..7f2310f29789 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -53,7 +53,7 @@ static int __init hash_setup(char *str)
>   	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) == 0) {
>   		if (strncmp(str, "sha1", 4) == 0) {
>   			ima_hash_algo = HASH_ALGO_SHA1;
> -		} else if (strncmp(str, "md5", 3) == 0) {
> +		} else if (IS_ENABLED(CONFIG_CRYPTO_MD5) && strncmp(str, "md5", 3) == 0) {
>   			ima_hash_algo = HASH_ALGO_MD5;
>   		} else {
>   			pr_err("invalid hash algorithm \"%s\" for template \"%s\"",
> 

Code change looks good.

  -lakshmi
