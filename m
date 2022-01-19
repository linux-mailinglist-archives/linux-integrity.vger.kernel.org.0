Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED12493B22
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jan 2022 14:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiASNcv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jan 2022 08:32:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1354833AbiASNcs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jan 2022 08:32:48 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JAvcst028475;
        Wed, 19 Jan 2022 13:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iQOM2B7pBkIu/v+1xQgTsapMW9lVF15319i1ZV98854=;
 b=Vvjfbr4zVL9FdnR3nFn8gSMLljR+2Z6Aksroq4Msrzxn+vHEyENF1wVPHXz3aneaoRtm
 7rsHbQLqOI63bM6IkQ51vu7v5/nH7QUCYhsCBIw37CCW6DB/pmGoNcjCYCIGlF5pJ0em
 Vwe6OiP5Upsi5xIt0swkziqFnh98Kj41NW3tqD5SMGeuJ/PVyUgQxoYfinOxALcOqW+/
 LLXYmEFexgHqaqWmdyq6QuOUOKTH+Q3udWsfku4rK0rHzrHiAE6Nq1nU3KN0UdbQZTUJ
 HOxNEkoWLLpgJBxXgaHtwKE0Nx8lIKUW82/4lRc899iK1sK7TyMeCkjLrRHVk/sPg80G ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dphbqb6h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 13:32:32 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20JDL71R012456;
        Wed, 19 Jan 2022 13:32:31 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dphbqb6gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 13:32:31 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20JDH8nG016689;
        Wed, 19 Jan 2022 13:32:30 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 3dknwaggg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 13:32:30 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20JDWTOi30409176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 13:32:29 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14F6DBE05B;
        Wed, 19 Jan 2022 13:32:29 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37A52BE053;
        Wed, 19 Jan 2022 13:32:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jan 2022 13:32:25 +0000 (GMT)
Message-ID: <c76b2bfc-d629-c720-e13c-84367524b88f@linux.ibm.com>
Date:   Wed, 19 Jan 2022 08:32:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 03/19] ima: Move policy related variables into
 ima_namespace
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
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-4-stefanb@linux.vnet.ibm.com>
 <150cb51f95c3fe54e94edc5b96b2e15edb3bf399.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <150cb51f95c3fe54e94edc5b96b2e15edb3bf399.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J1Ciy3qNc1FEHBz2o0_fECRRD-mCAzYY
X-Proofpoint-ORIG-GUID: Y6LSk7xDS6psh9z4QijZWX87OwSxJpQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_07,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190075
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/13/22 15:26, Mimi Zohar wrote:
> Hi Stefan,
>
> On Tue, 2022-01-04 at 12:04 -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Move variables related to the IMA policy into the ima_namespace. This way
>> the IMA policy of an IMA namespace can be set and displayed using a
>> front-end like SecurityFS.
>>
>> Implement ima_ns_from_file() to get the IMA namespace via the user
>> namespace of the SecurityFS superblock that a file belongs to.
>>
>> To get the current ima_namespace use get_current_ns() when a function
>> that is related to a policy rule is called. In other cases where functions
>> are called due file attribute modifications, use init_ima_ns, since these
>> functions are related to IMA appraisal and changes to file attributes are
>> only relevant to the init_ima_ns until IMA namespaces also support IMA
>> appraisal. In ima_file_free() use init_ima_ns since in this case flags
>> related to file measurements may be affected, which is not supported in
>> IMA namespaces, yet.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Please split this patch into "ima: pass through ima namespace", or some
> other name,  and "ima: Move policy related variables into

What is supposed to happen in the 'ima: pass through ima namespace' 
patch? What part of this patch do you expect to see there and what do 
you want to see deferred to a 2nd patch?


> ima_namespace".  The other option is to combine the "pass through ima
> namespace" with the 2nd patch, like Christian's example.

You mean I should merge this patch with the 2nd?

I am a bit confused as to what you are proposing. The first option would 
create 2 patches out of this one, the 2nd option would merge this one 
with the 2nd patch.

The equivalent of Christian's 2nd patch would be to merge this patch 
into the 2nd. So then let's do that?


>
>> ---
>>   security/integrity/ima/ima.h                 |  49 ++++---
>>   security/integrity/ima/ima_api.c             |   8 +-
>>   security/integrity/ima/ima_appraise.c        |  28 ++--
>>   security/integrity/ima/ima_asymmetric_keys.c |   4 +-
>>   security/integrity/ima/ima_fs.c              |  16 ++-
>>   security/integrity/ima/ima_init.c            |   8 +-
>>   security/integrity/ima/ima_init_ima_ns.c     |   6 +
>>   security/integrity/ima/ima_main.c            |  83 +++++++----
>>   security/integrity/ima/ima_policy.c          | 142 ++++++++++---------
>>   security/integrity/ima/ima_queue_keys.c      |  11 +-
>>   10 files changed, 213 insertions(+), 142 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index c4af3275f015..0b3dc9425076 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -20,6 +20,7 @@
>>   #include <linux/hash.h>
>>   #include <linux/tpm.h>
>>   #include <linux/audit.h>
>> +#include <linux/user_namespace.h>
>>   #include <crypto/hash_info.h>
>>   
>>   #include "../integrity.h"
>> @@ -43,9 +44,6 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
>>   
>>   #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
>>   
>> -/* current content of the policy */
>> -extern int ima_policy_flag;
>> -
>>   /* bitset of digests algorithms allowed in the setxattr hook */
>>   extern atomic_t ima_setxattr_allowed_hash_algorithms;
>>   
>> @@ -120,6 +118,14 @@ struct ima_kexec_hdr {
>>   };
>>   
>>   struct ima_namespace {
>> +	struct list_head ima_default_rules;
>> +	/* ns's policy rules */
> Thank you for adding comments.  Why is the ima_default_rules not
> considered "ns's policy rules"?   Will this come later or is it limited
> to init_ima_ns?
Let me move the comment up.
>
>> +	struct list_head ima_policy_rules;
>> +	struct list_head ima_temp_rules;
>> +	/* Pointer to ns's current policy */
>> +	struct list_head __rcu *ima_rules;
> Since "Pointer to ns's current policy" only refers to ima_rules, append
> it to the variable definition.


Ok, I will move it onto the same line then.


>
>> +	/* current content of the policy */
>> +	int ima_policy_flag;
> Similarly here append the comment to the variable definition.

Will do. Thanks.


>
>>   } __randomize_layout;
>>   extern struct ima_namespace init_ima_ns;
> thanks,
>
> Mimi
>
>
