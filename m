Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0084E2E2718
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Dec 2020 14:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgLXNHQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Dec 2020 08:07:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727946AbgLXNHQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Dec 2020 08:07:16 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BOD2WkL134699;
        Thu, 24 Dec 2020 08:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KFF6x3KFSu0w+hWXZvFxS9K582o3/n8xLLQKZzBDEOk=;
 b=PNkCX84goiER9nDt4AzAMHnuqkC0afNbn2R5O7P773GPqM3MhZ7GFyBhm1Txsto6NTso
 v/yy++4HIo8Hc3BpTaFT6LnYeZTd8CWskJ+Qlf9be6U4q2i9/Et563RzCidFACwGn0E9
 eaI7E45OySd4NR3WR2iF+xN2/A8oS0TQOaHtZYHQoZQ9+ZPKRzHTddyZFr2tA4Z5lOS/
 Js8VhrgCgJUoFgjPMpEPoLi1HgCbIeAANPCPimKOeJzHj4lrKpj8bbX4pICTih6v3wab
 LJBsQW35r5aD/DLfq9N8G3tQpGtlc06n1Z6S8vN3HqWEl5Yf5Xj7FFdR7DDUCfWzAMgW OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35mtdk9enk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 08:06:31 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BOD3D5H137112;
        Thu, 24 Dec 2020 08:06:31 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35mtdk9emr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 08:06:31 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BOD27lf022354;
        Thu, 24 Dec 2020 13:06:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 35kwqkhb2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 13:06:28 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BOD6PfE24052042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Dec 2020 13:06:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B9E911C050;
        Thu, 24 Dec 2020 13:06:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E099111C04A;
        Thu, 24 Dec 2020 13:06:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.1.132])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Dec 2020 13:06:23 +0000 (GMT)
Message-ID: <acec2f96b5fa5ae8fb0e12e76f508cf6e7f7ec97.camel@linux.ibm.com>
Subject: Re: [PATCH v9 1/8] IMA: generalize keyring specific measurement
 constructs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Thu, 24 Dec 2020 08:06:22 -0500
In-Reply-To: <20201212180251.9943-2-tusharsu@linux.microsoft.com>
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
         <20201212180251.9943-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-24_08:2020-12-24,2020-12-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012240079
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-12-12 at 10:02 -0800, Tushar Sugandhi wrote:
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 68956e884403..e76ef4bfd0f4 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -786,13 +786,13 @@ int ima_post_load_data(char *buf, loff_t size,
>   * @eventname: event name to be used for the buffer entry.
>   * @func: IMA hook
>   * @pcr: pcr to extend the measurement
> - * @keyring: keyring name to determine the action to be performed
> + * @func_data: private data specific to @func, can be NULL.

This can be simplified to "func specific data, may be NULL".   Please
update in all places.

>   *
>   * Based on policy, the buffer is measured into the ima log.
>   */
>  void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  				const char *eventname, enum ima_hooks func,
> -				int pcr, const char *keyring)
> +				int pcr, const char *func_data)
>  {
>  	int ret = 0;
>  	const char *audit_cause = "ENOMEM";
> @@ -831,7 +831,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  	if (func) {
>  		security_task_getsecid(current, &secid);
>  		action = ima_get_action(inode, current_cred(), secid, 0, func,
> -					&pcr, &template, keyring);
> +					&pcr, &template, func_data);
>  		if (!(action & IMA_MEASURE))
>  			return;
>  	}
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 823a0c1379cb..a09d1a41a290 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -453,30 +453,41 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>  }
>  
>  /**
> - * ima_match_keyring - determine whether the keyring matches the measure rule
> - * @rule: a pointer to a rule
> - * @keyring: name of the keyring to match against the measure rule
> + * ima_match_rule_data - determine whether the given func_data matches
> + *			 the measure rule data

After the function_name is a brief description of the function, which
should not span multiple lines.  Refer to Documentation/doc-
guide/kernel-doc.rst for details. 

Please trim the function description to:
determine whether func_data matches the policy rule

> + * @rule: IMA policy rule

This patch should be limited to renaming "keyring" to "func_data".   It
shouldn't make other changes, even simple ones like this.

> + * @func_data: data to match against the measure rule data
>   * @cred: a pointer to a credentials structure for user validation
>   *
> - * Returns true if keyring matches one in the rule, false otherwise.
> + * Returns true if func_data matches one in the rule, false otherwise.
>   */
> -static bool ima_match_keyring(struct ima_rule_entry *rule,
> -			      const char *keyring, const struct cred *cred)
> +static bool ima_match_rule_data(struct ima_rule_entry *rule,
> +				const char *func_data,
> +				const struct cred *cred)
>  {
> +	const struct ima_rule_opt_list *opt_list = NULL;
>  	bool matched = false;
>  	size_t i;
>  
>  	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
>  		return false;
>  
> -	if (!rule->keyrings)
> -		return true;
> +	switch (rule->func) {
> +	case KEY_CHECK:
> +		if (!rule->keyrings)
> +			return true;
> +
> +		opt_list = rule->keyrings;
> +		break;
> +	default:
> +		return false;
> +	}
>  
> -	if (!keyring)
> +	if (!func_data)
>  		return false;
>  
> -	for (i = 0; i < rule->keyrings->count; i++) {
> -		if (!strcmp(rule->keyrings->items[i], keyring)) {
> +	for (i = 0; i < opt_list->count; i++) {
> +		if (!strcmp(opt_list->items[i], func_data)) {
>  			matched = true;
>  			break;
>  		}
> @@ -493,20 +504,20 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
>   * @secid: the secid of the task to be validated
>   * @func: LIM hook identifier
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
> - * @keyring: keyring name to check in policy for KEY_CHECK func
> + * @func_data: private data specific to @func, can be NULL.

Update as previously suggested.

>   *
>   * Returns true on rule match, false on failure.
>   */
>  static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  			    const struct cred *cred, u32 secid,
>  			    enum ima_hooks func, int mask,
> -			    const char *keyring)
> +			    const char *func_data)
>  {
>  	int i;
>  
>  	if (func == KEY_CHECK) {
>  		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
> -		       ima_match_keyring(rule, keyring, cred);
> +			ima_match_rule_data(rule, func_data, cred);
>  	}
>  	if ((rule->flags & IMA_FUNC) &&
>  	    (rule->func != func && func != POST_SETATTR))
> @@ -610,8 +621,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
>   * @pcr: set the pcr to extend
>   * @template_desc: the template that should be used for this rule
> - * @keyring: the keyring name, if given, to be used to check in the policy.
> - *           keyring can be NULL if func is anything other than KEY_CHECK.
> + * @func_data: private data specific to @func, can be NULL.

And again here.

thanks,

Mimi

