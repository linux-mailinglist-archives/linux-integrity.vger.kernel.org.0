Return-Path: <linux-integrity+bounces-9204-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD1dAjBW4GmrfAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9204-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 05:23:28 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB3409EA8
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 05:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D6083053D07
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 03:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6121A2D1303;
	Thu, 16 Apr 2026 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xo/eSRnR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B22D29C7;
	Thu, 16 Apr 2026 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776309804; cv=none; b=nODWWntGP1Zi+LXYrqYnXDFnD7NTpN+x8FnSWHDoGpBeMVatwSQDipVuo0kp+ixEGcme3fQvcZiUYp0t5TU4LmzKR/hFCDF+KO0/6ndzoLSKlp8+XlaZBOPQOcGRKchB0vV4IAHmjpO6qnWrgn/m1i6qj/+lEZzQR+ItawLnElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776309804; c=relaxed/simple;
	bh=HlQX4Adau2R5onNZ4hQZ9wPsgjH+B/IhganZTtXcGdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kO+AQBFEhOzaa71NDTBiUd8E8FpdOmalZxj3EAisw6/FO4Vg0smJwJgxVw4EbnIZVodJIFVRrA5UMa6itO1k90jZW/h1ap/ovCZCwhBSe/aSUpaM0O+TiEZxrZnKQfrvv9C4c7tSC14QKLmSXoFM5wrjtMU/i4LTZVwSFHVk61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xo/eSRnR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FGpUVH1804500;
	Thu, 16 Apr 2026 03:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qhmxM3
	gr/wrpaVGlpBEOBItyUitHGshfPV2GbWA1xao=; b=Xo/eSRnR0LrfGOs7yMqPRm
	c4vHxJ8T7Wu0sS0VE9Oy9GE0UJjsm4deG3d4CPEwqxqDTxgLBSVhyeq7Rx7nP2O5
	RIoYah6RKcziF1j2+XXIDyuHYwHfmgY97ZIZg7eZGjv2y85KEbl5UtFkA9a/bwXf
	86elMDDCyRRwJwZ0RP+9JbdZntXfM8wp6eYkqidRHNGcL4Cq5w7nmM+sNJeQg2SB
	4GSKpLos2tsJ54Y7ppjiJJuNox3sKjMTh7I2nnvALcToGn7lQScVP/+TDxxXLnCT
	9v6zLlnHWf938mo/uvE6HQwgaYICGYEGy9/sMCM7KW9uzXy02WwURMsJzsHrdpjg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kaq06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 03:16:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G1ojII003594;
	Thu, 16 Apr 2026 03:16:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnh4j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 03:16:34 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63G3GXFu26149520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 03:16:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6758658095;
	Thu, 16 Apr 2026 03:16:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C07655809C;
	Thu, 16 Apr 2026 03:16:30 +0000 (GMT)
Received: from [9.61.145.232] (unknown [9.61.145.232])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 03:16:30 +0000 (GMT)
Message-ID: <1569ac4b-a569-4c78-a415-7e9c189d9cb6@linux.ibm.com>
Date: Wed, 15 Apr 2026 23:16:29 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] KEYS: trusted: Debugging as a feature
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Srish Srinivasan <ssrish@linux.ibm.com>, Jonathan Corbet
 <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ahmad Fatoum
 <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Feng Tang <feng.tang@linux.alibaba.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
        Marco Elver <elver@google.com>, Li RongQing <lirongqing@baidu.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260415111202.63888-1-jarkko@kernel.org>
Content-Language: en-US
From: Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <20260415111202.63888-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: KQs0K3VmyIOiiaAotl8jIaQj_pgOcwaG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDAyNCBTYWx0ZWRfX7jdsV3hJl25F
 wgNI/yzuVOIDxGsHByiCGYlO+b2RZJiYQQHpXqtPnP2l/PXX9yaxCsiwgZtNpB5gsGXKUGX5CdJ
 DByWXWoK8un5jrBw3448Z3/hJ4E5W9sY+BWFzaOZ7eAXNB0p6p9YOLqykZG9ITrV8Z10whGoP8s
 WSwacaQHprnFlBCR/CiCw06JdzlgQDBdRhvWmu3zvgSxlWzZhinTfeSZgFRFkaNYOMDc5nqxd9X
 YTWOez6IA+uAC/VGSFbheIULWPtTEdMzVe5rAT/fJmVrOdDaPM90HTOjSECwPUu+8WOZJNekMv9
 nIOnGlo3NSR/rC/l3WU2vA7mbPp0aUxbXx9BH0gx0UDaLH969DhS6oslFnNJ7yuvbpClRjb8X2+
 tRhBSXnVha8xyp3hN0OqYajyHt59KYAtETvyhr6BUylbVFbBmPZuFIGJa/LKu92NfJeDBTMUvyT
 PWA9gC+e8U75129cgvw==
