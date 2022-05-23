Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B099530FA0
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiEWM7G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 08:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiEWM7E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 08:59:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B96453A78;
        Mon, 23 May 2022 05:59:03 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NBhfMQ001446;
        Mon, 23 May 2022 12:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ao6i9q5nir95GhlKCWmpICQQ1/EhBatmG7utTJsxclM=;
 b=WrmPpM9V/d6B+QNI/k88Td7uajtbxVDDB0BbnfDVHSNM36kMX1EA7TiwYuAnb/bVo0CK
 YVWWM5sUFDKzqy2FmX7d3zylf/+8phwzTMZ8eHHwCWdmlSF0C4vh4FzxxZmgsuZJ4qvk
 eghoCWdb+yJQMBGli18uVozTJDJBMeDi0+JEGlkZXKFJlbJUO9FX7ZTyHQxx/HqW3v7D
 v3WPTArK/TZfmB/zepVExN+PwJpOOGxvimfQmTUiAKfgzx4Qfm9DmooAZvZd3NbYVYb5
 kY/Re+miMreuIGKTopbTjCz5ivc6ODaBESOB+Sj8VGks+hJcyGi5PPxNy/MopmpezeYV BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g89n49h3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 12:58:30 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24NCsjtX001541;
        Mon, 23 May 2022 12:58:29 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g89n49h3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 12:58:29 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24NCDx85003390;
        Mon, 23 May 2022 12:58:29 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 3g6qq9r42d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 12:58:29 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24NCwR2128574014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 12:58:27 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9FDDBE059;
        Mon, 23 May 2022 12:58:27 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99E4BBE04F;
        Mon, 23 May 2022 12:58:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 23 May 2022 12:58:26 +0000 (GMT)
Message-ID: <22582372-97ba-d1ad-3025-0cc88ac3a721@linux.ibm.com>
Date:   Mon, 23 May 2022 08:58:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v12 13/26] userns: Add pointer to ima_namespace to
 user_namespace
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-14-stefanb@linux.ibm.com>
 <20220522182426.GA24765@mail.hallyn.com>
 <20220523095932.adr2r26o2obch4r5@wittgenstein>
 <e1df20d5-a6c9-d30c-3671-46f7a8742bc0@linux.ibm.com>
 <20220523124159.zsbp2gonh2dum4jm@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220523124159.zsbp2gonh2dum4jm@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4cWlrSfImznvrFA0dW4Wt9l_S4KY84H_
