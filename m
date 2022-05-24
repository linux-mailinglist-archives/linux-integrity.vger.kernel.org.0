Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7366532B22
	for <lists+linux-integrity@lfdr.de>; Tue, 24 May 2022 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiEXNUC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 May 2022 09:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiEXNUC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 May 2022 09:20:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D198095;
        Tue, 24 May 2022 06:20:01 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OCjcAb029586;
        Tue, 24 May 2022 13:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qZODpqFwVOu9imLO2DLb89vkcW+eAv0FCCFk93WM9fQ=;
 b=raCpb/Wvwimv+0qs58BtbqK29AbF0EbRuF+oRdpZtLs4XGYlbn1b711MbZu2xR5Deai7
 HjXFfHg9+0j+So74CmMyp52dIZdkY1wHv2PRD1a66Oc8fs4BWDGv/IuOmNn2JT5Zgf5+
 fFK2NE/ypHwENKE365U38WDeZH6BbROAt7C++stztTGyp83Za5kq1Ur49apAwyPBPLMC
 jHWcLTnoK8v6YXtgYSYgu2tgLrYfk8SNW7n5Of9/emwVrPtjYYqX2wp87CLk3jgPPUXF
 rPmgdlF5UYYwiUX9vCrSoGcGxMxsxXIvnJ5go0/QHxyAlLrc5PIVwFzRuaY9cN48UsVF kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8yna8shk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 13:19:31 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24OD7aif027682;
        Tue, 24 May 2022 13:19:31 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8yna8sha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 13:19:31 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24ODIuH6012350;
        Tue, 24 May 2022 13:19:30 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 3g6qq9r4fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 13:19:30 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24ODJTas24576346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 13:19:29 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2080978063;
        Tue, 24 May 2022 13:19:29 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DF7878067;
        Tue, 24 May 2022 13:19:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 13:19:26 +0000 (GMT)
Message-ID: <e1c3941e-80d4-f8f2-774e-01bd89fd474a@linux.ibm.com>
Date:   Tue, 24 May 2022 09:19:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v12 23/26] ima: Show owning user namespace's uid and gid
 when displaying policy
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
        jpenumak@redhat.com
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-24-stefanb@linux.ibm.com>
 <20220522175452.GB24519@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220522175452.GB24519@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rtUV8HzU-sn-srON6l5ot-o0FFSQ1kLt
X-Proofpoint-ORIG-GUID: ksryRKuSnqf6b1Ga2LNHDakXKDApaO99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_07,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205240066
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/22/22 13:54, Serge E. Hallyn wrote:
> On Wed, Apr 20, 2022 at 10:06:30AM -0400, Stefan Berger wrote:
>> Show the uid and gid values relative to the user namespace that is
>> currently active. The effect of this changes is that when one displays
> 
> When you say "is currently active", in my mind it's not clear whether you
> mean in the process which opened the seq_file, or is active in the ima_ns,
> or the reader (which might I guess be differenet still).  The code of
> course does make it clear.  Can you change it to say "the user namespace
> which opened the policy_show file" or something like that?
> 
> Also, s/The effect of this changes/The effect of this change/.
> 
>> the policy from the user namespace that originally set the policy,
>> the same uid and gid values are shown in the policy as those that were
>> used when the policy was set.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

I modified the  text above now to state:

Show the uid and gid values relative to the user namespace that opened
the IMA policy file. The effect of this change is that when one displays
the policy from the user namespace that originally set the policy,
the same uid and gid values are shown in the policy as those that were
used when the policy was set.

Thanks.
    Stefan
> 
>> ---
>> v9:
>>    - use seq_user_ns and from_k{g,u}id_munged()
>> ---
>>   security/integrity/ima/ima_policy.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index eb10d895923d..4f8c50ddb777 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -2018,6 +2018,7 @@ static void ima_policy_show_appraise_algos(struct seq_file *m,
>>   
>>   int ima_policy_show(struct seq_file *m, void *v)
>>   {
>> +	struct user_namespace *user_ns = seq_user_ns(m);
>>   	struct ima_rule_entry *entry = v;
>>   	int i;
>>   	char tbuf[64] = {0,};
>> @@ -2103,7 +2104,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_UID) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kuid_munged(user_ns, entry->uid));
>>   		if (entry->uid_op == &uid_gt)
>>   			seq_printf(m, pt(Opt_uid_gt), tbuf);
>>   		else if (entry->uid_op == &uid_lt)
>> @@ -2114,7 +2116,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_EUID) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kuid_munged(user_ns, entry->uid));
>>   		if (entry->uid_op == &uid_gt)
>>   			seq_printf(m, pt(Opt_euid_gt), tbuf);
>>   		else if (entry->uid_op == &uid_lt)
>> @@ -2125,7 +2128,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_GID) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kgid_munged(user_ns, entry->gid));
>>   		if (entry->gid_op == &gid_gt)
>>   			seq_printf(m, pt(Opt_gid_gt), tbuf);
>>   		else if (entry->gid_op == &gid_lt)
>> @@ -2136,7 +2140,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_EGID) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kgid_munged(user_ns, entry->gid));
>>   		if (entry->gid_op == &gid_gt)
>>   			seq_printf(m, pt(Opt_egid_gt), tbuf);
>>   		else if (entry->gid_op == &gid_lt)
>> @@ -2147,7 +2152,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>>   	}
>>   
>>   	if (entry->flags & IMA_FOWNER) {
>> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
>> +		snprintf(tbuf, sizeof(tbuf),
>> +			 "%d", from_kuid_munged(user_ns, entry->fowner));
>>   		if (entry->fowner_op == &uid_gt)
>>   			seq_printf(m, pt(Opt_fowner_gt), tbuf);
>>   		else if (entry->fowner_op == &uid_lt)
>> @@ -2158,7 +2164,8 @@ int ima_policy_show(struct seq_file *m, void *v)
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
>> 2.34.1
