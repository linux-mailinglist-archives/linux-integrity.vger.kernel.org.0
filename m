Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E72377E402
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Aug 2023 16:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbjHPOnd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Aug 2023 10:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbjHPOnB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Aug 2023 10:43:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005FDDF;
        Wed, 16 Aug 2023 07:42:59 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GEYtDY021497;
        Wed, 16 Aug 2023 14:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sEg2SMUzqWpdJrFF2KvJKOhl26hag1OPiZc2m3KpvCg=;
 b=jOiHTKMpXhtXHmaurX2TS+ZtAqAIka7Gio1ffu31i/8OCUJzZQVf4sbshTmUyL7t/ale
 8ej5c1Kaqu7doP/5oo9aHWx53TN93/FRzkgKptMrPJbaOpHN8evInfv5+fLCIM6a5azp
 oPiyvFj7T1hWNhFlvOmAqF4namURbGIYd1EeBUv8YybheYythP4DkG2MnBxiSp6wx5Cb
 O3IVOynjkUcaPfHLGerTuBKyXUi3xP2BMBuZ8JSiKa90mUhVGzvflOjTWgGgHj0rv0sG
 h6mpLD8PrlVyeAb3uN4lJZ9wYp1v9DS4SY3BcQc/61aEiaox+KRhrPzpuXA4pqytESp7 GQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh0bk0jt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 14:42:47 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GDsCTQ003439;
        Wed, 16 Aug 2023 14:42:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semdsnv1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 14:42:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GEgU8A11010802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 14:42:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82EF02004D;
        Wed, 16 Aug 2023 14:42:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C03F62004B;
        Wed, 16 Aug 2023 14:42:28 +0000 (GMT)
Received: from [9.43.32.205] (unknown [9.43.32.205])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 14:42:28 +0000 (GMT)
Message-ID: <0f6883a5-13b4-435a-6e0d-e457b394027d@linux.ibm.com>
Date:   Wed, 16 Aug 2023 20:12:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 6/6] integrity: PowerVM support for loading third party
 code signing keys
Content-Language: en-US
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, inux-kernel@vger.kernel.org
References: <20230815112722.1591829-1-nayna@linux.ibm.com>
 <20230815112722.1591829-7-nayna@linux.ibm.com>
From:   R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20230815112722.1591829-7-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PPS1LelOqatfXDznjzCb4AJB_fEZo2Rm
X-Proofpoint-ORIG-GUID: PPS1LelOqatfXDznjzCb4AJB_fEZo2Rm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_14,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160125
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 15/08/23 4:57 pm, Nayna Jain wrote:
> On secure boot enabled PowerVM LPAR, third party code signing keys are
> needed during early boot to verify signed third party modules. These
> third party keys are stored in moduledb object in the Platform
> KeyStore (PKS).
> 
> Load third party code signing keys onto .secondary_trusted_keys keyring.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>


Tested with trustedcadb, moduledb scenarios
Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

