Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8625D4731BE
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 17:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbhLMQ1X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 11:27:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240829AbhLMQ1W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 11:27:22 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEvbUn005479;
        Mon, 13 Dec 2021 16:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=e1aZ+2xJZloIDuB98xFShjjoPFmttrlwP6Sn6rAuUIs=;
 b=GYpvHBdjQ0i00PO4u+QQlSCeiw8PzN/uy5AkXYNdVBWpFfNGM9fnQv7pwQjJFyZXB9XY
 30vkyL27GI+9gSWGy2hC6v5ScbC2I59rhl/eCf8oxmovI/l2wb2jzNtVWMDFmhXcCXzk
 qlny/pet9XA7HsukBpTcPC5uB3pKwvYihtfCZfP8ahFTyCXzOTgFOQ5FELHe2z+6ygMp
 cKCxGPXa0ftMAPHJhngaEiEkucyJ9a7L2HEG4omNW8UbCezJOokzu7m4IEPpZdQCe/g+
 BV2+1c2jchuckpo2l5jr5M6YqHVK1JV5APio9iOAxVdpq15S1tE9UWjvSLd3mjxOgBPv TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx8d5t8sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 16:26:57 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BDFTh9Z008104;
        Mon, 13 Dec 2021 16:26:56 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx8d5t8rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 16:26:56 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BDGOUa4027065;
        Mon, 13 Dec 2021 16:26:54 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3cvkma9vpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 16:26:54 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BDGPTaX47972860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 16:25:29 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48C3B112061;
        Mon, 13 Dec 2021 16:25:29 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E8C0112079;
        Mon, 13 Dec 2021 16:25:28 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 13 Dec 2021 16:25:28 +0000 (GMT)
Message-ID: <eb3d11b4-8077-bea0-85ff-8d7cf84dae58@linux.ibm.com>
Date:   Mon, 13 Dec 2021 11:25:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 13/16] ima: Move some IMA policy and filesystem related
 variables into ima_namespace
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-14-stefanb@linux.ibm.com>
 <20211209191109.o3x7nynnm52zhygz@wittgenstein>
 <0ab33fbc-8438-27b6-ff4c-0321bfc73855@linux.ibm.com>
 <20211210113244.odv2ibrifz2jzft5@wittgenstein>
 <dca4e7c9-87a7-9a9e-b1f2-df16f1a45019@linux.ibm.com>
 <20211211095026.i2gvqjy4df3sxq42@wittgenstein>
 <85b75c98-6452-9706-7549-10b416350b7d@linux.ibm.com>
 <20211213155020.pvadnomqnsub5vg2@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211213155020.pvadnomqnsub5vg2@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DCIE-KbiLjZP-a5OpLI-RyWBNtW-Tv6i
