Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28F4697B6
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 15:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245066AbhLFOHX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 09:07:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245073AbhLFOHW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 09:07:22 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6CLYHn027938;
        Mon, 6 Dec 2021 14:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WKBiNAsRf5m488ylTECLK4QiGY1zbbjiWd7Pl1242i0=;
 b=EBetE5G4/pUy+kuXhpfdmnp/ud6V5Q+Ja180dxKheVpBe5L3h9K31RSxwqJcPl+K+bPp
 zqvbU8dbUwwYhPOpnkGF/R8UKyPmjuQwopasK5mPdbd5QoeYNO2hNRK5M7jiGd6RjGYb
 ZG5zn9TW4/WFzll1qPutA+Gn9r/cMpa40ONDFwxrrEe9Bi74kODTugjj/XCX94mDY3n9
 mRGWznLnG+QoFykaS1rwLtmY8N+0CFap1vdHxt6UAgiOzA8lHJzG42tmxD98jRZRTTKs
 9ukZQPGzoIrVEpTzaa0XqZ49bwVF46Jw05DRujEOXUk++NI5S7kESO5UbHBXT38IxPXx zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3csjf32067-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 14:03:41 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6CZUqX024305;
        Mon, 6 Dec 2021 14:03:41 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3csjf3205v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 14:03:41 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Dxgl7009581;
        Mon, 6 Dec 2021 14:03:40 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 3cqyy9p3gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 14:03:40 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6E3cwZ27984156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 14:03:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C3FBB2076;
        Mon,  6 Dec 2021 14:03:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 088F5B206B;
        Mon,  6 Dec 2021 14:03:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 14:03:37 +0000 (GMT)
Message-ID: <e4134d4f-5134-ade8-6428-3510ac940757@linux.ibm.com>
Date:   Mon, 6 Dec 2021 09:03:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
Content-Language: en-US
To:     jejb@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-20-stefanb@linux.ibm.com>
 <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
 <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
 <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
 <cd05433a-3630-e7f5-e144-ff766d7792fa@linux.ibm.com>
 <084e6522e1e778408cf6b3581d75f7349d336006.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <084e6522e1e778408cf6b3581d75f7349d336006.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pP2y1wag8LWlLx3XtRs-ejXkKN6HjghT
X-Proofpoint-ORIG-GUID: j9ep7OKxgeQYne3UYnKqh9y10XI3pGEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_04,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112060088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/5/21 23:27, James Bottomley wrote:
> On Fri, 2021-12-03 at 14:11 -0500, Stefan Berger wrote:
>> On 12/3/21 13:50, James Bottomley wrote:
>>> On Fri, 2021-12-03 at 13:06 -0500, Stefan Berger wrote:
> [...]
>>>> I suppose any late filesystem init callchain would have to be
>>>> connected to the user_namespace somehow?
>>>   
>>> I don't think so; I think just moving some securityfs entries into
>>> the user_namespace and managing the notifier chain from within
>>> securityfs will do for now.  [although I'd have to spec this out in
>>> code before I knew for sure].
>> It doesn't have to be right in the user_namespace. The IMA namespace
>> is  connected to the user namespace and holds the dentries now...
>>
>> Please spec it out...
> OK, this is what I have.  fill_super turned out to be a locking
> nightmare, so I triggered it from free context instead (which doesn't
> have the once per keyed superblock property, so I added a flag in the
> user namespace).  I've got it to the point where the event is triggered
> on mount and unmount, so all the entries for the namespace are added
> when the filesystem is mounted and remove when it's unmounted.  This
> style of addition no longer needs the simple_pin_fs, because the
> add/remove callbacks substitute (plus, if we pinned, the free_super
> wouldn't trigger on unmount).  The default behaviour still does pinning
> and unpinning, but that can be keyed off the current user_namespace.
>
> This is all on top of your current series ... some of the functions
> should probably be renamed, but I kept them to show how the code was
> migrating in this sketch.
>
> James
>
> ---
>
>  From 59c45daa8698c66c3bcebfb194123977d548a9a6 Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Sat, 4 Dec 2021 16:38:37 +0000
> Subject: [PATCH] rework securityfs
>
> ---
>
> -
> -static void _securityfs_remove(struct dentry *dentry,
> -			       struct vfsmount **mount, int *mount_count)
> +void securityfs_remove(struct dentry *dentry)
>   {
>   	struct inode *dir;
> +	struct user_namespace *ns = current_user_ns();

I had problems with this in this place. So I had to use use

struct user_namespace *user_ns = dentry->d_sb->s_user_ns;

I'll try to split up your patch and post a v3 with then. Or is it too early?

   Stefan


