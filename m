Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E864492B39
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 17:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbiARQbz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 11:31:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233718AbiARQby (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 11:31:54 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IExPY9026569;
        Tue, 18 Jan 2022 16:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gwtBNDrjoRUjgdImL2lUJU8rSD1D9vwLIi3HT5QdUQw=;
 b=hNApWxNnWcHtPBWqgnPX9WkAEBaK1ydzmh8rlRn0KHpWGkkgorDX1r78srNXUyO7vF9j
 hVOYGB8aTqGmFd3ndympaUP8xMAXPF85cdYFVRmaeq7Q/K4gDbsPnFSNfXB3YvfnnYEk
 4sruIkRFy+qrGg6xl7/SFk6a9D6u7DA4/Km2FqZL1BPAgn7ibbpfnygKMA7UCQ6GxYH5
 knb07xYxvQdD1mWC79zgf9KBX7JHB9lV+2cpva0CR0XNvL/sLCkC//GqoDfdvTe6p02v
 R12KDBPNv/XbCWid1qAJ9SYcNT6UfqHNCKgPquh5ygepDOLXKt+Tx2eW3h5+zINavqCk ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dnydgaq5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 16:31:34 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20IGQwM3005255;
        Tue, 18 Jan 2022 16:31:34 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dnydgaq5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 16:31:34 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20IGDYb9005520;
        Tue, 18 Jan 2022 16:31:33 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 3dknwbjgy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 16:31:33 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20IGVTw633882384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 16:31:29 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C559AAC073;
        Tue, 18 Jan 2022 16:31:29 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F510AC068;
        Tue, 18 Jan 2022 16:31:29 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jan 2022 16:31:29 +0000 (GMT)
Message-ID: <971dc802-42b2-9f04-f143-89f9ae26f0fe@linux.ibm.com>
Date:   Tue, 18 Jan 2022 11:31:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 18/19] ima: Show owning user namespace's uid and gid
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
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-19-stefanb@linux.vnet.ibm.com>
 <20220114134527.bk5ijfrqwt334ypr@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220114134527.bk5ijfrqwt334ypr@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y_QP-K8FJAh6YkJT1ap-2b-M7beQ2bbN
X-Proofpoint-GUID: T_nExa_IjIW3VGgu4p_5nbPEnLYQRT_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_04,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1011 spamscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/14/22 08:45, Christian Brauner wrote:
> On Tue, Jan 04, 2022 at 12:04:15PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Show the uid and gid values of the owning user namespace when displaying
>> the IMA policy rather than the kernel uid and gid values. Now the same uid
>> and gid values are shown in the policy as those that were used when the
>> policy was set.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   security/integrity/ima/ima_policy.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 15c68dc5da9e..b7dbc687b6ff 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -1997,6 +1997,7 @@ static void ima_policy_show_appraise_algos(struct seq_file *m,
>>   
>>   int ima_policy_show(struct seq_file *m, void *v)
>>   {
>> +	struct user_namespace *user_ns = ima_user_ns_from_file(m->file);
> Hm, so when looking at the policy entries via seq_file's .show method
> and displaying the {g,u}id values of the rules we don't want the values
> resolved according to the user namespace the securityfs instances was
> mounted in. That would be misleading for callers that are in an
> ancestor userns (which we allow in .permission).
>
> So we want to make sure that we see the values as the opener of the file
> would see them. This is similar to e.g. looking at a task's ids through
> /proc/<pid>/status. So this should be seq_user_ns(m) instead of
> ima_user_ns_from_file().
>>   	struct ima_rule_entry *entry = v;
>>   	int i;
>>   	char tbuf[64] = {0,};
>> @@ -2074,7 +2075,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_UID) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kuid(user_ns, entry->uid));
> This should be from_k{g,u}id_munged().

Thanks, fixed.

When I run a runc container as uid=1000 I see uid = 0 when inside the 
container and when entering its mount namespace from root account via 
nsenter it shows 'uid = 1000' while before it was showing 'uid = 0'.

