Return-Path: <linux-integrity+bounces-8955-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLxyCCJOr2noTgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8955-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Mar 2026 23:48:02 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6145F242594
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Mar 2026 23:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FBFF30B5DFC
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Mar 2026 22:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B87F34D934;
	Mon,  9 Mar 2026 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E/hizLf4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D434F479;
	Mon,  9 Mar 2026 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096332; cv=none; b=qZ4V0grWd5haRdxtUIu6P88PQaIXUjRhG0ZI5ev5BJCHsdplwOlG2MN5djDkQ7Iv7dWUe60LQypG7+B6uojXzSvfqgvPobDN/bVBxZawd4qTlkFCPYAaTSWLH5orUlwk/KX7k3wJKlhme2q8NWB3cnwIzWaBHN2o/X8adajzwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096332; c=relaxed/simple;
	bh=qKGKR1AgrfGqCWEJlLl+KoYVEWkdjla5/URAnXt4mRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPpRnb8Ed3Na2kYI2LIN2ipB0/x43OTW9osO8wqVnyhedER3ml9vMD8xNqnqs88ONZyYtprKgGWWICFHVpyqjqCF4/0CaTD0u3Mwc8qyHx9ATYlw7MQVlPWlUoAw9Z1emAatAQZeDGoVVbUocKDjY0X0Ix4V2/6rk1zT4vQZWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E/hizLf4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629FSi3q1528364;
	Mon, 9 Mar 2026 22:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kE/tVo
	HduQxrRZs1u6XyeOfuv9zJsp0GANrS8sktR54=; b=E/hizLf4vQqHqgNr1mV+me
	uMRIgCHj/z6GffHBQ18BVdtLXoigpJoBjCLM4Q0Nwk4acWVGRQ0lFIaeSvSwlsti
	eFR6PVuCeMCAA0mjvCcjo+Xe0Skkz0+u+pSisZA7dIqsDl4Nzg7ELCghIe1PDXsg
	OyULc25tI+JGp24+KglG6+ZtdnwpaQv6YetzrwvfI3WrfQIFXOxhA0+dXhaqRvsk
	FgLe0IL/3chgjFn0wWdUZrV0pRnVfdWq7uJ77Fue/o4LBnP0WBBdU6cL63hjUVh/
	a/akHPgXnGiMy/mKV+UWSRY0LjbxBnyrXR5mXWxI5tAbGOqPFt5IjvqkNnKBkcwQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm8ps7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 22:45:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629IeLW6009091;
	Mon, 9 Mar 2026 22:45:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crxqy6wk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 22:45:26 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629MjPh225494180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 22:45:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A21B58056;
	Mon,  9 Mar 2026 22:45:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 869CE5803F;
	Mon,  9 Mar 2026 22:45:24 +0000 (GMT)
Received: from [9.61.90.19] (unknown [9.61.90.19])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 22:45:24 +0000 (GMT)
Message-ID: <7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com>
Date: Mon, 9 Mar 2026 18:45:23 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] keys/trusted_keys: clean up debug message logging
 in the tpm backend
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260220183426.80446-1-ssrish@linux.ibm.com>
 <20260220183426.80446-2-ssrish@linux.ibm.com>
Content-Language: en-US
From: Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <20260220183426.80446-2-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cSZH333F3690PREVwHuAQ6EFZ8DyS2bf
X-Proofpoint-ORIG-GUID: cSZH333F3690PREVwHuAQ6EFZ8DyS2bf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIwMCBTYWx0ZWRfX9kJhZH0PidBg
 Fswj8VPS/8aM3y/SGmEjEdDnnrfBwMF/tjNtYLxA/XeG3KUkQf3PHySfHVnR3+Mjgb3uYhq8Fq0
 FXxgM7BandAcfiC8HDebSbkqY/EHzGX3qqG1GQh+BRIRLvLYedQI0iqLthb+yWhqhlfYrDvcOF8
 CeWwh4GbT9P2rosngehLpIpIceJmcJ3B/Zo+aGN2XSKR3vz/OLzy7xOOU8MtMAxgFq4yegEd3e9
 z0zFqcgfq4DASRIUu+CGpUcLU+adNpkOEgzzmUzJer6hTnDT4OEHUgcGZKFhRrUirDQ740t5vC+
 JaU0F99oJWR4wrfPyBC3zZEpxrwfq3uy4VWHZPHU4J8NT+1gT3az2rHdaEaIm3l1iSVN91b9yHH
 LPuvf61QHOzqO5WFRDQd3NVP5oRhXS5qHcsjRk07YZDrfJEDPSucrh92BVctVsqJa1ttJ5DwY4a
 hCl9ueUPw05KMFX7enQ==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69af4d87 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=xuhc9tRqGfZKXBDnGkgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090200
