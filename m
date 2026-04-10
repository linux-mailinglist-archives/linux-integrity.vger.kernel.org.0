Return-Path: <linux-integrity+bounces-9155-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFmrC6k02WmjnQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9155-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 19:34:33 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51F3DB177
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 19:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1420230055FE
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C63BE161;
	Fri, 10 Apr 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KQdyXOOs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501931197B;
	Fri, 10 Apr 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842467; cv=none; b=jYNmCE//m5yLyi4ID35eZjsBUGvtX+bpCl6jaFnc1diHkf5OcaxlCIeQRSysuw0o+iKkFc7KxM9EymtM2UVyK17k0r9bERzFdCQ7joR/p2u3+eN29KO2L28yG3Ft4IL4u+sxN10e8to97dAuKry4s4Gm6zgNNYT2Rg1+8/CKSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842467; c=relaxed/simple;
	bh=SytBU+gVlBZFZmcD149/vLjEy1Kc7EaN4+jTmF5X16k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gczwuhzUjCYIiNS5mWR6+G3I5nayM1x8z5lpURUXcbOOh2/DWV1P7j+7TXBitFdj3xhqK0UD+Fz46BdRW/zJe1t0D91TxTCldKKugF4BP9bWAC82u0bbpUOVotvQH/KBOupvgPiQJd50rRCwLW+fC3i09GeDgTYFzE3aIN02gg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KQdyXOOs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AF4MFO2315079;
	Fri, 10 Apr 2026 17:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sxuw9U
	RWaYwq734cQChTmoBJHNMMp2zsf3hfTKvU1J0=; b=KQdyXOOsLJ/eFiWD5HGcqV
	XHzHnVrRrZyD1TjxECfCZyUoKxm0elaOqVB22rtvbRWJXMmGYkr1+656UqENGMHz
	bAQPwHKd5brpv6o8EWDcgZX5mndgCk4JOBs7n6hSG3Psv8X203Nez/6hCEF4ipu7
	78DiEs0XmV7VmRrLY1Za01urYT8K0AaJW1PRSE9zascRFDIM5+uX1+wC0PDYAcOJ
	GGhlRDadNn0INGuNYUx5kCHcjOJuwDxY5rEWuKDAtGxcqTCtvZ3AMF9TXbwb9j7w
	1pIVDG3tRc4ul5p9PyYVO4WSKiuY9blQTOEt7cLhdCxwqAyllLOiM1cH15lZ1fJw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2gb9bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 17:34:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63AGmSwW026646;
	Fri, 10 Apr 2026 17:34:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg894qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 17:34:06 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63AHY4Jf40567132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 17:34:04 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EC7E58055;
	Fri, 10 Apr 2026 17:34:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED7BD5803F;
	Fri, 10 Apr 2026 17:33:59 +0000 (GMT)
Received: from [9.124.214.12] (unknown [9.124.214.12])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 17:33:59 +0000 (GMT)
Message-ID: <05c9a2c3-8077-4a1c-87f8-4e240ee1e5c4@linux.ibm.com>
Date: Fri, 10 Apr 2026 23:03:58 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KEYS: trusted: Debugging as a feature
To: Jarkko Sakinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc: Nayna Jain <nayna@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ahmad Fatoum
 <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260409160752.988713-1-jarkko@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <20260409160752.988713-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d9348f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=tDorxWB54CrSdUbKvnUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P81F6UpsKvBJQvCIils-FdvMCFHRncEU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2MiBTYWx0ZWRfX6A8Sfe9Ny/w9
 J+8Dm3Fd9jUweJWzBtu2+Cs595iEHjcbZT0hc3v2s7hXC5adi45+QxEZ94h7mlNdHw7s6KrX+ce
 TrVr9CMWTP/x/r/SQclzrUVNR/AdWtrmdZAjV9zO4xRV/gWlPckV33e+AtSwze+GDAMaZnlNKl/
 o8lxfFgtnJtwq+75tzXahJ6HvhfbVm5FR2NRC2FdWPyOc+3Ff0K9MkN5d2rnMJLzYaSWnzHGo/T
 A7gt/h38b6IFWaofmsfqg2f/pUbk+75MzkuXNDaZn8nXWR5UC0dlXO6CrOJqUreWPEC9DjluFxR
 D3gxxgP2FmtrBAAkLBFePi1ablyxpjPtkGf73l1hoOddiQwHfV/ytEBPcghk0L0V9UsTavEweEY
 RIb81v5ZUwgNiGIywrGVz+SXnmOD9PyP6GYSxGcvyZT5HxedUoii83B+GlOXYMTUSBBljCq5bFx
 pudRc6aVnbJmtStUxUA==
X-Proofpoint-GUID: P81F6UpsKvBJQvCIils-FdvMCFHRncEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100162
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9155-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 2B51F3DB177
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/9/26 9:37 PM, Jarkko Sakinen wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
>
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
>
> Cc: Srish Srinivasan <ssrish@linux.ibm.com>
> Reported-by: Nayna Jain <nayna@linux.ibm.com>
> Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>


Tested on PKWM and emulated TPM backends.

Tested-by: Srish Srinivasan <ssrish@linux.ibm.com>


> ---
> v3:
> - Add kernel-command line option for enabling the traces.
> - Add safety information to the Kconfig entry.
> v2:
> - Implement for all trusted keys backends.
> - Add HAVE_TRUSTED_KEYS_DEBUG as it is a good practice despite full
>    coverage.
> ---
>   include/keys/trusted-type.h               | 21 ++++++-----
>   security/keys/trusted-keys/Kconfig        | 23 ++++++++++++
>   security/keys/trusted-keys/trusted_caam.c |  7 ++--
>   security/keys/trusted-keys/trusted_core.c |  6 ++++
>   security/keys/trusted-keys/trusted_tpm1.c | 44 +++++++++++++----------
>   5 files changed, 71 insertions(+), 30 deletions(-)
>
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
> index 9e00482d886a..c1ae7db1f612 100644
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
> +	  Trusted keys backends and core code that support debug traces can
> +	  opt-in that feature here. Traces must only use debug level output, as
> +	  sensitive data may pass by. In the kernel-command line traces can be
> +	  enabled via trusted.dyndbg='+p'.
> +
> +	  SAFETY: Debug dumps are inactive at runtime until trusted.debug=1 is
> +	  set on the kernel command-line. Use at your utmost consideration when
> +	  enabling this feature on a production build. The general advice is not
> +	  to do this.
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
> index 9046123d94de..9ce2459d14b4 100644
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
> index c865c97aa1b4..b9fa2b4205cf 100644
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

