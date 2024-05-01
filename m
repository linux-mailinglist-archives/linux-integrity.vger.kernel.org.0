Return-Path: <linux-integrity+bounces-2301-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257A8B90E7
	for <lists+linux-integrity@lfdr.de>; Wed,  1 May 2024 22:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6691F23414
	for <lists+linux-integrity@lfdr.de>; Wed,  1 May 2024 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1147E29405;
	Wed,  1 May 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QNZFerJj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6C91649B3;
	Wed,  1 May 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596542; cv=none; b=X4eX3LNkaCZZMxBUkvyeljtSZWGQb9yo2j5gCYKD0zfAcGF9eEGHNxEz5e86Fxd6vnXXcL/gQzvitvLZwkxjmLpGxaeTxMJSEagGthtfONUxV/2RZAYgbUDc0urUon2tSGcox0EIWuLnsqnxAzbSqwsXTPyTdjg3bEZd8M44a50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596542; c=relaxed/simple;
	bh=vYVHQz7LVOJQ1l+1Q+luzrST3mctVW7Oe5+/FBr/4Bo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=XEl4gcdEIh3s+cqJYFVBlwBaHtts2drIlD4Y0bOhQLHOwQOV7luUZU0gEuawv618vIW8Zrpt1x4AeGz/lsKEetLXuoUdte5kNHf4/eG5M94+IrMWiqj/OvAH3v7JI6Bo6NQeZk3opej4LjFdV1eV95g23TqsIeRmgVsN3S1Ylzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QNZFerJj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441KmbDI028505;
	Wed, 1 May 2024 20:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=QQ7kkJ18hLQjxGVphtNo3xqJXIC2fHGWJ+5viySu6a8=;
 b=QNZFerJjpCAsFiptZPMgxn0nhldnZ0Fdx2IUNIzBE6Ts7RnIUjChzUSRU24JodcZN+yW
 zAwRJg0OzfTDBX54gEZYt76kxQHCcdathx8oGLsS8BiFdLh8FM771jrkYKYmsGH4TiJw
 sG5uZPBOvQhB0nNu45N4l0VYNkyKFa9QQ6dQCYkmUynZUPVxrzy9/HNgCIajV2Vxm/pq
 F6dJBe1xR+UU7fSMuHDxfL09OSOufz5H4jblrzIfDX2VLTIHZmJ8Vu3GvNCZN+T4oshN
 ah9UZffqK3pBCZnniPE14aL5PIlMDAScyVMVd9emWdIm7EAG2cxR8kpi648et5E9A/Zu kA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xuw3b0013-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 20:48:37 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 441Kmagg028442;
	Wed, 1 May 2024 20:48:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xuw3b000y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 20:48:36 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 441KBB0f022182;
	Wed, 1 May 2024 20:48:36 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsd6mvc8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 20:48:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 441KmXu226739314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 May 2024 20:48:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72B6B58067;
	Wed,  1 May 2024 20:48:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9D9E5805D;
	Wed,  1 May 2024 20:48:32 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.157.98])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 May 2024 20:48:32 +0000 (GMT)
Message-ID: <870ebd4d7a8789bfe55056635dcf9a308d5b0e40.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: Avoid blocking in RCU read-side critical section
From: Mimi Zohar <zohar@linux.ibm.com>
To: GUO Zihua <guozihua@huawei.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com
Cc: eric.snowberg@oracle.com, omosnace@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Date: Wed, 01 May 2024 16:48:32 -0400
In-Reply-To: <20240428091045.85513-1-guozihua@huawei.com>
References: <20240428091045.85513-1-guozihua@huawei.com>
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
X-Proofpoint-ORIG-GUID: vrxnrgS6T-qfqoiMTwXTomeJelVhDgCk
X-Proofpoint-GUID: Kr6kmf2CJN_S6B2kIKRb4sSB9zVJ4c5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2405010147

Hi Scott,

On Sun, 2024-04-28 at 09:10 +0000, GUO Zihua wrote:
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index c0556907c2e6..216ffe388ce5 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -410,7 +410,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>          * Immutable elements are copied over as pointers and data; only
>          * lsm rules can change
>          */
> -       nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
> +       nentry = kmemdup(entry, sizeof(*nentry), GFP_ATOMIC);
>         if (!nentry)
>                 return NULL;
>  
> @@ -425,7 +425,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  
>                 ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>                                      nentry->lsm[i].args_p,
> -                                    &nentry->lsm[i].rule);
> +                                    &nentry->lsm[i].rule,
> +                                    GFP_ATOMIC);
>                 if (!nentry->lsm[i].rule)
>                         pr_warn("rule for LSM \'%s\' is undefined\n",
>                                 nentry->lsm[i].args_p);

If only the call to ima_lsm_copy_rule() in ima_match_rules() needs to be
GFP_ATOMIC, then pass the gfp type.

thanks,

Mimi


> @@ -1140,7 +1141,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>         entry->lsm[lsm_rule].type = audit_type;
>         result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
>                                       entry->lsm[lsm_rule].args_p,
> -                                     &entry->lsm[lsm_rule].rule);
> +                                     &entry->lsm[lsm_rule].rule,
> +                                     GFP_KERNEL);
>         if (!entry->lsm[lsm_rule].rule) {
>                 pr_warn("rule for LSM \'%s\' is undefined\n",
>                         entry->lsm[lsm_rule].args_p);


