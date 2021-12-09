Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2D46EA7E
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 16:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbhLIPE5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 10:04:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239090AbhLIPE4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 10:04:56 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9ESGSc011821;
        Thu, 9 Dec 2021 15:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qjPSf9cqFY3elru7WUptUw1nNMQBwasBcprAhDiJ6ck=;
 b=lOFxiysgC8gyd8cpJDnWFaK8qNRvGKy0Ye2bCd/UChJx1AqOC42K1BepSbOsQD1m8vmj
 HgClx5T4ov0i5FvK6ydo7VAyuReQ87syAyRMhyUkIvBYNphOzYJvdkVXGLP0ay0brXQK
 +Er/nfTwK+3FONGna4qXpptj4zCsxsOM4cXzWCGDxpLz+8y0fz8MnN4/3dUwDQ95pUnO
 SOo7psbP+sDp+UA/RDs2Tge7StecA8eYsH11sE8ggty9Sq0ScgjJG1ZlYjKXkdlVYnAc
 t2OJgHauFlVaJcnfsIy+C9c2XCOXHtBi7tHlzzT6XlDtjI7k/8KKLTns0ABcvNjcUHH3 ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cukkegsws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 15:01:06 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B9EUIgS017613;
        Thu, 9 Dec 2021 15:01:05 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cukkegsvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 15:01:05 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B9EvwMg021869;
        Thu, 9 Dec 2021 15:01:04 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3cqyychnv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 15:01:04 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B9F12HS29032770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Dec 2021 15:01:02 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89BEC6E062;
        Thu,  9 Dec 2021 15:01:02 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5034A6E05B;
        Thu,  9 Dec 2021 15:01:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  9 Dec 2021 15:01:00 +0000 (GMT)
Message-ID: <f0710142-0d91-d6c4-8d2c-7eac1a946969@linux.ibm.com>
Date:   Thu, 9 Dec 2021 10:00:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
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
 <20211208221818.1519628-16-stefanb@linux.ibm.com>
 <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
 <20211209143749.wk4agkynfqdzftbl@wittgenstein>
 <20211209144109.4xkyibwsuaqkbu47@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211209144109.4xkyibwsuaqkbu47@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5q1pABsIVYjQNXorR3WX8xglQnKNiAxK
X-Proofpoint-ORIG-GUID: J8VKn4iBrlplLGUTS2G6yeX2NbrkuVgY
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_06,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090082
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/9/21 09:41, Christian Brauner wrote:
> On Thu, Dec 09, 2021 at 03:37:49PM +0100, Christian Brauner wrote:
>> On Thu, Dec 09, 2021 at 03:34:28PM +0100, Christian Brauner wrote:
>>> On Wed, Dec 08, 2021 at 05:18:17PM -0500, Stefan Berger wrote:
>>>> Move the dentries into the ima_namespace for reuse by virtualized
>>>> SecurityFS. Implement function freeing the dentries in order of
>>>> files and symlinks before directories.
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> ---
>>> This doesn't work as implemented, I think.
>>>
>>> What I would have preferred and what I tried to explain in the earlier
>>> review was:
>>> Keep the dentry stashing global since it is only needed for init_ima_ns.
>>> Then struct ima_namespace becomes way smaller and simpler.
>>> If you do that then it makes sense to remove the additional dget() in
>>> securityfs_create_dentry() for non-init_ima_ns.
>>> Then you can rely on auto-cleanup in .kill_sb() or on
>>> ima_securityfs_init() failure and you only need to call
>>> ima_fs_ns_free_dentries() if ns != init_ima_ns.
> s/ns != init_ima_ns/ns == init_ima_ns/
>
>>> IIuc, it seems you're currently doing one dput() too many since you're
>>> calling securityfs_remove() in the error path for non-init_ima_ns which
>>> relies on the previous increased dget() which we removed.

I thought that securityfs_remove() will now simply influence when a 
dentry is removed and freed. If we call it in the error cleanup path in 
non-init_user_ns case it would go away right there and leave nothing to 
do for .kill_sb() while an additional dget() would require the cleanup 
as well but do another cleanup then in .kill_sb() since that brings the 
reference count to 0 via the dput()s that it does. Am I wrong on this?


