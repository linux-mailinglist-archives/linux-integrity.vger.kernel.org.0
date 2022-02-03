Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF14A7E44
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Feb 2022 04:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbiBCDPd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 22:15:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236168AbiBCDPc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 22:15:32 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212NBHVE002741;
        Thu, 3 Feb 2022 03:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UEW5qdexga0BMBxV6tALb0iSs2cti1jehdUOsK8BHUk=;
 b=CZKl5P/wNbvVpabHpHTBoAKSwQhU2alqhOAhwhx3VP950KPkS5ODa/dzqQ/hpOc1vtEt
 /eJ0SCUUodhkji32J610Q8HZ4AyoS0dWsTs82avFJOpv4T5QTINJPifwTYJCetAP4mW/
 yQgM4xg3yt/AcBptp9m8nWgwixGwpj/IDPT/weIqE3CuFb56LTokK+l1XEmid40JVPOo
 fD8GrN5ewabt+Jtn/CMGXRmlLSuludhqdWafvxA1TOqZ0qlG8m6EeWP4HM9TaQ2iWcx/
 8w9+hcuk44houdSRuFcR1f3uM229drfRRSlAvCcDQfbiY3u+82MDBeUzTr7EXy95CUFP WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dywrr9nq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 03:15:27 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2133FR1I002281;
        Thu, 3 Feb 2022 03:15:27 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dywrr9npx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 03:15:27 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2133CTxU011042;
        Thu, 3 Feb 2022 03:15:26 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 3dy0sxg8m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 03:15:26 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2133FPMD37028272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 03:15:25 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D1F8136068;
        Thu,  3 Feb 2022 03:15:25 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C66C6136069;
        Thu,  3 Feb 2022 03:15:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  3 Feb 2022 03:15:24 +0000 (GMT)
Message-ID: <7c9d973f-847e-e8bc-95fb-6c98a98a02e6@linux.ibm.com>
Date:   Wed, 2 Feb 2022 22:15:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Content-Language: en-US
To:     Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
References: <20220202065906.2598366-1-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220202065906.2598366-1-vt@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cHMRdbgrwzIQyuoLYea7KytJG9MXHcKr
X-Proofpoint-GUID: 3aVh1MEXsKOUAwUkzUOAmiqbVJGwinOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/2/22 01:59, Vitaly Chikunov wrote:
> Rarely used `keyctl pkey_verify' can verify raw signatures, but was
> failing, because ECDSA/EC-RDSA signature sizes are twice key sizes which
> does not pass in/out sizes check in keyctl_pkey_params_get_2.
> This in turn because these values cannot be distinguished by a single
> `max_size' callback return value.
> Also, `keyctl pkey_query` displays incorrect `max_sig_size' about these
> algorithms.
>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>   crypto/asymmetric_keys/public_key.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> index 4fefb219bfdc..3ffbab07ed2a 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -143,8 +143,19 @@ static int software_key_query(const struct kernel_pkey_params *params,
>   
>   	len = crypto_akcipher_maxsize(tfm);
>   	info->key_size = len * 8;
> -	info->max_data_size = len;
> -	info->max_sig_size = len;
> +	if (strcmp(alg_name, "ecrdsa") == 0 ||
> +	    strncmp(alg_name, "ecdsa-", 6) == 0) {
> +		/*
> +		 * For these algos sig size is twice key size.
> +		 * keyctl uses max_sig_size as minimum input size, and
> +		 * max_data_size as minimum output size for a signature.
> +		 */
> +		info->max_data_size = len * 2;
> +		info->max_sig_size = len * 2;
I don't know about the data size but following my tests this is not 
enough for ECDSA signature size. In ECDSA case the r and s components of 
the signature are encode in asn.1, not 'raw'. So there are 2 bytes at 
the beginning for sequence identifier , 2 bytes asn.1 for the r 
component, 1 additional 0-byte to make the r component always a positive 
number, then the r component, then 2 bytes asn.1 for the s component, 1 
addition 0-byte to make the s component a positive number, then the s 
component. Phew.

info->max_sig_size = 2 + (2 + 1 + len) * 2;

so for NIST P384 it's: 2 + (2+1+48) * 2 = 104

Then it works for me as well.


> +	} else {
> +		info->max_data_size = len;
> +		info->max_sig_size = len;
> +	}
>   	info->max_enc_size = len;
>   	info->max_dec_size = len;
>   	info->supported_ops = (KEYCTL_SUPPORTS_ENCRYPT |
