Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06701D2824
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 08:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgENGrF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 02:47:05 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgENGrF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 02:47:05 -0400
Received: from lhreml727-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A880E1E63677723AA141;
        Thu, 14 May 2020 07:47:02 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml727-chm.china.huawei.com (10.201.108.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 14 May 2020 07:47:02 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Thu, 14 May 2020 08:47:01 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
CC:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@nokia.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v2] evm: Fix a small race in init_desc()
Thread-Topic: [PATCH v2] evm: Fix a small race in init_desc()
Thread-Index: AQHWKIW26TW8+nmMh0uO3AmaJaMu26inJMRg
Date:   Thu, 14 May 2020 06:47:01 +0000
Message-ID: <a30fdceccef443b0a6ac8e0b06b83efc@huawei.com>
References: <c7743ab21a574eeeac40d783e0b8581c@huawei.com>
 <20200512174706.GA298379@mwanda>
In-Reply-To: <20200512174706.GA298379@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.16.80]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Tuesday, May 12, 2020 7:47 PM
> This patch avoids a kernel panic due to accessing an error pointer set by
> crypto_alloc_shash(). It occurs especially when there are many files that
> require an unsupported algorithm, as it would increase the likelihood of
> the following race condition.
> 
> Imagine we have two threads and in the first thread crypto_alloc_shash()
> fails and returns an error pointer.
> 
> 		*tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
> 		if (IS_ERR(*tfm)) {
> 			rc = PTR_ERR(*tfm); <--- FIRST THREAD HERE!
> 			pr_err("Can not allocate %s (reason: %ld)\n", algo,
> rc);
> 			*tfm = NULL;
> 
> And the second thread is here:
> 
> 	if (*tfm == NULL) {  <--- SECOND THREAD HERE!
> 		mutex_lock(&mutex);
> 		if (*tfm)
> 			goto out;
> 
> Since "*tfm" is non-NULL, we assume that it is valid and that leads to
> a crash when it dereferences "*tfm".
> 
> 	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
>                                                              ^^^^
> 
> This patch fixes the problem by introducing a temporary "tmp_tfm" and
> only setting "*tfm" at the very end after everything has succeeded.  The
> other change is that I reversed the initial "if (!*tfm) {" condition and
> pull the code in one indent level.
> 
> Cc: stable@vger.kernel.org
> Fixes: d46eb3699502b ("evm: crypto hash replaced by shash")
> Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reported-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli


> ---
> v2: I folded mine patch together with Roberto's
> 
>  security/integrity/evm/evm_crypto.c | 44 ++++++++++++++---------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_crypto.c
> b/security/integrity/evm/evm_crypto.c
> index 35682852ddea9..c9f7206591b30 100644
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
> -	if (*tfm == NULL) {
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

