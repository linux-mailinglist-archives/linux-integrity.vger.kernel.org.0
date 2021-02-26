Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B632691F
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Feb 2021 22:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBZVFj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Feb 2021 16:05:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229989AbhBZVFi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Feb 2021 16:05:38 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QL3Zsx049879;
        Fri, 26 Feb 2021 16:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ak4rVZcwh/8yG+ylNVMK76dgKw8QgENgMszJIrbJpRA=;
 b=nXiHkmzie6w3wAqgdV2fPC57PJm1UTG366+xaEpYrKDSdcyn2DzCe62nLno2zkFPVYd0
 GQJWXcWOg8biaJm2KccF3Xp8WNZFd8v+hIGGaxQdMPM+o2IFyZpptF1DzShhDzsOgz9o
 lP0+idehZZF4/44OUWyJKlt6RdhAYu7upDttje8fDicnsqDe8kf4dGQPQzP/3ADfABNt
 HNIFmmlseU210lUhtJ3BxsZprXchFTihIwLGxacXiI/H3R4FR8czJFq+cdLzmI4XJnC9
 KYH+jAfzugIRdnEImBZa1OArpdxszkRHiOJ0qz1Dn2iQqnJuD8Fghd1DG/xIlLrzxPH3 gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36y8he0374-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 16:04:53 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11QL3bYG050059;
        Fri, 26 Feb 2021 16:04:52 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36y8he036s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 16:04:52 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QL1uwc027984;
        Fri, 26 Feb 2021 21:04:52 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 36v5y9xb87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 21:04:52 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QL4pY530802202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 21:04:51 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3223BAC090;
        Fri, 26 Feb 2021 21:04:51 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2069EAC08E;
        Fri, 26 Feb 2021 21:04:51 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 21:04:51 +0000 (GMT)
Subject: Re: [PATCH 2/3] integrity: Allow specifying flags in
 integrity_load_cert
To:     Patrick Uiterwijk <patrick@puiterwijk.org>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org
Cc:     pbrobinson@gmail.com, kgold@linux.ibm.com
References: <20210225203229.363302-1-patrick@puiterwijk.org>
 <20210225203229.363302-3-patrick@puiterwijk.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <69c59b37-a45c-493f-6b86-e324d4dd6f9f@linux.ibm.com>
Date:   Fri, 26 Feb 2021 16:04:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210225203229.363302-3-patrick@puiterwijk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_09:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260157
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/25/21 3:32 PM, Patrick Uiterwijk wrote:
> Allows passing flags for key_create_or_update via
> integrity_load_cert.
>
> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   security/integrity/digsig.c                          | 11 ++++++-----
>   security/integrity/integrity.h                       |  6 ++++--
>   security/integrity/platform_certs/platform_keyring.c |  2 +-
>   3 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 250fb0836156..93203c767b57 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -144,7 +144,7 @@ int __init integrity_init_keyring(const unsigned int id)
>   }
>   
>   static int __init integrity_add_key(const unsigned int id, const void *data,
> -				    off_t size, key_perm_t perm)
> +				    off_t size, key_perm_t perm, unsigned long flags)
>   {
>   	key_ref_t key;
>   	int rc = 0;
> @@ -154,7 +154,7 @@ static int __init integrity_add_key(const unsigned int id, const void *data,
>   
>   	key = key_create_or_update(make_key_ref(keyring[id], 1), "asymmetric",
>   				   NULL, data, size, perm,
> -				   KEY_ALLOC_NOT_IN_QUOTA);
> +				   flags | KEY_ALLOC_NOT_IN_QUOTA);
>   	if (IS_ERR(key)) {
>   		rc = PTR_ERR(key);
>   		pr_err("Problem loading X.509 certificate %d\n", rc);
> @@ -186,18 +186,19 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
>   	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ;
>   
>   	pr_info("Loading X.509 certificate: %s\n", path);
> -	rc = integrity_add_key(id, (const void *)data, size, perm);
> +	rc = integrity_add_key(id, (const void *)data, size, perm, 0);
>   
>   	vfree(data);
>   	return rc;
>   }
>   
>   int __init integrity_load_cert(const unsigned int id, const char *source,
> -			       const void *data, size_t len, key_perm_t perm)
> +			       const void *data, size_t len, key_perm_t perm,
> +			       unsigned long flags)
>   {
>   	if (!data)
>   		return -EINVAL;
>   
>   	pr_info("Loading X.509 certificate: %s\n", source);
> -	return integrity_add_key(id, data, len, perm);
> +	return integrity_add_key(id, data, len, perm, flags);
>   }
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 547425c20e11..1194ff71a1c1 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -166,7 +166,8 @@ int integrity_modsig_verify(unsigned int id, const struct modsig *modsig);
>   int __init integrity_init_keyring(const unsigned int id);
>   int __init integrity_load_x509(const unsigned int id, const char *path);
>   int __init integrity_load_cert(const unsigned int id, const char *source,
> -			       const void *data, size_t len, key_perm_t perm);
> +			       const void *data, size_t len, key_perm_t perm,
> +			       unsigned long flags);
>   #else
>   
>   static inline int integrity_digsig_verify(const unsigned int id,
> @@ -190,7 +191,8 @@ static inline int integrity_init_keyring(const unsigned int id)
>   static inline int __init integrity_load_cert(const unsigned int id,
>   					     const char *source,
>   					     const void *data, size_t len,
> -					     key_perm_t perm)
> +					     key_perm_t perm,
> +					     unsigned long flags)
>   {
>   	return 0;
>   }
> diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
> index bcafd7387729..131462c826b5 100644
> --- a/security/integrity/platform_certs/platform_keyring.c
> +++ b/security/integrity/platform_certs/platform_keyring.c
> @@ -32,7 +32,7 @@ void __init add_to_platform_keyring(const char *source, const void *data,
>   	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
>   
>   	rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source, data, len,
> -				 perm);
> +				 perm, 0);
>   	if (rc)
>   		pr_info("Error adding keys to platform keyring %s\n", source);
>   }