>> If you really want to move the dentry stashing into struct ima_namespace
>> even though it's really unnecessary then you may as well not care about
>> the auto-cleanup and keep that additional ima_fs_ns_free_dentries(ns)
>> call in .kill_sb(). But I really think not dragging dentry stashing into
>> struct ima_namespace is the correct way to go about this.


I moved the dentries into the ima_namespace so that each namespace holds 
a pointer to the dentries it owns and isolates them. We certainly 
wouldn't want to have IMA namespaces write over the current static 
variables and create a mess with what these are pointing to ( 
https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_fs.c#L359 
) and possible race conditions when doing parallel initialization (if 
that's possible at all). This also reduces the code size and we don't 
need two different implementations for init_user_ns and 
non-init_user_ns. So I don't quite understand whey we wouldn't want to 
have the dentries isolated via ima_namespace?


>>
>>>>   include/linux/ima.h             | 13 ++++++
>>>>   security/integrity/ima/ima_fs.c | 72 ++++++++++++++++++---------------
>>>>   2 files changed, 52 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>>>> index 3aaf6e806db4..4dd64e318b15 100644
>>>> --- a/include/linux/ima.h
>>>> +++ b/include/linux/ima.h
>>>> @@ -220,6 +220,17 @@ struct ima_h_table {
>>>>   	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
>>>>   };
>>>>   
>>>> +enum {
>>>> +	IMAFS_DENTRY_DIR = 0,
>>>> +	IMAFS_DENTRY_SYMLINK,
>>>> +	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
>>>> +	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
>>>> +	IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT,
>>>> +	IMAFS_DENTRY_VIOLATIONS,
>>>> +	IMAFS_DENTRY_IMA_POLICY,
>>>> +	IMAFS_DENTRY_LAST
>>>> +};
>>>> +
>>>>   struct ima_namespace {
>>>>   	struct kref kref;
>>>>   	struct user_namespace *user_ns;
>>>> @@ -266,6 +277,8 @@ struct ima_namespace {
>>>>   	struct mutex ima_write_mutex;
>>>>   	unsigned long ima_fs_flags;
>>>>   	int valid_policy;
>>>> +
>>>> +	struct dentry *dentry[IMAFS_DENTRY_LAST];
>>>>   };
>>>>   
>>>>   extern struct ima_namespace init_ima_ns;
>>>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>>>> index a749a3e79304..3810d11fb463 100644
>>>> --- a/security/integrity/ima/ima_fs.c
>>>> +++ b/security/integrity/ima/ima_fs.c
>>>> @@ -360,14 +360,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>>>>   	return result;
>>>>   }
>>>>   
>>>> -static struct dentry *ima_dir;
>>>> -static struct dentry *ima_symlink;
>>>> -static struct dentry *binary_runtime_measurements;
>>>> -static struct dentry *ascii_runtime_measurements;
>>>> -static struct dentry *runtime_measurements_count;
>>>> -static struct dentry *violations;
>>>> -static struct dentry *ima_policy;
>>>> -
>>>>   enum ima_fs_flags {
>>>>   	IMA_FS_BUSY,
>>>>   };
>>>> @@ -437,8 +429,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>>>>   
>>>>   	ima_update_policy(ns);
>>>>   #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
>>>> -	securityfs_remove(ima_policy);
>>>> -	ima_policy = NULL;
>>>> +	securityfs_remove(ns->dentry[IMAFS_DENTRY_IMA_POLICY]);
>>>> +	ns->dentry[IMAFS_DENTRY_IMA_POLICY] = NULL;
>>>>   #elif defined(CONFIG_IMA_WRITE_POLICY)
>>>>   	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
>>>>   #elif defined(CONFIG_IMA_READ_POLICY)
>>>> @@ -455,58 +447,72 @@ static const struct file_operations ima_measure_policy_ops = {
>>>>   	.llseek = generic_file_llseek,
>>>>   };
>>>>   
>>>> -int __init ima_fs_init(void)
>>>> +static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
>>>>   {
>>>> -	ima_dir = securityfs_create_dir("ima", integrity_dir);
>>>> -	if (IS_ERR(ima_dir))
>>>> +	int i;
>>>> +
>>>> +	for (i = IMAFS_DENTRY_LAST - 1; i >= 0; i--)
>>>> +		securityfs_remove(ns->dentry[i]);
>>>> +
>>>> +	memset(ns->dentry, 0, sizeof(ns->dentry));
>>>> +}
>>>> +
>>>> +static int __init ima_securityfs_init(struct user_namespace *user_ns)
>>>> +{
>>>> +	struct ima_namespace *ns = user_ns->ima_ns;
>>>> +	struct dentry *ima_dir;
>>>> +
>>>> +	ns->dentry[IMAFS_DENTRY_DIR] = securityfs_create_dir("ima", integrity_dir);
>>>> +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_DIR]))
>>>>   		return -1;
>>>> +	ima_dir = ns->dentry[IMAFS_DENTRY_DIR];
>>>>   
>>>> -	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
>>>> -						NULL);
>>>> -	if (IS_ERR(ima_symlink))
>>>> +	ns->dentry[IMAFS_DENTRY_SYMLINK] =
>>>> +	    securityfs_create_symlink("ima", NULL, "integrity/ima", NULL);
>>>> +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_SYMLINK]))
>>>>   		goto out;
>>>>   
>>>> -	binary_runtime_measurements =
>>>> +	ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS] =
>>>>   	    securityfs_create_file("binary_runtime_measurements",
>>>>   				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>>>>   				   &ima_measurements_ops);
>>>> -	if (IS_ERR(binary_runtime_measurements))
>>>> +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS]))
>>>>   		goto out;
>>>>   
>>>> -	ascii_runtime_measurements =
>>>> +	ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS] =
>>>>   	    securityfs_create_file("ascii_runtime_measurements",
>>>>   				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>>>>   				   &ima_ascii_measurements_ops);
>>>> -	if (IS_ERR(ascii_runtime_measurements))
>>>> +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS]))
>>>>   		goto out;
>>>>   
>>>> -	runtime_measurements_count =
>>>> +	ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT] =
>>>>   	    securityfs_create_file("runtime_measurements_count",
>>>>   				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>>>>   				   &ima_measurements_count_ops);
>>>> -	if (IS_ERR(runtime_measurements_count))
>>>> +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT]))
>>>>   		goto out;
>>>>   
>>>> -	violations =
>>>> +	ns->dentry[IMAFS_DENTRY_VIOLATIONS] =
>>>>   	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
>>>>   				   ima_dir, NULL, &ima_htable_violations_ops);
>>>> -	if (IS_ERR(violations))
>>>> +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_VIOLATIONS]))
>>>>   		goto out;
>>>>   
>>>> -	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
>>>> +	ns->dentry[IMAFS_DENTRY_IMA_POLICY] =
>>>> +	    securityfs_create_file("policy", POLICY_FILE_FLAGS,
>>>>   					    ima_dir, NULL,
>>>>   					    &ima_measure_policy_ops);
>>>> -	if (IS_ERR(ima_policy))
>>>> +	if (IS_ERR(ns->dentry[IMAFS_DENTRY_IMA_POLICY]))
>>>>   		goto out;
>>>>   
>>>>   	return 0;
>>>>   out:
>>>> -	securityfs_remove(violations);
>>>> -	securityfs_remove(runtime_measurements_count);
>>>> -	securityfs_remove(ascii_runtime_measurements);
>>>> -	securityfs_remove(binary_runtime_measurements);
>>>> -	securityfs_remove(ima_symlink);
>>>> -	securityfs_remove(ima_dir);
>>>> -	securityfs_remove(ima_policy);
>>>> +	ima_fs_ns_free_dentries(ns);
>>>>   	return -1;
>>>>   }
>>>> +
>>>> +int __init ima_fs_init(void)
>>>> +{
>>>> +	return ima_securityfs_init(&init_user_ns);
>>>> +}
>>>> -- 
>>>> 2.31.1
>>>>
>>>>
