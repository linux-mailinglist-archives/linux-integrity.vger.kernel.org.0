Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B51477EC3
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 22:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhLPV1y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 16:27:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235006AbhLPV1x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 16:27:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGJt7vP010211;
        Thu, 16 Dec 2021 21:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5ao+xK1EgpsPTzgCgFw37uwPKVAFxaoR/OvOZzffXVM=;
 b=Lc0tXNLni0lDeqKDxkW4WXLuDEZwitStpqyLn1d6DikBXM2pZ/lVJXPImOSd7ZrY3025
 5Bt3SIuKjc2sxu5SGAaO2m72a+4AbUgJBcVGFYykKuD3lX20kRx9amG0SudSDEkHY31Z
 MTNNEYdvrABw1fqP66vZytHUHqrNqK5FLuaZ7dnKmvX8U1h3rljQkDkBso0VNbUzfYJb
 TeKtQuqc+lWnMHCB0EbXv8mamJzWqHB33i2Pug0sXIBA1ODEpQveGUJRpywLc1D7P7z2
 AZbcy+FY6H/pAJIHbXk/8LW7ciJJ37vnIm7G+zWYBDq9wIXRBBf+GPXUMMTgdfP++5qq Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyqbjbu5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 21:27:29 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BGLRNxT017924;
        Thu, 16 Dec 2021 21:27:29 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyqbjbu4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 21:27:29 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BGLDIOM000450;
        Thu, 16 Dec 2021 21:27:28 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 3cy7e4emxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 21:27:27 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BGLRQet19005888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 21:27:26 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A26213605D;
        Thu, 16 Dec 2021 21:27:26 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC929136053;
        Thu, 16 Dec 2021 21:27:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 21:27:24 +0000 (GMT)
Message-ID: <daccd334-7f8a-41a1-fedd-05c39c504b5b@linux.ibm.com>
Date:   Thu, 16 Dec 2021 16:27:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v7 00/14] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
 <20211216125027.fte6625wu5vxkjpi@wittgenstein>
 <20211216133148.aw3xs4sxuebkampb@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211216133148.aw3xs4sxuebkampb@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uC7bIVTeeyFtfdmZbjayVjyA-HV-BY_t
X-Proofpoint-ORIG-GUID: 0J9Y15GAcWP8TK9-4GgNvCyB4ZroCw0a
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_08,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112160113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/16/21 08:31, Christian Brauner wrote:
> On Thu, Dec 16, 2021 at 01:50:27PM +0100, Christian Brauner wrote:
>> On Thu, Dec 16, 2021 at 12:43:09AM -0500, Stefan Berger wrote:
>>
>>> This patch also introduces usage of CAP_MAC_ADMIN to allow access to the
>>> IMA policy via reduced capabilities. We would again later on use this
>>> capability to allow users to set file extended attributes for IMA appraisal
>>> support.
>>>
>>> My tree with these patches is here:
>>>
>>> git fetch https://github.com/stefanberger/linux-ima-namespaces v5.15+imans.v7.posted
>>>
>>> Regards,
>>>     Stefan
>>>
>>> v7:
>>>   - Dropped 2 patches related to key queues; using &init_ima_ns for all calls
>>>     from functions related to key queues where calls need ima_namespace
>>>   - Moved ima_namespace to security/integrity/ima/ima.h
>>>   - Extended API descriptions with ns parameter where needed
>>>   - Using init_ima_ns in functions related to appraisal and xattrs
>>>   - SecurityFS: Using ima_ns_from_file() to get ns pointer
>>>   - Reformatted to 80 columns per line
>> Since we're starting to be fairly along I would ask you to please write
>> detailed commit messages for the next revision.
>>
>> I would also like to see all links for prior versions of this patchset
>> in the commit message since the discussion has been fairly extensive so
>> for this series it makes a lot of sense. So something like:
>>
>> Link: https://lore.kernel.org/r/$MSGID (v1)
>> Link: https://lore.kernel.org/r/$MSGID (v2)
>> Link: https://lore.kernel.org/r/$MSGID (v3)
>> Link: https://lore.kernel.org/r/$MSGID (v4)
>> Link: https://lore.kernel.org/r/$MSGID (v5)
>> Link: https://lore.kernel.org/r/$MSGID (v6)
>> Link: https://lore.kernel.org/r/$MSGID (v7)
>> Signed-off-by: meh
>> Signed-off-by: mih
>> Signed-off-by: muh
>>
>> I find that extremely pleasant in case we need to revisit things later.
>> (Technically you can get the same by searching lore via the final link
>> but I find it be pretty pleasing to just copy+paste directly from the
>> commit message to the discussion for the earlier patch.)
> So I looked through the series from a high-level view for once and I
> would like to change how it is currently structured.
>
> Currently, it looks a lot like you end up with a half-namespaced ima if
> you compile and run a kernel in the middle of this patch series. Not
> just is this asking for semantic chaos if we need to debug something it
> also makes bisection a giant pain later.
>
> In addition, the fact that you need a hack like
>
>> +struct ima_namespace {
>> +	int avoid_zero_size;
> in the first patch is another good sign that this should be restructured.
>
> Here's how I would prefer to see this done. I think we should organize
> this in three big chunks (bullet points are not meant to signify
> individual patches):
>
> 1. namespace securityfs
>     This patch is thematically standalone and should move to the
>     beginning of the series.
>     I would strongly recommend to fold patch 9 and 10 into a single patch
>     and add a lengthy explanation. You should be able to recycle a lof of
>     stuff I wrote in earlier reviews.
>
> 2. Introduce struct ima_namespace and pass it through to all callers:
>     - introduce struct ima_namespace
>     - move all the relevant things into this structure (this also avoids
>       the "avoid_zero_size" hack).

Before I start any move and don't get it right:

Is this to be done like in the current set of patches in those steps 
where one thing is moved after another?


>     - define, setup, and expose init_ima_ns


We do this alongside the move of the individual pieces into 
ima_namesapce as is done across the patches now? Most of those 'move' 
patches haven't received much feedback so far.


>     - introduce get_current_ns() and always have it return &init_ima_ns for now
>     - replace all accesses to global variables to go through &init_ima_ns

And not pass get_current_ns() down from the top level and access the 
right away via ns->foobar but use init_ima_ns.foobar instead?


>     - add new infrastructure you'll need later on
>     Bonus is that you can extend all the functions that later need access
>     to a specific ima namespace to take a struct ima_namespace * argument
>     and pass down &init_ima_ns down (retrieved via get_current_ns()). This
>     will make the actual namespace patch very easy to follow.


I am wondering how this new series is going to relate to the existing 
series and the links you suggest be added on a per patch basis? How much 
of the existing patches can be preserved?


>
> 3. namespace ima
>     - add a new entry for struct ima_namespace to struct user_namespace
>     - add creation helpers, kmem cache etc.
>     - create files in securityfs per ns
>
> This way at all points in the series we have clearly defined semantics
> where ima namespacing is either fully working or fully not working and
> the switch is atomic in the patch(es) part of 3.


The existing series tried this by enabling IMA namespacing support when 
SecurityFS is enabled... Is that also the last step then in what you 
suggest?

