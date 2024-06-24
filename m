Return-Path: <linux-integrity+bounces-2922-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6879D914F5E
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 15:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174E3280CDB
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 13:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A208142621;
	Mon, 24 Jun 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ymarozn8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E81411C8;
	Mon, 24 Jun 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237527; cv=none; b=dWaPjqJ851dlMVvsk/TkOJdikzqo5bc5Zr/kLi+bADYcdxFdBujTdvQxWyF+v7FAa5c1T953vpCia8p3qaeLc/Lome5FQzeIYFCguoKCFRTYN+iBNYkQw5J+3wBa0JbVS4nqjudkJxeJAv7s6OY9kePS+AuPAOpOZmwA9HHpxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237527; c=relaxed/simple;
	bh=k7EsiwWu48lSPxdtRUnfEfHrKfVYjJpHJkgnJCKpzRk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=WHMSxcV0mgzslYbP/A+UEbQQzgT0zo3EIkogM95FySemgE6m3lSPdAQjH7BLvY5hX6YCoYMOIVOAB27OmetqQHpRyjaiVpHsP0QFuqxg5AahyLdzSh+cpy1QxzpjjsfLHujq+0f8Q7fK/M3upD+X/vZ4a9qFRk8S6SDN/yHguDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ymarozn8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ODupIT007124;
	Mon, 24 Jun 2024 13:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	CTZ4e0joJnVTwvbvvdwwYY7VAB9lj9okhi94KejEzBE=; b=Ymarozn8UhBR820r
	Z5P34tcHLyH+W3cUGLkQ5h7tLOPJ/aSldtF7uouktOuJxwli+QDxosT37nDBOQVy
	1B2ZxTW+eYYLVcrEI7PP0tzBKrhg0NvRH5Klx+wSK0/SQbUuh04XEMgSS8LEfOsH
	XauZ5xtJwFxxJKWzRPi7jaDQm+4IAX7uPUNd5bjPeFfOGw359wC5J7ay64r0MnxM
	OE+0xWsMKJUkWbSCZzKNnSo3Sf6ZXn3CA7vnJpoO9qAI70P6S8Agi/a+zMjUcVd7
	/3Jr+nJ1YC96O9P4afs91u7cL+zfsadvjS/WTbuhs6UXSM9anzMluPg6HR+jLQ/r
	I7OGEQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy7ha8fkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 13:58:33 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45ODwWwH010864;
	Mon, 24 Jun 2024 13:58:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy7ha8fkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 13:58:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45ODpkLr019949;
	Mon, 24 Jun 2024 13:58:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxb5m8tak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 13:58:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45ODwT8Y14680726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 13:58:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 349C958065;
	Mon, 24 Jun 2024 13:58:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B76E58043;
	Mon, 24 Jun 2024 13:58:28 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.65.213])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 13:58:27 +0000 (GMT)
Message-ID: <bef69e74a011c8d4d084e9a60d3030a89402fcc3.camel@linux.ibm.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from
 security_audit_rule
From: Mimi Zohar <zohar@linux.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        mic@digikod.net, linux-integrity@vger.kernel.org
Date: Mon, 24 Jun 2024 09:58:27 -0400
In-Reply-To: <20231215221636.105680-2-casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
	 <20231215221636.105680-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lSd7AER_bEcm5DxB6kSlN5Ky-UmGMBJ_
X-Proofpoint-ORIG-GUID: FgFfHrbx6Pod-atijOQ6GxA0zE0m4V_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_10,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240111

On Fri, 2023-12-15 at 14:15 -0800, Casey Schaufler wrote:
> Create real functions for the ima_filter_rule interfaces.
> These replace #defines that obscure the reuse of audit
> interfaces. The new functions are put in security.c because
> they use security module registered hooks that we don't
> want exported.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> Cc: linux-integrity@vger.kernel.org
> ---
>  include/linux/security.h     | 24 ++++++++++++++++++++++++
>  security/integrity/ima/ima.h | 26 --------------------------
>  security/security.c          | 21 +++++++++++++++++++++
>  3 files changed, 45 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 750130a7b9dd..4790508818ee 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2009,6 +2009,30 @@ static inline void security_audit_rule_free(void *lsmrule)
>  #endif /* CONFIG_SECURITY */
>  #endif /* CONFIG_AUDIT */
>  
> +#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> +void ima_filter_rule_free(void *lsmrule);
> +
> +#else
> +
> +static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> +					   void **lsmrule)
> +{
> +	return 0;
> +}
> +
> +static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> +					    void *lsmrule)
> +{
> +	return 0;
> +}
> +

scripts/checkpatch.pl complains about the formatting of "void *lsmrule".


> +static inline void ima_filter_rule_free(void *lsmrule)
> +{ }
> +
> +#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
> +
>  #ifdef CONFIG_SECURITYFS
>  
>  extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..560d6104de72 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -420,32 +420,6 @@ static inline void ima_free_modsig(struct modsig *modsig)
>  }
>  #endif /* CONFIG_IMA_APPRAISE_MODSIG */
>  
> -/* LSM based policy rules require audit */
> -#ifdef CONFIG_IMA_LSM_RULES
> -
> -#define ima_filter_rule_init security_audit_rule_init
> -#define ima_filter_rule_free security_audit_rule_free
> -#define ima_filter_rule_match security_audit_rule_match
> -
> -#else
> -
> -static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> -				       void **lsmrule)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline void ima_filter_rule_free(void *lsmrule)
> -{
> -}
> -
> -static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> -					void *lsmrule)
> -{
> -	return -EINVAL;
> -}
> -#endif /* CONFIG_IMA_LSM_RULES */
> -
>  #ifdef	CONFIG_IMA_READ_POLICY
>  #define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
>  #else
> diff --git a/security/security.c b/security/security.c
> index d7b15ea67c3f..8e5379a76369 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5350,6 +5350,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
>  }
>  #endif /* CONFIG_AUDIT */
>  
> +#ifdef CONFIG_IMA_LSM_RULES
> +/*
> + * The integrity subsystem uses the same hooks as
> + * the audit subsystem.

- No reason for the comment to be split.
- Please note that these calls are limited to IMA, not the integrity subsystem
in general.

> + */
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
> +{
> +	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> +}
> +
> +void ima_filter_rule_free(void *lsmrule)
> +{
> +	call_void_hook(audit_rule_free, lsmrule);
> +}
> +
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +{
> +	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +}
> +#endif /* CONFIG_IMA_LSM_RULES */

In terms of function naming, refer to thread with Roberto's response.

> +
>  #ifdef CONFIG_BPF_SYSCALL
>  /**
>   * security_bpf() - Check if the bpf syscall operation is allowed


