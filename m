Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3EF46170F
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 14:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244506AbhK2NzQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 08:55:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231931AbhK2NxO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 08:53:14 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATDl8Zt028162;
        Mon, 29 Nov 2021 13:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2FUUl4eyPX4tQe5O+maFuSt5luwvfRM83SL7Nqvw9io=;
 b=NLXJrM1wMCCLw00THQVgI1EN4ZRfJkNq38cTGyfEgp26SZjUPeVqeG8LT2BZu25q73h9
 bOQ7ie82ZCsPfgz+VdxLQVBCTUhwR6VMN9dTnLhUPPVhZ26pVlxwRpTZd4wCKQ/x9VOc
 Sv6G/hz21uwoGKeAXqMlx8BRiOXIhv93wXcsxbVJTMy96fRsjtJiGFJBY1+/MW0C2v/K
 gRtRlBDOwtusaGGXS9msjyQC31zyayABeSL9eeoxj01s5Ot7xsLuFd+U3hZakRwww+tZ
 K13614+MVud0n6Aiuj+UJ5GdMZBiEsFSuRyXI0yupS1KFF2JP6Q1Rdst9JbvxFMb3yC1 dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cn026r18h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:49:46 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATDlHL3028370;
        Mon, 29 Nov 2021 13:49:46 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cn026r189-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:49:45 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATDhTON022904;
        Mon, 29 Nov 2021 13:49:44 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 3ckcaajes6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:49:44 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATDnhdq53936530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 13:49:43 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25DA613605E;
        Mon, 29 Nov 2021 13:49:43 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 309D8136059;
        Mon, 29 Nov 2021 13:49:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 13:49:40 +0000 (GMT)
Message-ID: <9f3466c1-276b-1d7e-917c-37c6f02d5571@linux.ibm.com>
Date:   Mon, 29 Nov 2021 08:49:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 1/3] userns: add uuid field
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, containers@lists.linux.dev,
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
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-2-James.Bottomley@HansenPartnership.com>
 <20211128044558.GA11794@mail.hallyn.com>
 <2e32a6897877ed600de64b3d664dc6014389dbe4.camel@HansenPartnership.com>
 <20211128151805.GA15306@mail.hallyn.com>
 <60c99d461368593dfd51765c527b01c6bf0a9fea.camel@HansenPartnership.com>
 <20211128204715.GA17707@mail.hallyn.com>
 <e1b36c9c36f0f6d3262de6141ad67e8044cfeade.camel@HansenPartnership.com>
 <20211128214906.GA18470@mail.hallyn.com>
 <e1d8fcb0dffd5d88c95140f644ece25273071d79.camel@HansenPartnership.com>
 <20211129015901.GA20161@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211129015901.GA20161@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rMHOVYs9M0TRE1umvdBFMdb4ZPOYaW4J
X-Proofpoint-ORIG-GUID: rO7J5WKGAD4sR7WkeqHcUWJQiE5ytNJI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_08,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290068
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/28/21 20:59, Serge E. Hallyn wrote:
> On Sun, Nov 28, 2021 at 05:56:28PM -0500, James Bottomley wrote:
>> On Sun, 2021-11-28 at 15:49 -0600, Serge E. Hallyn wrote:
>>> On Sun, Nov 28, 2021 at 04:21:29PM -0500, James Bottomley wrote:
>>>> On Sun, 2021-11-28 at 14:47 -0600, Serge E. Hallyn wrote:
>>>>> On Sun, Nov 28, 2021 at 01:00:28PM -0500, James Bottomley wrote:
>>>>>> On Sun, 2021-11-28 at 09:18 -0600, Serge E. Hallyn wrote:
>> [...]
>>>>>>> So given that 'unique per boot' is sufficient, what would be
>>>>>>> the problem with simply adding a simple ever-increasing
>>>>>>> unique atomix count to the struct user_namespace?
>>>>>> I don't think there is any ... but I equally don't see why
>>>>>> people would want to save and restore the uuid but not the new
>>>>>> monotonic identifier ... because it's still just a marker on a
>>>>>> namespace.
>>>>> But you've called it "the namespace uuid".  I'm not even really
>>>>> thinking of checkpoint/restart, just stopping and restarting a
>>>>> container.  I'm convinced people will want to start using it
>>>>> because, well, it is a nice feature.
>>>> Right, but the uniqueness property depends on you not being able to
>>>> set it.  If you just want a namespace label, you can have that, but
>>>> anything a user can set is either a pain to guarantee uniqueness
>>>> (have to check all the other objects) or is simply a non-unique
>>>> label.
>>>>
>>>> If you want to label a container, which could have many namespaces
>>>> and be stopped and restarted many times, it does sound like you
>>>> want a non-unique settable label.  However, IMA definitely needs a
>>>> guaranteed per namespace unique label.
>>>>
>>>> Is the objection simply you think a UUID sound like it should be
>>> Objection is too strong.  Concern.
>>>
>>> But yes, to me a uuid (a) feels like it should be generally useful
>>> including being settable and (b) not super duper 100% absolutely
>>> guaranteed to always be unique per boot, as an incremented counter
>>> would be.
>> OK, but a bunch of cats I found on the Internet agree with me, a UUID
>> shouldn't be settable:
>>
>> https://en.wikipedia.org/wiki/Universally_unique_identifier
>>
>> The key point being, if you can set the id, it can't be unique ... it
> Ok, so can you just put a comment above there saying "this must not
> be settable from userspace" ?

So I have been working on an IMA namespacing series again as well and 
would like to use some sort of unique identifier for audit messages 
emitted from an IMA/user namespace other than the init_ima_ns. This UUID 
may just work for this, but how would one associate the UUID with a 
container if it ever comes to that when evaluating audit logs? Shouldn't 
it be settable from user space for some sort of 'coordination' between 
container runtime and kernel?

    Stefan


