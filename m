Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89D1691F81
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 14:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjBJNG2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 08:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjBJNG1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 08:06:27 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223E47AE11;
        Fri, 10 Feb 2023 05:06:11 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ACtYDD018947;
        Fri, 10 Feb 2023 13:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RMH9PfxrEZmXBs5HlCWUIj1nqHeW1n/Z8WQHJeUWOqg=;
 b=nMt2jStB/RyQux4u1Jx1XzrM4NLw3uCBkSDZCIp2aNgoNfJ4pGeT1Y/kk078Byp90BnV
 yUgF7S/5cMzap2aA0R9smC6uVk2S1F1jAjDTJxbDGTOK7GCOJvg2MeCm96kEFBsLtR5y
 t4y3BnORfZzeRx+t/1fqPI0ntbAF8ngd9nRPCAy3rbfIqbRAozNJZzP7YaCX+53QAb7D
 owd8RK9BPnecBwXbYsrmQdYh4qjvPyEU5dRyTu88TVP1z0N7gUlU+k597c43icFZdViX
 fY0ZvR26BmwTpvxds9r8vlapHfeIQp5EoyTfcxPV+q2fm0djdc7zOAdAhEPuzHKxadpU vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnpc0ga0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 13:05:28 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31ACu6NA020617;
        Fri, 10 Feb 2023 13:05:27 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnpc0g9xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 13:05:27 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31ACCrSX001971;
        Fri, 10 Feb 2023 13:05:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3nhf07xsp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 13:05:25 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31AD5Ouf56754632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 13:05:24 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D1F95803F;
        Fri, 10 Feb 2023 13:05:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAA9D58060;
        Fri, 10 Feb 2023 13:05:22 +0000 (GMT)
Received: from sig-9-77-142-160.ibm.com (unknown [9.77.142.160])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 13:05:22 +0000 (GMT)
Message-ID: <4bda209dfc891ac9044ce847785c383e89f14f97.camel@linux.ibm.com>
Subject: Re: [PATCH v4 6/6] integrity: machine keyring CA configuration
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, tadeusz.struk@intel.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 10 Feb 2023 08:05:22 -0500
In-Reply-To: <20230207025958.974056-7-eric.snowberg@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
         <20230207025958.974056-7-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iRVp5qk64i13A31hNdiBJVZrE8vj_KXY
X-Proofpoint-GUID: x5mR7gi2FFWd4BNQqSF3zFvhIVEUIIbL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_07,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 phishscore=0
 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Mon, 2023-02-06 at 21:59 -0500, Eric Snowberg wrote:
> Add a machine keyring CA restriction menu option to control the type of
> keys that may be added to it. The options include none, min and max
> restrictions.
> 
> When no restrictions are selected, all Machine Owner Keys (MOK) are added
> to the machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MIN is
> selected, the CA bit must be true.  Also the key usage must contain
> keyCertSign, any other usage field may be set as well.
> 
> When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is selected, the CA bit must
> be true. Also the key usage must contain keyCertSign and the
> digitialSignature usage may not be set.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Missing from the patch description is the motivation for this change.  
The choices none, min, max implies a progression, which is good, and
the technical differences between the choices, but not the reason.

The motivation, at least from my perspective, is separation of
certificate signing from code signing keys, where "none" is no
separation and "max" being total separation of keys based on usage.

Subsequent work, as discussed in the cover letter thread, will limit
certificates being loaded onto the IMA keyring to code signing keys
used for signature verification.

thanks,

Mimi
> ---
>  crypto/asymmetric_keys/restrict.c |  2 ++
>  security/integrity/Kconfig        | 39 ++++++++++++++++++++++++++++++-
>  security/integrity/digsig.c       |  8 +++++--
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
> index 48457c6f33f9..633021ea7901 100644
> --- a/crypto/asymmetric_keys/restrict.c
> +++ b/crypto/asymmetric_keys/restrict.c
> @@ -140,6 +140,8 @@ int restrict_link_by_ca(struct key *dest_keyring,
>  		return -ENOKEY;
>  	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
>  		return -ENOKEY;
> +	if (IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MIN))
> +		return 0;
>  	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
>  		return -ENOKEY;
>  
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 599429f99f99..eba6fd59fd16 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -68,13 +68,50 @@ config INTEGRITY_MACHINE_KEYRING
>  	depends on INTEGRITY_ASYMMETRIC_KEYS
>  	depends on SYSTEM_BLACKLIST_KEYRING
>  	depends on LOAD_UEFI_KEYS
> -	depends on !IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
>  	help
>  	 If set, provide a keyring to which Machine Owner Keys (MOK) may
>  	 be added. This keyring shall contain just MOK keys.  Unlike keys
>  	 in the platform keyring, keys contained in the .machine keyring will
>  	 be trusted within the kernel.
>  
> +choice
> +	prompt "Enforce Machine Keyring CA Restrictions"
> +	default INTEGRITY_CA_MACHINE_KEYRING_NONE
> +	depends on INTEGRITY_MACHINE_KEYRING
> +	help
> +	  The .machine keyring can be configured to enforce CA restriction
> +	  on any key added to it. The options include none, min and max
> +	  restrictions. By default no restrictions are in place and all
> +	  Machine Owner Keys (MOK) are added to the machine keyring.
> +
> +config INTEGRITY_CA_MACHINE_KEYRING_NONE
> +	bool "No restrictions"
> +	help
> +	  When no restrictions are selected, all Machine Owner Keys (MOK)
> +	  are added to the machine keyring. MOK keys do not require the
> +	  CA bit to be set. The key usage field is ignored. This is the
> +	  default setting.
> +
> +config INTEGRITY_CA_MACHINE_KEYRING_MIN
> +	bool "Only CA keys (with or without DigitialSignature usage set)"
> +	help
> +	  When min is selected, only load CA keys into the machine keyring.
> +	  The CA bit must be set along with the keyCertSign Usage field.
> +	  Keys containing the digitialSignature Usage field will also be
> +	  loaded. The remaining MOK keys are loaded into the .platform
> +	  keyring.
> +
> +config INTEGRITY_CA_MACHINE_KEYRING_MAX
> +	bool "Only CA keys"
> +	help
> +	  When max is selected, only load CA keys into the machine keyring.
> +	  The CA bit must be set along with the keyCertSign Usage field.
> +	  Keys containing the digitialSignature Usage field will not be
> +	  loaded. The remaining MOK keys are loaded into the .platform
> +	  keyring.
> +
> +endchoice
> +
>  config LOAD_UEFI_KEYS
>         depends on INTEGRITY_PLATFORM_KEYRING
>         depends on EFI
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index f2193c531f4a..3385f534f1da 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -132,7 +132,8 @@ int __init integrity_init_keyring(const unsigned int id)
>  		| KEY_USR_READ | KEY_USR_SEARCH;
>  
>  	if (id == INTEGRITY_KEYRING_PLATFORM ||
> -	    id == INTEGRITY_KEYRING_MACHINE) {
> +	    (id == INTEGRITY_KEYRING_MACHINE &&
> +	    IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING_NONE))) {
>  		restriction = NULL;
>  		goto out;
>  	}
> @@ -144,7 +145,10 @@ int __init integrity_init_keyring(const unsigned int id)
>  	if (!restriction)
>  		return -ENOMEM;
>  
> -	restriction->check = restrict_link_to_ima;
> +	if (id == INTEGRITY_KEYRING_MACHINE)
> +		restriction->check = restrict_link_by_ca;
> +	else
> +		restriction->check = restrict_link_to_ima;
>  
>  	/*
>  	 * MOK keys can only be added through a read-only runtime services


