Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E437467CF7
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 19:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359352AbhLCSKK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 13:10:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353418AbhLCSKI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 13:10:08 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3FpZi2030775;
        Fri, 3 Dec 2021 18:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=siyREWmz2+sW8HcsCvJYgd9SEIscCNn5ZgDPBq8SHHE=;
 b=hiiRtF4SgiZlbF1X4g7zPwdvd3y2p3NY5NJDMOZLvQftljDkdfVoT9S1IXncEovChOMN
 AQ+Vvwr97rFIts53N/bfUXxOmtXNIAundDkvcwxFq6/E8eJ9CaNSk1rVLW7Hyzr5wBOw
 ip7clAI8w+se591PzziCYkJWiXbWhJe+Q+u2A9JQcLBkGbb66FtxKTNdk9vlBI0wanNo
 FLhC6DjvbYjE5UMzB2/huJ6d42b+XGV2Zhm1g+58BTWglTk0kp0cihy3NYffjvaXmblR
 Qw/pQMKx0H8vEBARlsbMBDBQd//Q61ZCGBZD1XOcc04Wk19uY0CVCjE03/iFmT8cb4UR vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cqp8haq95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 18:06:18 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B3HsqpS008034;
        Fri, 3 Dec 2021 18:06:18 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cqp8haq8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 18:06:18 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B3I4GFg025496;
        Fri, 3 Dec 2021 18:06:17 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3ckcaeb8q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 18:06:17 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B3I6E0O66650470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 18:06:14 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DB05AE067;
        Fri,  3 Dec 2021 18:06:14 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB874AE060;
        Fri,  3 Dec 2021 18:06:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 18:06:13 +0000 (GMT)
Message-ID: <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
Date:   Fri, 3 Dec 2021 13:06:13 -0500
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lWcBeCjaWeVDNMaRIbVwCWN9gF0yiUFI
X-Proofpoint-GUID: -0WCxuWP3EctpDJDj3AWClbN7ztDSNL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112030115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/3/21 12:03, James Bottomley wrote:
> On Thu, 2021-12-02 at 21:31 -0500, Stefan Berger wrote:
> [...]
>>   static int securityfs_init_fs_context(struct fs_context *fc)
>>   {
>> +	int rc;
>> +
>> +	if (fc->user_ns->ima_ns->late_fs_init) {
>> +		rc = fc->user_ns->ima_ns->late_fs_init(fc->user_ns);
>> +		if (rc)
>> +			return rc;
>> +	}
>>   	fc->ops = &securityfs_context_ops;
>>   	return 0;
>>   }
> I know I suggested this, but to get this to work in general, it's going
> to have to not be specific to IMA, so it's going to have to become
> something generic like a notifier chain.  The other problem is it's
> only working still by accident:

I had thought about this also but the rationale was:

securityfs is compiled due to CONFIG_IMA_NS and the user namespace 
exists there and that has a pointer now to ima_namespace, which can have 
that callback. I assumed that other namespaced subsystems could also be 
reached then via such a callback, but I don't know.

I suppose any late filesystem init callchain would have to be connected 
to the user_namespace somehow?


>
>> +int ima_fs_ns_init(struct ima_namespace *ns)
>> +{
>> +	ns->mount = securityfs_ns_create_mount(ns->user_ns);
> This actually triggers on the call to securityfs_init_fs_context, but
> nothing happens because the callback is null.  Every subsequent use of
> fscontext will trigger this.  The point of a keyed supeblock is that
> fill_super is only called once per key, that's the place we should be
> doing this.   It should also probably be a blocking notifier so any
> consumer of securityfs can be namespaced by registering for this
> notifier.


What I don't like about the fill_super is that it gets called too early:

[   67.058611] securityfs_ns_create_mount @ 102 target user_ns: 
ffff95c010698c80; nr_extents: 0
[   67.059836] securityfs_fill_super @ 47  user_ns: ffff95c010698c80; 
nr_extents: 0

We are switching to the target user namespace in 
securityfs_ns_create_mount. The expected nr_extents at this point is 0, 
since user_ns hasn't been configured, yet. But then security_fill_super 
is also called with nr_extents 0. We cannot use that, it's too early!


>
>> +	if (IS_ERR(ns->mount)) {
>> +		ns->mount = NULL;
>> +		return -1;
>> +	}
>> +	ns->mount_count = 1;
> This is a bit nasty, too: we're spilling the guts of mount count
> tracking into IMA instead of encapsulating it inside securityfs.


Ok, I can make this disappear.


>
>> +
>> +	/* Adjust the trigger for user namespace's early teardown of
>> dependent
>> +	 * namespaces. Due to the filesystem there's an additional
>> reference
>> +	 * to the user namespace.
>> +	 */
>> +	ns->user_ns->refcount_teardown += 1;
>> +
>> +	ns->late_fs_init = ima_fs_ns_late_init;
>> +
>> +	return 0;
>> +}
> I think what should be happening is that we shouldn't so the
> simple_pin_fs, which creates the inodes, ahead of time; we should do it
> inside fill_super using a notifier, meaning it gets called once per

fill_super would only work for the init_user_ns from what I can see.


> key, creates the root dentry then triggers the notifier which
> instantiates all the namespaced entries.  We can still use
> simple_pin_fs for this because there's no locking across fill_super.
> This would mean fill_super would be called the first time the
> securityfs is mounted inside the namespace.


I guess I would need to know how fill_super would work or how it could 
be called late/delayed as well.


>
> If we do it this way, we can now make securityfs have its own mount and
> mount_count inside the user namespace, which it uses internally to the
> securityfs code, thus avoiding exposing them to ima or any other
> namespaced consumer.
>
> I also think we now don't need the securityfs_ns_ duplicated functions
> because the callback via the notifier chain now ensures we can use the
> namespace they were created in to distinguish between non namespaced
> and namespaced entries.

Is there then no need to pass a separate vfsmount * in anymore? Where 
would the vfsmount pointer reside? For now it's in ima_namespace, but it 
sounds like it should be in a more centralized place? Should it also be 
connected to the user_namespace so we can pick it up using get_user_ns()?


>
> So non-namespaced consumers of securityfs would do what they do now
> (calling the securityfs_create on initialization) and namespaced
> consumers would register a callback on the notifier which would get
> called once for every namespace the securityfs gets mounted in.
>
> I also theorize if we do it with notifiers, we could have a notifier on
> kill_sb to tear down all the entires.  If we do this, I think we don't
> have to pin any more.
>
> James
>
>

diff --git a/security/inode.c b/security/inode.c
index ed5f1c533776..49c9839642ed 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -44,6 +44,8 @@ static int securityfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
         static const struct tree_descr files[] = {{""}};
         int error;

+       printk(KERN_INFO "%s @ %u  user_ns: %px; nr_extents: %d\n", 
__func__, __LINE__, fc->user_ns, fc->user_ns->uid_map.nr_extents);
+
         error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
         if (error)
                 return error;
@@ -97,6 +99,8 @@ struct vfsmount *securityfs_ns_create_mount(struct 
user_namespace *user_ns)
         put_user_ns(fc->user_ns);
         fc->user_ns = get_user_ns(user_ns);

+       printk(KERN_INFO "%s @ %u target user_ns: %px; nr_extents: 
%d\n", __func__, __LINE__, fc->user_ns, fc->user_ns->uid_map.nr_extents);
+
         mnt = fc_mount(fc);
         put_fs_context(fc);
         return mnt;

