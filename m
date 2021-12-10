Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA0947022B
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 14:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbhLJOBM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 09:01:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238967AbhLJOBL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 09:01:11 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAD32XU003997;
        Fri, 10 Dec 2021 13:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WONfZwi5yBYjg5QQMeftDEJFAo24M9aLbV3ceXCEXBg=;
 b=SFuTEHqT/mZwv/5xXLZ78smYRWgJb1uOb+XlNPePVT4wVa8AV4YjbOTajbb/mrc95VVz
 3NTfI1gQA6kjbSsnjSGEeGgqxOFCiWnQc7XsiePvSBkMF/4U+YLTXBKz6IWvePuTptbj
 U+sTqleTVTFl5XLL+YA8sUx08aH1dEKIGUQV6K2nlj1O/+g8OiIt1WAjPabyv7hQzfSS
 V+UzzCiv4uE70eM9rzoSsQnQi6e34RaErm98QpUUh2/hPag7lIV3CCOtN3Y9e4RybL+/
 8Wzax3PPgq3s2AxHzB67EZjt/GC9Y/AnHNcX0EY9NkZ6KogrWrXVOPeOueFij8UQkQNM Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv61jar8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 13:57:21 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BADq5R6022488;
        Fri, 10 Dec 2021 13:57:20 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv61jar7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 13:57:20 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BADmFeA019242;
        Fri, 10 Dec 2021 13:57:18 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3cqyycfmg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 13:57:18 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BADvHUk24445388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 13:57:17 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BC78136060;
        Fri, 10 Dec 2021 13:57:17 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18B51136068;
        Fri, 10 Dec 2021 13:57:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 13:57:11 +0000 (GMT)
