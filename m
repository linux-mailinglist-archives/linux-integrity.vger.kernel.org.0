Return-Path: <linux-integrity+bounces-9090-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOi2M79pxWl1+AQAu9opvQ
	(envelope-from <linux-integrity+bounces-9090-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:15:43 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 915A5339033
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B845930FA3F8
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C7421893;
	Thu, 26 Mar 2026 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CpRuM4SW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0D27FD75;
	Thu, 26 Mar 2026 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544728; cv=none; b=OFiy8K1HgRBD/v8t68EGRIHdc14fTuP0H7SMpj/3Jt4F3FqF5y9BnyY+XR06hjJxSKlgR2rRDVMGZofJ9U9SKdy3i8DVa75Ssp6v4656YT4yN1vgaVZamxPV67fYTf6sswwkLM56Jjq8m7MWnnfgO9StimsK7ZUK+4RwV3fZigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544728; c=relaxed/simple;
	bh=wwT8IcuZNGY/4L8pI23iKZgguLKjG+SYZC129kw9BGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnRbYqVB6b1awLc33ggx2r8O9LNf4LNq9hq3bXfCYh+c4lidinN5/itDikIMeZbj3GrCiAhTDjyLKJzVPXV546Kx7RymvMugI2MGoFk4owzRwugxUInn/PmONaK6fAYyS8DchVkG2bBz8UQ7FJx9J4TiBSOnAS8wrURWdXU0f/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CpRuM4SW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QElNQg670670;
	Thu, 26 Mar 2026 17:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cX4hUe
	gJluicWnx+VsXDTf/AVhViit/rZsgRCm8k/NA=; b=CpRuM4SWqiEXTsztr9X/Ee
	BqUG/Trmol9JlsvBIm+CFxIM+Gi3yNsYkN11vkVdyRyE7C3dHalnurSKAqJYKY6h
	7frUScvYbC4vAwmm8L1Z7imaLgKp8Oi5uxmIDNH4SbbiVfjdlSXyDyaQoSo0UomC
	6mDppOfr0qA+xpcnEWgB/bjVg7HqrE9Zj/FJeg5pwkYZ3Rh7m7qgK+hpJSvKHKQz
	AfrRotqhIfNlL+4kuZihHszQSo/OhiHxHKFugNmE+c6FigZjLxKwOQW3jKzV+GU2
	PFQAOGFXhw1uXxnxoWWRvn0khVMnddlk9ALloI7oRsUvIDRXqscQnPgvXc3bFJ5Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv5a6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 17:05:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QFjI7g005976;
	Thu, 26 Mar 2026 17:05:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yv0dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 17:05:06 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QH558634013750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 17:05:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09C2C58050;
	Thu, 26 Mar 2026 17:05:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 787C558054;
	Thu, 26 Mar 2026 17:05:00 +0000 (GMT)
Received: from [9.39.29.16] (unknown [9.39.29.16])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 17:05:00 +0000 (GMT)
Message-ID: <0ce8d850-9ca7-4327-a6be-d1cb84925915@linux.ibm.com>
Date: Thu, 26 Mar 2026 22:34:58 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KEYS: trusted: Debugging as a feature
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ahmad Fatoum
 <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
References: <20260324110018.67081-1-jarkko@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <20260324110018.67081-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: czlX2P7hXv12V3PGer_OJzZI345CX_cz
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c56743 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=E9m4iwf8s1Ab0jgAuK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExOSBTYWx0ZWRfXy2UHYXUjEkwv
 NEXekn9joZLK1DLnL+AvkOY8QG5mltQ2ZQPNvzFbi/n/PfQ/OMk6CiXqpNjNiwM58DQLLZ4ROBk
 7dPU6RXEb4yKmhGO0vZX+wBbG4zaXMu/MeIsNL3IeHNm1scGTjK+GAEOK/PYokb/E9kQ2IhQm0w
 I/HAcWWkuGFb4fYERmvdffOMpBaDc8tvGRD+fATRxu1cWYUgA7Fi+yZzR/FNmM6JeF4EHVIx1mr
 AN5Fudqh/XhAF2OlTjldOk0XBuNn5AJb8Aj/APDdT7K4C97nRg2I+OMIQKVRY9wDAjyJtg/gEcJ
 zk17RBh0tmWOHYKV/NlvqZj1MD2WE1ej4lUagANDWhLMFAnd3qWQF4a7px8+u6WmjzyOj/n0uL+
 vwufadnVW1GK0r7I5D92HDakI+IPvvXLNPKwt5Rd9a+xctD90U69MgkdENpOtJEHWVcn8XL80Nj
 vR7jbTpWCxHU7uIiB2g==
X-Proofpoint-GUID: czlX2P7hXv12V3PGer_OJzZI345CX_cz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260119
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9090-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 915A5339033
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 4:30 PM, Jarkko Sakkinen wrote:
> TPM_DEBUG, and other similar flags, are a non-standard way to specify a
> feature in Linux kernel.  Introduce CONFIG_TRUSTED_KEYS_DEBUG for
> trusted keys, and use it to replace these ad-hoc feature flags.
>
> Given that trusted keys debug dumps can contain sensitive data, harden
> the feature as follows:
>
> 1. In the Kconfig description postulate that pr_debug() statements must be
>     used.
> 2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.
>
> Traces, when actually needed, can be easily enabled by providing
> trusted.dyndbg='+p' in the kernel command-line.
>
> Cc: Srish Srinivasan <ssrish@linux.ibm.com>
> Reported-by: Nayna Jain <nayna@linux.ibm.com>
> Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>


Tested on PKWM and emulated TPM backends.

Tested-by: Srish Srinivasan <ssrish@linux.ibm.com>


> ---
> v2:
> - Implement for all trusted keys backends.
> - Add HAVE_TRUSTED_KEYS_DEBUG as it is a good practice despite full
>    coverage.
> ---
>   include/keys/trusted-type.h               | 18 +++++-------
>   security/keys/trusted-keys/Kconfig        | 19 ++++++++++++
>   security/keys/trusted-keys/trusted_caam.c |  4 +--
>   security/keys/trusted-keys/trusted_tpm1.c | 36 +++++++++++------------
>   4 files changed, 46 insertions(+), 31 deletions(-)
>
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index 03527162613f..620a1f890b6b 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -83,18 +83,16 @@ struct trusted_key_source {
>   
>   extern struct key_type key_type_trusted;
>   
> -#define TRUSTED_DEBUG 0
> -
> -#if TRUSTED_DEBUG
> +#ifdef CONFIG_TRUSTED_KEYS_DEBUG
>   static inline void dump_payload(struct trusted_key_payload *p)
>   {
> -	pr_info("key_len %d\n", p->key_len);
> -	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
> -		       16, 1, p->key, p->key_len, 0);
> -	pr_info("bloblen %d\n", p->blob_len);
> -	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
> -		       16, 1, p->blob, p->blob_len, 0);
> -	pr_info("migratable %d\n", p->migratable);
> +	pr_debug("key_len %d\n", p->key_len);
> +	print_hex_dump_debug("key ", DUMP_PREFIX_NONE,
> +			     16, 1, p->key, p->key_len, 0);
> +	pr_debug("bloblen %d\n", p->blob_len);
> +	print_hex_dump_debug("blob ", DUMP_PREFIX_NONE,
> +			     16, 1, p->blob, p->blob_len, 0);
> +	pr_debug("migratable %d\n", p->migratable);
>   }
>   #else
>   static inline void dump_payload(struct trusted_key_payload *p)
> diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
> index 9e00482d886a..2ad9ba0e03f1 100644
> --- a/security/keys/trusted-keys/Kconfig
> +++ b/security/keys/trusted-keys/Kconfig
> @@ -1,10 +1,25 @@
>   config HAVE_TRUSTED_KEYS
>   	bool
>   
> +config HAVE_TRUSTED_KEYS_DEBUG
> +	bool
> +
> +config TRUSTED_KEYS_DEBUG
> +	bool "Debug trusted keys"
> +	depends on HAVE_TRUSTED_KEYS_DEBUG
> +	default n
> +	help
> +	  Trusted keys backends and core code that support debug dumps
> +	  can opt-in that feature here. Dumps must only use DEBUG
> +	  level output, as sensitive data may pass by. In the
> +	  kernel-command line traces can be enabled via
> +	  trusted.dyndbg='+p'.
> +
>   config TRUSTED_KEYS_TPM
>   	bool "TPM-based trusted keys"
>   	depends on TCG_TPM >= TRUSTED_KEYS
>   	default y
> +	select HAVE_TRUSTED_KEYS_DEBUG
>   	select CRYPTO_HASH_INFO
>   	select CRYPTO_LIB_SHA1
>   	select CRYPTO_LIB_UTILS
> @@ -23,6 +38,7 @@ config TRUSTED_KEYS_TEE
>   	bool "TEE-based trusted keys"
>   	depends on TEE >= TRUSTED_KEYS
>   	default y
> +	select HAVE_TRUSTED_KEYS_DEBUG
>   	select HAVE_TRUSTED_KEYS
>   	help
>   	  Enable use of the Trusted Execution Environment (TEE) as trusted
> @@ -33,6 +49,7 @@ config TRUSTED_KEYS_CAAM
>   	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
>   	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
>   	default y
> +	select HAVE_TRUSTED_KEYS_DEBUG
>   	select HAVE_TRUSTED_KEYS
>   	help
>   	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
> @@ -42,6 +59,7 @@ config TRUSTED_KEYS_DCP
>   	bool "DCP-based trusted keys"
>   	depends on CRYPTO_DEV_MXS_DCP >= TRUSTED_KEYS
>   	default y
> +	select HAVE_TRUSTED_KEYS_DEBUG
>   	select HAVE_TRUSTED_KEYS
>   	help
>   	  Enable use of NXP's DCP (Data Co-Processor) as trusted key backend.
> @@ -50,6 +68,7 @@ config TRUSTED_KEYS_PKWM
>   	bool "PKWM-based trusted keys"
>   	depends on PSERIES_PLPKS >= TRUSTED_KEYS
>   	default y
> +	select HAVE_TRUSTED_KEYS_DEBUG
>   	select HAVE_TRUSTED_KEYS
>   	help
>   	  Enable use of IBM PowerVM Key Wrapping Module (PKWM) as a trusted key backend.
> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
> index 601943ce0d60..015cddc6b53c 100644
> --- a/security/keys/trusted-keys/trusted_caam.c
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -28,10 +28,10 @@ static const match_table_t key_tokens = {
>   	{opt_err, NULL}
>   };
>   
> -#ifdef CAAM_DEBUG
> +#ifdef CONFIG_TRUSTED_KEYS_DEBUG
>   static inline void dump_options(const struct caam_pkey_info *pkey_info)
>   {
> -	pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
> +	pr_debug("key encryption algo %d\n", pkey_info->key_enc_algo);
>   }
>   #else
>   static inline void dump_options(const struct caam_pkey_info *pkey_info)
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index c865c97aa1b4..8fe889c7cdd1 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -46,38 +46,36 @@ enum {
>   	SRK_keytype = 4
>   };
>   
> -#define TPM_DEBUG 0
> -
> -#if TPM_DEBUG
> +#ifdef CONFIG_TRUSTED_KEYS_DEBUG
>   static inline void dump_options(struct trusted_key_options *o)
>   {
> -	pr_info("sealing key type %d\n", o->keytype);
> -	pr_info("sealing key handle %0X\n", o->keyhandle);
> -	pr_info("pcrlock %d\n", o->pcrlock);
> -	pr_info("pcrinfo %d\n", o->pcrinfo_len);
> -	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
> -		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
> +	pr_debug("sealing key type %d\n", o->keytype);
> +	pr_debug("sealing key handle %0X\n", o->keyhandle);
> +	pr_debug("pcrlock %d\n", o->pcrlock);
> +	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
> +	print_hex_dump_debug("pcrinfo ", DUMP_PREFIX_NONE,
> +			     16, 1, o->pcrinfo, o->pcrinfo_len, 0);
>   }
>   
>   static inline void dump_sess(struct osapsess *s)
>   {
> -	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
> -		       16, 1, &s->handle, 4, 0);
> -	pr_info("secret:\n");
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> -		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
> -	pr_info("trusted-key: enonce:\n");
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> -		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
> +	print_hex_dump_debug("trusted-key: handle ", DUMP_PREFIX_NONE,
> +			     16, 1, &s->handle, 4, 0);
> +	pr_debug("secret:\n");
> +	print_hex_dump_debug("", DUMP_PREFIX_NONE,
> +			     16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
> +	pr_debug("trusted-key: enonce:\n");
> +	print_hex_dump_debug("", DUMP_PREFIX_NONE,
> +			     16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
>   }
>   
>   static inline void dump_tpm_buf(unsigned char *buf)
>   {
>   	int len;
>   
> -	pr_info("\ntpm buffer\n");
> +	pr_debug("\ntpm buffer\n");
>   	len = LOAD32(buf, TPM_SIZE_OFFSET);
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
> +	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
>   }
>   #else
>   static inline void dump_options(struct trusted_key_options *o)

