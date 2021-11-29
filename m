Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6D461B8D
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 17:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbhK2QMz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 11:12:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239158AbhK2QKy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 11:10:54 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATFm0OA030586;
        Mon, 29 Nov 2021 16:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=P+h0LW38cx58Q+u/B7VpchjjD0S1wJM5I8K7t6UthAg=;
 b=FQEf1sL+C0kpHP16DgaBLikxChUW/pmz1ge+bCUjjwOoXbUZGhj7YsZWox18rUXT/kKn
 W3z4B5wznuqldCEO9C97HSP+8IT3TPh78ANjXBgNpTpH2IrNUNhLBdp8p/ceaq1nhrNG
 KL/gWJ1AhEYy9QlBmujqFhsFgZhVPKwzbSdxSKLvaNf4X4HPpmQy5qD1PcPKaLQ7t/al
 klVq2PLJfMe/h0MbXXzCzWxeBrHjhvNeJy/2eK8uLB6yDDnItf5DKrQ4n+u0THtVoTvG
 lPoOxuI6O6CBzk4+66E2lTevp2C8saNPGEW3PsrpiD/OKcytiqyJXICWwu5vMFHHo8rh Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn1tj8gfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 16:07:25 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATFta32032055;
        Mon, 29 Nov 2021 16:07:24 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn1tj8gf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 16:07:24 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATG3s5b011541;
        Mon, 29 Nov 2021 16:07:23 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3ckcaaxrmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 16:07:23 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATG7MU950725296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 16:07:22 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E5396E090;
        Mon, 29 Nov 2021 16:07:21 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A007D6E058;
        Mon, 29 Nov 2021 16:07:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 16:07:19 +0000 (GMT)
Message-ID: <2ce561d8-be86-1d49-23a4-720c13ada92d@linux.ibm.com>
Date:   Mon, 29 Nov 2021 11:07:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
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
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
 <20211129045834.GB20606@mail.hallyn.com>
 <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
 <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
 <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
 <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
 <afee2f0483271a6cdb1bc7b48b819a3ca2c4ceda.camel@HansenPartnership.com>
 <20211129153539.GA26325@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211129153539.GA26325@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zDKo_ugVEsqVM0TQdNBNBnvVwcN7vBYw
