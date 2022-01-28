Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2271549FB30
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jan 2022 15:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245739AbiA1ODk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jan 2022 09:03:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238986AbiA1ODj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jan 2022 09:03:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SD6HZR030935;
        Fri, 28 Jan 2022 14:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : in-reply-to : references : content-type : mime-version :
 date : content-transfer-encoding; s=pp1;
 bh=lzD27m9tVyI10xVC7XyEDLr4pq/3o3FXlGhpDw5JHt4=;
 b=HZtpc9J2CwrhFbMwHr4txaUKABbsXwBVetQXLt0kCqvBH+bwQqO2BxIBBYLVh3o5CvyV
 Gmo+FXYIC8InNyzTHamLOqtJK/B0avs3hvUoM85/r6bJ+QkXH+staoOoPhhUboyjKA5w
 QsApBtuDCYw9p+iHzA2lfuYwbo0+FYeIK3FIm+TKRDDV3eBNr0TNajnO41MlZ13BlmyV
 j1+bqSRKrJWnpMJ1vJRKPbV/QBp6VouPsMeg3dpv0sO0Undh480OJ4FQXyy5XjM14GSI
 cq4bEUImHeVNzxnQymSvFYgtuEPRyi3Lb10PcpY2wDsERqhWj3k36IBsLD4gva7UOHE0 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dvgqwhf22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 14:03:15 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20SD9qNT015365;
        Fri, 28 Jan 2022 14:03:14 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dvgqwheyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 14:03:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20SE0ekU016233;
        Fri, 28 Jan 2022 14:03:11 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3dr96ka38j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 14:03:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20SE382Q35979684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 14:03:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0625A5204E;
        Fri, 28 Jan 2022 14:03:08 +0000 (GMT)
Received: from sig-9-65-83-59.ibm.com (unknown [9.65.83.59])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 57B305206B;
        Fri, 28 Jan 2022 14:03:05 +0000 (GMT)
Message-ID: <258c7c5e1aebfc9376560549794d43e744654713.camel@linux.ibm.com>
Subject: Re: [PATCH v9 16/23] ima: Implement ima_free_policy_rules() for
 freeing of an ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220125224645.79319-17-stefanb@linux.vnet.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
         <20220125224645.79319-17-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Date:   Fri, 28 Jan 2022 09:02:23 -0500
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Xzjbnohdiwo_aRI8Gc6kV7Yr2shG8kIu
X-Proofpoint-GUID: f8tz81gN8LY9ADPXjR3bdBEWWTE-OFYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Tue, 2022-01-25 at 17:46 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Implement ima_free_policy_rules() that is needed when an ima_namespace
> is freed.
> 
> Only reset temp_ima_appraise when using init_ima_ns.

Instead of having to walk the policy rules to know if there are any
"appraise" rules, the ima_appraise flag is set.  For now, only reset
temp_ima_appraise flag on failed policy rule updates for init_ima_ns.

> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
>  v9:
>   - Only reset temp_ima_appraise when using init_ima_ns.
> ---
>  security/integrity/ima/ima.h        |  1 +
>  security/integrity/ima/ima_policy.c | 20 +++++++++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index aea8fb8d2854..8c757223d549 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -329,6 +329,7 @@ void ima_update_policy_flags(struct ima_namespace *ns);
>  ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
>  void ima_delete_rules(struct ima_namespace *ns);
>  int ima_check_policy(struct ima_namespace *ns);
> +void ima_free_policy_rules(struct ima_namespace *ns);
>  void *ima_policy_start(struct seq_file *m, loff_t *pos);
>  void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
>  void ima_policy_stop(struct seq_file *m, void *v);
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e8140e73d80b..47f2d1b5d156 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1880,13 +1880,31 @@ void ima_delete_rules(struct ima_namespace *ns)
>  {
>  	struct ima_rule_entry *entry, *tmp;
>  
> -	temp_ima_appraise = 0;
> +	if (ns == &init_ima_ns)
> +		temp_ima_appraise = 0;
> +
>  	list_for_each_entry_safe(entry, tmp, &ns->ima_temp_rules, list) {
>  		list_del(&entry->list);
>  		ima_free_rule(entry);
>  	}
>  }
>  
> +/**
> + * ima_free_policy_rules - free all policy rules
> + * @ns: IMA namespace that has the policy
> + */
> +void ima_free_policy_rules(struct ima_namespace *ns)
> +{
> +	struct ima_rule_entry *entry, *tmp;
> +
> +	ima_delete_rules(ns);

When the IMA policy is being extended, new rules are temporarily added
to the ima_temp_rules list.  If the entire set of rules being added are
valid, they're appended to the tail.

There shouldn't be any rules on the ima_temp_rules list unless the
policy is currently being extended.  Is that possible at this point?

> +
> +	list_for_each_entry_safe(entry, tmp, &ns->ima_policy_rules, list) {
> +		list_del(&entry->list);
> +		ima_free_rule(entry);
> +	}
> +}
> +
>  #define __ima_hook_stringify(func, str)	(#func),
>  
>  const char *const func_tokens[] = {

thanks,

Mimi

