Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E2D492CCC
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 18:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244366AbiARRyX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 12:54:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1347631AbiARRyT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 12:54:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IGS4Rl002620;
        Tue, 18 Jan 2022 17:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=y3efBJ6aT6fI6z4I5om7afk68D/bkad5TF9TKGyQmGw=;
 b=djNwvVVBlpJDEZXKYi0bEo9L8CUwhaY8Oqy2Rj/C1ALDzzV70l8vpg0shiEc3vGjh5q5
 pzoNqnnuKYfzIZjtz9mFoagJ7tvsAZ17LvExIbi4OZlGSjiKfQlBOFunF6yFtiMZ9XbP
 XvD1GUiIDutqlqfX4ktm+5QgDZvIUxB6ajqeTkinYy4Iy+FF5fXozcJpPUsYkuaH1S39
 UCSUGQxV8Djr+iZ7G9GgSuIQPfY9QiwOAQqSWYFbLETVpfgrWq4VCNlyEdOkT7vTPlRN
 MQKHdmBcFNxQc39m2dkjEmVhq5fjnCgB3YiuuSnijLjLFho5EWke3NNCh4YLEXfWpFUm LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dp13hsvyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 17:54:00 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20IHoFEX010362;
        Tue, 18 Jan 2022 17:54:00 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dp13hsvyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 17:54:00 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20IHlsX8025593;
        Tue, 18 Jan 2022 17:53:59 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 3dknwapvwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 17:53:59 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20IHrwU533292696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 17:53:58 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF1516E05E;
        Tue, 18 Jan 2022 17:53:57 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C1AA6E058;
        Tue, 18 Jan 2022 17:53:55 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jan 2022 17:53:54 +0000 (GMT)
Message-ID: <15ae2c20-ae1f-0341-95d5-3168cdf899a5@linux.ibm.com>
Date:   Tue, 18 Jan 2022 12:53:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 19/19] ima: Enable IMA namespaces
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-20-stefanb@linux.vnet.ibm.com>
 <20220114120547.jrasikjcaahareue@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220114120547.jrasikjcaahareue@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WoKmuWAJVfbWo5bSfKsP711Xate2ghkI