X-Proofpoint-GUID: fzVbuZwu2trqr4BKcUeQwfU4ah-7RkDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_06,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230069
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/23/22 08:41, Christian Brauner wrote:
> On Mon, May 23, 2022 at 07:31:29AM -0400, Stefan Berger wrote:
>>
>>
>> On 5/23/22 05:59, Christian Brauner wrote:
>>> On Sun, May 22, 2022 at 01:24:26PM -0500, Serge Hallyn wrote:
>>>> On Wed, Apr 20, 2022 at 10:06:20AM -0400, Stefan Berger wrote:
>>>>> Add a pointer to ima_namespace to the user_namespace and initialize
>>>>> the init_user_ns with a pointer to init_ima_ns. We need a pointer from
>>>>> the user namespace to its associated IMA namespace since IMA namespaces
>>>>> are piggybacking on user namespaces.
>>>>>
>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>> Acked-by: Christian Brauner <brauner@kernel.org>
>>>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>>>>
>>>>> ---
>>>>> v11:
>>>>>    - Added lost A-b from Christian back
>>>>>    - Added sentence to patch description explaining why we need the pointer
>>>>>
>>>>> v9:
>>>>>    - Deferred implementation of ima_ns_from_user_ns() to later patch
>>>>> ---
>>>>>    include/linux/ima.h            | 2 ++
>>>>>    include/linux/user_namespace.h | 4 ++++
>>>>>    kernel/user.c                  | 4 ++++
>>>>>    3 files changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>>>>> index 426b1744215e..fcb60a44e05f 100644
>>>>> --- a/include/linux/ima.h
>>>>> +++ b/include/linux/ima.h
>>>>> @@ -14,6 +14,8 @@
>>>>>    #include <crypto/hash_info.h>
>>>>>    struct linux_binprm;
>>>>> +extern struct ima_namespace init_ima_ns;
>>>>> +
>>>>>    #ifdef CONFIG_IMA
>>>>>    extern enum hash_algo ima_get_current_hash_algo(void);
>>>>>    extern int ima_bprm_check(struct linux_binprm *bprm);
>>>>> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
>>>>> index 33a4240e6a6f..019e8cf7b633 100644
>>>>> --- a/include/linux/user_namespace.h
>>>>> +++ b/include/linux/user_namespace.h
>>>>> @@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
>>>>>    #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
>>>>>    struct ucounts;
>>>>> +struct ima_namespace;
>>>>>    enum ucount_type {
>>>>>    	UCOUNT_USER_NAMESPACES,
>>>>> @@ -99,6 +100,9 @@ struct user_namespace {
>>>>>    #endif
>>>>>    	struct ucounts		*ucounts;
>>>>>    	long ucount_max[UCOUNT_COUNTS];
>>>>> +#ifdef CONFIG_IMA_NS
>>>>
>>>> It's probably worth putting a comment here saying that user_ns does not
>>>> pin ima_ns.
>>>>
>>>> That the only time the ima_ns will be freed is when user_ns is freed,
>>>> and only time it will be changed is when user_ns is freed, or during
>>>> ima_fs_ns_init() (under smp_load_acquire) during a new mount.
>>>>
>>>>> +	struct ima_namespace	*ima_ns;
>>>>
>>>> So, if I create a new user_ns with a new ima_ns, and in there I
>>>> create a new user_ns again, it looks like ima_ns will be NULL in
>>>> the new user_ns?  Should it not be set to the parent->ima_ns?
>>>> (which would cause trouble for the way it's currently being
>>>> freed...)
>>>
>>> Would also work and wouldn't be difficult to do imho.
>>
>> We previously decide to create an ima_namespace when securityfs is mounted.
>> This now also applies to nested containers where an IMA namespace is first
>> configured with the hash and template to use in a particular container and
>> then activated. If no configuration is done it will inherit the hash and
>> template from the first ancestor that has been configure when it is
>> activated. So the same steps and behavior applies to *all* containers, no
>> difference at any depth of nesting. Besides that, we don't want nested
>> containers to share policy and logs but keep them isolated from each other,
>> or do we not?
>>
>> Further, how should it work if we were to apply this even to the first
>> container? Should it just inherit the &init_ima_namespace and we'd have no
>> isolation at all? Why would we start treating containers at deeper nesting
>> levels differently?
> 
> Valid points. I understood Serge as suggesting an implementation detail
> change not a design change but might misunderstand him here.
> 
> # Currently
> 
> 1. create new userns -> imans set to NULL
> 2. mount securityfs and configure imans -> set imans to &new_ima_ns
> 
> When 2. hasn't been done then we find the relevant imans by walking
> the userns hierarchy upwards finding the first parent userns that has a
> non-NULL imans.
> 
> # Serge's suggestion
> 
> 1. create new userns -> imans is set to parent imans
> 2. mount securityfs and configure imans -> replace parent with &new_ima_ns
> 
> So when 2. hasn't been done we don't need to walk the userns hierarchy
> upwards. We always find the relevant imans directly. Some massaging

In my understanding we *always* have to walk the hierarchy upwards 
independent of nesting depth and visit all the parent namespaces so we 
don't miss anything that has happened in a child namespace and can log 
the action in the parent namespaces depending on that namespace's 
policy. It's this command line that I am concerned about that must not 
lead to concealing of running of programs in nested user namespaces from 
the init_ima_ns for example:

unshare --user --map-root-user \
   unshare --user --map-root-user \
   unshare --user --map-root-user \
   ... \
   <malware>

The malware would obviously run in the init_(pid|mnt|...)_namespace's.

Similarly this applies to running nested user namespaces that root could 
nsenter into to try to conceal the execution of programs.

So I would rather want to prevent having to walk namespaces backwards 
and encountering an ima_namespace pointer multiple times and having to 
figure out whether the evaluation of the policy of that namespace 
already occurred. I'd rather skip over user namespaces with NULL 
pointers to IMA namespaces because those have not been configured and/or 
activated, yet.

> would be needed in process_measurement() probably but it wouldn't need
> to change semantics per se.
> 
> But I think I misunderstood something in any case. So looking at an
> example like ima_post_path_mknod(). You seem to not call into
> ima_must_appraise() if the caller's userns doesn't have an imans
> enabled. I somehow had thought that the same logic applied as in
> process_measurement. But if it isn't then it might make sense to keep
> the current implementation.
