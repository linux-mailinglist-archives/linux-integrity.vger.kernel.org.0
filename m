Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87533E06DB
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 19:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhHDRjv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 13:39:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37452 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhHDRju (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 13:39:50 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id A21FD20B36E0;
        Wed,  4 Aug 2021 10:39:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A21FD20B36E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628098777;
        bh=BmxsRYJ0XNs021aqPW3vQh12zIMTm59GOpKwiHgA8s4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=MeVnrRP1299IQ64R4yF3r31x9j5d4hqv1bfo4MBL829vq1Sqkqo+0MEdWOZaAXmum
         avJvtA5R3Mslkx3ZQwlv+dA6qTxAUK6XQwc5MPqMbQiNeOCM5d5Qu3RvMIvT5EL2RW
         dFnMQIQgY6fOXsuYDLbNDvXsr4AJeEFJ6UnU0J+U=
Subject: Re: [PATCH v6 1/5] IMA: remove the dependency on CRYPTO_MD5
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
 <20210804092010.350372-2-simon.thoby@viveris.fr>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ace93099-79c2-f8ca-910f-00ebaf9f624e@linux.microsoft.com>
Date:   Wed, 4 Aug 2021 10:41:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804092010.350372-2-simon.thoby@viveris.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/4/2021 2:20 AM, THOBY Simon wrote:
> MD5 is a weak digest algorithm that shouldn't be used for cryptographic
> operation. It hinders the efficiency of a patch set that aims to limit
> the digests allowed for the extended file attribute namely security.ima.
> MD5 is no longer a requirement for IMA, nor should it be used there.
> 
> Remove the CRYPTO_MD5 dependency for IMA.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>   security/integrity/ima/Kconfig    | 1 -
>   security/integrity/ima/ima_main.c | 3 ++-
>   2 files changed, 2 insertions(+), 2 deletions(-)
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
> index 1cba6beb5a60..b70ee0125168 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -53,7 +53,8 @@ static int __init hash_setup(char *str)
>   	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) == 0) {
>   		if (strncmp(str, "sha1", 4) == 0) {
>   			ima_hash_algo = HASH_ALGO_SHA1;
> -		} else if (strncmp(str, "md5", 3) == 0) {
> +		} else if (IS_ENABLED(CONFIG_CRYPTO_MD5)
> +			   && strncmp(str, "md5", 3) == 0) {
>   			ima_hash_algo = HASH_ALGO_MD5;
>   		} else {
>   			pr_err("invalid hash algorithm \"%s\" for template \"%s\"",
> 
