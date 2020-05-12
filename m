Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52C1CF608
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgELNnz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 09:43:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbgELNnz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 09:43:55 -0400
Received: from lhreml718-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 661F7554DE7C1AF8E32F;
        Tue, 12 May 2020 14:43:53 +0100 (IST)
Received: from fraeml704-chm.china.huawei.com (10.206.15.53) by
 lhreml718-chm.china.huawei.com (10.201.108.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Tue, 12 May 2020 14:43:53 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 12 May 2020 15:43:52 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Tue, 12 May 2020 15:43:52 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>
CC:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH] evm: Fix a small race in init_desc()
Thread-Topic: [PATCH] evm: Fix a small race in init_desc()
Thread-Index: AQHWKGALS6wWEHovpU+0Qv/QmQu7IqikdX+g
Date:   Tue, 12 May 2020 13:43:52 +0000
Message-ID: <c7743ab21a574eeeac40d783e0b8581c@huawei.com>
References: <20200512130410.GB2056@kadam> <20200512131917.GA287386@mwanda>
In-Reply-To: <20200512131917.GA287386@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.12.77]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> owner@vger.kernel.org] On Behalf Of Dan Carpenter
> Sent: Tuesday, May 12, 2020 3:19 PM
> Subject: [PATCH] evm: Fix a small race in init_desc()
> 
> The IS_ERR_OR_NULL() function has two conditions and if we got really
> unlucky we could hit a race where "ptr" started as an error pointer and
> then was set to NULL.  Both conditions would be false even though the
> pointer at the end was NULL.
> 
> This patch fixes the problem by ensuring that "*tfm" can only be NULL
> or valid.  I have introduced a "tmp_tfm" variable to make that work.  I
> also reversed a condition and pulled the code in one tab.
> 
> Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
> Fixes: 53de3b080d5e: "evm: Check also if *tfm is an error pointer in
> init_desc()"
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I just had a go at the fix.  I'm not super wedded to this solution, but
> I hoped it was nice.

Thanks. I think you can merge both patches in one, as the first one
is not yet pulled.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli


>  security/integrity/evm/evm_crypto.c | 44 ++++++++++++++---------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_crypto.c
> b/security/integrity/evm/evm_crypto.c
> index 5d3789edab71f..168c3b78ac47b 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -73,7 +73,7 @@ static struct shash_desc *init_desc(char type, uint8_t
> hash_algo)
>  {
>  	long rc;
>  	const char *algo;
> -	struct crypto_shash **tfm;
> +	struct crypto_shash **tfm, *tmp_tfm;
>  	struct shash_desc *desc;
> 
>  	if (type == EVM_XATTR_HMAC) {
> @@ -91,31 +91,31 @@ static struct shash_desc *init_desc(char type, uint8_t
> hash_algo)
>  		algo = hash_algo_name[hash_algo];
>  	}
> 
> -	if (IS_ERR_OR_NULL(*tfm)) {
> -		mutex_lock(&mutex);
> -		if (*tfm)
> -			goto out;
> -		*tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
> -		if (IS_ERR(*tfm)) {
> -			rc = PTR_ERR(*tfm);
> -			pr_err("Can not allocate %s (reason: %ld)\n", algo,
> rc);
> -			*tfm = NULL;
> +	if (*tfm)
> +		goto alloc;
> +	mutex_lock(&mutex);
> +	if (*tfm)
> +		goto unlock;
> +
> +	tmp_tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
> +	if (IS_ERR(tmp_tfm)) {
> +		pr_err("Can not allocate %s (reason: %ld)\n", algo,
> +		       PTR_ERR(tmp_tfm));
> +		mutex_unlock(&mutex);
> +		return ERR_CAST(tmp_tfm);
> +	}
> +	if (type == EVM_XATTR_HMAC) {
> +		rc = crypto_shash_setkey(tmp_tfm, evmkey, evmkey_len);
> +		if (rc) {
> +			crypto_free_shash(tmp_tfm);
>  			mutex_unlock(&mutex);
>  			return ERR_PTR(rc);
>  		}
> -		if (type == EVM_XATTR_HMAC) {
> -			rc = crypto_shash_setkey(*tfm, evmkey,
> evmkey_len);
> -			if (rc) {
> -				crypto_free_shash(*tfm);
> -				*tfm = NULL;
> -				mutex_unlock(&mutex);
> -				return ERR_PTR(rc);
> -			}
> -		}
> -out:
> -		mutex_unlock(&mutex);
>  	}
> -
> +	*tfm = tmp_tfm;
> +unlock:
> +	mutex_unlock(&mutex);
> +alloc:
>  	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
>  			GFP_KERNEL);
>  	if (!desc)
> --
> 2.26.2

