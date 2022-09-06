Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1462C5AF5E8
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 22:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiIFUbk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 16:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIFUbj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 16:31:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A139A9FED
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 13:31:36 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286JVRCO018501;
        Tue, 6 Sep 2022 20:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Qex/WjoMrmB+VA3RP3Rtl8RKS/5wf9vUYjdv87RlVI4=;
 b=XRwEm85R1a2dquMSnHtQa8ExehWt+wjox+2QEh1Z+VVBtTm4HD+UAE41IScKiMoGgWDw
 q/VQLDM9lnBM+4RUV6tb3tnObrDjnaNs1AbyGO6z/BKBAwUB/1clIyuPNTaPh9w7qoQd
 jrsNczk5TDhTDXKm9AaR+sB405A8cTNqeAXa3FYZpwf/uvKybx7YxKcLef72Cqfl9zIp
 VZKkEJ7PpFZqSnyRvAcaV2kx9r9nxLC26kFq0h3bDDsDyEQe4L4V+grqZp8Gq4bBBaza
 F+boeoXhHWEXPg3jNB6+OS+dOuc4zsFh5uCRxrhiYFHjbhlLOM/ei6TXBRR0cdV62q8N lw== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jecek9j4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:31:32 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286KLOZe001489;
        Tue, 6 Sep 2022 20:31:32 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 3jbxj9dqvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:31:32 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286KVVUf9110128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 20:31:31 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9914F2805A;
        Tue,  6 Sep 2022 20:31:31 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 554B728059;
        Tue,  6 Sep 2022 20:31:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 20:31:31 +0000 (GMT)
Message-ID: <e84d0311-ad29-e24b-3fdd-eea936251835@linux.ibm.com>
Date:   Tue, 6 Sep 2022 16:31:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v2 06/12] Replace the low level HMAC calls
 when calculating the EVM HMAC
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
 <20220906195021.854090-7-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220906195021.854090-7-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: upIr-qaElJ8W3zqMpiWLQpl_onp7ua_n
