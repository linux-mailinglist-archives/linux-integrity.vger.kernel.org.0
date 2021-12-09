Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6F546F4BC
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhLIURD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 15:17:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229897AbhLIURC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 15:17:02 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9KBaRI017725;
        Thu, 9 Dec 2021 20:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y66Sv7AvwC1Gldg15l5DUFHuOUz3gBLYsTkNWknNyoY=;
 b=MZJAWxVi32eNA8e2c89Ppitv1MSRdnE3JPi2307brxYMqox+0/x1wLPi/5PHNryoMH/x
 8vSUygybwXfvN8Nv2ZzzqKCsSRenLnlgLrbrye1KN1S+jzh1PlHtstIpA3+2Adron+z4
 hlCBfGAaHszOfOnWM33dQ9DXkobQ8baZyYFzgSxIBt5LwlvQSEfNiBKq/Wu6r4P7hC2R
 c/154HcXr1FSs//S1bNuVCbOeSd9bvFjxfCBFMqJW6+4oPeslXrY3fUAR6MOK6G5S/lz
 Yr5Dmt6PkIZzjB1Q1C+FhGdrAxcDQhAbRd0p/6F5VVZoj2HDljC6JnioRmEIZAAfSLT2 CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cup7pu6xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 20:13:15 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B9KCilj025177;
        Thu, 9 Dec 2021 20:13:14 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cup7pu6x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 20:13:14 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B9KC6lY027477;
        Thu, 9 Dec 2021 20:13:13 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 3cqyyc105t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 20:13:13 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B9KDCq654591872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Dec 2021 20:13:12 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE97B112065;
        Thu,  9 Dec 2021 20:13:11 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ABD7112062;
        Thu,  9 Dec 2021 20:13:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  9 Dec 2021 20:13:11 +0000 (GMT)
Message-ID: <ca5912c8-b74e-5cd4-9a68-0e7c160121fc@linux.ibm.com>
Date:   Thu, 9 Dec 2021 15:13:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
Content-Language: en-US
To:     jejb@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-16-stefanb@linux.ibm.com>
 <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
 <20211209143749.wk4agkynfqdzftbl@wittgenstein>
 <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
 <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5rQG5iYqb71RF1kGPemKOzU5RL2Lp7oW