X-Proofpoint-GUID: WvAvawlIHd7d2AZ0rpG4VKYz3BaX85Kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_08,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130103
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/13/21 10:50, Christian Brauner wrote:
> On Mon, Dec 13, 2021 at 10:33:40AM -0500, Stefan Berger wrote:
>> On 12/11/21 04:50, Christian Brauner wrote:
>>> On Fri, Dec 10, 2021 at 08:57:11AM -0500, Stefan Berger wrote:
>>>>
>>>> there anything that would prevent us from setns()'ing to that target user
>>>> namespace so that we would now see that of a user namespace that we are not
>>>> allowed to see?
>>> If you're really worried about someone being able to access a securityfs
>>> instance whose userns doesn't match the userns the securityfs instance
>>> was mounted in there are multiple ways to fix it. The one that I tend to
>>> prefer is:
>>>
>>>   From e0ff6a8dcc573763568e685dd70d1547efd68df9 Mon Sep 17 00:00:00 2001
>>> From: Christian Brauner <christian.brauner@ubuntu.com>
>>> Date: Fri, 10 Dec 2021 11:47:37 +0100
>>> Subject: !!!! HERE BE DRAGONS - COMPLETELY UNTESTED !!!!
>>>
>>> securityfs: only allow access to securityfs from within same namespace
>>>
>>> Limit opening of securityfs files to callers located in the same namespace.
>>>
>>> ---
>>>    security/inode.c | 33 +++++++++++++++++++++++++++++++--
>>>    1 file changed, 31 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/security/inode.c b/security/inode.c
>>> index eaccba7017d9..9eaf757c08cb 100644
>>> --- a/security/inode.c
>>> +++ b/security/inode.c
>>> @@ -80,6 +80,35 @@ static struct file_system_type fs_type = {
>>>    	.fs_flags =	FS_USERNS_MOUNT,
>>>    };
>>> +static int securityfs_permission(struct user_namespace *mnt_userns,
>>> +				 struct inode *inode, int mask)
>>> +{
>>> +	int err;
>>> +
>>> +	err = generic_permission(&init_user_ns, inode, mask);
>>> +	if (!err) {
>>> +		if (inode->i_sb->s_user_ns != current_user_ns())
>>> +			err = -EACCES;
>>> +	}
>>> +
>>> +	return err;
>>> +}
>>> +
>>> +const struct inode_operations securityfs_dir_inode_operations = {
>>> +	.permission	= securityfs_permission,
>>> +	.lookup		= simple_lookup,
>>> +};
>>> +
>>> +const struct file_operations securityfs_dir_operations = {
>>> +	.permission	= securityfs_permission,
>>
>> This interface function on file operations doesn't exist.
> It's almost as if the subject line of this patch warned about its draft
> character. That was supposed for regular files.
>
>> I'll use the inode_operations and also hook it to the root dentry of the
>> super_block. Then there's no need to have this check on symlinks and
>> files...
> Don't special case the inode_operations for the root inode!

I modified the inode_operations *also* for the root node, since that one 
is initialized with &simple_dir_inode_operationsby simple_fill_super, so 
I didn't want to miss it...


> If a privileged process opens an fd refering to a struct file for the
> root inode and leaks it to an unprivileged process by accident the
> unprivileged process can open any file or directory beneath via openat()
> and friends.
>
> Symlinks don't need a .permission handler anyway because they just
> contain the name of another file and that is checked for .permission
> unless you have a separate .getlink handler where you want to restrict
> link contents further.
>
> But regular files need to have a .permission method see openat().

So here's what I have now for the hardening.


diff --git a/security/inode.c b/security/inode.c
index fee01ff4d831..a0d9f086e3d5 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -26,6 +26,29 @@
  static struct vfsmount *init_securityfs_mount;
  static int init_securityfs_mount_count;

+static int securityfs_permission(struct user_namespace *mnt_userns,
+                                struct inode *inode, int mask)
+{
+       int err;
+
+       err = generic_permission(&init_user_ns, inode, mask);
+       if (!err) {
+               if (inode->i_sb->s_user_ns != current_user_ns())
+                       err = -EACCES;
+       }
+
+       return err;
+}
+
+const struct inode_operations securityfs_dir_inode_operations = {
+       .permission     = securityfs_permission,
+       .lookup         = simple_lookup,
+};
+
+const struct inode_operations securityfs_file_inode_operations = {
+       .permission     = securityfs_permission,
+};
+
  static void securityfs_free_inode(struct inode *inode)
  {
         if (S_ISLNK(inode->i_mode))
@@ -41,20 +64,25 @@ static const struct super_operations 
securityfs_super_operations = {
  static int securityfs_fill_super(struct super_block *sb, struct 
fs_context *fc)
  {
         static const struct tree_descr files[] = {{""}};
+       struct user_namespace *ns = fc->user_ns;
         int error;

+       if (WARN_ON(ns != current_user_ns()))
+               return -EINVAL;
+
         error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
         if (error)
                 return error;

         sb->s_op = &securityfs_super_operations;
+       sb->s_root->d_inode->i_op = &securityfs_dir_inode_operations;

         return 0;
  }
[...]
@@ -157,7 +186,7 @@ static struct dentry *securityfs_create_dentry(const 
char *name, umode_t mode,
         inode->i_atime = inode->i_mtime = inode->i_ctime = 
current_time(inode);
         inode->i_private = data;
         if (S_ISDIR(mode)) {
-               inode->i_op = &simple_dir_inode_operations;
+               inode->i_op = &securityfs_dir_inode_operations;
                 inode->i_fop = &simple_dir_operations;
                 inc_nlink(inode);
                 inc_nlink(dir);
@@ -165,10 +194,10 @@ static struct dentry 
*securityfs_create_dentry(const char *name, umode_t mode,
                 inode->i_op = iops ? iops : 
&simple_symlink_inode_operations;
                 inode->i_link = data;
         } else {
+               inode->i_op = &securityfs_file_inode_operations;
                 inode->i_fop = fops;
         }
         d_instantiate(dentry, inode);