X-Proofpoint-GUID: upIr-qaElJ8W3zqMpiWLQpl_onp7ua_n
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060093
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
> Calculating the EVM HMAC and labeling the filesystem was originally
> included in ima-evm-utils for debugging purposes only.  For now,
> instead of removing EVM HMAC support just replace the low level
> HMAC_ calls with EVP_ calls.
> 
> The '-a, --hashalgo' specifies the IMA hash or signature algorithm.
> The kernel EVM HMAC is limited to SHA1.  Fix ima-evm-utils by hard
> coding the EVM HMAC algorithm to SHA1.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 57 +++++++++++++++++++++++++++++-----------------------
>   1 file changed, 32 insertions(+), 25 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 641504047a36..a9b2f1040787 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1159,12 +1159,12 @@ static int cmd_setxattr_ima(struct command *cmd)
>   
>   static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
>   {
> -        const EVP_MD *md;
> +	size_t mdlen;
> +	EVP_MD_CTX *pctx;
> +	EVP_PKEY *pkey = NULL;
>   	struct stat st;
>   	int err = -1;
>   	uint32_t generation = 0;
> -	HMAC_CTX *pctx;
> -	unsigned int mdlen;
>   	char **xattrname;
>   	unsigned char xattr_value[1024];
>   	unsigned char *key;
> @@ -1175,10 +1175,8 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>   	struct h_misc_64 hmac_misc;
>   	int hmac_size;
>   #if OPENSSL_VERSION_NUMBER < 0x10100000
> -	HMAC_CTX ctx;
> +	EVP_MD_CTX ctx;
>   	pctx = &ctx;
> -#else
> -	pctx = HMAC_CTX_new();
>   #endif
>   
>   	key = file2bin(keyfile, NULL, &keylen);
> @@ -1226,19 +1224,26 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>   		goto out;
>   	}
>   
> -	md = EVP_get_digestbyname(imaevm_params.hash_algo);
> -	if (!md) {
> -		log_err("EVP_get_digestbyname(%s) failed\n",
> -			imaevm_params.hash_algo);


hash_algo was expected to always be sha1 before because now you seem to 
hard code it to  EVP_sha1() below? Following what I see here this seems 
to indeed be the only hash supported for HMAC:

https://elixir.bootlin.com/linux/latest/source/security/integrity/evm/evm_crypto.c#L38

--> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> +#if OPENSSL_VERSION_NUMBER >= 0x10100000
> +	pctx = EVP_MD_CTX_new();
> +	if (!pctx) {
> +		log_err("EVP_MD_CTX_new failed\n");
>   		goto out;
>   	}
> +#endif
>   
> -	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), md, NULL);
> -	if (err) {
> +	pkey = EVP_PKEY_new_mac_key(EVP_PKEY_HMAC, NULL, evmkey, sizeof(evmkey));
> +	if (!pkey) {
>   		log_err("HMAC_Init() failed\n");
>   		goto out;
>   	}
>   
> +	err = EVP_DigestSignInit(pctx, NULL, EVP_sha1(), NULL, pkey);
> +	if (err != 1) {
> +		log_err("EVP_DigestSignInit() failed\n");
> +		goto out;
> +	}
> +
>   	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
>   		err = lgetxattr(file, *xattrname, xattr_value, sizeof(xattr_value));
>   		if (err < 0) {
> @@ -1249,12 +1254,12 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>   			log_info("skipping xattr: %s\n", *xattrname);
>   			continue;
>   		}
> -		/*log_debug("name: %s, value: %s, size: %d\n", *xattrname, xattr_value, err);*/
>   		log_info("name: %s, size: %d\n", *xattrname, err);
>   		log_debug_dump(xattr_value, err);
> -		err = !HMAC_Update(pctx, xattr_value, err);
> -		if (err) {
> -			log_err("HMAC_Update() failed\n");
> +
> +		err = EVP_DigestSignUpdate(pctx, xattr_value, err);
> +		if (err != 1) {
> +			log_err("EVP_DigestSignUpdate() failed\n");
>   			goto out_ctx_cleanup;
>   		}
>   	}
> @@ -1293,23 +1298,24 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>   	log_debug("hmac_misc (%d): ", hmac_size);
>   	log_debug_dump(&hmac_misc, hmac_size);
>   
> -	err = !HMAC_Update(pctx, (const unsigned char *)&hmac_misc, hmac_size);
> -	if (err) {
> +	err = EVP_DigestSignUpdate(pctx, &hmac_misc, hmac_size);
> +	if (err != 1) {
>   		log_err("HMAC_Update() failed\n");
>   		goto out_ctx_cleanup;
>   	}
> -	err = !HMAC_Final(pctx, hash, &mdlen);
> -	if (err)
> +	err = EVP_DigestSignFinal(pctx, hash, &mdlen);
> +	if (err != 1)
>   		log_err("HMAC_Final() failed\n");
>   out_ctx_cleanup:
> -#if OPENSSL_VERSION_NUMBER < 0x10100000
> -	HMAC_CTX_cleanup(pctx);
> -#else
> -	HMAC_CTX_free(pctx);
> +	EVP_PKEY_free(pkey);
> +#if OPENSSL_VERSION_NUMBER >= 0x10100000
> +	EVP_MD_CTX_free(pctx);
>   #endif
>   out:
>   	free(key);
> -	return err ?: mdlen;
> +	if (err == 1)
> +		return mdlen;
> +	return err;
>   }
>   
>   static int hmac_evm(const char *file, const char *key)
> @@ -1333,6 +1339,7 @@ static int hmac_evm(const char *file, const char *key)
>   		err = lsetxattr(file, xattr_evm, sig, len + 1, 0);
>   		if (err < 0) {
>   			log_err("setxattr failed: %s\n", file);
> +			errno = 0;
>   			return err;
>   		}
>   	}
