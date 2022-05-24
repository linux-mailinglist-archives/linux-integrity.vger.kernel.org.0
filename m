Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846DF532CBA
	for <lists+linux-integrity@lfdr.de>; Tue, 24 May 2022 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbiEXO5s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 May 2022 10:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbiEXO5r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 May 2022 10:57:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97B954011;
        Tue, 24 May 2022 07:57:46 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OEgHxc014966;
        Tue, 24 May 2022 14:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=29pST3gjXSTrS26v72BbeghZM9snaNLlt+14xpqeLd0=;
 b=lvnSoKnqSxaHtGZNv768VSXnFNTmyZZIffG2YxL4knuDDqwzLtU2a69tFd/pRloPlraV
 ygG8XBD0Tgh70gO0LlslQqyRsLT98AXBlbNl7sXJowE2l5NoVybeiZD9QH394M5tN1eJ
 +fC2zMjFc6wDOPM+KE+cAsHd3xbypVssueZMRPa0wz+za1KZOa+UtBE4xeVuxr1s7eAH
 OYzX6s/w20TuG+JgxiFA9eW/beeYYG5sm76JU/4gdYsf+w1ZMJLczaZJkSRP98tvBLsf
 7UqSnlYLzUoHDt2vZINpfieUNnpU1CU7bdzkZgvQTbzFqQtF/mWjulGO0ux0KxjdcniC TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g91bt89ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 14:57:18 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24OEgQL6015588;
        Tue, 24 May 2022 14:57:17 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g91bt89t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 14:57:17 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OEjCFx023245;
        Tue, 24 May 2022 14:57:16 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 3g6qqa0qxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 14:57:16 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OEvExh27656644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 14:57:14 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2A05136053;
        Tue, 24 May 2022 14:57:14 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3A71136051;
        Tue, 24 May 2022 14:57:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 14:57:13 +0000 (GMT)
Message-ID: <81730e47-21f4-b678-6585-f21e57620a60@linux.ibm.com>
Date:   Tue, 24 May 2022 10:57:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v12 03/26] ima: Define ima_namespace struct and start
 moving variables into it
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Christian Brauner <brauner@kernel.org>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-4-stefanb@linux.ibm.com>
 <20220521023351.GA9107@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220521023351.GA9107@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IWXhtstDlKf4et679hp_5cgQyunjeAIG
X-Proofpoint-GUID: 5PGx_nncF4HZMk5TgLnDKWSpD6YDy_Gr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_07,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=845
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 mlxscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205240074
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/20/22 22:33, Serge E. Hallyn wrote:

>> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
>> index 93056c03bf5a..e366a21dd8be 100644
>> --- a/security/integrity/ima/ima_queue_keys.c
>> +++ b/security/integrity/ima/ima_queue_keys.c
>> @@ -10,6 +10,7 @@
>>   
>>   #include <linux/user_namespace.h>
>>   #include <linux/workqueue.h>
>> +#include <linux/ima.h>
>>   #include <keys/asymmetric-type.h>
>>   #include "ima.h"
>>   
>> @@ -42,7 +43,7 @@ static bool timer_expired;
>>   static void ima_keys_handler(struct work_struct *work)
>>   {
>>   	timer_expired = true;
>> -	ima_process_queued_keys();
>> +	ima_process_queued_keys(&init_ima_ns);
>>   }
>>   
>>   /*
>> @@ -130,11 +131,15 @@ bool ima_queue_key(struct key *keyring, const void *payload,
>>    * This function sets ima_process_keys to true and processes queued keys.
>>    * From here on keys will be processed right away (not queued).
>>    */
>> -void ima_process_queued_keys(void)
>> +void ima_process_queued_keys(struct ima_namespace *ns)
>>   {
>>   	struct ima_key_entry *entry, *tmp;
>>   	bool process = false;
>>   
>> +	/* only applies to init_ima_ns */
> 
> Hm, yes, it seems to, but it should be unreachable with
> ns != &init_ima_ns, ever, right?
> 
> So it seems better to either not have this hunk at all, (both
> here and at ima_keys_handler()) or to actually have a BUG_ON.
> 
> Or am I completely misreading the situation?

No, you are right. This function is only calledwith ns = &init_ima_ns at 
the moment. How about changing it to this here?

if (WARN_ON(ns != &init_ima_ns))
         return;



> 
>> +	if (ns != &init_ima_ns)
>> +		return;
>> +
>>   	if (ima_process_keys)
>>   		return;
>>   
>> @@ -159,7 +164,7 @@ void ima_process_queued_keys(void)
>>   
>>   	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
>>   		if (!timer_expired)
>> -			process_buffer_measurement(&init_user_ns, NULL,
>> +			process_buffer_measurement(ns, &init_user_ns, NULL,
>>   						   entry->payload,
>>   						   entry->payload_len,
>>   						   entry->keyring_name,
>> -- 
>> 2.34.1