X-Proofpoint-ORIG-GUID: zZiomidkrvZtHEqWYeD7TUrloaee9BC_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_09,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290079
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/29/21 10:35, Serge E. Hallyn wrote:
> On Mon, Nov 29, 2021 at 09:46:55AM -0500, James Bottomley wrote:
>> On Mon, 2021-11-29 at 15:22 +0100, Christian Brauner wrote:
>>> On Mon, Nov 29, 2021 at 09:10:29AM -0500, James Bottomley wrote:
>>>> On Mon, 2021-11-29 at 08:53 -0500, Stefan Berger wrote:
>>>>> On 11/29/21 07:50, James Bottomley wrote:
>>>>>> On Sun, 2021-11-28 at 22:58 -0600, Serge E. Hallyn wrote:
>>>>>>> On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley
>>>>>>> wrote:
>>>>>>>> Currently we get one entry in the IMA log per unique file
>>>>>>>> event.  So, if you have a measurement policy and it
>>>>>>>> measures a particular binary it will not get measured again
>>>>>>>> if it is subsequently executed. For Namespaced IMA, the
>>>>>>>> correct behaviour seems to be to log once per inode per
>>>>>>>> namespace (so every unique execution in a namespace gets a
>>>>>>>> separate log entry).  Since logging once per inode per
>>>>>>>> namespace is
>>>>>>> I suspect I'll need to do a more in depth reading of the
>>>>>>> existing code, but I'll ask the lazy question anyway (since
>>>>>>> you say "the correct behavior seems to be") - is it actually
>>>>>>> important that files which were appraised under a parent
>>>>>>> namespace's policy already should be logged again?
>>>>>> I think so.  For a couple of reasons, assuming the namespace
>>>>>> eventually gets its own log entries, which the next incremental
>>>>>> patch proposed to do by virtualizing the securityfs
>>>>>> entries.  If you don't do this:
>>>>> To avoid duplicate efforts, an implementation of a virtualized
>>>>> securityfs is in this series here:
>>>>>
>>>>> https://github.com/stefanberger/linux-ima-namespaces/commits/v5.15%2Bimans.20211119.v3
>>>>>
>>>>> It starts with 'securityfs: Prefix global variables with
>>>>> secruityfs_'
>>>> That's quite a big patch series.  I already actually implemented
>>>> this as part of the RFC for getting the per namespace measurement
>>>> log.  The attached is basically what I did.
>>>>
>>>> Most of the time we don't require namespacing the actual virtualfs
>>>> file, because it's world readable.  IMA has a special requirement
>>>> in this regard because the IMA files should be readable (and
>>>> writeable when we get around to policy updates) by the admin of the
>>>> namespace but their protection is 0640 or 0440.  I thought the
>>>> simplest solution would be to make an additional flag that coped
>>>> with the permissions and a per-inode flag way of making the file as
>>>> "accessible by userns admin".  Doing something simple like this
>>>> gives a much smaller diffstat:
>>> That's a NAK from me. Stefan's series might be bigger but it does
>>> things correctly. I appreciate the keep it simple attitude but no. I
>>> won't speciale-case securityfs or similar stuff in core vfs helpers.
>> Well, there's a reason it's an unpublished patch.  However, the more
>> important point is that namespacing IMA requires discussion of certain
>> points that we never seem to drive to a conclusion.  Using the akpm
>> method, I propose simple patches that drive the discussion.  I think
>> the points are:
>>
>>     1. Should IMA be its own namespace or tied to the user namespace?  The
>>        previous patches all took the separate Namespace approach, but I
>>        think that should be reconsidered now keyrings are in the user
>>        namespace.
> Well that purely depends on the needed scope.
>
> The audit container identifier is a neat thing.  But it absolutely must
> be settable, so seems to conflict with your needs.
>
> Your patch puts an identifier on the user_namespace.  I'm not quite sure,
> does that satisfy Stefan's needs?  A new ima ns if and only if there is a
> new user ns?
>
> I think you two need to get together and discuss the requirements, and come
> back with a brief but very precise document explaining what you need.

What would those want who look at audit messages? [Idk] Would they want 
a constant identifier for IMA audit messages in the audit log across all 
restarts of a container? Presumably that would make quick queries across 
restarts much easier. Or could they live with an audit message emitted 
from the container runtime indicating that this time the (IMA) audit 
messages from this container will have this UUID here?

I guess both would 'work.'

>
> Are you both looking at the same use case?  Who is consuming the audit
> log, and to what end?  Container administrators?  Any time they log in?
> How do they assure themselves that the securityfs file they're reading
> hasn't been overmounted?

The question is also should there only be one identifier or can there be 
two different one (one from audit patch series and uuid of user namespace).


>
> I need to find a document to read about IMA's usage of PCRs.  For
> namespacing, are you expecting each container to be hooked up to a
> swtmp instance so they have their own PCR they can use?

It's complicated and there's a bit more to this... I would try to 
architect it in a way that the IMA system policy can cover what's going 
on inside IMA namespaces, i.e., audit and measure and appraise file 
accesses occurring in those namespace. We call it hierarchical 
processing ( 
https://github.com/stefanberger/linux-ima-namespaces/commit/e88dc84ec97753fd65d302ee1bf03951001ab48f 
) where file access are evaluated against the current namespace's policy 
and then also evaluated against those of parent namespaces back to the 
init_ima_ns. The goal is to avoid evasion of measurements etc. by the 
user just by spawning new IMA namespaces. I think logging into the IMA 
system log will not scale well if there are hundreds of containers on 
the system using IMA and logging into the system log and hammering the 
TPM. So, the answer then is write your policy in such a way that it 
doesn't cover the IMA/user namespaces (containers) and have each 
container have its own IMA policy and IMA log and and an optional vTPM. 
So my answer would be 'optional swtpm.'

    Stefan


