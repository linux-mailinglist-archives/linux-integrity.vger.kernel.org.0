Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6374466978
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 18:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376488AbhLBR63 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 12:58:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1376486AbhLBR62 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 12:58:28 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2HkpVc022493;
        Thu, 2 Dec 2021 17:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=mWardeEN34QmwHWWMnolE3Vo3MtreJ/o6Dm6dMiwj6U=;
 b=DPzbR2nLHd6PEvRBwGRZVOWqs289red4BbGpWTUXEAaHvkZ0qPRsld5rXjrJSXDiLuUe
 xz7qUxzwq2ILqKgH9duxC0KvxwRsiiut4e/D2Kl1AmMRDUovkVNBdIlZGoarUPWPPecA
 1ddfafV+UEGqtyUA7oJhREtmK22AXldUo3vtGq0FUvO0SNE7popaYqeCjleHbdZZM8zH
 gDjIA0pD7qQEiUo/sZTTmbj8x3bgGckAhAiCpyPGiLVeMucC2RVJnwKwU3Ap2jcD4mzv
 z//oXE4Ep8NpV/hkPjBVXceDmlwrOZ1THtxyT5281L3RwdsCH4m4VezvY9KvUGV26lcC xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cq2uj064s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 17:54:44 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2Hl9BD026018;
        Thu, 2 Dec 2021 17:54:44 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cq2uj064j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 17:54:44 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2HfO0c005564;
        Thu, 2 Dec 2021 17:54:43 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne3axue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 17:54:43 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2Hsfd730278138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 17:54:41 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 183FE78060;
        Thu,  2 Dec 2021 17:54:41 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 481EE7805E;
        Thu,  2 Dec 2021 17:54:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 17:54:38 +0000 (GMT)
Message-ID: <ca119ada-c7c5-ff91-24b8-e4809c57d011@linux.ibm.com>
Date:   Thu, 2 Dec 2021 12:54:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 17/20] ima: Use integrity_admin_ns_capable() to check
 corresponding capability
Content-Language: en-US
To:     Denis Semakin <denis.semakin@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "mpeters@redhat.com" <mpeters@redhat.com>,
        "lhinds@redhat.com" <lhinds@redhat.com>,
        "lsturman@redhat.com" <lsturman@redhat.com>,
        "puiterwi@redhat.com" <puiterwi@redhat.com>,
        "jamjoom@us.ibm.com" <jamjoom@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "rgb@redhat.com" <rgb@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-18-stefanb@linux.ibm.com>
 <7c751783b28766412f158e5ca074748ed18070bd.camel@linux.ibm.com>
 <34085058-ff5f-c28e-c716-6f4fa71747a3@linux.ibm.com>
 <4b12309289c6a51991c5062fed0fde03e0a6f703.camel@linux.ibm.com>
 <70960f70d44840789b5f7a847116281e@huawei.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <70960f70d44840789b5f7a847116281e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w6BUdIvDJ7G4Qfc3ZZbpujMoyDJEIIGA
