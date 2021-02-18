Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B331731ED56
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 18:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhBRR3T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 12:29:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233291AbhBROHO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 09:07:14 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11IE2LlY149221;
        Thu, 18 Feb 2021 09:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=kFkc2BkjITUUVcB3zRSRaU4iPFcuwkbtNUW8tXZ2WIQ=;
 b=ft+rgwXClHwJztvaqhGVEvJP4IYnFW+y/NxhMURDo6CAWWn/5vS1muU1bFCu75uiedYo
 +dofguyRzrsEZICP6HMq8rf1K5kksTgFy6pf0E/Osmz0I2S1POlhfEbaKebeEbq7S5wF
 5aLPhcD/4Lm2UpiO2UE5Z4XOvf3S+XIoPDrJw3oeFyw1ZvhPMK6zulo2+seV7bs32gJr
 8HM51FgoSPF5DbxcWMb1gxAX8oUMzKVXfBHGtYUtCNPrCITzc/O7iyEoCVcgmHP0OLDN
 rzFGBpjomfxItKKfJhxlqNHulPeQO09JZWokjJ3Q/yjQ+eN1LaVBCfzpBBls1vVV+4Si xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36ssn603ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 09:06:20 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11IE2LUJ149214;
        Thu, 18 Feb 2021 09:06:20 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36ssn603ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 09:06:20 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11IE1shW009355;
        Thu, 18 Feb 2021 14:06:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 36p61hcn6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 14:06:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IE64PF37093884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 14:06:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6782442045;
        Thu, 18 Feb 2021 14:06:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 265FD4203F;
        Thu, 18 Feb 2021 14:06:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.24.199])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 14:06:14 +0000 (GMT)
Message-ID: <c4c8e4dc150440de6d6b97c8bb06cea367d98bad.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] ima-evm-utils: Support SM2 algorithm
 for sign and verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Date:   Thu, 18 Feb 2021 09:06:13 -0500
In-Reply-To: <20210211052241.91068-1-tianjia.zhang@linux.alibaba.com>
References: <20210211052241.91068-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_05:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia,

On Thu, 2021-02-11 at 13:22 +0800, Tianjia Zhang wrote:
> The combination of SM2 and SM3 algorithms has been implemented in the
> kernel. At present, the ima-evm-utils signature tool does not support
> this combination of algorithms. Because in the current version of
> OpenSSL 1.1.1, the SM2 algorithm and the public key using the EC
> algorithm share the same ID 'EVP_PKEY_EC', and the specific algorithm
> can only be distinguished by the curve name used. This patch supports
> this feature.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  src/libimaevm.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index fa6c278..589dd09 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -518,6 +518,16 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
>  		return -1;
>  	}
>  
> +#ifdef EVP_PKEY_SM2
> +	/* If EC key are used, check whether it is SM2 key */
> +	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
> +		EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
> +		int curve = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
> +		if (curve == NID_sm2)
> +			EVP_PKEY_set_alias_type(pkey, EVP_PKEY_SM2);
> +	}
> +#endif
> +

Suppose a file is signed on one system and verified on another.  What
happens if EVP_PKEY_SM2 is defined on one system, but not the other? 
Since the signing/verifying code do exactly the same thing, a
sign_verify test wouldn't detect the problem.   In anycase, please
define a sign_verify test.

thanks,

Mimi


>  	st = "EVP_PKEY_CTX_new";
>  	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
>  		goto err;
> @@ -932,6 +942,16 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>  		return -1;
>  	}
>  
> +#ifdef EVP_PKEY_SM2
> +	/* If EC key are used, check whether it is SM2 key */
> +	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
> +		EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
> +		int curve = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
> +		if (curve == NID_sm2)
> +			EVP_PKEY_set_alias_type(pkey, EVP_PKEY_SM2);
> +	}
> +#endif
> +
>  	calc_keyid_v2(&keyid, name, pkey);
>  	hdr->keyid = keyid;
>  


