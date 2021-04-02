Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CF3352A3E
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Apr 2021 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhDBL3O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Apr 2021 07:29:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48392 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229599AbhDBL3M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Apr 2021 07:29:12 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 132B3e62048211;
        Fri, 2 Apr 2021 07:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=baN2HCX6z+JmzsCjWczczvSsDjzUtioVeAX2rTn259M=;
 b=knjcTyumeyoyUhhR2I6FsiTxaVnpwrrNthOT7ssoiheX3IGjqOEyrVDaO85kF+eNg7Je
 sY9nEqWwqkUjOOcM64tjdxE9DxKVRnlZE02oKUi0ON80hrcDC6oPo1POFtuYxroHVb12
 v6/jiCfP86oiaGwvSCgPHRFdJC+3XMOpKHG4Of77nbcChQ430j72DpW0yjGB4Ywxm9rH
 6tCqgPUR53DKzB95urMVWiUkDS3WClARt8x7/tPOcK4IMbnQxKVDrk1s/s6Fhpq85lVJ
 pabpM1/ReY1klHq347lPLuDSB1G84GBBbKftV9qSQa9L/2+yi0nHC/Fj+kEPXnvV9paR 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ntw1j2wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Apr 2021 07:29:07 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 132BL0fb100342;
        Fri, 2 Apr 2021 07:29:07 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ntw1j2w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Apr 2021 07:29:07 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 132BRGps017585;
        Fri, 2 Apr 2021 11:29:06 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 37n29bnd4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Apr 2021 11:29:06 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 132BT4SL33161658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Apr 2021 11:29:04 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB5F6BE054;
        Fri,  2 Apr 2021 11:29:04 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E510BE051;
        Fri,  2 Apr 2021 11:29:03 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  2 Apr 2021 11:29:03 +0000 (GMT)
Subject: Re: [PATCH v3 3/3] ima: enable loading of build time generated key on
 .ima keyring
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20210330131636.21711-1-nayna@linux.ibm.com>
 <20210330131636.21711-4-nayna@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <07e8055e-2871-f8ac-a125-19046c6390c7@linux.ibm.com>
Date:   Fri, 2 Apr 2021 07:29:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330131636.21711-4-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jYe-uR7Z7-AGKjVQiVVnlAD7wEhtkM6q
X-Proofpoint-ORIG-GUID: bl1rbU4b1jXUsNTiK-hWc-PrbtadVpJs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_07:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103310000 definitions=main-2104020080
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 3/30/21 9:16 AM, Nayna Jain wrote:
> The kernel currently only loads the kernel module signing key onto the
> builtin trusted keyring. Load the module signing key onto the IMA keyring
> as well.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   certs/system_certificates.S   | 13 +++++++++-
>   certs/system_keyring.c        | 47 +++++++++++++++++++++++++++--------
>   include/keys/system_keyring.h |  7 ++++++
>   security/integrity/digsig.c   |  2 ++
>   4 files changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/certs/system_certificates.S b/certs/system_certificates.S
> index 8f29058adf93..dcad27ea8527 100644
> --- a/certs/system_certificates.S
> +++ b/certs/system_certificates.S
> @@ -8,9 +8,11 @@
>   	.globl system_certificate_list
>   system_certificate_list:
>   __cert_list_start:
> -#ifdef CONFIG_MODULE_SIG
> +__module_cert_start:
> +#if defined(CONFIG_MODULE_SIG) || defined(CONFIG_IMA_APPRAISE_MODSIG)
>   	.incbin "certs/signing_key.x509"
>   #endif
> +__module_cert_end:
>   	.incbin "certs/x509_certificate_list"
>   __cert_list_end:
>   
> @@ -35,3 +37,12 @@ system_certificate_list_size:
>   #else
>   	.long __cert_list_end - __cert_list_start
>   #endif
> +
> +	.align 8
> +	.globl module_cert_size
> +module_cert_size:
> +#ifdef CONFIG_64BIT
> +	.quad __module_cert_end - __module_cert_start
> +#else
> +	.long __module_cert_end - __module_cert_start
> +#endif
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 4b693da488f1..bb122bf4cc17 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -27,6 +27,7 @@ static struct key *platform_trusted_keys;
>   
>   extern __initconst const u8 system_certificate_list[];
>   extern __initconst const unsigned long system_certificate_list_size;
> +extern __initconst const unsigned long module_cert_size;
>   
>   /**
>    * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
> @@ -132,19 +133,11 @@ static __init int system_trusted_keyring_init(void)
>    */
>   device_initcall(system_trusted_keyring_init);
>   
> -/*
> - * Load the compiled-in list of X.509 certificates.
> - */
> -static __init int load_system_certificate_list(void)
> +static __init int load_cert(const u8 *p, const u8 *end, struct key *keyring)
>   {
>   	key_ref_t key;
> -	const u8 *p, *end;
>   	size_t plen;
>   
> -	pr_notice("Loading compiled-in X.509 certificates\n");
> -
> -	p = system_certificate_list;
> -	end = p + system_certificate_list_size;
>   	while (p < end) {
>   		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
>   		 * than 256 bytes in size.
> @@ -159,7 +152,7 @@ static __init int load_system_certificate_list(void)
>   		if (plen > end - p)
>   			goto dodgy_cert;
>   
> -		key = key_create_or_update(make_key_ref(builtin_trusted_keys, 1),
> +		key = key_create_or_update(make_key_ref(keyring, 1),
>   					   "asymmetric",
>   					   NULL,
>   					   p,
> @@ -186,6 +179,40 @@ static __init int load_system_certificate_list(void)
>   	pr_err("Problem parsing in-kernel X.509 certificate list\n");
>   	return 0;
>   }
> +
> +__init int load_module_cert(struct key *keyring)
> +{
> +	const u8 *p, *end;
> +
> +	if (!IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG))
> +		return 0;
> +
> +	pr_notice("Loading compiled-in module X.509 certificates\n");
> +
> +	p = system_certificate_list;
> +	end = p + module_cert_size;
> +
> +	return load_cert(p, end, keyring);
> +}
> +
> +/*
> + * Load the compiled-in list of X.509 certificates.
> + */
> +static __init int load_system_certificate_list(void)
> +{
> +	const u8 *p, *end;
> +
> +	pr_notice("Loading compiled-in X.509 certificates\n");
> +
> +#ifdef CONFIG_MODULE_SIG
> +	p = system_certificate_list;
> +#else
> +	p = system_certificate_list + module_cert_size;
> +#endif
> +
> +	end = p + system_certificate_list_size;
> +	return load_cert(p, end, builtin_trusted_keys);
> +}
>   late_initcall(load_system_certificate_list);
>   
>   #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index fb8b07daa9d1..f954276c616a 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -16,9 +16,16 @@ extern int restrict_link_by_builtin_trusted(struct key *keyring,
>   					    const struct key_type *type,
>   					    const union key_payload *payload,
>   					    struct key *restriction_key);
> +extern __init int load_module_cert(struct key *keyring);
>   
>   #else
>   #define restrict_link_by_builtin_trusted restrict_link_reject
> +
> +static inline __init int load_module_cert(struct key *keyring)
> +{
> +	return 0;
> +}
> +
>   #endif
>   
>   #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 250fb0836156..3b06a01bd0fd 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -111,6 +111,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
>   	} else {
>   		if (id == INTEGRITY_KEYRING_PLATFORM)
>   			set_platform_trusted_keys(keyring[id]);
> +		if (id == INTEGRITY_KEYRING_IMA)
> +			load_module_cert(keyring[id]);
>   	}
>   
>   	return err;
