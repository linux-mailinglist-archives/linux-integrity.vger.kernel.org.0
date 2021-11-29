Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6924617EB
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 15:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377923AbhK2OZe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 09:25:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234191AbhK2OXd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 09:23:33 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATDkkG8019690;
        Mon, 29 Nov 2021 14:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jmsZe/xEkN4cSW5Yjd8y4hkMPC6IgFnHBbNVvRh71gY=;
 b=ieMjhulmCFB7GL4JEN67tdz1d5pc980Yscgju0fMIkecVzv8FfbMFpeo8ugTISkQU8gw
 EoehoFsY0kv1jQisFDGrJ1bfZ+4PqIf4M2lbXDUEnn25M10C+VaQ+eASf0qEQCXM/6CW
 i/qOmzZt7yzXM6tlmaF15q8kCX+JBixlW5SdQ/8vewjfD/5IiQdVwAmgxAZ648jLNjEG
 yY7IV/gT2oM+Jd2AhxMqUOPycU1HlBELus1cV1m8Q9z6SkdUCgXX/X8Zzs9evT8NiYjb
 rteVzjw89L5FhSuifTDjN02K/C64d8UGAkuhRTr+Xq8x6b4CYlyehOB9qr83LzgnzRmX NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn01w8u1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 14:19:56 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATDqqDK040598;
        Mon, 29 Nov 2021 14:19:56 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn01w8u0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 14:19:56 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATEDrBS022422;
        Mon, 29 Nov 2021 14:19:54 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03wdc.us.ibm.com with ESMTP id 3ckcaaaxw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 14:19:54 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATEJsGs56820204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 14:19:54 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4F39C6063;
        Mon, 29 Nov 2021 14:19:53 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F11FC606E;
        Mon, 29 Nov 2021 14:19:51 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 14:19:50 +0000 (GMT)
Message-ID: <01bd7270-df8c-de33-497e-13eb09679d28@linux.ibm.com>
Date:   Mon, 29 Nov 2021 09:19:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 1/3] userns: add uuid field
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
References: <20211128044558.GA11794@mail.hallyn.com>
 <2e32a6897877ed600de64b3d664dc6014389dbe4.camel@HansenPartnership.com>
 <20211128151805.GA15306@mail.hallyn.com>
 <60c99d461368593dfd51765c527b01c6bf0a9fea.camel@HansenPartnership.com>
 <20211128204715.GA17707@mail.hallyn.com>
 <e1b36c9c36f0f6d3262de6141ad67e8044cfeade.camel@HansenPartnership.com>
 <20211128214906.GA18470@mail.hallyn.com>
 <e1d8fcb0dffd5d88c95140f644ece25273071d79.camel@HansenPartnership.com>
 <20211129015901.GA20161@mail.hallyn.com>
 <9f3466c1-276b-1d7e-917c-37c6f02d5571@linux.ibm.com>
 <20211129135639.3boeegnusxllho35@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211129135639.3boeegnusxllho35@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jPQ_l5Zv75hK0WAl5_jFKmPYePDMaGi4
X-Proofpoint-GUID: uy6EH6FVMFrbbp1R49-9Ys6yVCh--NBE
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_08,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290071
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/29/21 08:56, Christian Brauner wrote:
> On Mon, Nov 29, 2021 at 08:49:40AM -0500, Stefan Berger wrote:
>> On 11/28/21 20:59, Serge E. Hallyn wrote:
>>> On Sun, Nov 28, 2021 at 05:56:28PM -0500, James Bottomley wrote:
>>>> On Sun, 2021-11-28 at 15:49 -0600, Serge E. Hallyn wrote:
>>>>> On Sun, Nov 28, 2021 at 04:21:29PM -0500, James Bottomley wrote:
>>>>>> On Sun, 2021-11-28 at 14:47 -0600, Serge E. Hallyn wrote:
>>>>>>> On Sun, Nov 28, 2021 at 01:00:28PM -0500, James Bottomley wrote:
>>>>>>>> On Sun, 2021-11-28 at 09:18 -0600, Serge E. Hallyn wrote:
>>>> [...]
>>>>>>>>> So given that 'unique per boot' is sufficient, what would be
>>>>>>>>> the problem with simply adding a simple ever-increasing
>>>>>>>>> unique atomix count to the struct user_namespace?
>>>>>>>> I don't think there is any ... but I equally don't see why
>>>>>>>> people would want to save and restore the uuid but not the new
>>>>>>>> monotonic identifier ... because it's still just a marker on a
>>>>>>>> namespace.
>>>>>>> But you've called it "the namespace uuid".  I'm not even really
>>>>>>> thinking of checkpoint/restart, just stopping and restarting a
>>>>>>> container.  I'm convinced people will want to start using it
>>>>>>> because, well, it is a nice feature.
>>>>>> Right, but the uniqueness property depends on you not being able to
>>>>>> set it.  If you just want a namespace label, you can have that, but
>>>>>> anything a user can set is either a pain to guarantee uniqueness
>>>>>> (have to check all the other objects) or is simply a non-unique
>>>>>> label.
>>>>>>
>>>>>> If you want to label a container, which could have many namespaces
>>>>>> and be stopped and restarted many times, it does sound like you
>>>>>> want a non-unique settable label.  However, IMA definitely needs a
>>>>>> guaranteed per namespace unique label.
>>>>>>
>>>>>> Is the objection simply you think a UUID sound like it should be
>>>>> Objection is too strong.  Concern.
>>>>>
>>>>> But yes, to me a uuid (a) feels like it should be generally useful
>>>>> including being settable and (b) not super duper 100% absolutely
>>>>> guaranteed to always be unique per boot, as an incremented counter
>>>>> would be.
>>>> OK, but a bunch of cats I found on the Internet agree with me, a UUID
>>>> shouldn't be settable:
>>>>
>>>> https://en.wikipedia.org/wiki/Universally_unique_identifier
>>>>
>>>> The key point being, if you can set the id, it can't be unique ... it
>>> Ok, so can you just put a comment above there saying "this must not
>>> be settable from userspace" ?
>> So I have been working on an IMA namespacing series again as well and would
>> like to use some sort of unique identifier for audit messages emitted from
>> an IMA/user namespace other than the init_ima_ns. This UUID may just work
>> for this, but how would one associate the UUID with a container if it ever
>> comes to that when evaluating audit logs? Shouldn't it be settable from user
>> space for some sort of 'coordination' between container runtime and kernel?
> Wouldn't this be solved by the audit container id patchset? In fact,
> can't we use this for IMA as well?

I suppose it's this yet-to-be-merged series you are referring to: 
https://lkml.org/lkml/2021/1/12/818

It would work for as long as it's *required* to set the identifier or 
the identifier is readily available when the first audit message needs 
to be emitted. If this is not the case then that unique identifier 
should maybe originate in the kernel and be queryable by user space but 
then again the same container may come up with different identifiers 
every time. I am not sure whether that is desirable. Some sort of 'base 
UUID' could be passed with the clone3() call and either all namespaces 
could derive from the base UUID or just get the same value. If that's 
not set the kernel gets to choose the base UUID... At least by updating 
container runtimes the coordination issue could be solved and with the 
clone3() call the early availability of the UUID could be guranteed?


