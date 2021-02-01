Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978DA30A57A
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 11:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhBAKh1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 05:37:27 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:6998 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233100AbhBAKhZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 05:37:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UNZ0iAR_1612175770;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UNZ0iAR_1612175770)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 18:36:11 +0800
Subject: Re: [PATCH v6 4/4] ima: Support EC keys for signature verification
To:     Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        David Howells <dhowells@redhat.com>
References: <20210131233301.1301787-1-stefanb@linux.ibm.com>
 <20210131233301.1301787-5-stefanb@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <a2657484-95e6-843c-7864-dd3b28557ce2@linux.alibaba.com>
Date:   Mon, 1 Feb 2021 18:36:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210131233301.1301787-5-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2/1/21 7:33 AM, Stefan Berger wrote:
> Add support for IMA signature verification for EC keys. Since SHA type
> of hashes can be used by RSA and ECDSA signature schemes we need to
> look at the key and derive from the key which signature scheme to use.
> Since this can be applied to all types of keys, we change the selection
> of the encoding type to be driven by the key's signature scheme rather
> than by the hash type.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Vitaly Chikunov <vt@altlinux.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: Vitaly Chikunov <vt@altlinux.org>
> Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: keyrings@vger.kernel.org
> ---
>   include/keys/asymmetric-type.h         |  6 ++++++
>   security/integrity/digsig_asymmetric.c | 29 ++++++++++++--------------
>   2 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
> index a29d3ff2e7e8..c432fdb8547f 100644
> --- a/include/keys/asymmetric-type.h
> +++ b/include/keys/asymmetric-type.h
> @@ -72,6 +72,12 @@ const struct asymmetric_key_ids *asymmetric_key_ids(const struct key *key)
>   	return key->payload.data[asym_key_ids];
>   }
>   
> +static inline
> +const struct public_key *asymmetric_key_public_key(const struct key *key)
> +{
> +	return key->payload.data[asym_crypto];
> +}
> +
>   extern struct key *find_asymmetric_key(struct key *keyring,
>   				       const struct asymmetric_key_id *id_0,
>   				       const struct asymmetric_key_id *id_1,
> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
> index a662024b4c70..29002d016607 100644
> --- a/security/integrity/digsig_asymmetric.c
> +++ b/security/integrity/digsig_asymmetric.c
> @@ -84,6 +84,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
>   {
>   	struct public_key_signature pks;
>   	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
> +	const struct public_key *pk;
>   	struct key *key;
>   	int ret;
>   
> @@ -105,23 +106,19 @@ int asymmetric_verify(struct key *keyring, const char *sig,
>   	memset(&pks, 0, sizeof(pks));
>   
>   	pks.hash_algo = hash_algo_name[hdr->hash_algo];
> -	switch (hdr->hash_algo) {
> -	case HASH_ALGO_STREEBOG_256:
> -	case HASH_ALGO_STREEBOG_512:
> -		/* EC-RDSA and Streebog should go together. */
> -		pks.pkey_algo = "ecrdsa";
> -		pks.encoding = "raw";
> -		break;
> -	case HASH_ALGO_SM3_256:
> -		/* SM2 and SM3 should go together. */
> -		pks.pkey_algo = "sm2";
> -		pks.encoding = "raw";
> -		break;
> -	default:
> -		pks.pkey_algo = "rsa";
> +
> +	pk = asymmetric_key_public_key(key);
> +	pks.pkey_algo = pk->pkey_algo;
> +	if (!strcmp(pk->pkey_algo, "rsa"))
>   		pks.encoding = "pkcs1";
> -		break;
> -	}
> +	else if (!strcmp(pk->pkey_algo, "ecdsa"))
> +		pks.encoding = "x962";
> +	else if (!strcmp(pk->pkey_algo, "ecrdsa") ||
> +		   !strcmp(pk->pkey_algo, "sm2"))
> +		pks.encoding = "raw";
> +	else
> +		return -ENOPKG;
> +
>   	pks.digest = (u8 *)data;
>   	pks.digest_size = datalen;
>   	pks.s = hdr->sig;
> 

Looks good to me, so

Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Thanks,
Tianjia