X-Proofpoint-ORIG-GUID: QSmYg_siB4Boj2NCDH0480Emj7m4TrV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112090104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/9/21 14:38, James Bottomley wrote:
> On Thu, 2021-12-09 at 10:30 -0500, James Bottomley wrote:
>> On Thu, 2021-12-09 at 15:37 +0100, Christian Brauner wrote:
>>> On Thu, Dec 09, 2021 at 03:34:28PM +0100, Christian Brauner wrote:
>>>> On Wed, Dec 08, 2021 at 05:18:17PM -0500, Stefan Berger wrote:
>>>>> Move the dentries into the ima_namespace for reuse by
>>>>> virtualized
>>>>> SecurityFS. Implement function freeing the dentries in order of
>>>>> files and symlinks before directories.
>>>>>
>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>> ---
>>>> This doesn't work as implemented, I think.
>>>>
>>>> What I would have preferred and what I tried to explain in the
>>>> earlier review was:
>>>> Keep the dentry stashing global since it is only needed for
>>>> init_ima_ns.
>>>> Then struct ima_namespace becomes way smaller and simpler.
>>>> If you do that then it makes sense to remove the additional
>>>> dget() in securityfs_create_dentry() for non-init_ima_ns.
>>>> Then you can rely on auto-cleanup in .kill_sb() or on
>>>> ima_securityfs_init() failure and you only need to call
>>>> ima_fs_ns_free_dentries() if ns != init_ima_ns.
>>>>
>>>> IIuc, it seems you're currently doing one dput() too many since
>>>> you're calling securityfs_remove() in the error path for non-
>>>> init_ima_ns which relies on the previous increased dget() which
>>>> we removed.
>>> If you really want to move the dentry stashing into struct
>>> ima_namespace even though it's really unnecessary then you may as
>>> well not care about the auto-cleanup and keep that additional
>>> ima_fs_ns_free_dentries(ns) call in .kill_sb(). But I really think
>>> not dragging dentry stashing into struct ima_namespace is the
>>> correct way to go about this.
>> We, unfortunately, do have one case we can't avoid stashing for the
>> policy file.  It's this code in ima_release_policy:
>>
>>> #if !defined(CONFIG_IMA_WRITE_POLICY) &&
>>> !defined(CONFIG_IMA_READ_POLICY)
>>> 	securityfs_remove(ns->dentry[IMAFS_DENTRY_IMA_POLICY]);
>>> 	ns->dentry[IMAFS_DENTRY_IMA_POLICY] = NULL;
>>>
>> What it does is that in certain config options, the policy file entry
>> gets removed from the securityfs ima directory after you write to it.
> This is what I have incremental to v5 that corrects all of this.  It
> actually keeps every dentry reference (including init_user_ns ones) at
> 1 so they can be reaped on unmount.  For the remove case it does
> d_delete and then puts the only reference.  This means
> securityfs_remove() works for the namespaced policy file as well.
I fixed it now as well but do another dget() on securityfs_removed() for 
ns != init_user_ns. Ok, I will add what you have below.
>
> I also got rid of the spurious initialized check in ima_securityfs_init
> because it prevents you doing a mount;umount;mount on securityfs within
> a namespace.
>
> There's still the problem that if you write the policy, making the file
> disappear then unmount and remount securityfs it will come back.  My
> guess for fixing this is that we only stash the policy file reference,
> create it if NULL but then set the pointer to PTR_ERR(-EINVAL) or
> something and refuse to create it for that value.

What about boolean to remember this? I just added this.


>
> James
>
> ---
>
>  From 7de285a81ff06b6e0eb2c6db24810aeef9f6dd17 Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Thu, 9 Dec 2021 19:33:49 +0000
> Subject: [PATCH] fix dentry ref counting
>
> ---
>   security/inode.c                | 12 ++----------
>   security/integrity/ima/ima_fs.c |  4 ----
>   2 files changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/security/inode.c b/security/inode.c
> index eaccba7017d9..b53152f7a625 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -178,8 +178,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
>   		inode->i_fop = fops;
>   	}
>   	d_instantiate(dentry, inode);
> -	if (ns == &init_user_ns)
> -		dget(dentry);
>   	inode_unlock(dir);
>   	return dentry;
>   
> @@ -317,21 +315,15 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
>   void securityfs_remove(struct dentry *dentry)
>   {
>   	struct user_namespace *ns = dentry->d_sb->s_user_ns;
> -	struct inode *dir;
>   
>   	if (!dentry || IS_ERR(dentry))
>   		return;
>   
> -	dir = d_inode(dentry->d_parent);
> -	inode_lock(dir);
>   	if (simple_positive(dentry)) {
> -		if (d_is_dir(dentry))
> -			simple_rmdir(dir, dentry);
> -		else
> -			simple_unlink(dir, dentry);
> +		d_delete(dentry);
>   		dput(dentry);
>   	}
> -	inode_unlock(dir);
> +
>   	if (ns == &init_user_ns)
>   		simple_release_fs(&init_securityfs_mount,
>   				  &init_securityfs_mount_count);
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 778983fd9a73..077a6ff46858 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -466,10 +466,6 @@ int ima_securityfs_init(struct user_namespace *user_ns, struct dentry *root)
>   	struct ima_namespace *ns = user_ns->ima_ns;
>   	struct dentry *ima_dir;
>   
> -	/* already initialized? */
> -	if (ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR])
> -		return 0;
> -
>   	/* FIXME: update when evm and integrity are namespaced */
>   	if (user_ns != &init_user_ns) {
>   		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] =
