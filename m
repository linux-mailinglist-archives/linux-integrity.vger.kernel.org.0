Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE94BC055
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 20:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbiBRTjP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 14:39:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiBRTjO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 14:39:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE6766CB2;
        Fri, 18 Feb 2022 11:38:56 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IIQ579024123;
        Fri, 18 Feb 2022 19:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/eEVGEmUBeidOsRf4Pyinmz3aHRlCrnw8azpAlCiZlg=;
 b=Fmor6WTeq5e50ih5omj+rFB1sujcNQEd60mSG/CtzI5+HHlaiNb48IOpwEeVwjDyl3c/
 KeAaGwnmk+b9kqrmY/r21vAhGgS0q25/tbMGZe6kSYRoh/Ca6GcVBIB0uMRx0oTnJPlB
 IMXt3vzyx5EfYe8pt5KSEL7ciHXUbphHTHDUdi2Pjesn93Kv3PQLgApEaeO7vnqQR8bU
 ImY3Lnd0vNjiJoMku0PynBneKJh8mXzNPo2nLAtUI1ubNOL6PiI/cjfGFLSIKsByNeS1
 7rJtNuxBIMggtXj/vILPhpRm9FPFoS4tUArWtZSx04kgn8AVVQHWcnDFImLsGeAxs0Wm ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eagqshxf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 19:38:37 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21IJcatM030086;
        Fri, 18 Feb 2022 19:38:36 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eagqshxej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 19:38:36 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21IJWVVf019298;
        Fri, 18 Feb 2022 19:38:35 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3e64hcxvu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 19:38:35 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21IJcYGm7143756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 19:38:34 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FCF4124055;
        Fri, 18 Feb 2022 19:38:34 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1889A12405E;
        Fri, 18 Feb 2022 19:38:34 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 18 Feb 2022 19:38:34 +0000 (GMT)
Message-ID: <55c0c300-3fe4-f610-0b78-adc5593a70a0@linux.ibm.com>
Date:   Fri, 18 Feb 2022 14:38:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 16/27] ima: Implement ima_free_policy_rules() for
 freeing of an ima_namespace
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
 <20220201203735.164593-17-stefanb@linux.ibm.com>
 <ce1fbc8baf5359b698bf4420e602cc3a5a2a1f44.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <ce1fbc8baf5359b698bf4420e602cc3a5a2a1f44.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _Bs9JlM9K9HtpSmAlqTpWIOt3J0ol6fi
X-Proofpoint-ORIG-GUID: 1Nz7iO0AXWlzKWZpegIpkDHCCVkvbR2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_08,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/18/22 12:09, Mimi Zohar wrote:
> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
>> Implement ima_free_policy_rules() that is needed when an ima_namespace
>> is freed.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> ---
>> v10:
>>    - Not calling ima_delete_rules() anymore
>>    - Move access check from ima_delete_rules into very last patch
>>
>>   v9:
>>    - Only reset temp_ima_appraise when using init_ima_ns.
>> ---
>>   security/integrity/ima/ima.h        |  1 +
>>   security/integrity/ima/ima_policy.c | 14 ++++++++++++++
>>   2 files changed, 15 insertions(+)
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
>> index 2dcc5a8c585a..fe3dce8fb939 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -1889,6 +1889,20 @@ void ima_delete_rules(struct ima_namespace *ns)
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
>> +	list_for_each_entry_safe(entry, tmp, &ns->ima_policy_rules, list) {
>> +		list_del(&entry->list);
>> +		ima_free_rule(entry);
>> +	}
>> +}
>> +
> The first time a policy is loaded, the policy rules pivot
> from ima_default_rules to the custom rules.  When this happens, the
> architecture specific policy rules are freed.  Here too, if a custom
> policy isn't already loaded, the architecture specific rules stored as
> an array need to be freed.  Refer to the comment in
> ima_update_policy().

Right. So here's how it's done (before arch_policy_entry was moved into 
ima_namespace).

         /*
          * IMA architecture specific policy rules are specified
          * as strings and converted to an array of ima_entry_rules
          * on boot.  After loading a custom policy, free the
          * architecture specific rules stored as an array.
          */
         kfree(arch_policy_entry);


So, I now added kfree(ns->arch_policy_entry).

Thanks.

    Stefan

>
>>   #define __ima_hook_stringify(func, str)	(#func),
>>   
>>   const char *const func_tokens[] = {
