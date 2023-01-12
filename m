Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44EB6675E4
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 15:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjALO0y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 09:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbjALO0J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 09:26:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8F055647
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 06:17:19 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CDgASR014008;
        Thu, 12 Jan 2023 14:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fjXN1FW7w24VbSxwD/uWZ0hk3EeB5XpIs49xpYiGvB8=;
 b=qRo6bd1OspzwPa6JZMSyTmbHjtU4ksDgtFX9qGWqKYZwOADWkcU072foWRdolB61DpRw
 FinvmfgKwOLrdddo9wwzLHnOHqh4YiWUhKR6EFBFyjGVFSGODYmkPeqTPlSM8drlKXar
 cIGR6Fcyl/Yv+7SXEVe/o/2D058KH9UOY8vVHcOfD/ZaZzS5DWYbTLaStRUfV9By7wFa
 NbpoWAsZDDzWMxsCPJ1u+fqca5I17VWu35pl57rlZRvj580N6F+i1iiHUofVZ9YFq0fX
 nrXx+m72XmE3ylfOZI2Q5HS/RP5W2+WwQu7llV7sWL+vOjmbWCFYdbXHEoTTIflakpPk iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2kak13pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 14:16:43 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CDhc6M017434;
        Thu, 12 Jan 2023 14:16:43 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2kak13nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 14:16:43 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30CBH3j5004593;
        Thu, 12 Jan 2023 14:16:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3n1kk7hkpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 14:16:41 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CEGdZX15139564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 14:16:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE1FB5805C;
        Thu, 12 Jan 2023 14:16:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F54C5805E;
        Thu, 12 Jan 2023 14:16:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 14:16:39 +0000 (GMT)
Message-ID: <2d9918be-3083-e967-c666-fffb5c7191c8@linux.ibm.com>
Date:   Thu, 12 Jan 2023 09:16:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v2 1/9] Fix error messages and mdlen init in
 calc_evm_hmac()
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
 <20230112122426.3759938-2-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230112122426.3759938-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5bf2P2KLCqbwBVR18Qivs_OfUhpDUCKj
X-Proofpoint-ORIG-GUID: EZkmNobcE3hljIpZx0nFyW2nOmwTmIdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/12/23 07:24, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Make sure that the function name in the error message corresponds to the
> actual function called. Also, initialize mdlen to the size of 'hash'
> (MAX_DIGEST_SIZE), as this is expected by EVP_DigestSignFinal().

This code was converted from HMAC_Final() where the man page doesn't say much
about mdlen on input but required md to be of size EVP_MAX_MD_SIZE. Now it's
called sig & siglen in the man page:


        maximum necessary size of the output buffer is written to the siglen parameter. If sig is not NULL then before the
        call the siglen parameter should contain the length of the sig buffer. If the call is successful the signature is
        written to sig and the amount of data written to siglen.

It say's 'should' not 'must'. Following the last sentence abive I think evmctl will NOT have created short
HMAC signatures.
The mdlen should be called siglen and hash should defintely be renamed to sig at some point because it's not a 'hash'
and never was.

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   src/evmctl.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 0ac7930da6f2..d4912d7ee891 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1186,7 +1186,7 @@ static int cmd_setxattr_ima(struct command *cmd)
>   
>   static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
>   {
> -	size_t mdlen;
> +	size_t mdlen = MAX_DIGEST_SIZE;
>   	EVP_MD_CTX *pctx;
>   	EVP_PKEY *pkey = NULL;
>   	struct stat st;
> @@ -1260,7 +1260,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>   
>   	pkey = EVP_PKEY_new_mac_key(EVP_PKEY_HMAC, NULL, evmkey, sizeof(evmkey));
>   	if (!pkey) {
> -		log_err("HMAC_Init() failed\n");
> +		log_err("EVP_PKEY_new_mac_key() failed\n");
>   		goto out;
>   	}
>   
> @@ -1326,12 +1326,12 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>   
>   	err = EVP_DigestSignUpdate(pctx, &hmac_misc, hmac_size);
>   	if (err != 1) {
> -		log_err("HMAC_Update() failed\n");
> +		log_err("EVP_DigestSignUpdate() failed\n");
>   		goto out_ctx_cleanup;
>   	}
>   	err = EVP_DigestSignFinal(pctx, hash, &mdlen);
>   	if (err != 1)
> -		log_err("HMAC_Final() failed\n");
> +		log_err("EVP_DigestSignFinal() failed\n");
>   out_ctx_cleanup:
>   	EVP_PKEY_free(pkey);
>   #if OPENSSL_VERSION_NUMBER >= 0x10100000
