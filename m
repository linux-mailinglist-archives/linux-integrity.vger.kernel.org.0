Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD2D3195DF
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 23:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhBKWc4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 17:32:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhBKWcz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 17:32:55 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BMDpfi148712;
        Thu, 11 Feb 2021 17:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ShQRyD10tU91FvYiAUdM/l349mIMyrxrOieoAPMQ+bA=;
 b=rcTKgtCE2Eco+cbCxG91XKOtcKEY9HBvZzp1n4BCqGladxaEFdL+DFYjYTCWGV/lP8tt
 E1GYPHSve99kLogk8igVEuQLSbgQ0+p+ErcPgGJ46g/+U1sEPS0bi3mti0uSZJ3/q8Ul
 G0tuiYb3FagdrOdTdusqRqrR1IlLwsHkAFl9jtp8sQya3W5PyPl8ExPirXtICQnvrUBI
 t2e/+Z9862QxT4jvqWbDUaIxubmdhhI8sb5F6FsqngXjyPM+MVxnT2UcmWnLWdMdM6fd
 8I4USNsVHj6ek4b1sjrsel8XyiuJkOtYnJLmI5HVtx0nq4tJL0booeZAC7WTIfoSBf52 zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nd6d0gca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 17:32:12 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BMECNR149159;
        Thu, 11 Feb 2021 17:32:12 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nd6d0gbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 17:32:12 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BMRpab025384;
        Thu, 11 Feb 2021 22:32:11 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 36hjr9rwqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 22:32:11 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BMWA3m7275144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 22:32:10 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBD1712406C;
        Thu, 11 Feb 2021 22:32:10 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A864C12406B;
        Thu, 11 Feb 2021 22:32:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 22:32:10 +0000 (GMT)
Subject: Re: [PATCH 5/5] ima: enable loading of build time generated key to
 .ima keyring
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
 <20210211195435.135582-6-nayna@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <804e0075-e435-f60b-e0a7-a9b48a76ce72@linux.ibm.com>
Date:   Thu, 11 Feb 2021 17:32:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210211195435.135582-6-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110170
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/11/21 2:54 PM, Nayna Jain wrote:
> The kernel currently only loads the kernel module signing key onto
> the builtin trusted keyring. To support IMA, load the module signing
> key selectively either onto builtin or ima keyring based on MODULE_SIG
> or MODULE_APPRAISE_MODSIG config respectively; and loads the CA kernel
> key onto builtin trusted keyring.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>   certs/system_keyring.c        | 56 +++++++++++++++++++++++++++--------
>   include/keys/system_keyring.h |  9 +++++-
>   security/integrity/digsig.c   |  4 +++
>   3 files changed, 55 insertions(+), 14 deletions(-)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 798291177186..0bbbe501f8a7 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -26,6 +26,7 @@ static struct key *platform_trusted_keys;
>   
>   extern __initconst const u8 system_certificate_list[];
>   extern __initconst const unsigned long system_certificate_list_size;
> +extern __initconst const unsigned long module_cert_size;
>   
>   /**
>    * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
> @@ -131,19 +132,12 @@ static __init int system_trusted_keyring_init(void)
>    */
>   device_initcall(system_trusted_keyring_init);
>   
> -/*
> - * Load the compiled-in list of X.509 certificates.
> - */
> -static __init int load_system_certificate_list(void)
> +static __init int load_cert(const u8 *p, const u8 *end, struct key *keyring,
> +			    unsigned long flags)
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
> @@ -158,16 +152,15 @@ static __init int load_system_certificate_list(void)
>   		if (plen > end - p)
>   			goto dodgy_cert;
>   
> -		key = key_create_or_update(make_key_ref(builtin_trusted_keys, 1),
> +		key = key_create_or_update(make_key_ref(keyring, 1),
>   					   "asymmetric",
>   					   NULL,
>   					   p,
>   					   plen,
>   					   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
>   					   KEY_USR_VIEW | KEY_USR_READ),
> -					   KEY_ALLOC_NOT_IN_QUOTA |
> -					   KEY_ALLOC_BUILT_IN |
> -					   KEY_ALLOC_BYPASS_RESTRICTION);
> +					   flags);
> +
>   		if (IS_ERR(key)) {
>   			pr_err("Problem loading in-kernel X.509 certificate (%ld)\n",
>   			       PTR_ERR(key));
> @@ -185,6 +178,43 @@ static __init int load_system_certificate_list(void)
>   	pr_err("Problem parsing in-kernel X.509 certificate list\n");
>   	return 0;
>   }
> +
> +__init int load_module_cert(struct key *keyring, unsigned long flags)
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
> +	load_cert(p, end, keyring, flags);
> +
> +	return 0;

See my comment below.


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
> +	end = p + system_certificate_list_size;
> +	load_cert(p, end, builtin_trusted_keys, KEY_ALLOC_NOT_IN_QUOTA |
> +						KEY_ALLOC_BUILT_IN |
> +						KEY_ALLOC_BYPASS_RESTRICTION);
> +	return 0;


The old  load_system_certificate_list always returned 0 and the new 
load_cert also does. You could just do 'return load_cert(p, ...)' here 
and still get the 0.



> +}
>   late_initcall(load_system_certificate_list);
>   
>   #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index fb8b07daa9d1..e91c03376599 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -16,9 +16,16 @@ extern int restrict_link_by_builtin_trusted(struct key *keyring,
>   					    const struct key_type *type,
>   					    const union key_payload *payload,
>   					    struct key *restriction_key);
> -
> +extern __init int load_module_cert(struct key *keyring, unsigned long flags);
>   #else
>   #define restrict_link_by_builtin_trusted restrict_link_reject
> +
> +static inline __init int load_module_cert(struct key *keyring,
> +					  unsigned long flags)
> +{
> +	return 0;
> +}
> +
>   #endif
>   
>   #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 0f518dcfde05..4009d1e33fe0 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -111,8 +111,12 @@ static int __init __integrity_init_keyring(const unsigned int id,
>   	} else {
>   		if (id == INTEGRITY_KEYRING_PLATFORM)
>   			set_platform_trusted_keys(keyring[id]);
> +		if (id == INTEGRITY_KEYRING_IMA)
> +			load_module_cert(keyring[id], KEY_ALLOC_NOT_IN_QUOTA);
>   	}
>   
> +	pr_info("Loading key to ima keyring\n");
> +
>   	return err;
>   }
>   

Otherwise lgtm.


