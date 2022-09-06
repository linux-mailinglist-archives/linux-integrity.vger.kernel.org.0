Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE27D5AF62D
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 22:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiIFUgL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 16:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiIFUgJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 16:36:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE100DE90
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 13:36:08 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286KCOHh021121;
        Tue, 6 Sep 2022 20:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EsWAn9gKfKalDl2WMohvWI61YgETKQQJKOrSJ4XQAyA=;
 b=GKKMWrOXvnQR2oFliyX+MV1SX1e8kxnb7VLlm7L69gtXkSkqRXqOy+SycGL7lxie0kbY
 ZLCGOZe3zTwrd/VqTORhGy0uYZFVGf0FxEC4U5zWWy20W0Syty6ilJdaKeVR0f5E7LPU
 qhReimeSvWtrizR7ch8XHx7jqbxbtNwVfoiBvfM9DgteAZnovbhkC4wqyGlEkPRSmi2H
 nrwk8gybFhrB2NyuqTeZvcrhe8auQbDPPnW2pBk/oV6/V9akjZ7tpIYZKS8flhLwgTJ3
 GnLgJverPo9nHBxxyO+lX8XbRBGOaCOmdSOdiQo4o4TvYtN2YaKBYYefK37oRuKLUHQ5 Gg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jed1g8kj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:36:04 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286KZQUM011332;
        Tue, 6 Sep 2022 20:36:03 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 3jbxj9u45x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:36:03 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286Ka3Yf11207178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 20:36:03 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77F00BE053;
        Tue,  6 Sep 2022 20:45:50 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E552BE054;
        Tue,  6 Sep 2022 20:45:50 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 20:45:49 +0000 (GMT)
Message-ID: <4a48b62f-94f1-3211-9931-9a9774102755@linux.ibm.com>
Date:   Tue, 6 Sep 2022 16:36:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v2 07/12] Add missing EVP_MD_CTX_free() call
 in calc_evm_hash()
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
 <20220906195021.854090-8-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220906195021.854090-8-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qd_1Ysu2hu-bTOEspF70SDvJOW0-WPLB