X-Proofpoint-GUID: 6Sz1Xv7YR2fMotG61WgActJmXguHOwit
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_12,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/2/21 02:16, Denis Semakin wrote:
> Obviously the main goal by adding new capability was to avoid the using CAP_SYS_ADMIN (IOW superuser)
> to manage IMA stuff, that was also about security granularity.  It's good if CAP_MAC_ADMIN will be enough for doing IMA related things (write policies and extended attributes).
> But for me it's a little bit unclear how to deal with unprivileged users: assuming there's no CAP_INTEGRITY_ADMIN but CAP_MAC_ADMIN was set up, so in this case user can control any LSM (seLinux, SMACK, etc) and IMA (policies, xattrs). What if .. for some systems there would be some requirements that will allow to touch LSM but do not change any IMA (integrity) things? A user can set up any IMA policy (it's about the system integrity), modify IMA related xattrs but it's forbidden to change seLinux policies and e.g. SMACK labels... May be it's unreal scenario of course... but I guess it's not 100% impossible.

If we can introduce a new capability I would use CAP_INTEGRITY_ADMIN, if 
not CAP_MAC_ADMIN.


    Stefan

>
> Best regards,
> Denis
>
>
> -----Original Message-----
> From: James Bottomley [mailto:jejb@linux.ibm.com]
> Sent: Wednesday, December 1, 2021 10:29 PM
> To: Stefan Berger <stefanb@linux.ibm.com>; linux-integrity@vger.kernel.org
> Cc: zohar@linux.ibm.com; serge@hallyn.com; christian.brauner@ubuntu.com; containers@lists.linux.dev; dmitry.kasatkin@gmail.com; ebiederm@xmission.com; Krzysztof Struczynski <krzysztof.struczynski@huawei.com>; Roberto Sassu <roberto.sassu@huawei.com>; mpeters@redhat.com; lhinds@redhat.com; lsturman@redhat.com; puiterwi@redhat.com; jamjoom@us.ibm.com; linux-kernel@vger.kernel.org; paul@paul-moore.com; rgb@redhat.com; linux-security-module@vger.kernel.org; jmorris@namei.org; Denis Semakin <denis.semakin@huawei.com>
> Subject: Re: [RFC 17/20] ima: Use integrity_admin_ns_capable() to check corresponding capability
>
> On Wed, 2021-12-01 at 12:35 -0500, Stefan Berger wrote:
>> On 12/1/21 11:58, James Bottomley wrote:
>>> On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
>>>> From: Denis Semakin <denis.semakin@huawei.com>
>>>>
>>>> Use integrity_admin_ns_capable() to check corresponding capability
>>>> to allow read/write IMA policy without CAP_SYS_ADMIN but with
>>>> CAP_INTEGRITY_ADMIN.
>>>>
>>>> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
>>>> ---
>>>>    security/integrity/ima/ima_fs.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/security/integrity/ima/ima_fs.c
>>>> b/security/integrity/ima/ima_fs.c index fd2798f2d224..6766bb8262f2
>>>> 100644
>>>> --- a/security/integrity/ima/ima_fs.c
>>>> +++ b/security/integrity/ima/ima_fs.c
>>>> @@ -393,7 +393,7 @@ static int ima_open_policy(struct inode
>>>> *inode, struct file *filp)
>>>>    #else
>>>>    		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>>>>    			return -EACCES;
>>>> -		if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
>>>> +		if (!integrity_admin_ns_capable(ns->user_ns))
>>> so this one is basically replacing what you did in RFC 16/20, which
>>> seems a little redundant.
>>>
>>> The question I'd like to ask is: is there still a reason for needing
>>> CAP_INTEGRITY_ADMIN?  My thinking is that now IMA is pretty much
>>> tied to requiring a user (and a mount, because of
>>> securityfs_ns) namespace, there might not be a pressing need for an
>>> admin capability separated from CAP_SYS_ADMIN because the owner of
>>> the user namespace passes the ns_capable(..., CAP_SYS_ADMIN) check.
>>> The rationale in
>> Casey suggested using CAP_MAC_ADMIN, which I think would also work.
>>
>>       CAP_MAC_ADMIN (since Linux 2.6.25)
>>                 Allow MAC configuration or state changes. Implemented
>> for
>>                 the Smack Linux Security Module (LSM).
>>
>>
>> Down the road I think we should cover setting file extended attributes
>> with the same capability as well for when a user signs files or
>> installs packages with file signatures.  A container runtime could
>> hold CAP_SYS_ADMIN while setting up a container and mounting
>> filesystems and drop it for the first process started there. Since we
>> are using the user namespace to spawn an IMA namespace, we would then
>> require CAP_SYSTEM_ADMIN to be left available so that the user can do
>> IMA related stuff in the container (set or append to the policy, write
>> file signatures). I am not sure whether that should be the case or
>> rather give the user something finer grained, such as CAP_MAC_ADMIN.
>> So, it's about granularity...
> It's possible ... any orchestration system that doesn't enter a user
> namespace has to strictly regulate capabilities.   I'm probably biased
> because I always use a user_ns so I never really had to mess with capabilities.
>
>>> https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerat
>>> ions
>>>
>>> Is effectively "because CAP_SYS_ADMIN is too powerful" but that's no
>>> longer true of the user namespace owner.  It only passes the
>>> ns_capable() check not the capable() one, so while it does get
>>> CAP_SYS_ADMIN, it can only use it in a few situations which
>>> represent quite a power reduction already.
>> At least docker containers drop CAP_SYS_ADMIN.
> Well docker doesn't use the user_ns.  But even given that, CAP_SYS_ADMIN is always dropped for most container systems.  What happens when you enter a user namespace is the ns_capable( ...,
> CAP_SYS_ADMIN) check returns true if you're the owner of the user_ns, in the same way it would for root.  So effectively entering a user namespace without CAP_SYS_ADMIN but mapping the owner id to 0 (what unshare -r --user does) gives you back a form of CAP_SYS_ADMIN that responds only in the places in the kernel that have a ns_capable() check instead of a capable() one (most of the places you list below).
> This is the principle of how unprivileged containers actually work ...
> and the source of some of our security problems if you get back an ability to do something you shouldn't be allowed to do as an unprivileged user.
>
>>   I am not sure what the decision was based on but probably they don't
>> want to give the user what is not absolutely necessary, but usage of
>> user namespaces (with IMA namespaces) would kind of force it to be
>> available then to do IMA-related stuff ...
>>
>> Following this man page here
>> https://man7.org/linux/man-pages/man7/user_namespaces.7.html
>>
>> CAP_SYS_ADMIN in a user namespace is about
>>
>> - bind-mounting filesystems
>>
>> - mounting /proc filesystems
>>
>> - creating nested user namespaces
>>
>> - configuring UTS namespace
>>
>> - configuring whether setgroups() can be used
>>
>> - usage of setns()
>>
>>
>> Do we want to add '- only way of *setting up* IMA related stuff' to
>> this list?
> I don't see why not, but other container people should weigh in because, as I said, I mostly use the user namespace and unprivileged containers and don't bother with capabilities.
>
> James
>
>