> ---
>   certs/system_keyring.c                        | 30 +++++++++++++++++++
>   include/keys/system_keyring.h                 |  4 +++
>   .../platform_certs/keyring_handler.c          |  8 +++++
>   .../platform_certs/keyring_handler.h          |  5 ++++
>   .../integrity/platform_certs/load_powerpc.c   | 17 +++++++++++
>   5 files changed, 64 insertions(+)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index b348e0898d34..33841c91f12c 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -152,6 +152,36 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
>   
>   	return restriction;
>   }
> +
> +/**
> + * add_to_secondary_keyring - Add to secondary keyring.
> + * @source: Source of key
> + * @data: The blob holding the key
> + * @len: The length of the data blob
> + *
> + * Add a key to the secondary keyring. The key must be vouched for by a key in the builtin,
> + * machine or secondary keyring itself.
> + */
> +void __init add_to_secondary_keyring(const char *source, const void *data, size_t len)
> +{
> +	key_ref_t key;
> +	key_perm_t perm;
> +
> +	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
> +
> +	key = key_create_or_update(make_key_ref(secondary_trusted_keys, 1),
> +				   "asymmetric",
> +				   NULL, data, len, perm,
> +				   KEY_ALLOC_NOT_IN_QUOTA);
> +	if (IS_ERR(key)) {
> +		pr_err("Problem loading X.509 certificate from %s to secondary keyring %ld\n",
> +		       source, PTR_ERR(key));
> +		return;
> +	}
> +
> +	pr_notice("Loaded X.509 cert '%s'\n", key_ref_to_ptr(key)->description);
> +	key_ref_put(key);
> +}
>   #endif
>   #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
>   void __init set_machine_trusted_keys(struct key *keyring)
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 7e2583208820..8365adf842ef 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -50,9 +50,13 @@ int restrict_link_by_digsig_builtin_and_secondary(struct key *keyring,
>   						  const struct key_type *type,
>   						  const union key_payload *payload,
>   						  struct key *restriction_key);
> +void __init add_to_secondary_keyring(const char *source, const void *data, size_t len);
>   #else
>   #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
>   #define restrict_link_by_digsig_builtin_and_secondary restrict_link_by_digsig_builtin
> +static inline void __init add_to_secondary_keyring(const char *source, const void *data, size_t len)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
> index 586027b9a3f5..13ea17207902 100644
> --- a/security/integrity/platform_certs/keyring_handler.c
> +++ b/security/integrity/platform_certs/keyring_handler.c
> @@ -78,6 +78,14 @@ __init efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type)
>   	return NULL;
>   }
>   
> +__init efi_element_handler_t get_handler_for_code_signing_keys(const efi_guid_t *sig_type)
> +{
> +	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0)
> +		return add_to_secondary_keyring;
> +
> +	return NULL;
> +}
> +
>   /*
>    * Return the appropriate handler for particular signature list types found in
>    * the UEFI dbx and MokListXRT tables.
> diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
> index 6f15bb4cc8dc..f92895cc50f6 100644
> --- a/security/integrity/platform_certs/keyring_handler.h
> +++ b/security/integrity/platform_certs/keyring_handler.h
> @@ -34,6 +34,11 @@ efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
>    */
>   efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type);
>   
> +/*
> + * Return the handler for particular signature list types for code signing keys.
> + */
> +efi_element_handler_t get_handler_for_code_signing_keys(const efi_guid_t *sig_type);
> +
>   /*
>    * Return the handler for particular signature list types found in the dbx.
>    */
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
> index 339053d9726d..c85febca3343 100644
> --- a/security/integrity/platform_certs/load_powerpc.c
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -60,6 +60,7 @@ static int __init load_powerpc_certs(void)
>   {
>   	void *db = NULL, *dbx = NULL, *data = NULL;
>   	void *trustedca;
> +	void *moduledb;
>   	u64 dsize = 0;
>   	u64 offset = 0;
>   	int rc = 0;
> @@ -137,6 +138,22 @@ static int __init load_powerpc_certs(void)
>   		kfree(data);
>   	}
>   
> +	data = get_cert_list("moduledb", 9,  &dsize);
> +	if (!data) {
> +		pr_info("Couldn't get moduledb list from firmware\n");
> +	} else if (IS_ERR(data)) {
> +		rc = PTR_ERR(data);
> +		pr_err("Error reading moduledb from firmware: %d\n", rc);
> +	} else {
> +		extract_esl(moduledb, data, dsize, offset);
> +
> +		rc = parse_efi_signature_list("powerpc:moduledb", moduledb, dsize,
> +					      get_handler_for_code_signing_keys);
> +		if (rc)
> +			pr_err("Couldn't parse moduledb signatures: %d\n", rc);
> +		kfree(data);
> +	}
> +
>   	return rc;
>   }
>   late_initcall(load_powerpc_certs);

-- 
Thanks and Regards
R.Nageswara Sastry