X-Proofpoint-GUID: Qd_1Ysu2hu-bTOEspF70SDvJOW0-WPLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060095
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/6/22 15:50, Mimi Zohar wrote:
> When EVP_MD_CTX_new() call was added, the corresponding EVP_MD_CTX_free()
> was never called.  Properly free it.
> 
> Fixes: 81010f0d87ef ("ima-evm-utils: Add backward compatible support for openssl 1.1")
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 57 ++++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index a9b2f1040787..b89e74e06c3d 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -331,11 +331,17 @@ err:
>   	return -1;
>   }
>   
> +/*
> + * calc_evm_hash - calculate the file metadata hash
> + *
> + * Returns 0 for EVP_ function failures. Return -1 for other failures.
> + * Return hash algorithm size on success.
> + */
>   static int calc_evm_hash(const char *file, unsigned char *hash)
>   {
>           const EVP_MD *md;
>   	struct stat st;
> -	int err;
> +	int err = -1;
>   	uint32_t generation = 0;
>   	EVP_MD_CTX *pctx;
>   	unsigned int mdlen;
> @@ -349,12 +355,11 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>   #if OPENSSL_VERSION_NUMBER < 0x10100000
>   	EVP_MD_CTX ctx;
>   	pctx = &ctx;
> -#else
> -	pctx = EVP_MD_CTX_new();
>   #endif
>   
>   	if (lstat(file, &st)) {
>   		log_err("Failed to stat: %s\n", file);
> +		errno = 0;
>   		return -1;
>   	}
>   
> @@ -391,20 +396,30 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>   	list_size = llistxattr(file, list, sizeof(list));
>   	if (list_size < 0) {
>   		log_err("llistxattr() failed\n");
> +		errno = 0;
>   		return -1;
>   	}
>   
> +#if OPENSSL_VERSION_NUMBER >= 0x10100000
> +	pctx = EVP_MD_CTX_new();
> +	if (!pctx) {
> +		log_err("EVP_MD_CTX_new() failed\n");
> +		return 0;
> +	}
> +#endif
> +
>   	md = EVP_get_digestbyname(imaevm_params.hash_algo);
>   	if (!md) {
>   		log_err("EVP_get_digestbyname(%s) failed\n",
>   			imaevm_params.hash_algo);
> -		return 1;
> +		err = 0;
> +		goto out;
>   	}
>   
>   	err = EVP_DigestInit(pctx, md);
>   	if (!err) {
>   		log_err("EVP_DigestInit() failed\n");
> -		return 1;
> +		goto out;
>   	}
>   
>   	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
> @@ -415,7 +430,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>   			if (err > sizeof(xattr_value)) {
>   				log_err("selinux[%u] value is too long to fit into xattr[%zu]\n",
>   					err, sizeof(xattr_value));
> -				return -1;
> +				err = -1;
> +				goto out;
>   			}
>   			strcpy(xattr_value, selinux_str);
>   		} else if (!strcmp(*xattrname, XATTR_NAME_IMA) && ima_str) {
> @@ -423,7 +439,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>   			if (err > sizeof(xattr_value)) {
>   				log_err("ima[%u] value is too long to fit into xattr[%zu]\n",
>   					err, sizeof(xattr_value));
> -				return -1;
> +				err = -1;
> +				goto out;
>   			}
>   			hex2bin(xattr_value, ima_str, err);
>   		} else if (!strcmp(*xattrname, XATTR_NAME_IMA) && evm_portable){
> @@ -432,7 +449,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>   			if (err < 0) {
>   				log_err("EVM portable sig: %s required\n",
>   					xattr_ima);
> -				return -1;
> +				goto out;
>   			}
>   			use_xattr_ima = 1;
>   		} else if (!strcmp(*xattrname, XATTR_NAME_CAPS) && (hmac_flags & HMAC_FLAG_CAPS_SET)) {
> @@ -442,7 +459,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>   			if (err >= sizeof(xattr_value)) {
>   				log_err("caps[%u] value is too long to fit into xattr[%zu]\n",
>   					err + 1, sizeof(xattr_value));
> -				return -1;
> +				err = -1;
> +				goto out;
>   			}
>   			strcpy(xattr_value, caps_str);
>   		} else {
> @@ -463,7 +481,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>   		err = EVP_DigestUpdate(pctx, xattr_value, err);
>   		if (!err) {
>   			log_err("EVP_DigestUpdate() failed\n");
> -			return 1;
> +			goto out;
>   		}
>   	}
>   
> @@ -517,29 +535,33 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>   	err = EVP_DigestUpdate(pctx, &hmac_misc, hmac_size);
>   	if (!err) {
>   		log_err("EVP_DigestUpdate() failed\n");
> -		return 1;
> +		goto out;
>   	}
>   
>   	if (!evm_immutable && !evm_portable &&
>   	    !(hmac_flags & HMAC_FLAG_NO_UUID)) {
>   		err = get_uuid(&st, uuid);
>   		if (err)
> -			return -1;
> +			goto out;
>   
>   		err = EVP_DigestUpdate(pctx, (const unsigned char *)uuid, sizeof(uuid));
>   		if (!err) {
>   			log_err("EVP_DigestUpdate() failed\n");
> -			return 1;
> +			goto out;
>   		}
>   	}
>   
>   	err = EVP_DigestFinal(pctx, hash, &mdlen);
> -	if (!err) {
> +	if (!err)
>   		log_err("EVP_DigestFinal() failed\n");
> -		return 1
> -	}
>   
> -	return mdlen;
> +out:
> +#if OPENSSL_VERSION_NUMBER >= 0x10100000
> +	EVP_MD_CTX_free(pctx);
> +#endif
> +	if (err == 1)
> +		return mdlen;
> +	return err;
>   }
>   
>   static int sign_evm(const char *file, const char *key)
> @@ -575,6 +597,7 @@ static int sign_evm(const char *file, const char *key)
>   		err = lsetxattr(file, xattr_evm, sig, len, 0);
>   		if (err < 0) {
>   			log_err("setxattr failed: %s\n", file);
> +			errno = 0;
>   			return err;
>   		}
>   	}

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