Message-ID: <dca4e7c9-87a7-9a9e-b1f2-df16f1a45019@linux.ibm.com>
Date:   Fri, 10 Dec 2021 08:57:11 -0500
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211210113244.odv2ibrifz2jzft5@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IDBp8fUWqtkLjuM35jMFYgk5yYe4eZsn
X-Proofpoint-ORIG-GUID: J08jX-gnm7GW6tBI_SZ8yWhfpNtOAWcw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_04,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/10/21 06:32, Christian Brauner wrote:
> On Thu, Dec 09, 2021 at 07:57:02PM -0500, Stefan Berger wrote:
>> On 12/9/21 14:11, Christian Brauner wrote:
>>>   From 1f03dc427c583d5e9ebc9ebe9de77c3c535bbebe Mon Sep 17 00:00:00 2001
>>> From: Christian Brauner <christian.brauner@ubuntu.com>
>>> Date: Thu, 9 Dec 2021 20:07:02 +0100
>>> Subject: [PATCH] !!!! HERE BE DRAGONS - UNTESTED !!!!
>>>
>>> ---
>>>    security/integrity/ima/ima_fs.c | 43 +++++++++++++++++++++++++++++----
>>>    1 file changed, 38 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>>> index 583462b29cb5..d5b302b925b8 100644
>>> --- a/security/integrity/ima/ima_fs.c
>>> +++ b/security/integrity/ima/ima_fs.c
>>> @@ -317,10 +317,14 @@ static ssize_t ima_read_policy(char *path)
>>>    static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>>>    				size_t datalen, loff_t *ppos)
>>>    {
>>> -	struct ima_namespace *ns = get_current_ns();
>>> +	struct ima_namespace *ns;
>>> +	struct user_namespace *user_ns;
>>>    	char *data;
>>>    	ssize_t result;
>>> +	user_ns = ima_filp_private(filp);
>>> +	ns = user_ns->ima_ns
>>> +
>>>    	if (datalen >= PAGE_SIZE)
>>>    		datalen = PAGE_SIZE - 1;
>>> @@ -373,26 +377,51 @@ static const struct seq_operations ima_policy_seqops = {
>>>    };
>>>    #endif
>>> +static struct user_namespace *ima_filp_private(struct file *filp)
>>> +{
>>> +	if (!(filp->f_flags & O_WRONLY)) {
>>> +#ifdef CONFIG_IMA_READ_POLICY
>>> +		struct seq_file *seq;
>>> +
>>> +		seq = filp->private_data;
>>> +		return seq->private;
>>> +#endif
>>> +	}
>>> +	return filp->private_data;
>>> +}
>>> +
>>>    /*
>>>     * ima_open_policy: sequentialize access to the policy file
>>>     */
>>>    static int ima_open_policy(struct inode *inode, struct file *filp)
>>>    {
>>> -	struct ima_namespace *ns = get_current_ns();
>>> +	struct user_namespace *user_ns = current_user_ns();
>>
>> Do we have to take a reference on the user namespace assuming one can open
>> the file, pass the fd down the hierarchy, and then the user namespace with
>> the opened file goes away? Or is there anything else that keeps the user
>> namespace alive?
> No, we don't. When ima_policy_open() is called we do current_user_ns()
> but that will be guaranteed to be identical to filp->f_cred->user_ns.
> And f_cred is a reference that has been taken when the vfs allocated a
> struct file for this .open call so won't go away until the last fput.
>
> My proposal is also too complicated, I think.
> (The booster is giving me the same side-effects as my second shot so
> this looks like two good days of fever and headache. So I'll use that as
> an excuse. :))
>
> Your patch series as it stands has a bit of a security issue with those
> get_current_ns() calls across differnet file/seq_file operations.
>
> You have to make an architectural decision, I think. I see two sensible
> options:
> 1. The relevant ima_ns that .open/.read/.write operate on is always taken
>     to be the ima_ns of the filesystem's userns, i.e.
>     sb->s_user_ns->ima_ns.
>     This - but I'm not an ima person - makes the most sense to me and the
>     semantics are straightforward. If I write to a file to alter some
>     policy then I expect the ima namespace of the user namespace to be
>     affected that the securityfs instance was mounted in.
> 2. The relevant ima_ns that .open/.read/.write operate on is always
>     taken to be the one of the opener. I don't really like that as that
>     gets weird if for some complicated reason the caller is not located
>     in the userns the filesystem was mounted in (weird mount propagation
>     scenario or sm). It also feels strange to operate on an ima_ns that's
>     different from s_user_ns->ima_ns in a securityfs instance.

We have this situation because one can setns() to another mount 
namespaces but the data shown by SecurityFS lives in a user namespace, 
right? And now we need to decide whether to affect the data in the user 
namespace  that did the open (option 2) or to which the SecurityFS 
belongs to (option 1). If we were to open a regular file it would be 
option 1, so we should probably not break that existing semantic and 
also choose option 1 unless there one wasn't allowed to choose the user 
namespace the SecurityFS files belonged to then it should be option 2 
but then we have file descriptor passing where 'being allowed' can 
change depending on who is reading/writing a file... Is there anything 
that would prevent us from setns()'ing to that target user namespace so 
that we would now see that of a user namespace that we are not allowed 
to see?

Following man page of setns:

"   User namespaces
               A process reassociating itself with a user namespace must
               have the CAP_SYS_ADMIN capability in the target user
               namespace.  (This necessarily implies that it is only
               possible to join a descendant user namespace.)  Upon
               successfully joining a user namespace, a process is
               granted all capabilities in that namespace, regardless of
               its user and group IDs."


So if we choose option 1 maybe we have to test for this capability upon 
every read/write from/to a file?


    Stefan


>
> So I think I would propose you do sm:
>
>  From 6c8018f14f22e7bc2255dcebab96f9b8c39a8459 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Fri, 10 Dec 2021 10:31:27 +0100
> Subject: [PATCH 1/2] !!!! HERE BE DRAGONS - COMPLETELY UNTESTED !!!!
>
> The relevant ima_ns that .open/.read/.write operate on is always taken to be
> the ima_ns of the filesystem's userns, i.e.  sb->s_user_ns->ima_ns. This - but
> I'm not an ima person - makes the most sense to me and the semantics are
> straightforward. If I write to a file to alter some policy then I expect the
> ima namespace of the user namespace to be affected that the securityfs instance
> was mounted in.
> ---
>   security/integrity/ima/ima_fs.c     | 30 ++++++++++++++++++-----------
>   security/integrity/ima/ima_policy.c |  8 ++++++--
>   2 files changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 778983fd9a73..95b7b9ec2a76 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -49,7 +49,8 @@ static ssize_t ima_show_htable_violations(struct file *filp,
>   					  char __user *buf,
>   					  size_t count, loff_t *ppos)
>   {
> -	struct ima_namespace *ns = get_current_ns();
> +	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->s_user_ns;
> +	struct ima_namespace *ns = user_ns->ima_ns;
>   
>   	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.violations);
>   }
> @@ -63,7 +64,8 @@ static ssize_t ima_show_measurements_count(struct file *filp,
>   					   char __user *buf,
>   					   size_t count, loff_t *ppos)
>   {
> -	struct ima_namespace *ns = get_current_ns();
> +	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->s_user_ns;
> +	struct ima_namespace *ns = user_ns->ima_ns;
>   
>   	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
>   }
> @@ -76,7 +78,9 @@ static const struct file_operations ima_measurements_count_ops = {
>   /* returns pointer to hlist_node */
>   static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
>   {
> -	struct ima_namespace *ns = get_current_ns();
> +	const struct file *filp = m->file;
> +	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->s_user_ns;
> +	struct ima_namespace *ns = user_ns->ima_ns;
>   	loff_t l = *pos;
>   	struct ima_queue_entry *qe;
>   
> @@ -94,7 +98,9 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
>   
>   static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
>   {
> -	struct ima_namespace *ns = get_current_ns();
> +	const struct file *filp = m->file;
> +	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->s_user_ns;
> +	struct ima_namespace *ns = user_ns->ima_ns;
>   	struct ima_queue_entry *qe = v;
>   
>   	/* lock protects when reading beyond last element
> @@ -273,9 +279,8 @@ static const struct file_operations ima_ascii_measurements_ops = {
>   	.release = seq_release,
>   };
>   
> -static ssize_t ima_read_policy(char *path)
> +static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
>   {
> -	struct ima_namespace *ns = get_current_ns();
>   	void *data = NULL;
>   	char *datap;
>   	size_t size;
> @@ -317,7 +322,8 @@ static ssize_t ima_read_policy(char *path)
>   static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>   				size_t datalen, loff_t *ppos)
>   {
> -	struct ima_namespace *ns = get_current_ns();
> +	struct user_namespace *user_ns = file->f_path.mnt->mnt_sb->s_user_ns;
> +	struct ima_namespace *ns = user_ns->ima_ns;
>   	char *data;
>   	ssize_t result;
>   
> @@ -340,7 +346,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>   		goto out_free;
>   
>   	if (data[0] == '/') {
> -		result = ima_read_policy(data);
> +		result = ima_read_policy(ns, data);
>   	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
>   		pr_err("signed policy file (specified as an absolute pathname) required\n");
>   		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
> @@ -378,7 +384,8 @@ static const struct seq_operations ima_policy_seqops = {
>    */
>   static int ima_open_policy(struct inode *inode, struct file *filp)
>   {
> -	struct ima_namespace *ns = get_current_ns();
> +	struct user_namespace *user_ns = inode->i_sb->s_user_ns;
> +	struct ima_namespace *ns = user_ns->ima_ns;
>   
>   	if (!(filp->f_flags & O_WRONLY)) {
>   #ifndef	CONFIG_IMA_READ_POLICY
> @@ -386,7 +393,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
>   #else
>   		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>   			return -EACCES;
> -		if (!mac_admin_ns_capable(ns->user_ns))
> +		if (!mac_admin_ns_capable(user_ns))
>   			return -EPERM;
>   		return seq_open(filp, &ima_policy_seqops);
>   #endif
> @@ -405,7 +412,8 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
>    */
>   static int ima_release_policy(struct inode *inode, struct file *file)
>   {
> -	struct ima_namespace *ns = get_current_ns();
> +	struct user_namespace *user_ns = inode->i_sb->s_user_ns;
> +	struct ima_namespace *ns = user_ns->ima_ns;
>   	const char *cause = ns->valid_policy ? "completed" : "failed";
>   
>   	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 747dca6131d6..41e5f17ec44d 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1908,7 +1908,9 @@ static const char *const mask_tokens[] = {
>   
>   void *ima_policy_start(struct seq_file *m, loff_t *pos)
>   {
> -	struct ima_namespace *ns = get_current_ns();
> +	const struct file *filp = m->file;
> +	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->user_ns;
> +	struct ima_namespace *ns = user_ns->ima_ns;
>   	loff_t l = *pos;
>   	struct ima_rule_entry *entry;
>   	struct list_head *ima_rules_tmp;
> @@ -1928,7 +1930,9 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
>   void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
>   {
>   	struct ima_rule_entry *entry = v;
> -	struct ima_namespace *ns = get_current_ns();
> +	const struct file *filp = m->file;
> +	struct user_namespace *user_ns = filp->f_path.mnt->mnt_sb->user_ns;
> +	struct ima_namespace *ns = user_ns->ima_ns;
>   
>   	rcu_read_lock();
>   	entry = list_entry_rcu(entry->list.next, struct ima_rule_entry, list);