X-Proofpoint-ORIG-GUID: au-3_HIjGvpReuOQLMWnpLP-U0wEWjrm
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e05494 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=zzKBsTiU_qEVFVDPJAMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160024
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9204-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nayna@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid]
X-Rspamd-Queue-Id: DFEB3409EA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/15/26 7:12 AM, Jarkko Sakkinen wrote:
> TPM_DEBUG, and other similar flags, are a non-standard way to specify a
> feature in Linux kernel. Introduce CONFIG_TRUSTED_KEYS_DEBUG for trusted
> keys, and use it to replace these ad-hoc feature flags.
>
> Given that trusted keys debug dumps can contain sensitive data, harden the
> feature as follows:
>
> 1. In the Kconfig description postulate that pr_debug() statements must be
>     used.
> 2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.
> 3. Require trusted.debug=1 on the kernel command line (default: 0) to
>     activate dumps at runtime, even when CONFIG_TRUSTED_KEYS_DEBUG=y.
>
> Traces, when actually needed, can be easily enabled by providing
> trusted.dyndbg='+p' and trusted.debug=1 in the kernel command-line.

Thanks for adding the documentation.

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

>
> Reported-by: Nayna Jain <nayna@linux.ibm.com>
> Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
> Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
> Tested-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v4:
> - Added kernel parameter documentation.t
> - Added tags from Srishand and Nayna.
> - Sanity check round. This version will be applied unless there is
>    something specific to address.
> v3:
> - Add kernel-command line option for enabling the traces.
> - Add safety information to the Kconfig entry.
> v2:
> - Implement for all trusted keys backends.
> - Add HAVE_TRUSTED_KEYS_DEBUG as it is a good practice despite full
>    coverage.
> ---
>   .../admin-guide/kernel-parameters.txt         | 16 +++++++
>   include/keys/trusted-type.h                   | 21 +++++----
>   security/keys/trusted-keys/Kconfig            | 23 ++++++++++
>   security/keys/trusted-keys/trusted_caam.c     |  7 ++-
>   security/keys/trusted-keys/trusted_core.c     |  6 +++
>   security/keys/trusted-keys/trusted_tpm1.c     | 44 +++++++++++--------
>   6 files changed, 87 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f2ce1f4975c1..f1515668c8ab 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7917,6 +7917,22 @@ Kernel parameters
>   			first trust source as a backend which is initialized
>   			successfully during iteration.
>   
> +	trusted.debug=	[KEYS]
> +			Format: <bool>
> +			Enable trusted keys debug traces at runtime when
> +			CONFIG_TRUSTED_KEYS_DEBUG=y.
> +
> +			To make the traces visible after enabling the option,
> +			use trusted.dyndbg='+p' as needed. By convention,
> +			the subsystem uses pr_debug() for these traces.
> +
> +			SAFETY: The traces can leak sensitive data, so be
> +			cautious before enabling this. They remain inactive
> +			unless this parameter is set this option to  a true
> +			value.
> +
> +			Default: false
> +
>   	trusted.rng=	[KEYS]
>   			Format: <string>
>   			The RNG used to generate key material for trusted keys.
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index 03527162613f..9f9940482da4 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -83,18 +83,21 @@ struct trusted_key_source {
>   
>   extern struct key_type key_type_trusted;
>   
> -#define TRUSTED_DEBUG 0
> +#ifdef CONFIG_TRUSTED_KEYS_DEBUG
> +extern bool trusted_debug;
>   
> -#if TRUSTED_DEBUG
>   static inline void dump_payload(struct trusted_key_payload *p)
>   {
> -	pr_info("key_len %d\n", p->key_len);
> -	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
> -		       16, 1, p->key, p->key_len, 0);
> -	pr_info("bloblen %d\n", p->blob_len);
> -	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
> -		       16, 1, p->blob, p->blob_len, 0);
> -	pr_info("migratable %d\n", p->migratable);
> +	if (!trusted_debug)
> +		return;
> +
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
> index 9e00482d886a..e5a4a53aeab2 100644
> --- a/security/keys/trusted-keys/Kconfig
> +++ b/security/keys/trusted-keys/Kconfig
> @@ -1,10 +1,29 @@
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
> +	  Trusted key backends and core code that support debug traces can
> +	  opt-in that feature here. Traces must only use debug level output, as
> +	  sensitive data may pass by. In the kernel-command line traces can be
> +	  enabled via trusted.dyndbg='+p'.
> +
> +	  SAFETY: Debug dumps are inactive at runtime until trusted.debug is set
> +	  to a true value on the kernel command-line. Use at your utmost
> +	  consideration when enabling this feature on a production build. The
> +	  general advice is not to do this.
> +
>   config TRUSTED_KEYS_TPM
>   	bool "TPM-based trusted keys"
>   	depends on TCG_TPM >= TRUSTED_KEYS
>   	default y
> +	select HAVE_TRUSTED_KEYS_DEBUG
>   	select CRYPTO_HASH_INFO
>   	select CRYPTO_LIB_SHA1
>   	select CRYPTO_LIB_UTILS
> @@ -23,6 +42,7 @@ config TRUSTED_KEYS_TEE
>   	bool "TEE-based trusted keys"
>   	depends on TEE >= TRUSTED_KEYS
>   	default y
> +	select HAVE_TRUSTED_KEYS_DEBUG
>   	select HAVE_TRUSTED_KEYS
>   	help
>   	  Enable use of the Trusted Execution Environment (TEE) as trusted
> @@ -33,6 +53,7 @@ config TRUSTED_KEYS_CAAM
>   	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
>   	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
>   	default y
> +	select HAVE_TRUSTED_KEYS_DEBUG
>   	select HAVE_TRUSTED_KEYS
>   	help
>   	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
> @@ -42,6 +63,7 @@ config TRUSTED_KEYS_DCP
>   	bool "DCP-based trusted keys"
>   	depends on CRYPTO_DEV_MXS_DCP >= TRUSTED_KEYS
>   	default y
> +	select HAVE_TRUSTED_KEYS_DEBUG
>   	select HAVE_TRUSTED_KEYS
>   	help
>   	  Enable use of NXP's DCP (Data Co-Processor) as trusted key backend.
> @@ -50,6 +72,7 @@ config TRUSTED_KEYS_PKWM
>   	bool "PKWM-based trusted keys"
>   	depends on PSERIES_PLPKS >= TRUSTED_KEYS
>   	default y
> +	select HAVE_TRUSTED_KEYS_DEBUG
>   	select HAVE_TRUSTED_KEYS
>   	help
>   	  Enable use of IBM PowerVM Key Wrapping Module (PKWM) as a trusted key backend.
> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
> index 601943ce0d60..6a33dbf2a7f5 100644
> --- a/security/keys/trusted-keys/trusted_caam.c
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -28,10 +28,13 @@ static const match_table_t key_tokens = {
>   	{opt_err, NULL}
>   };
>   
> -#ifdef CAAM_DEBUG
> +#ifdef CONFIG_TRUSTED_KEYS_DEBUG
>   static inline void dump_options(const struct caam_pkey_info *pkey_info)
>   {
> -	pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
> +	if (!trusted_debug)
> +		return;
> +
> +	pr_debug("key encryption algo %d\n", pkey_info->key_enc_algo);
>   }
>   #else
>   static inline void dump_options(const struct caam_pkey_info *pkey_info)
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index 0b142d941cd2..6aed17bee09d 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -31,6 +31,12 @@ static char *trusted_rng = "default";
>   module_param_named(rng, trusted_rng, charp, 0);
>   MODULE_PARM_DESC(rng, "Select trusted key RNG");
>   
> +#ifdef CONFIG_TRUSTED_KEYS_DEBUG
> +bool trusted_debug;
> +module_param_named(debug, trusted_debug, bool, 0);
> +MODULE_PARM_DESC(debug, "Enable trusted keys debug traces (default: 0)");
> +#endif
> +
>   static char *trusted_key_source;
>   module_param_named(source, trusted_key_source, charp, 0);
>   MODULE_PARM_DESC(source, "Select trusted keys source (tpm, tee, caam, dcp or pkwm)");
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 6ea728f1eae6..13513819991e 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -46,38 +46,44 @@ enum {
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
> +	if (!trusted_debug)
> +		return;
> +
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
> +	if (!trusted_debug)
> +		return;
> +
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
> +	if (!trusted_debug)
> +		return;
> +	pr_debug("\ntpm buffer\n");
>   	len = LOAD32(buf, TPM_SIZE_OFFSET);
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
> +	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
>   }
>   #else
>   static inline void dump_options(struct trusted_key_options *o)