X-Rspamd-Queue-Id: 6145F242594
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8955-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-integrity];
	FROM_NEQ_ENVFROM(0.00)[nayna@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action


On 2/20/26 1:34 PM, Srish Srinivasan wrote:
> The TPM trusted-keys backend uses a local TPM_DEBUG guard and pr_info()
> for logging debug information.
>
> Replace pr_info() with pr_debug(), and use KERN_DEBUG for print_hex_dump().
> Remove TPM_DEBUG.
>
> No functional change intended.
There is functional change here.  This change allows secret and nonce in 
the function dump_sess() to be logged to kernel logs when dynamic debug 
is enabled. Previously, it was possible only in the debug builds and not 
the production builds at runtime. With this change, it is always there 
in production build. This can result in possible attack.

Instead of doing this change, I think add a comment to prevent this sort 
of change in the future.

Thanks & Regards,

     - Nayna

>
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   security/keys/trusted-keys/trusted_tpm1.c | 40 +++++++----------------
>   1 file changed, 12 insertions(+), 28 deletions(-)
>
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index c865c97aa1b4..216caef97ffc 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -46,28 +46,25 @@ enum {
>   	SRK_keytype = 4
>   };
>   
> -#define TPM_DEBUG 0
> -
> -#if TPM_DEBUG
>   static inline void dump_options(struct trusted_key_options *o)
>   {
> -	pr_info("sealing key type %d\n", o->keytype);
> -	pr_info("sealing key handle %0X\n", o->keyhandle);
> -	pr_info("pcrlock %d\n", o->pcrlock);
> -	pr_info("pcrinfo %d\n", o->pcrinfo_len);
> -	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
> +	pr_debug("sealing key type %d\n", o->keytype);
> +	pr_debug("sealing key handle %0X\n", o->keyhandle);
> +	pr_debug("pcrlock %d\n", o->pcrlock);
> +	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
> +	print_hex_dump(KERN_DEBUG, "pcrinfo ", DUMP_PREFIX_NONE,
>   		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
>   }
>   
>   static inline void dump_sess(struct osapsess *s)
>   {
> -	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
> +	print_hex_dump(KERN_DEBUG, "trusted-key: handle ", DUMP_PREFIX_NONE,
>   		       16, 1, &s->handle, 4, 0);
> -	pr_info("secret:\n");
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> +	pr_debug("secret:\n");
> +	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
>   		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
> -	pr_info("trusted-key: enonce:\n");
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> +	pr_debug("trusted-key: enonce:\n");
> +	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
>   		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
>   }
>   
> @@ -75,23 +72,10 @@ static inline void dump_tpm_buf(unsigned char *buf)
>   {
>   	int len;
>   
> -	pr_info("\ntpm buffer\n");
> +	pr_debug("\ntpm buffer\n");
>   	len = LOAD32(buf, TPM_SIZE_OFFSET);
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
> -}
> -#else
> -static inline void dump_options(struct trusted_key_options *o)
> -{
> -}
> -
> -static inline void dump_sess(struct osapsess *s)
> -{
> -}
> -
> -static inline void dump_tpm_buf(unsigned char *buf)
> -{
> +	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
>   }
> -#endif
>   
>   static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
>   		       unsigned int keylen, ...)

