Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C935A4C18D7
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 17:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242932AbiBWQig (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 11:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbiBWQid (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 11:38:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F4258385;
        Wed, 23 Feb 2022 08:38:05 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NG62Wa016747;
        Wed, 23 Feb 2022 16:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8mzKbb2ti1kJXWNa3haK0U6Y1jISsogRXqdr17NayRU=;
 b=jMUeOAudwK1G2GMwzt7HnUmyYC1UosTXkHAGVB1fOPwozKXiUKIR+WxQYXs7l3GOCU1y
 A+iGeI673EIOOXS+iw6YK/S8LNokszYXVhhM9sziWfjwsHYjCW+Yh5SrFOoSubunbeRd
 eDX87HsawrNKcOpRvgA7iPthXBgG3cDauBVyEtEi6g7D9E2XhIXCKZnxs0f0ToHThyS9
 r8J9tsDateviGc49Zgy/LZKik9BYsAralTlR4HzarK94+nNiiznQ7LikIah+7pbJw456
 sxWAPMjBjy5lk8MYqUA9PI9DCrE0ycJhDyg3PcJbn3F7ijdPvqLiGNPNOBkjq2BitZPH Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edp4f4be3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 16:37:54 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NG7v24028679;
        Wed, 23 Feb 2022 16:37:54 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edp4f4bdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 16:37:54 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NGXwP4004798;
        Wed, 23 Feb 2022 16:37:52 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3ear6bvbqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 16:37:52 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NGbod629360630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 16:37:50 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B5D8C605A;
        Wed, 23 Feb 2022 16:37:50 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18CB8C605B;
        Wed, 23 Feb 2022 16:37:47 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 16:37:46 +0000 (GMT)
Message-ID: <479f09e7-0d39-0281-45ef-5cce4861d24d@linux.ibm.com>
Date:   Wed, 23 Feb 2022 11:37:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 26/27] ima: Limit number of policy rules in
 non-init_ima_ns
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-27-stefanb@linux.ibm.com>
 <5e4a862917785972281bbcb483404da01b71e801.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <5e4a862917785972281bbcb483404da01b71e801.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YtdmZR6yvhc-B140zcPhCzlkHr9pdBRS
X-Proofpoint-ORIG-GUID: UVGcGe1ZYf3dKIlHSyVwet67Jlxqw0cL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_08,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/23/22 10:38, Mimi Zohar wrote:
> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
>> Limit the number of policy rules one can set in non-init_ima_ns to a
>> hardcoded 1024 rules. If the user attempts to exceed this limit by
>> setting too many additional rules, emit an audit message with the cause
>> 'too-many-rules' and simply ignore the newly added rules.
> This paragraph describes 'what' you're doing, not 'why'.  Please prefix
> this paragraph with a short, probably one sentence, reason for the
> change.
>> Switch the accounting for the memory allocated for IMA policy rules to
>> GFP_KERNEL_ACCOUNT so that cgroups kernel memory accounting takes effect.
> Does this change affect the existing IMA policy rules for init_ima_ns?

There's typically no cgroup for the int_ima_ns, so not effect on 
init_ima_ns.


Here's the updated text:

Limit the number of policy rules one can set in non-init_ima_ns to a
hardcoded 1024 rules to restrict the amount of memory used for IMA's
policy. Ignore the added rules if the user attempts to exceed this
limit by setting too many additional rules.

Switch the accounting for the memory allocated for IMA policy rules to
GFP_KERNEL_ACCOUNT so that cgroups kernel memory accounting takes effect.
This switch has no effect on the init_ima_ns.

    Stefan


>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   security/integrity/ima/ima_fs.c     | 20 ++++++++++++++------
>>   security/integrity/ima/ima_policy.c | 23 ++++++++++++++++++-----
>>   2 files changed, 32 insertions(+), 11 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index 58d80884880f..cd102bbd4677 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -410,24 +410,32 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>>   {
>>   	struct ima_namespace *ns = &init_ima_ns;
>>   	const char *cause = ns->valid_policy ? "completed" : "failed";
>> +	int err = 0;
>>   
>>   	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
>>   		return seq_release(inode, file);
>>   
>> -	if (ns->valid_policy && ima_check_policy(ns) < 0) {
>> -		cause = "failed";
>> -		ns->valid_policy = 0;
>> +	if (ns->valid_policy) {
>> +		err = ima_check_policy(ns);
>> +		if (err < 0) {
>> +			if (err == -ENOSPC)
> Perhaps "EDQUOT" would be more appropriate.
>
>> +				cause = "too-many-rules";
>> +			else
>> +				cause = "failed";
>> +			ns->valid_policy = 0;
>> +		}
>>   	}
>>   
>>   	pr_info("policy update %s\n", cause);
>> -	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
>> -			    "policy_update", cause, !ns->valid_policy, 0);
>> +	integrity_audit_message(AUDIT_INTEGRITY_STATUS, NULL, NULL,
>> +				"policy_update", cause, !ns->valid_policy, 0,
>> +				-err);
> The 'err' value is already properly set.  No need for the minus sign.
>
>>   
>>   	if (!ns->valid_policy) {
>>   		ima_delete_rules(ns);
>>   		ns->valid_policy = 1;
>>   		clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
>> -		return 0;
>> +		return err;
>>   	}
>>   
>>   	ima_update_policy(ns);
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index acb4c36e539f..3f84d04f101d 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -305,7 +305,8 @@ static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
>>   		return ERR_PTR(-EINVAL);
>>   	}
>>   
>> -	opt_list = kzalloc(struct_size(opt_list, items, count), GFP_KERNEL);
>> +	opt_list = kzalloc(struct_size(opt_list, items, count),
>> +			   GFP_KERNEL_ACCOUNT);
>>   	if (!opt_list) {
>>   		kfree(src_copy);
>>   		return ERR_PTR(-ENOMEM);
>> @@ -379,7 +380,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_namespace *ns,
>>   	 * Immutable elements are copied over as pointers and data; only
>>   	 * lsm rules can change
>>   	 */
>> -	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
>> +	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL_ACCOUNT);
>>   	if (!nentry)
>>   		return NULL;
>>   
>> @@ -826,7 +827,7 @@ static void add_rules(struct ima_namespace *ns,
>>   
>>   		if (policy_rule & IMA_CUSTOM_POLICY) {
>>   			entry = kmemdup(&entries[i], sizeof(*entry),
>> -					GFP_KERNEL);
>> +					GFP_KERNEL_ACCOUNT);
>>   			if (!entry)
>>   				continue;
>>   
>> @@ -863,7 +864,7 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
>>   
>>   	ns->arch_policy_entry = kcalloc(arch_entries + 1,
>>   					sizeof(*ns->arch_policy_entry),
>> -					GFP_KERNEL);
>> +					GFP_KERNEL_ACCOUNT);
>>   	if (!ns->arch_policy_entry)
>>   		return 0;
>>   
>> @@ -975,8 +976,20 @@ void __init ima_init_policy(struct ima_namespace *ns)
>>   /* Make sure we have a valid policy, at least containing some rules. */
>>   int ima_check_policy(struct ima_namespace *ns)
>>   {
>> +	struct ima_rule_entry *entry;
>> +	size_t len1 = 0;
>> +	size_t len2 = 0;
>> +
>>   	if (list_empty(&ns->ima_temp_rules))
>>   		return -EINVAL;
>> +	if (ns != &init_ima_ns) {
>> +		list_for_each_entry(entry, &ns->ima_temp_rules, list)
>> +			len1++;
>> +		list_for_each_entry(entry, &ns->ima_policy_rules, list)
> Using list_for_each_entry() is fine here, because multiple policy
> updates at the same time are blocked.  Please add a comment.
>
>> +			len2++;
>> +		if (len1 + len2 > 1024)
> One variable should be enough.
>
>> +			return -ENOSPC;
>> +	}
>>   	return 0;
>>   }
>>   
>> @@ -1848,7 +1861,7 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
>>   	if (*p == '#' || *p == '\0')
>>   		return len;
>>   
>> -	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
>>   	if (!entry) {
>>   		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
>>   				    NULL, op, "-ENOMEM", -ENOMEM, audit_info);
