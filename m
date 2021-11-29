Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44AF461AE5
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 16:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344677AbhK2Pco (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 10:32:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237054AbhK2Pao (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 10:30:44 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATFHoZA008059;
        Mon, 29 Nov 2021 15:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2SrZa8vyNi7z5lYPwmZoGm94XkYQzGlUb5dOigu6psQ=;
 b=YmJl1a5DhPaXJYIvZ/UJ6mSt4Fm6Z/PAZkPgDwSKS8MUrJROGF/2ABukNrNwcZaQRGvW
 ZsLPGOgRghe9qshpjz5bN/y7wO/OZgQIPjFYOVwNUWLiSQ7ZreEawt4fyJP+ycACdQ/S
 yUvDaBKMn77yVo6PWstcge6eapoCNTLqGDDbN/Kmea1kVBsSlUyzh1wNoE6aYvHZdxfC
 p5UcopFfXd13LcdAxZyGspZGCJNYhJ+i7v+MMPc3sHKCZV/cNNQp17dLsOTDcNs1iLgS
 T4Y8UT1ZXZ3aqs3H64vfYaKSUTJbKkMY36AMRXUsnsGLkPWXHGeyqAbptHruC6JqI4jl LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn1cpr5xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 15:27:13 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATFPG6G002805;
        Mon, 29 Nov 2021 15:27:11 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn1cpr5ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 15:27:11 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATFHG6V015116;
        Mon, 29 Nov 2021 15:27:10 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 3ckcaanf44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 15:27:10 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATFR9s957016702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 15:27:09 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D68B28059;
        Mon, 29 Nov 2021 15:27:09 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C42C62806E;
        Mon, 29 Nov 2021 15:27:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 15:27:08 +0000 (GMT)
Message-ID: <3e609b60-221a-8b9b-5f55-ab7081a83786@linux.ibm.com>
Date:   Mon, 29 Nov 2021 10:27:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <afee2f0483271a6cdb1bc7b48b819a3ca2c4ceda.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iqSwyweeqqdHqCnWnd0msYH_Jwz4uiH2
X-Proofpoint-ORIG-GUID: AO4C5fLMxg-sIS47GgeNDxBoFYDBoSsT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_09,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290073
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/29/21 09:46, James Bottomley wrote:
> On Mon, 2021-11-29 at 15:22 +0100, Christian Brauner wrote:
>> On Mon, Nov 29, 2021 at 09:10:29AM -0500, James Bottomley wrote:
>>> On Mon, 2021-11-29 at 08:53 -0500, Stefan Berger wrote:
>>>> On 11/29/21 07:50, James Bottomley wrote:
>>>>> On Sun, 2021-11-28 at 22:58 -0600, Serge E. Hallyn wrote:
>>>>>> On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley
>>>>>> wrote:
>>>>>>> Currently we get one entry in the IMA log per unique file
>>>>>>> event.  So, if you have a measurement policy and it
>>>>>>> measures a particular binary it will not get measured again
>>>>>>> if it is subsequently executed. For Namespaced IMA, the
>>>>>>> correct behaviour seems to be to log once per inode per
>>>>>>> namespace (so every unique execution in a namespace gets a
>>>>>>> separate log entry).  Since logging once per inode per
>>>>>>> namespace is
>>>>>> I suspect I'll need to do a more in depth reading of the
>>>>>> existing code, but I'll ask the lazy question anyway (since
>>>>>> you say "the correct behavior seems to be") - is it actually
>>>>>> important that files which were appraised under a parent
>>>>>> namespace's policy already should be logged again?
>>>>> I think so.  For a couple of reasons, assuming the namespace
>>>>> eventually gets its own log entries, which the next incremental
>>>>> patch proposed to do by virtualizing the securityfs
>>>>> entries.  If you don't do this:
>>>> To avoid duplicate efforts, an implementation of a virtualized
>>>> securityfs is in this series here:
>>>>
>>>> https://github.com/stefanberger/linux-ima-namespaces/commits/v5.15%2Bimans.20211119.v3
>>>>
>>>> It starts with 'securityfs: Prefix global variables with
>>>> secruityfs_'
>>> That's quite a big patch series.  I already actually implemented
>>> this as part of the RFC for getting the per namespace measurement
>>> log.  The attached is basically what I did.
>>>
>>> Most of the time we don't require namespacing the actual virtualfs
>>> file, because it's world readable.  IMA has a special requirement
>>> in this regard because the IMA files should be readable (and
>>> writeable when we get around to policy updates) by the admin of the
>>> namespace but their protection is 0640 or 0440.  I thought the
>>> simplest solution would be to make an additional flag that coped
>>> with the permissions and a per-inode flag way of making the file as
>>> "accessible by userns admin".  Doing something simple like this
>>> gives a much smaller diffstat:
>> That's a NAK from me. Stefan's series might be bigger but it does
>> things correctly. I appreciate the keep it simple attitude but no. I
>> won't speciale-case securityfs or similar stuff in core vfs helpers.
> Well, there's a reason it's an unpublished patch.  However, the more
> important point is that namespacing IMA requires discussion of certain
> points that we never seem to drive to a conclusion.  Using the akpm
> method, I propose simple patches that drive the discussion.  I think
> the points are:
[...]
>
>
> And, of course, the fun ones we're coming to.
>
>     1. Given that the current keyring namespacing doesn't give access to
>        the system keyrings, how do we get per-namespace access for
>        .ima/_ima system keyrings given that the namespace admin is going to
>        want to set their own key for appraisal?
>     2. What mechanism should we use for .ima/_ima key setting?  The current
>        mechanism is must be signed by a key in the system keyrings sounds
>        appropriate, but is problematic given most system owners don't
>        actually have any private keys for keys in the system keyrings.
>        Hopefully the MoK keyring patches will help us have an easier
>        approach to this.

The approach we took in the previous implementation was to support BYOK 
(bring your own key) for every container. The (trusted) container 
runtime has to do what dracut would typically do, namely create the 
keyrings and load the keys onto it.

The container runtime would

1a) expect keys to be found inside a container's filesystem at the usual 
location (/etc/keys/ima) but then also allow for a CA key that is used 
to verify the signature of those keys; that CA key is typically baked 
into the Linux kernel when .ima is to be used, but for containers and 
BYOK it's an additional file in the container's filesystem

1b) passing in keys via command line should be possible as well but 
that's an implementation detail

2) container runtime sets up either a restricted keyring [ 
https://elixir.bootlin.com/linux/latest/source/Documentation/crypto/asymmetric-keys.rst#L359 
] if that CA key is found in the filesystem or a 'normal' keyring. The 
container runtime then loads the keys onto that keyring; call that 
keyring '.ima' or '_ima' for as long as the kernel knows what keyring to 
search for. We created that keyring under a session keyring. With the 
user namespace isolation and keyrings support in the user namespace the 
isolation of the IMA related keyrings between different user namespaces 
should be possible.


The same would be done for the IMA policy where the container runtime 
also needs to do some work that usually dracut would do:

- expect the IMA policy for the container at the usual location 
(/etc/ima/ima-policy) and load it into the container's 'securityfs' 
policy file

    Stefan


