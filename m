Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982E9476866
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 03:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhLPCzw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 21:55:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48952 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233189AbhLPCzv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 21:55:51 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFMjNof008883;
        Thu, 16 Dec 2021 02:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=n1aarXbVf68G1xVu5ueFolIg01AbLnOTx4Qwo/7JSeM=;
 b=sGeVJHD8MVQgewhVU6V5i2aarMgxWb5GC2GtadhirEObboAzZ9cMe9FquaFrmPO691Ud
 wEC6bNoHepzBqfKmTzsH0uUOxr8wfDu9p+XDPIUYHA2FA+fBtL4iZYBEs6nmoHO5XOSB
 UyopPt0sVymCNAdQfjamXOG1ldhdnnbzdbj8hTkBgR5WxXYvSMwH1c0Ko7LP2SZHeH1Q
 cr88Ez/LrKkIrydPyBlOVzs8HFFb8nHMky7bofA8pSRsjvHSNL//FY9epZeew5jTO5w3
 LCjPyH+kJ0fWXAQsvm72XCySK33rIxsEgJ0u14cXMus5JJS2Osrh1CJxd52DCrJhfuqv 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cypc6fek0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:55:38 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG2sGxd016809;
        Thu, 16 Dec 2021 02:55:38 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cypc6fejr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:55:38 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG2lrix003230;
        Thu, 16 Dec 2021 02:55:37 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3cy7hf6q8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:55:37 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG2tasi26411358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 02:55:36 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 143D3124054;
        Thu, 16 Dec 2021 02:55:36 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DED6124052;
        Thu, 16 Dec 2021 02:55:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 02:55:35 +0000 (GMT)
Message-ID: <cd14c566-afaf-8295-5445-420164903336@linux.ibm.com>
Date:   Wed, 15 Dec 2021 21:55:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 10/16] ima: Implement hierarchical processing of file
 accesses
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-11-stefanb@linux.ibm.com>
 <20211208120954.nnawb6d2bpp54yll@wittgenstein>
 <20211208122339.vkqtuckl74ywg3s5@wittgenstein>
 <60fa585b-984e-fa13-e76f-56083a726259@linux.ibm.com>
 <395640be-e11d-c242-9e64-9ecf7b479f86@linux.ibm.com>
 <2cd00e8d0fa819b507cabd34e8f1760d5ff783c6.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <2cd00e8d0fa819b507cabd34e8f1760d5ff783c6.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gh5y9mLW-rzG7cTVHuP-4s9nM-bLT-l5
