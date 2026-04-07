Return-Path: <linux-integrity+bounces-9133-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB1rDhVv1Gn6twcAu9opvQ
	(envelope-from <linux-integrity+bounces-9133-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Apr 2026 04:42:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB583A92BA
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Apr 2026 04:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A17930069AA
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Apr 2026 02:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB1837267C;
	Tue,  7 Apr 2026 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ShToX8ul"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5FA34E779;
	Tue,  7 Apr 2026 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775529743; cv=none; b=TugmwKxMMLSrvkmW1dxB0HbQEVDEvK+qbHhLVWLQPH3J1CH/Si4Hmubsjew20lIGF2gxCqpUZK/ZlbLIuY3ol+pT0aLeRPVP92YDL6lySmHofmfWj3I0ZCCV4sX3eqgzpVUzS21ZqTnWZMrGVCbBROhBZKkDWQdt3veQtdNMtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775529743; c=relaxed/simple;
	bh=hD7ny2UtURDWAaGQWwY50Eq44SALrFdnbjtoJ7AO95A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0fcoD8DwFQ4uPqYqr9JDB3lhKv5NpTu50inS4geytLLS/lj9XmQe4oBGEhMUNc/dWayRzCF/VGLJGLJdoZ6hDI+2sAxVWwywUq5UBJssi5YbI8gtHBdl+vGKE6df8IC0DiRRvvVCgyvvQBxIAV5ARKdnRj/pDeVz5p/2phOe84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ShToX8ul; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmWOm2302659;
	Tue, 7 Apr 2026 02:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SjZSuM
	MSH7KpHIfjsafQiM652H97zB0x6jfHu2syyu4=; b=ShToX8ulucyElHd1M9VsEk
	y5R6q8gi/gnUcC/e4NQEMsC/+INQLkteeycVnUzdiX6OwrgdQQI4pkQTOQDhb2Ng
	Dg8bjcfkeICwDkd7gk3Nmt0d+2OtAXsgFVM9iCjM5bPlhdggmdTWVajrNy301cgw
	rnQAeEKX+OhUfeW7LKY80k8lncklde/tUfm6B79eS//DMT5teq1zuQqadmwuG7Ba
	lIvz8mlifNNvwJr6Q3qCZ9fFdxUquocGjYWeQY6IjR9uxznjsvvKoF6RD+heCkwF
	1yo603R9VQFmlPDc/GhXBbCMxEQuJ2L8GQ2g50uI4E/ru6KXx9N/9nS1e4+UOBAQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2f8rde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 02:42:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636L8t4c026655;
	Tue, 7 Apr 2026 02:42:03 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7rsev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 02:42:03 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6372g1cK21299802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 02:42:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C38BD5806E;
	Tue,  7 Apr 2026 02:42:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 238F758078;
	Tue,  7 Apr 2026 02:42:01 +0000 (GMT)
Received: from [9.61.12.143] (unknown [9.61.12.143])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 02:42:01 +0000 (GMT)
Message-ID: <afc489d2-a62f-4604-8e56-219311b46516@linux.ibm.com>
Date: Mon, 6 Apr 2026 22:42:00 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KEYS: trusted: Debugging as a feature
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Srish Srinivasan <ssrish@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ahmad Fatoum
 <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
References: <20260324110043.67248-1-jarkko@kernel.org>
Content-Language: en-US
From: Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <20260324110043.67248-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyMCBTYWx0ZWRfX8aXmQrBQcTzg
 7i9Y1K3k1OL3Q28XWfljbac938IMGnfJvIPdgZmzHAJZfdVQFTLedQun/N9MgrDCESgmdxCWQ5+
 l0gLBFcq1jXxJ7xGx3bVlVvHMh3g4vI/ri6Z1BgDa3b8HxYkpOo33BLp56NJ6qR6g7dtoocfBLI
 XKdNL2Fxp1z6sAtd5Jf9/uYU2bGMjHTwvs7ODC9x2FOTvEO8u3pFIWOcXULIjgKFzCiZ0JdRyAt
 ifQM/B9j7i6yuw0A5aLT3225Ml1q5Yx0Z4mWn/GdavcYDbxDFNITAigkInBuJvCr7k9ox+udgEJ
 BFz9yLtgetNHLhlwzio0fAAVC1nrzTWBtDicoPILFmnWjI/RCGjcJ5VX/wkmfkByF9ebqjnUnJB
 NkE1JrMFs0HWtVNw7L0oGQDK7E48zEQ2hroMmTcSEFVjMsxD9pE5gc45ixKJagsj8xkezBNE0P4
 cL6JvUK+ME/TWsewM3w==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d46efc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=RvNJM_tC9QKxUJJT61sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ou-HjR_-LKL2lQukpjvvCC7pbCNSvzOy
X-Proofpoint-GUID: Ou-HjR_-LKL2lQukpjvvCC7pbCNSvzOy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070020
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9133-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nayna@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3CB583A92BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 7:00 AM, Jarkko Sakkinen wrote:
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

Would it be good idea to add an explicit note/warning:


NOTE: This option is intended for debugging purposes only. Do not enable 
on production systems as debug output may expose sensitive cryptographic 
material.
If you are unsure, say N.

Apart from this, looks good to me.

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>


