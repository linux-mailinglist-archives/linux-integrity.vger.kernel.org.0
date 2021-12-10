Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C245E4703EB
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 16:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhLJPga (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 10:36:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhLJPga (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 10:36:30 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAESlDF028803;
        Fri, 10 Dec 2021 15:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QXkAoGRUSqajWh2lh1ecNPfcB8fABmXkCu9QlMXkY14=;
 b=AFZs/JECV6KAXBM0NNeXsDeri8EOsIyJR0kd8U1reYsllbAY5qmjCxJJH3ksdU9e7pTw
 uskOqWvwaAZE/3Ue0VPQ6gmLHQC7yCqBNUmdtm/Uw7Nj4omUaFA9DzY3VdcSXXXnwMBw
 rv2K/vpMwmTorjeFY88HSc1PgXlF9vWzdGupdS5QdykUCM2ZF1esDH8cBaYfp0v2nLTv
 pReQ45NhW1n4YEuBOTZRGN8V52TAEYnKPu2n8pUeYjjylivvpC+ckq22W+12YHMTP1Uc
 hBCvbUbFUiyGo0sSBCiq6oTksBRpvevPwc8PkeZcFyIvjTI7W4Eo3SgrtOHXdErKOrHB 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv8pq9cfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 15:32:39 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAFNpjT021877;
        Fri, 10 Dec 2021 15:32:38 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv8pq9cfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 15:32:38 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAFI4BU006492;
        Fri, 10 Dec 2021 15:32:37 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 3cqyyeegft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 15:32:37 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAFWZVK46334348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 15:32:35 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2F8E28060;
        Fri, 10 Dec 2021 15:32:35 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6556E28058;
        Fri, 10 Dec 2021 15:32:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 15:32:35 +0000 (GMT)
Message-ID: <9806a2ba-8b45-3bb8-22c5-797ab2affaac@linux.ibm.com>
Date:   Fri, 10 Dec 2021 10:32:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, jejb@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-16-stefanb@linux.ibm.com>
 <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
 <20211209143749.wk4agkynfqdzftbl@wittgenstein>
 <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
 <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
 <20211210114934.tacjnwryihrsx6ln@wittgenstein>
 <2587716d7d021c35e3b6ef22b6e30f44c2b3f98e.camel@linux.ibm.com>
 <6de8d349-74f8-7be4-3854-5c4ac72860ad@linux.ibm.com>
 <d8a6a6827da17825c1aa011256b96d195b1ebf13.camel@linux.ibm.com>
 <66b377f6-40b4-77da-c02b-2650fa72d0b4@linux.ibm.com>
 <d6011a5a40c3c304f386a328385836ba9838baf9.camel@linux.ibm.com>
 <b8f3fe8de8788da92c3822912c11404a46531ac2.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <b8f3fe8de8788da92c3822912c11404a46531ac2.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ruUhLg4XjurIuQ6uHu_8smb255bCF1G0
X-Proofpoint-ORIG-GUID: i_DHK2dEWAuWGRHiD4vx6NeSNhlyuRjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_05,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/10/21 10:26, Mimi Zohar wrote:
> On Fri, 2021-12-10 at 09:26 -0500, James Bottomley wrote:
>> On Fri, 2021-12-10 at 09:17 -0500, Stefan Berger wrote:
>>> On 12/10/21 08:02, Mimi Zohar wrote:
>>>> On Fri, 2021-12-10 at 07:40 -0500, Stefan Berger wrote:
>>>>> On 12/10/21 07:09, Mimi Zohar wrote:
>>>>>> On Fri, 2021-12-10 at 12:49 +0100, Christian Brauner wrote:
>>>>>>>> There's still the problem that if you write the policy,
>>>>>>>> making the file disappear then unmount and remount
>>>>>>>> securityfs it will come back.  My guess for fixing this is
>>>>>>>> that we only stash the policy file reference,
>>>>>>>> create it if NULL but then set the pointer to PTR_ERR(-
>>>>>>>> EINVAL) or something and refuse to create it for that
>>>>>>>> value.
>>>>>>> Some sort of indicator that gets stashed in struct ima_ns
>>>>>>> that the file does not get recreated on consecutive mounts.
>>>>>>> That shouldn't be hard to fix.
>>>>>> The policy file disappearing is for backwards compatibility,
>>>>>> prior to being able to extend the custom policy.  For embedded
>>>>>> usecases, allowing the policy to be written exactly once might
>>>>>> makes sense.  Do we really want/need to continue to support
>>>>>> removing the policy in namespaces?
>>>>> I don't have an answer but should the behavior for the same
>>>>> #define in this case be different for host and namespaces? Or
>>>>> should we just 'select IMA_WRITE_POLICY and IMA_READ_POLICY' when
>>>>> IMA_NS is selected?
>>>> The latter option sounds good.  Being able to analyze the namespace
>>>> policy is really important.
>>> Ok, I will adjust the Kconfig for this then. This then warrants the
>>> question whether to move the dentry into the ima_namespace. The
>>> current code looks like this.
>>>
>>> #if !defined(CONFIG_IMA_WRITE_POLICY) &&
>>> !defined(CONFIG_IMA_READ_POLICY)
>>>           securityfs_remove(ns->policy_dentry);
>>>           ns->policy_dentry = NULL;
>>>           ns->policy_dentry_removed = true;
>>> #elif defined(CONFIG_IMA_WRITE_POLICY)
>>>
>>> With IMA_NS selecting IMA_WRITE_POLICY and IMA_READ_POLICY the above
>>> wouldn't be necessary anymore but I find it 'cleaner' to still have
>>> the dentry isolated rather than it being a global static as it was
>>> before...
>> This is really, really why you don't want the semantics inside the
>> namespace to differ from those outside, because it creates confusion
>> for the people reading the code, especially with magically forced
>> config options like this.  I'd strongly suggest you either keep the
>> semantic in the namespace or eliminate it entirely.
>>
>> If you really, really have to make the namespace behave differently,
>> then use global variables and put a big comment on that code saying it
>> can never be reached once CONFIG_IMA_NS is enabled.
> The problem seems to be with removing the securityfs policy file.
> Instead of removing it, just make it inacessible for the "if
> !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)"
> case.

So we would then leave it up to the one building the kernel to select 
the proper compile time options (suggested ones being IMA_WRITE_POLICY 
and IMA_READ_POLICY being enabled?) and behavior of host and IMA 
namespace is then the same per those options? Removing the file didn't 
seem the problem to me but more like whether the host should ever behave 
differently from the namespace.

    Stefan

>
> thanks,
>
> Mimi
>
