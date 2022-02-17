Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5366E4BAB5F
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Feb 2022 22:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbiBQVAN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Feb 2022 16:00:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiBQVAM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Feb 2022 16:00:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29143AC9;
        Thu, 17 Feb 2022 12:59:57 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HKlaip001166;
        Thu, 17 Feb 2022 20:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sXxrg1nnA6V/+9tvPqjzYCuForvG+Pxuis9Zb8uZPVo=;
 b=ROSu79jrqHiAQu6G7CniKEMvVO4Q9XiiYhNZERcG7dOXH5CnJqsDzq1t+YfpHveWQd4q
 QoEL/uqS1scMoGv2OiCISofLG0HK+obQ+i/MjAGaC532mqhuDmewcvE08k7PBeiGUiZL
 0ksu+ej5cOHLJpEaWs2ZwKk61fXV1s12Vzix1lkwPNEiUovEl1vLqwmJtKYtOce1XBik
 +u2wHLb7kDrwLTPwa1OtvpRJFpFtHptuO8WQ8Hiu4NdSYXbi10fT1TeqJ4fhbvLrTCQM
 gQUsaSMOk8cxKTO2YSTAcUQR14xBA9zU2LGpeViWU1gEIY8SPApweQuUfQB2yyBXAP8x Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9wq986b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 20:59:38 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21HKxcJj008044;
        Thu, 17 Feb 2022 20:59:38 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9wq986ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 20:59:38 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HKwUnT012424;
        Thu, 17 Feb 2022 20:59:37 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3e64hd9j5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 20:59:37 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HKxYAP39321996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 20:59:34 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 540F278063;
        Thu, 17 Feb 2022 20:59:34 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A21497805E;
        Thu, 17 Feb 2022 20:59:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 17 Feb 2022 20:59:31 +0000 (GMT)
Message-ID: <95a9eb64-654b-8d34-12c7-1dd7666e3420@linux.ibm.com>
Date:   Thu, 17 Feb 2022 15:59:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 11/27] ima: Move ima_lsm_policy_notifier into
 ima_namespace
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
 <20220201203735.164593-12-stefanb@linux.ibm.com>
 <62f946ec160296b6b20bee98986b2bafb8427718.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <62f946ec160296b6b20bee98986b2bafb8427718.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rZdlAmARqLRt4rmnC_GLL3UJ5QGadeEV
X-Proofpoint-ORIG-GUID: oYsipj6pGyMGcY9bOtEd_CZzHrqr7wPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_08,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/17/22 15:30, Mimi Zohar wrote:
> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
>
> The builtin IMA policy rules are broad and may be constrained by
> loading a custom policy, which could be defined in terms of LSM labels.
> When an LSM policy is loaded, existing LSM labels might be affected or
> even removed.  In either case, IMA policy rules based on LSM
> labels, need to reflect these changes.  If an LSM label is removed,
> instead of deleting the IMA policy rule based on the LSM label, the IMA
> policy rule is made inactive.

Ok, so I take this paragraph for the patch description.


>
>> Move the ima_lsm_policy_notifier into the ima_namespace. Each IMA
>> namespace can now register its own LSM policy change notifier callback.
>> The policy change notifier for the init_ima_ns still remains in init_ima()
>> and therefore handle the registration of the callback for all other
>> namespaces in init_ima_namespace().
>>
>> Suppress the kernel warning 'rule for LSM <label> is undefined` for all
>> other IMA namespaces than the init_ima_ns.
> Instead of ignoring the warnings totally, perhaps use either the
> "ratelimited" or "once" function options for non init_ima_ns.  It would
> be nice if these functions could be namespace aware, so that each
> affected IMA namespace would contain at least one warning.

The problem is that any user can now repeatedly create user namespaces 
and with that IMA namespaces and cause the kernel log to fill up with 
these messages and also flood the audit log -- I guess one could 
describe it as an unwanted side-effect. I am afraid that for as long as 
the kernel log is not namespaced it's probably best to just turn them 
off for non-init_ima_ns.


>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Thanks.
>
>> ---
>> v10:
>>   - Only call pr_warn('rule for LSM <label> is undefined`) for init_ima_ns
>> ---
>>   security/integrity/ima/ima.h             |  2 ++
>>   security/integrity/ima/ima_init_ima_ns.c | 14 ++++++++++++++
>>   security/integrity/ima/ima_main.c        |  6 +-----
>>   security/integrity/ima/ima_policy.c      | 16 ++++++++++------
>>   4 files changed, 27 insertions(+), 11 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 94c6e3a4d666..fb6bd054d899 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -144,6 +144,8 @@ struct ima_namespace {
>>   	int valid_policy;
>>   
>>   	struct dentry *ima_policy;
>> +
>> +	struct notifier_block ima_lsm_policy_notifier;
>>   } __randomize_layout;
>>   extern struct ima_namespace init_ima_ns;
>>   
>> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
>> index 425eed1c6838..1cba545ae477 100644
>> --- a/security/integrity/ima/ima_init_ima_ns.c
>> +++ b/security/integrity/ima/ima_init_ima_ns.c
>> @@ -10,6 +10,8 @@
>>   
>>   static int ima_init_namespace(struct ima_namespace *ns)
>>   {
>> +	int rc;
>> +
> There's no right or wrong, but the newer IMA code uses 'ret'.


I don't mind to change it. I will take your Reviewed-by, though :-)


>
>>   	INIT_LIST_HEAD(&ns->ima_default_rules);
>>   	INIT_LIST_HEAD(&ns->ima_policy_rules);
>>   	INIT_LIST_HEAD(&ns->ima_temp_rules);