X-Proofpoint-ORIG-GUID: 28fp6P9H9SXB8sfL7HXkXeSsy1O7F1dI
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_05,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180105
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/14/22 07:05, Christian Brauner wrote:
> On Tue, Jan 04, 2022 at 12:04:16PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Introduce the IMA_NS in Kconfig for IMA namespace enablement.
>>
>> Enable the lazy initialization of an IMA namespace when a user mounts
>> SecurityFS. Now a user_namespace will get a pointer to an ima_namespace
>> and therefore add an implementation of get_current_ns() that returns this
>> pointer.
>>
>> get_current_ns() may now return a NULL pointer for as long as the IMA
>> namespace hasn't been created, yet. Therefore, return early from those
>> functions that may now get a NULL pointer from this call. The NULL
>> pointer can typically be treated similar to not having an IMA policy set
>> and simply return early from a function.
>>
>> Implement ima_ns_from_file() for SecurityFS-related files where we can
>> now get the IMA namespace via the user namespace pointer associated
>> with the superblock of the SecurityFS filesystem instance. Since
>> the functions using ima_ns_from_file() will only be called after an
>> ima_namesapce has been allocated they will never get a NULL pointer
>> for the ima_namespace.
>>
>> Switch access to userns->ima_ns to use acquire/release semantics to ensure
>> that a newly created ima_namespace structure is fully visible upon access.
>>
>> Replace usage of current_user_ns() with ima_ns_from_user_ns() that
>> implements a method to derive the user_namespace from the given
>> ima_namespace. It leads to the same result.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   include/linux/ima.h                 |  9 ++++++-
>>   init/Kconfig                        | 13 ++++++++++
>>   kernel/user_namespace.c             |  2 ++
>>   security/integrity/ima/ima.h        | 35 ++++++++++++++++++++++-----
>>   security/integrity/ima/ima_fs.c     | 37 ++++++++++++++++++++++-------
>>   security/integrity/ima/ima_main.c   | 29 ++++++++++++++++------
>>   security/integrity/ima/ima_ns.c     |  3 ++-
>>   security/integrity/ima/ima_policy.c | 13 +++++-----
>>   8 files changed, 112 insertions(+), 29 deletions(-)
>>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index 5354e83d1694..7b9713b290ae 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -11,6 +11,7 @@
>>   #include <linux/fs.h>
>>   #include <linux/security.h>
>>   #include <linux/kexec.h>
>> +#include <linux/user_namespace.h>
>>   #include <crypto/hash_info.h>
>>   struct linux_binprm;
>>   
>> @@ -71,7 +72,13 @@ static inline const char * const *arch_get_ima_policy(void)
>>   static inline struct user_namespace
>>   *ima_ns_to_user_ns(struct ima_namespace *ns)
>>   {
>> -	return current_user_ns();
>> +	struct user_namespace *user_ns;
>> +
>> +	user_ns = current_user_ns();
>> +#ifdef CONFIG_IMA_NS
>> +	WARN_ON(user_ns->ima_ns != ns);
>> +#endif
>> +	return user_ns;
>>   }
>>   
>>   #else
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 4b7bac10c72d..e27155e0ddba 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1247,6 +1247,19 @@ config NET_NS
>>   	  Allow user space to create what appear to be multiple instances
>>   	  of the network stack.
>>   
>> +config IMA_NS
>> +	bool "IMA namespace"
>> +	depends on USER_NS
>> +	depends on IMA
>> +	default n
>> +	help
>> +	  Allow the creation of an IMA namespace for each user namespace.
>> +	  Namespaced IMA enables having IMA features work separately
>> +	  in each IMA namespace.
>> +	  Currently, only the audit status flags are stored in the namespace,
>> +	  which allows the same file to be audited each time it is accessed
>> +	  in a new namespace.
>> +
>>   endif # NAMESPACES
>>   
>>   config CHECKPOINT_RESTORE
>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>> index 6b2e3ca7ee99..653f8fa83b69 100644
>> --- a/kernel/user_namespace.c
>> +++ b/kernel/user_namespace.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/fs_struct.h>
>>   #include <linux/bsearch.h>
>>   #include <linux/sort.h>
>> +#include <linux/ima.h>
>>   
>>   static struct kmem_cache *user_ns_cachep __read_mostly;
>>   static DEFINE_MUTEX(userns_state_mutex);
>> @@ -196,6 +197,7 @@ static void free_user_ns(struct work_struct *work)
>>   			kfree(ns->projid_map.forward);
>>   			kfree(ns->projid_map.reverse);
>>   		}
>> +		free_ima_ns(ns);
>>   		retire_userns_sysctls(ns);
>>   		key_free_user_ns(ns);
>>   		ns_free_inum(&ns->ns);
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 344c8c4bd030..d993655ec796 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -509,21 +509,20 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
>>   	return file_inode(filp)->i_sb->s_user_ns;
>>   }
>>   
>> +#ifdef CONFIG_IMA_NS
>> +
>>   static inline struct ima_namespace
>>   *ima_ns_from_user_ns(struct user_namespace *user_ns)
>>   {
>> -	if (user_ns == &init_user_ns)
>> -		return &init_ima_ns;
>> -	return NULL;
>> +	/* Pairs with smp_store_releases() in create_ima_ns(). */
>> +	return smp_load_acquire(&user_ns->ima_ns);
>>   }
>>   
>>   static inline struct ima_namespace *get_current_ns(void)
>>   {
>> -	return &init_ima_ns;
>> +	return ima_ns_from_user_ns(current_user_ns());
>>   }
>>   
>> -#ifdef CONFIG_IMA_NS
>> -
>>   struct ima_namespace *create_ima_ns(struct user_namespace *user_ns);
>>   
>>   struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
>> @@ -532,6 +531,11 @@ struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
>>   
>>   void ima_free_ns_status_tree(struct ima_namespace *ns);
>>   
>> +static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
>> +{
>> +	return ima_user_ns_from_file(filp)->ima_ns;
>> +}
>> +
>>   #define IMA_NS_STATUS_ACTIONS   IMA_AUDIT
>>   #define IMA_NS_STATUS_FLAGS     IMA_AUDITED
>>   
>> @@ -542,6 +546,20 @@ unsigned long set_iint_flags(struct integrity_iint_cache *iint,
>>   
>>   #else
>>   
>> +static inline struct ima_namespace
>> +*ima_ns_from_user_ns(struct user_namespace *user_ns)
>> +{
>> +	if (user_ns == &init_user_ns)
>> +		return &init_ima_ns;
>> +	return NULL;
>> +}
>> +
>> +
>> +static inline struct ima_namespace *get_current_ns(void)
>> +{
>> +	return &init_ima_ns;
>> +}
>> +
>>   static inline struct ima_namespace *
>>   create_ima_ns(struct user_namespace *user_ns)
>>   {
>> @@ -572,6 +590,11 @@ static inline unsigned long set_iint_flags(struct integrity_iint_cache *iint,
>>   	return flags;
>>   }
>>   
>> +static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
>> +{
>> +	return &init_ima_ns;
>> +}
>> +
>>   #endif /* CONFIG_IMA_NS */
>>   
>>   #endif /* __LINUX_IMA_H */
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index 468508f6a7e8..ee3af81d1c3e 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -49,7 +49,7 @@ static ssize_t ima_show_htable_violations(struct file *filp,
>>   					  char __user *buf,
>>   					  size_t count, loff_t *ppos)
>>   {
>> -	struct ima_namespace *ns = &init_ima_ns;
>> +	struct ima_namespace *ns = ima_ns_from_file(filp);
>>   
>>   	return ima_show_htable_value(buf, count, ppos,
>>   				     &ns->ima_htable.violations);
>> @@ -64,7 +64,7 @@ static ssize_t ima_show_measurements_count(struct file *filp,
>>   					   char __user *buf,
>>   					   size_t count, loff_t *ppos)
>>   {
>> -	struct ima_namespace *ns = &init_ima_ns;
>> +	struct ima_namespace *ns = ima_ns_from_file(filp);
>>   
>>   	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
>>   }
>> @@ -77,7 +77,7 @@ static const struct file_operations ima_measurements_count_ops = {
>>   /* returns pointer to hlist_node */
>>   static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
>>   {
>> -	struct ima_namespace *ns = &init_ima_ns;
>> +	struct ima_namespace *ns = ima_ns_from_file(m->file);
>>   	loff_t l = *pos;
>>   	struct ima_queue_entry *qe;
>>   
>> @@ -95,7 +95,7 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
>>   
>>   static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
>>   {
>> -	struct ima_namespace *ns = &init_ima_ns;
>> +	struct ima_namespace *ns = ima_ns_from_file(m->file);
>>   	struct ima_queue_entry *qe = v;
>>   
>>   	/* lock protects when reading beyond last element
>> @@ -317,7 +317,7 @@ static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
>>   static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>>   				size_t datalen, loff_t *ppos)
>>   {
>> -	struct ima_namespace *ns = &init_ima_ns;
>> +	struct ima_namespace *ns = ima_ns_from_file(file);
>>   	char *data;
>>   	ssize_t result;
>>   
>> @@ -379,7 +379,7 @@ static const struct seq_operations ima_policy_seqops = {
>>   static int ima_open_policy(struct inode *inode, struct file *filp)
>>   {
>>   	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
>> -	struct ima_namespace *ns = &init_ima_ns;
>> +	struct ima_namespace *ns = ima_ns_from_file(filp);
>>   
>>   	if (!(filp->f_flags & O_WRONLY)) {
>>   #ifndef	CONFIG_IMA_READ_POLICY
>> @@ -406,7 +406,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
>>    */
>>   static int ima_release_policy(struct inode *inode, struct file *file)
>>   {
>> -	struct ima_namespace *ns = &init_ima_ns;
>> +	struct ima_namespace *ns = ima_ns_from_file(file);
>>   	const char *cause = ns->valid_policy ? "completed" : "failed";
>>   
>>   	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
>> @@ -459,12 +459,29 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>>   	struct dentry *ascii_runtime_measurements = NULL;
>>   	struct dentry *runtime_measurements_count = NULL;
>>   	struct dentry *violations = NULL;
>> +	bool created_ns = false;
>> +
>> +	/*
>> +	 * While multiple superblocks can exist they are keyed by userns in
>> +	 * s_fs_info for securityfs. The first time a userns mounts a
>> +	 * securityfs instance we lazily allocate the ima_namespace for the
>> +	 * userns since that's the only way a userns can meaningfully use ima.
>> +	 * The vfs ensures we're the only one to call fill_super() and hence
>> +	 * ima_fs_ns_init(), so we don't need any memory barriers here, i.e.
>> +	 * user_ns->ima_ns can't change while we're in here.
>> +	 */
>> +	if (!ns) {
>> +		ns = create_ima_ns(user_ns);
>> +		if (IS_ERR(ns))
>> +			return PTR_ERR(ns);
>> +		created_ns = true;
>> +	}
> Since create_ima_ns() initializes user_ns->ima_ns via
> smp_store_release() the patch currently implies that concurrent access
> to user_ns->ima_ns are safe once create_ima_ns() returns.
>
> Specifically, it entails that no caller will access entries in the ima
> namespace that will only be filled in past this point. Afaict, this only
> relates to the ns->policy_dentry which can't be accessed until
> securityfs is finished.
>
> Nonetheless, I would recommend that you change create_ima_ns() to not
> initialize user_ns->ima_ns and instead defer this until everything in
> the namespace is setup. So maybe move the smp_store_release() to the end
> of ima_fs_ns_init(). If ns->policy_dentry wouldn't be stashed in ima_ns
> it wouldn't matter but since it is I would not publish ima_ns before
> this is set. Sm like (uncompiled, untested):
>
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index ee3af81d1c3e..64ca47671d31 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -531,6 +531,8 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>                          goto out;
>          }
>
> +       if (!user_ns->ima_ns)
> +               smp_store_release(&user_ns->ima_ns, ns);
>          return 0;
>   out:
>          securityfs_remove(ns->policy_dentry);
>
> As a side-effect this will let you get rid of the bool created_ns and
> thereby simplify the codeflow.

Fixed. Thanks.


>
> (Note, that obviously means that the changes I mentioned earlier in
> https://lore.kernel.org/containers/20220114114321.7prnt72ukvch4wxa@wittgenstein
> can't be made.)