X-Proofpoint-GUID: nUDc9GT5K5sSTHUkAqxYtY2TbKFSYmuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160010
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/15/21 18:04, Mimi Zohar wrote:
> On Wed, 2021-12-08 at 13:22 -0500, Stefan Berger wrote:
>> On 12/8/21 11:50, Stefan Berger wrote:
>>> On 12/8/21 07:23, Christian Brauner wrote:
>>>> On Wed, Dec 08, 2021 at 01:09:54PM +0100, Christian Brauner wrote:
>>>>> On Tue, Dec 07, 2021 at 03:21:21PM -0500, Stefan Berger wrote:
>>>>>> Implement hierarchical processing of file accesses in IMA
>>>>>> namespaces by
>>>>>> walking the list of IMA namespaces towards the init_ima_ns. This way
>>>>>> file accesses can be audited in an IMA namespace and also be evaluated
>>>>>> against the IMA policies of parent IMA namespaces.
>>>>>>
>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>>> ---
>>>>>>    security/integrity/ima/ima_main.c | 29 +++++++++++++++++++++++++----
>>>>>>    1 file changed, 25 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/security/integrity/ima/ima_main.c
>>>>>> b/security/integrity/ima/ima_main.c
>>>>>> index 2121a831f38a..e9fa46eedd27 100644
>>>>>> --- a/security/integrity/ima/ima_main.c
>>>>>> +++ b/security/integrity/ima/ima_main.c
>>>>>> @@ -200,10 +200,10 @@ void ima_file_free(struct file *file)
>>>>>>        ima_check_last_writer(iint, inode, file);
>>>>>>    }
>>>>>>    -static int process_measurement(struct ima_namespace *ns,
>>>>>> -                   struct file *file, const struct cred *cred,
>>>>>> -                   u32 secid, char *buf, loff_t size, int mask,
>>>>>> -                   enum ima_hooks func)
>>>>>> +static int _process_measurement(struct ima_namespace *ns,
>>>>> Hm, it's much more common to use double underscores then single
>>>>> underscores to
>>>>>
>>>>> __process_measurement()
>>>>>
>>>>> reads a lot more natural to people perusing kernel code quite often.
>>>>>
>>>>>> +                struct file *file, const struct cred *cred,
>>>>>> +                u32 secid, char *buf, loff_t size, int mask,
>>>>>> +                enum ima_hooks func)
>>>>>>    {
>>>>>>        struct inode *inode = file_inode(file);
>>>>>>        struct integrity_iint_cache *iint = NULL;
>>>>>> @@ -405,6 +405,27 @@ static int process_measurement(struct
>>>>>> ima_namespace *ns,
>>>>>>        return 0;
>>>>>>    }
>>>>>>    +static int process_measurement(struct ima_namespace *ns,
>>>>>> +                   struct file *file, const struct cred *cred,
>>>>>> +                   u32 secid, char *buf, loff_t size, int mask,
>>>>>> +                   enum ima_hooks func)
>>>>>> +{
>>>>>> +    int ret = 0;
>>>>>> +    struct user_namespace *user_ns;
>>>>>> +
>>>>>> +    do {
>>>>>> +        ret = _process_measurement(ns, file, cred, secid, buf,
>>>>>> size, mask, func);
>>>>>> +        if (ret)
>>>>>> +            break;
>>>>>> +        user_ns = ns->user_ns->parent;
>>>>>> +        if (!user_ns)
>>>>>> +            break;
>>>>>> +        ns = user_ns->ima_ns;
>>>>>> +    } while (1);
>>>>> I'd rather write this as:
>>>>>
>>>>>      struct user_namespace *user_ns = ns->user_ns;
>>>>>
>>>>>      while (user_ns) {
>>>>>          ns = user_ns->ima_ns;
>>>>>
>>>>>              ret = __process_measurement(ns, file, cred, secid, buf,
>>>>> size, mask, func);
>>>>>              if (ret)
>>>>>                  break;
>>>>>          user_ns = user_ns->parent;
>>>>>
>>>>>      }
>>>>>
>>>>> because the hierarchy is only an implicit property inherited by ima
>>>>> namespaces from the implementation of user namespaces. In other words,
>>>>> we're only indirectly walking a hierarchy of ima namespaces because
>>>>> we're walking a hierarchy of user namespaces. So the ima ns actually
>>>>> just gives us the entrypoint into the userns hierarchy which the double
>>>>> deref writing it with a while() makes obvious.
>>>> Which brings me to another point.
>>>>
>>>> Technically nothing seems to prevent an ima_ns to survive the
>>>> destruction of its associated userns in ima_ns->user_ns?
>>>>
>>>> One thread does get_ima_ns() and mucks around with it while another one
>>>> does put_user_ns().
>>>>
>>>> Assume it's the last reference to the userns which is now -
>>>> asynchronously - cleaned up from ->work. So at some point you're ending
>>>> with a dangling pointer in ima_ns->user_ns eventually causing a UAF.
>>>>
>>>> If I'm thinking correct than you need to fix this. I can think of two
>>>> ways right now where one of them I'm not sure how well that would work:
>>>> 1. ima_ns takes a reference count to userns at creation. Here you need
>>>>      to make very sure that you're not ending up with reference counting
>>>>      cycles where the two structs keep each other alive.
>>> Right. I am not sure what the trigger would be for ima_ns to release
>>> that one reference.
>>>
>>>
>>>> 2. rcu trickery. That's the one I'm not sure how well that would work
>>>>      where you'd need rcu_read_lock()/rcu_read_unlock() with a
>>>>      get_user_ns() in the middle whenever you're trying to get a ref to
>>>>      the userns from an ima_ns and handle the case where the userns is
>>>>      gone.
>>>>
>>>> Or maybe I'me missing something in the patch series that makes this all
>>>> a non-issue.
>>> I suppose one can always call current_user_ns() to get a pointer to
>>> the current user namespace that the process is accessing the file in
>>> that IMA now reacts to. With the hierarchical processing we are
>>> walking backwards towards init_user_ns. The problem should only exist
>>> if something else frees the current user namespace (or its parents) so
>>> that the hierarchy collapses. Assuming we are always in a process
>>> context then 'current' should protect us, no ?
>>>
>> All existing callers to process_measurements call it at least once with
>> current_cred().
>>
>> The only problem that I see where we are accessing the IMA namespace
>> outside a process context is in 4/16 'ima: Move delayed work queue and
>> variables into ima_namespace' where a delayed work queue is used. I
>> fixed this now by getting an additional reference to the user namesapce
>> before scheduling the delayed work and release it when it ran or when it
>> is canceled (cancel_delayed_work_sync()) but it didn't run.
>>
>  From  the "ima: Move delayed work queue and variables into
> ima_namespace" patch description:
>     Since keys queued up for measurement currently are only relevant in
>     the init_ima_ns, call ima_init_key_queue() only when the init_ima_ns
>     is initialized.
>
> When IMA_QUEUE_EARLY_BOOT_KEYS is not enabled, ima_should_queue_key()
> simply returns false.  Why do the keys workqueue need to be namespaced?
> Is this preparatory for some future IMA namespacing?


06 ima: Move policy related variables into ima_namespace

05 ima: Move IMA's keys queue related variables into ima_namespace

04 ima: Move delayed work queue and variables into ima_namespace


06 requires the ima_namespace parameter to be passed into 
process_buffer_measurement(). The problem was ima_process_queued_keys() 
that needs to pass the namespace but it's probably sufficient to use 
&init_ima_ns there as the ima_namespace parameter, which would allow to 
drop 05 and 04.

   Stefan

>
> thanks,
>
> Mimi
>
