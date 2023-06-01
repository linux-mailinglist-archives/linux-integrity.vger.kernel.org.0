Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB53C71F454
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Jun 2023 23:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjFAVAp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Jun 2023 17:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFAVAo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Jun 2023 17:00:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BDCB3;
        Thu,  1 Jun 2023 14:00:42 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351Kr83v026695;
        Thu, 1 Jun 2023 21:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=f5x0/rJos9gwvHYQA7IE2LGxiRmwdpLZcGH5jW2WHfo=;
 b=btXPeQEICBBLmEWOhCgPFOH4l+6zPjE+E13XFC9Tz92C+OkcvfGDK0ClaRjUGbrxJZ9X
 Ajxq5pKK2+H3UJeO1/tXuvHuGSFKGif4sHD6v6qUjPZD3d3HEHq9Zo2hi0Ilwb4ae8ak
 zh0Pkdl7nhnfv2/1FhC3AD0M6+5h1Jd0JHi4AgEuiOg2EndWRsTFJ8zePsMranCFAtDX
 oG9lpfDomlRAHH4JCnxYmxVhzCoPyW2eCCuRLMJ667dlyb9mXfYcLA3qVmtufUHUAAj8
 Apr5WCPd7jKa9yu0NJwBujIcR3BFZrmvJclA4+A0rWUSZawOWQas44T2ZMNNzU/S56c4 lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qy2rv05kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 21:00:13 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351KrLjY027711;
        Thu, 1 Jun 2023 21:00:12 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qy2rv05j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 21:00:12 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 351FfL7C017372;
        Thu, 1 Jun 2023 21:00:10 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3qu9g5ac14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 21:00:10 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 351L084i31523462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jun 2023 21:00:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDD7658067;
        Thu,  1 Jun 2023 21:00:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2842A58063;
        Thu,  1 Jun 2023 21:00:07 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jun 2023 21:00:07 +0000 (GMT)
Message-ID: <fd161de5-61ce-94bf-96cf-65965115f981@linux.ibm.com>
Date:   Thu, 1 Jun 2023 17:00:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/2] KEYS: asymmetric: Copy sig and digest in
 public_key_verify_signature()
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        ebiggers@kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
References: <20221227142740.2807136-1-roberto.sassu@huaweicloud.com>
 <20221227142740.2807136-3-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221227142740.2807136-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c9Sbz3X_pkw-aUsteyk-p_sfXxfvsNe5
X-Proofpoint-ORIG-GUID: CG_mh8o8SpS0AnCLrMfMk75Yx0y4ZAKd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 12/27/22 09:27, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Commit ac4e97abce9b8 ("scatterlist: sg_set_buf() argument must be in linear
> mapping") checks that both the signature and the digest reside in the
> linear mapping area.
> 
> However, more recently commit ba14a194a434c ("fork: Add generic vmalloced
> stack support") made it possible to move the stack in the vmalloc area,
> which is not contiguous, and thus not suitable for sg_set_buf() which needs
> adjacent pages.
> 
> Always make a copy of the signature and digest in the same buffer used to
> store the key and its parameters, and pass them to sg_init_one(). Prefer it
> to conditionally doing the copy if necessary, to keep the code simple. The
> buffer allocated with kmalloc() is in the linear mapping area.
> 
> Cc: stable@vger.kernel.org # 4.9.x
> Fixes: ba14a194a434 ("fork: Add generic vmalloced stack support")
> Link: https://lore.kernel.org/linux-integrity/Y4pIpxbjBdajymBJ@sol.localdomain/
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>

I just ran into an issue with OpenBMC on ARM where EVM ECDSA signature verification failed due to invalid hashes being passed to the ECDSA signature verification algorithm. This patch here resolved the issue.

Tested-by: Stefan Berger <stefanb@linux.ibm.com>



> ---
>   crypto/asymmetric_keys/public_key.c | 38 ++++++++++++++++-------------
>   1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> index 2f8352e88860..49a3f7c01149 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -360,9 +360,10 @@ int public_key_verify_signature(const struct public_key *pkey,
>   	struct crypto_wait cwait;
>   	struct crypto_akcipher *tfm;
>   	struct akcipher_request *req;
> -	struct scatterlist src_sg[2];
> +	struct scatterlist src_sg;
>   	char alg_name[CRYPTO_MAX_ALG_NAME];
> -	char *key, *ptr;
> +	char *buf, *ptr;
> +	size_t buf_len;
>   	int ret;
>   
>   	pr_devel("==>%s()\n", __func__);
> @@ -400,34 +401,37 @@ int public_key_verify_signature(const struct public_key *pkey,
>   	if (!req)
>   		goto error_free_tfm;
>   
> -	key = kmalloc(pkey->keylen + sizeof(u32) * 2 + pkey->paramlen,
> -		      GFP_KERNEL);
> -	if (!key)
> +	buf_len = max_t(size_t, pkey->keylen + sizeof(u32) * 2 + pkey->paramlen,
> +			sig->s_size + sig->digest_size);
> +
> +	buf = kmalloc(buf_len, GFP_KERNEL);
> +	if (!buf)
>   		goto error_free_req;
>   
> -	memcpy(key, pkey->key, pkey->keylen);
> -	ptr = key + pkey->keylen;
> +	memcpy(buf, pkey->key, pkey->keylen);
> +	ptr = buf + pkey->keylen;
>   	ptr = pkey_pack_u32(ptr, pkey->algo);
>   	ptr = pkey_pack_u32(ptr, pkey->paramlen);
>   	memcpy(ptr, pkey->params, pkey->paramlen);
>   
>   	if (pkey->key_is_private)
> -		ret = crypto_akcipher_set_priv_key(tfm, key, pkey->keylen);
> +		ret = crypto_akcipher_set_priv_key(tfm, buf, pkey->keylen);
>   	else
> -		ret = crypto_akcipher_set_pub_key(tfm, key, pkey->keylen);
> +		ret = crypto_akcipher_set_pub_key(tfm, buf, pkey->keylen);
>   	if (ret)
> -		goto error_free_key;
> +		goto error_free_buf;
>   
>   	if (strcmp(pkey->pkey_algo, "sm2") == 0 && sig->data_size) {
>   		ret = cert_sig_digest_update(sig, tfm);
>   		if (ret)
> -			goto error_free_key;
> +			goto error_free_buf;
>   	}
>   
> -	sg_init_table(src_sg, 2);
> -	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
> -	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
> -	akcipher_request_set_crypt(req, src_sg, NULL, sig->s_size,
> +	memcpy(buf, sig->s, sig->s_size);
> +	memcpy(buf + sig->s_size, sig->digest, sig->digest_size);
> +
> +	sg_init_one(&src_sg, buf, sig->s_size + sig->digest_size);
> +	akcipher_request_set_crypt(req, &src_sg, NULL, sig->s_size,
>   				   sig->digest_size);
>   	crypto_init_wait(&cwait);
>   	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
> @@ -435,8 +439,8 @@ int public_key_verify_signature(const struct public_key *pkey,
>   				      crypto_req_done, &cwait);
>   	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
>   
> -error_free_key:
> -	kfree(key);
> +error_free_buf:
> +	kfree(buf);
>   error_free_req:
>   	akcipher_request_free(req);
>   error_free_tfm:
