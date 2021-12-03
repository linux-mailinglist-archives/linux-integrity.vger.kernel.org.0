Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B931467DDD
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 20:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbhLCTPQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 14:15:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241573AbhLCTPQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 14:15:16 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3HpN0J000860;
        Fri, 3 Dec 2021 19:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5OvUbO420IAXTkw6nVb1/4Rmq8Kpxkr2q6l1JzmLcg8=;
 b=cRlYDmvqcqNMEhAxFRAdjBRKijBDEhwMhDaaCAL6JXwGBYqFCgyQHHOVFCiX/uVq58RE
 fA9mKimXhoVs/egJfczXl6rjhNOAMgkrGmN/rFasxiUl8OHkKvkm2P9252Jub91vgZLP
 I0dcM6xiPMVoSXT36X6jjufOe3Gw+VoBK3JWWRlUpJHUHPqekXUl5Gr7y78XE3EbK3ST
 Jac9qUY0CQHcbLhKfaS62DQ+A/jQ9c/B1+Feri/U27eobXuueG23EZJy9PXLJwiAb409
 evSf4oVJDnvx+5Buj+h1rgBliS9LFuR3C/qkMjhoPIoknAUsL8zc6LbABSsW0WXVOoW7 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cqr0p9d9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 19:11:40 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B3IollV014490;
        Fri, 3 Dec 2021 19:11:40 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cqr0p9d9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 19:11:40 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B3J8Bim009403;
        Fri, 3 Dec 2021 19:11:39 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03wdc.us.ibm.com with ESMTP id 3cn3k426wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 19:11:39 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B3JBaia32375184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 19:11:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C76DAE05F;
        Fri,  3 Dec 2021 19:11:36 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCD80AE062;
        Fri,  3 Dec 2021 19:11:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 19:11:35 +0000 (GMT)
Message-ID: <cd05433a-3630-e7f5-e144-ff766d7792fa@linux.ibm.com>
Date:   Fri, 3 Dec 2021 14:11:35 -0500
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: brTutpzHVTiKJX_IbnV7N6xgla3vvqzC
X-Proofpoint-ORIG-GUID: uA7gP3kRgTYMePS4rPB0ZuCrAh2AgYRN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112030122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/3/21 13:50, James Bottomley wrote:
> On Fri, 2021-12-03 at 13:06 -0500, Stefan Berger wrote:
>> On 12/3/21 12:03, James Bottomley wrote:
>>> On Thu, 2021-12-02 at 21:31 -0500, Stefan Berger wrote:
>>> [...]
>>>>    static int securityfs_init_fs_context(struct fs_context *fc)
>>>>    {
>>>> +	int rc;
>>>> +
>>>> +	if (fc->user_ns->ima_ns->late_fs_init) {
>>>> +		rc = fc->user_ns->ima_ns->late_fs_init(fc->user_ns);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +	}
>>>>    	fc->ops = &securityfs_context_ops;
>>>>    	return 0;
>>>>    }
>>> I know I suggested this, but to get this to work in general, it's
>>> going to have to not be specific to IMA, so it's going to have to
>>> become something generic like a notifier chain.  The other problem
>>> is it's only working still by accident:
>> I had thought about this also but the rationale was:
>>
>> securityfs is compiled due to CONFIG_IMA_NS and the user namespace
>> exists there and that has a pointer now to ima_namespace, which can
>> have that callback. I assumed that other namespaced subsystems could
>> also be  reached then via such a callback, but I don't know.
> Well securityfs is supposed to exist for LSMs.  At some point each of
> those is going to need to be namespaced, which may eventually be quite
> a pile of callbacks, which is why I thought of a notifier.
>
>> I suppose any late filesystem init callchain would have to be
>> connected to the user_namespace somehow?
> I don't think so; I think just moving some securityfs entries into the
> user_namespace and managing the notifier chain from within securityfs
> will do for now.  [although I'd have to spec this out in code before I
> knew for sure].

It doesn't have to be right in the user_namespace. The IMA namespace is 
connected to the user namespace and holds the dentries now...

Please spec it out...


>
>>>> +int ima_fs_ns_init(struct ima_namespace *ns)
>>>> +{
>>>> +	ns->mount = securityfs_ns_create_mount(ns->user_ns);
>>> This actually triggers on the call to securityfs_init_fs_context,
>>> but nothing happens because the callback is null.  Every subsequent
>>> use of fscontext will trigger this.  The point of a keyed supeblock
>>> is that fill_super is only called once per key, that's the place we
>>> should be doing this.   It should also probably be a blocking
>>> notifier so anyconsumer of securityfs can be namespaced by
>>> registering for this notifier.
>> What I don't like about the fill_super is that it gets called too
>> early:
>>
>> [   67.058611] securityfs_ns_create_mount @ 102 target user_ns:
>> ffff95c010698c80; nr_extents: 0
>> [   67.059836] securityfs_fill_super @ 47  user_ns:
>> ffff95c010698c80;
>> nr_extents: 0
> Right, it's being activated by securityfs_ns_create_mount which is
> called as soon as the user_ns is created.

Well, that doesn't help us then...


>> We are switching to the target user namespace in
>> securityfs_ns_create_mount. The expected nr_extents at this point is
>> 0, since user_ns hasn't been configured, yet. But then
>> security_fill_super is also called with nr_extents 0. We cannot use
>> that, it's too early!
> Exactly, so I was thinking of not having a securityfs_ns_create_mount
> at all.  All the securityfs_ns_create.. calls would be in the notifier

But we need to somehow have a call to get_tree_keyed() and have that 
user namespace switched out. I don't know how else to do this other than 
having some function that does that and that is now called 
securityfs_ns_create_mount().

get_tree_keyed() will also call the fill_super() which is called when 
securityfs_ns_create_mount() is called.

[  196.739071] ima_fs_ns_init @ 639 before securityfs_ns_create_mount()
[  196.740426] securityfs_init_fs_context @ 72  user_ns: 
ffffffff98a3cc60; nr_extents: 1
[  196.741519] securityfs_ns_create_mount @ 105 target user_ns: 
ffff9e239753eb80; nr_extents: 0
[  196.742657] securityfs_get_tree @ 60 before get_tree_keyed()
[  196.743418] securityfs_fill_super @ 47  user_ns: ffff9e239753eb80; 
nr_extents: 0
[  196.744467] ima_fs_ns_init @ 641 after securityfs_ns_create_mount()
[  196.745304] ima: Allocated hash algorithm: sha256
[  196.757650] securityfs_init_fs_context @ 72  user_ns: 
ffff9e239753eb80; nr_extents: 1
[  196.758759] securityfs_get_tree @ 60 before get_tree_keyed()

You said it works by 'accident'. I know it works because the function 
securityfs_init_fs_context() that now populates the filesystem via the 
late_fs_init() is getting called twice. Does 'accident' here mean the 
call sequence could change?


>
>> Where would the vfsmount pointer reside? For now it's in
>> ima_namespace, but it sounds like it should be in a more centralized
>> place? Should it also be  connected to the user_namespace so we can
>> pick it up using get_user_ns()?
> exactly.  I think struct user_namespace should have two elements gated
> by a #ifdef CONFIG_SECURITYFS which are the vfsmount and the
> mount_count for passing into simple_pin_fs.

Also that we can do for as long as it flies beyond the conversation 
here... :-) Anyone else have an opinion ?

   Stefan


>
> James
>
>
