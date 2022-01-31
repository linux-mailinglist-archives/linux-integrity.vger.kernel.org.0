Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8234A4F05
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Jan 2022 19:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358236AbiAaS5X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Jan 2022 13:57:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1358218AbiAaS5W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Jan 2022 13:57:22 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VHW8wf018646;
        Mon, 31 Jan 2022 18:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OoBmDdOiqugOKX+t2tC8Z6K0AKa0cLylyvApIRSkk5I=;
 b=n4RqKA6nlmWnmrghvMD2CRaKMSvPCuChxumTowm2RPuW47np/HcETsr/QQ+cx7Gjnawj
 tG6geMo8+UCl80Bp8/YoPxt4F1ydV8yOz2eOqbpqmxuTSfX5ALHbBrRWID9xZ2n9j1nb
 E3j11pGu3R3nt7JyNpzQFWcQT0OMpeOc6p3MrBaWOwA4Dyk2jCy5e3o682EQnmt4G1qI
 0H3lbUcHzRZkZ+XCq2PnB3/2QBnVwRP26aPxZFHaxmtJhZPYgYIgYZTpB/o6ikQRbFu7
 +dNrfPSIIHRVM5cprlFemWd0Zci3e+RHJI0G+lTcfJaiiU2uU+DBpIo5Ud1aaU5mtIib 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxm8khyam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 18:56:55 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20VIpdpv018370;
        Mon, 31 Jan 2022 18:56:54 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxm8khya9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 18:56:54 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VIqJrA019182;
        Mon, 31 Jan 2022 18:56:53 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 3dvw7a9k3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 18:56:53 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VIuoDJ31850960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 18:56:50 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAF92124070;
        Mon, 31 Jan 2022 18:56:50 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67E35124055;
        Mon, 31 Jan 2022 18:56:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 18:56:48 +0000 (GMT)
Message-ID: <83d32ac3-6633-3ccc-1377-91caaf709445@linux.ibm.com>
Date:   Mon, 31 Jan 2022 13:56:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 16/23] ima: Implement ima_free_policy_rules() for
 freeing of an ima_namespace
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-17-stefanb@linux.vnet.ibm.com>
 <258c7c5e1aebfc9376560549794d43e744654713.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <258c7c5e1aebfc9376560549794d43e744654713.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZplDHnseCm730yNs_Y20Zp5bXUuJIEF_
X-Proofpoint-ORIG-GUID: LXRGMp9mqGG5FubM1xYAo-EY0g0LYkV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/28/22 09:02, Mimi Zohar wrote:
> Hi Stefan,
>
> On Tue, 2022-01-25 at 17:46 -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Implement ima_free_policy_rules() that is needed when an ima_namespace
>> is freed.
>>
>> Only reset temp_ima_appraise when using init_ima_ns.
> Instead of having to walk the policy rules to know if there are any
> "appraise" rules, the ima_appraise flag is set.  For now, only reset
> temp_ima_appraise flag on failed policy rule updates for init_ima_ns.


Ok, I am taking this whole text.


>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> ---
>>   v9:
>>    - Only reset temp_ima_appraise when using init_ima_ns.
>> ---
>>   security/integrity/ima/ima.h        |  1 +
>>   security/integrity/ima/ima_policy.c | 20 +++++++++++++++++++-
>>   2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index aea8fb8d2854..8c757223d549 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -329,6 +329,7 @@ void ima_update_policy_flags(struct ima_namespace *ns);
>>   ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
>>   void ima_delete_rules(struct ima_namespace *ns);
>>   int ima_check_policy(struct ima_namespace *ns);
>> +void ima_free_policy_rules(struct ima_namespace *ns);
>>   void *ima_policy_start(struct seq_file *m, loff_t *pos);
>>   void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
>>   void ima_policy_stop(struct seq_file *m, void *v);
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index e8140e73d80b..47f2d1b5d156 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -1880,13 +1880,31 @@ void ima_delete_rules(struct ima_namespace *ns)
>>   {
>>   	struct ima_rule_entry *entry, *tmp;
>>   
>> -	temp_ima_appraise = 0;
>> +	if (ns == &init_ima_ns)
>> +		temp_ima_appraise = 0;
>> +
>>   	list_for_each_entry_safe(entry, tmp, &ns->ima_temp_rules, list) {
>>   		list_del(&entry->list);
>>   		ima_free_rule(entry);
>>   	}
>>   }
>>   
>> +/**
>> + * ima_free_policy_rules - free all policy rules
>> + * @ns: IMA namespace that has the policy
>> + */
>> +void ima_free_policy_rules(struct ima_namespace *ns)
>> +{
>> +	struct ima_rule_entry *entry, *tmp;
>> +
>> +	ima_delete_rules(ns);
> When the IMA policy is being extended, new rules are temporarily added
> to the ima_temp_rules list.  If the entire set of rules being added are
> valid, they're appended to the tail.
>
> There shouldn't be any rules on the ima_temp_rules list unless the
> policy is currently being extended.  Is that possible at this point?

Actually, no. Nothing can be left. I am removing this call.

I wonder whether to split this patch into into two patches?


>
>> +
>> +	list_for_each_entry_safe(entry, tmp, &ns->ima_policy_rules, list) {
>> +		list_del(&entry->list);
>> +		ima_free_rule(entry);
>> +	}
>> +}
>> +
>>   #define __ima_hook_stringify(func, str)	(#func),
>>   
>>   const char *const func_tokens[] = {
> thanks,
>
> Mimi
>
