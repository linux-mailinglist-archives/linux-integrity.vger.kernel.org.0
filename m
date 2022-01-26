Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193F149D608
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 00:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiAZXNs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 18:13:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233439AbiAZXNr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 18:13:47 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QMnD79032141;
        Wed, 26 Jan 2022 23:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zvxSVDuUSN9c67gKeo+7qdK1xgI5l1LCOGcWxzPJOrA=;
 b=F1wXgn7SsKrigV97hjLB/OJBP1Lgm+MDpQ4FcBWXd1KcuhnQgZ4z3J0Rein9mVeDz2Hj
 7CQqp8b9ZnLSEDypG77bvwY7cBllVvSm2FCNtq7qb7q1B2b2Ht0V37YxLqfyORmVoLB6
 aN42c87lFFnluylqDjR5T1vaAfUUc+XpjXsi8/0k4oJWhkXxvhlTtl57nNijTXyKhjJ6
 lHzk4LmOKagInmpGj1G17iC1tlER6WBZNEwMgb4I391qXlN2FCYkL5dGbZEOelPO20pX
 sHbcoDPSEAIs7eGO2/4Ig8vUZr7WDMixzCX1+fWYl2S/K++EqTQjjfhqN5aROC/h4FcM Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dufb80geh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 23:13:22 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20QNBPXE010054;
        Wed, 26 Jan 2022 23:13:21 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dufb80gea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 23:13:21 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20QNC9Rh007993;
        Wed, 26 Jan 2022 23:13:20 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 3dr9jc26g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 23:13:20 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20QNDHRj15532428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:13:17 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4A40C6055;
        Wed, 26 Jan 2022 23:13:17 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79019C605D;
        Wed, 26 Jan 2022 23:13:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 23:13:16 +0000 (GMT)
Message-ID: <e1a8540c-0f53-d469-f10b-4098a3b9c9e0@linux.ibm.com>
Date:   Wed, 26 Jan 2022 18:13:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 22/23] ima: Show owning user namespace's uid and gid
 when displaying policy
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-23-stefanb@linux.vnet.ibm.com>
 <20220126144326.ci646xkm7mjsqwci@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220126144326.ci646xkm7mjsqwci@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JSvjeTjvBRvl9ZF5RqZyKVPXK25sLyWG
X-Proofpoint-ORIG-GUID: NmduSLxIcbmCfufW77-Gxcbl1eJOrh8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_09,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201260131
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/26/22 09:43, Christian Brauner wrote:
> On Tue, Jan 25, 2022 at 05:46:44PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Show the uid and gid values relative to the user namespace that is
>> currently active. The effect of this changes is that when one displays
>> the policy from the user namespace that originally set the policy,
>> the same uid and gid values are shown in the policy as those that were
>> used when the policy was set.
> "Make sure that the uid and gid values associated with the relevant
> ima policy are resolved in the user namespace of the opener of the
> policy file."

I updated the text now to:

Make sure that the uid and gid values associated with the relevant IMA

policy are resolved in the user namespace of the opener of the policy

file. The effect of this changes is that when one displays the policy
from the user namespace that originally set the policy, the same uid
and gid values are shown in the policy as those that were used when the
policy was set.

>
> is more correct. Also note, that by virtue of enforcing that securityfs
> files can only ever be opened if the opener's userns is the same or an
> ancestor of the userns the securityfs instance is mounted in we are
> guaranteed that the uid and gid can be resolved. That's another way of
> saying technically *_munged() isn't necessary but it is more correct
> since we're crossing the user-kernel boundary.
>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> ---
>> v9:
>>    - use seq_user_ns and from_k{g,u}id_munged()
>> ---
>>   security/integrity/ima/ima_policy.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 47f2d1b5d156..151f418036ee 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -2002,6 +2002,7 @@ static void ima_policy_show_appraise_algos(struct seq_file *m,
>>   
>>   int ima_policy_show(struct seq_file *m, void *v)
>>   {
>> +	struct user_namespace *user_ns = seq_user_ns(m);
>>   	struct ima_rule_entry *entry = v;
>>   	int i;
>>   	char tbuf[64] = {0,};
>> @@ -2087,7 +2088,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_UID) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kuid_munged(user_ns, entry->uid));
>>   		if (entry->uid_op == &uid_gt)
>>   			seq_printf(m, pt(Opt_uid_gt), tbuf);
>>   		else if (entry->uid_op == &uid_lt)
>> @@ -2098,7 +2100,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_EUID) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kuid_munged(user_ns, entry->uid));
>>   		if (entry->uid_op == &uid_gt)
>>   			seq_printf(m, pt(Opt_euid_gt), tbuf);
>>   		else if (entry->uid_op == &uid_lt)
>> @@ -2109,7 +2112,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_GID) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kgid_munged(user_ns, entry->gid));
>>   		if (entry->gid_op == &gid_gt)
>>   			seq_printf(m, pt(Opt_gid_gt), tbuf);
>>   		else if (entry->gid_op == &gid_lt)
>> @@ -2120,7 +2124,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_EGID) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kgid_munged(user_ns, entry->gid));
>>   		if (entry->gid_op == &gid_gt)
>>   			seq_printf(m, pt(Opt_egid_gt), tbuf);
>>   		else if (entry->gid_op == &gid_lt)
>> @@ -2131,7 +2136,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_FOWNER) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kuid_munged(user_ns, entry->fowner));
>>   		if (entry->fowner_op == &uid_gt)
>>   			seq_printf(m, pt(Opt_fowner_gt), tbuf);
>>   		else if (entry->fowner_op == &uid_lt)
>> @@ -2142,7 +2148,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_FGROUP) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->fgroup));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kgid_munged(user_ns, entry->fgroup));
>>   		if (entry->fgroup_op == &gid_gt)
>>   			seq_printf(m, pt(Opt_fgroup_gt), tbuf);
>>   		else if (entry->fgroup_op == &gid_lt)
>> -- 
>> 2.31.1
>>
>>
