Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F012424781
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Oct 2021 21:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbhJFTwB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Oct 2021 15:52:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47504 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229810AbhJFTwA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Oct 2021 15:52:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196IVXSL030685;
        Wed, 6 Oct 2021 15:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=L8prqtAD4A3iwQ8CC0mAy/CKO4HDayjvd6cvLXJwJn0=;
 b=X16iPw/Wq3DiwfUlhvfiM+Ba0BSPjmMKNeaezS7Irf+wkGl29snCBbQMZwnv0v6UiX2X
 sxQLE8zvNFXG5OxxHhDthX/mnZ1pxm7ucnVGe/t3VCKvkHaZ4tYhEcCFxwANGx2EFcOn
 yOUII4o569N25GfZRChAMALGDIYEAOGVwapNxNpeNV0D53h3uvCPiVy5+8M4240SgkG+
 A446yd3RtYWHpGpSOzJDz0akAdIsX/snwBaLorXTQdNVkQwS9JJ2GbIzDBoviEAhkOWP
 hUAywZwI4q7d9YLyL0dlSyB+PAvH74TQqyI24W6h3hI3Fhe8kOvH+ZMdzP0jmUd+XGVp hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bh38bdeat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 15:50:06 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 196JJSVO020152;
        Wed, 6 Oct 2021 15:50:05 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bh38bdea4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 15:50:05 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 196Jgrbu009018;
        Wed, 6 Oct 2021 19:50:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3bef2b92j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 19:50:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 196Jo1UU46596488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Oct 2021 19:50:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53699A404D;
        Wed,  6 Oct 2021 19:50:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 030A0A4051;
        Wed,  6 Oct 2021 19:50:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.15.60])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Oct 2021 19:49:59 +0000 (GMT)
Message-ID: <81863154aebf9d3e023bd37acca8ff265a187fd0.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: add gid support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Alex Henrie <alexh@vpitech.com>, linux-integrity@vger.kernel.org,
        pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Curtis Veit <veit@vpieng.com>
Date:   Wed, 06 Oct 2021 15:49:58 -0400
In-Reply-To: <20211005003237.501882-1-alexh@vpitech.com>
References: <20211005003237.501882-1-alexh@vpitech.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zhCraBuE3CLlswVuNxnXXZ4XMiuq-ZpE
X-Proofpoint-GUID: QLdeyXbIjJxF_yH9xZJrxl8GwfrtTu6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060121
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alex,

On Mon, 2021-10-04 at 18:32 -0600, Alex Henrie wrote:
> From: Curtis Veit <veit@vpieng.com>
> 
> IMA currently supports the concept of rules based on uid where the rule
> is based on the uid of the file owner or the uid of the user accessing
> the file. It is useful to have similar rules based on gid. This patch
> provides that ability.
> 
> Signed-off-by: Curtis Veit <veit@vpieng.com>
> Co-developed-by: Alex Henrie <alexh@vpitech.com>
> Signed-off-by: Alex Henrie <alexh@vpitech.com>
> ---
> v2: Trivial changes that Mimi requested

Sorry, scripts/check-patch.pl reported some warnings.  Two more trivial changes.

> ---
>  Documentation/ABI/testing/ima_policy |   8 +-
>  security/integrity/ima/ima_policy.c  | 201 +++++++++++++++++++++++----
>  2 files changed, 180 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 5c2798534950..e1a04bd3b9e5 100644
> --- a/Documentation/ABI/testing/ima_policy

> @@ -78,9 +81,13 @@ struct ima_rule_entry {
>  	unsigned long fsmagic;
>  	uuid_t fsuuid;
>  	kuid_t uid;
> +	kgid_t gid;
>  	kuid_t fowner;
> +	kgid_t fgroup;
>  	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
> +	bool (*gid_op)(kgid_t, kgid_t);
>  	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
> +	bool (*fgroup_op)(kgid_t, kgid_t); /* gid_eq(), gid_gt(), gid_lt() */

scripts/checkpatch.pl complains about missing variables.

>  	int pcr;
>  	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
>  	struct {
> 
> @@ -582,10 +590,23 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  		} else if (!rule->uid_op(cred->euid, rule->uid))
>  			return false;
>  	}
> -
> +	if ((rule->flags & IMA_GID) && !rule->gid_op(rule->gid, cred->gid))

All of uid_op/gid_op calls in ima_match_rules() pass the "cred->xxxx,
rule->xxx" except here, where it is rule->gid, cred->rule.   Reversing
the parameters here will help with addressing the checkpatch.pl
warning.

thanks,

Mimi

