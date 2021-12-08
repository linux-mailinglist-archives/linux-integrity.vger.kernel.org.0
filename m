Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC3A46D61B
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 15:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhLHOyJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 09:54:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235485AbhLHOyJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 09:54:09 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8EmpkL026137;
        Wed, 8 Dec 2021 14:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IvuS9X7/RtKjXnM5zh9hQ7f3NjgI2T2yF0Bg69kAweg=;
 b=iya9cXMF8OQ040OY3JwJfvtUDeGUh4Mml57lWg11VRf9jp08dq7yTED1TuDGD0icWIqG
 m5XszoUNquU7mjcMM0iki/GGomtcnPn79rOA7IJ23SedFL+yqAWo0DfFU5P/nE/SOM/G
 7xXHkV+3PEb03Yf1hNQw4woaUvj2aLddGiOqMR1Bxmigz/A2VM11ghlr4JQVIltvhXCD
 jwh/bL/DB4wBOV2B6kMx/ESaoYCRjp7yzLLkugeBYnfm5GAVjLI5zW7twZZK+CkATLW+
 N1dvDqYSnG0LI6rCpzaBjFksauPtqiqykPn1UYdmRu76I4Z2KNgAkmUXrqaQ5VhgKs+n 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ctxswr0sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:50:22 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8EngdR027857;
        Wed, 8 Dec 2021 14:50:22 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ctxswr0s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:50:22 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8ElqWv007940;
        Wed, 8 Dec 2021 14:50:21 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3cqyyb3c1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:50:21 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8EoJIm33554748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 14:50:19 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B437136065;
        Wed,  8 Dec 2021 14:50:19 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0696A136066;
        Wed,  8 Dec 2021 14:50:15 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 14:50:15 +0000 (GMT)
Message-ID: <5f9b38ef-04d7-e97e-be7d-424b39ef06bc@linux.ibm.com>
Date:   Wed, 8 Dec 2021 09:50:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 01/16] ima: Add IMA namespace support
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-2-stefanb@linux.ibm.com>
 <20211208112918.oxyyplwbpitytyfc@wittgenstein>
 <20211208115456.nwhhdwub6zlcmzb3@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211208115456.nwhhdwub6zlcmzb3@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rK6oN9noKo76U9v8d74iDgdIc9QmtDKN
X-Proofpoint-GUID: 9YPP9XyrF473pMestyTYV5Bmbi5C20Q9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_05,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080091
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/8/21 06:54, Christian Brauner wrote:
> On Wed, Dec 08, 2021 at 12:29:18PM +0100, Christian Brauner wrote:
>> On Tue, Dec 07, 2021 at 03:21:12PM -0500, Stefan Berger wrote:
>>> Implement an IMA namespace data structure that gets created alongside a
>>> user namespace with CLONE_NEWUSER. This lays down the foundation for
>>> namespacing the different aspects of IMA (eg. IMA-audit, IMA-measurement,
>>> IMA-appraisal).
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>>> ---
>>>   include/linux/ima.h                      | 59 +++++++++++++++++
>>>   include/linux/user_namespace.h           |  4 ++
>>>   init/Kconfig                             | 10 +++
>>>   kernel/user.c                            |  9 ++-
>>>   kernel/user_namespace.c                  | 16 +++++
>>>   security/integrity/ima/Makefile          |  3 +-
>>>   security/integrity/ima/ima.h             |  4 ++
>>>   security/integrity/ima/ima_init.c        |  4 ++
>>>   security/integrity/ima/ima_init_ima_ns.c | 32 +++++++++
>>>   security/integrity/ima/ima_ns.c          | 82 ++++++++++++++++++++++++
>>>   10 files changed, 221 insertions(+), 2 deletions(-)
>>>   create mode 100644 security/integrity/ima/ima_init_ima_ns.c
>>>   create mode 100644 security/integrity/ima/ima_ns.c
>>>
>>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>>> index b6ab66a546ae..86d126b9ff2f 100644
>>> --- a/include/linux/ima.h
>>> +++ b/include/linux/ima.h
>>> @@ -11,6 +11,7 @@
>>>   #include <linux/fs.h>
>>>   #include <linux/security.h>
>>>   #include <linux/kexec.h>
>>> +#include <linux/user_namespace.h>
>>>   #include <crypto/hash_info.h>
>>>   struct linux_binprm;
>>>   
>>> @@ -210,6 +211,64 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
>>>   }
>>>   #endif /* CONFIG_IMA_APPRAISE */
>>>   
>>> +struct ima_namespace {
>>> +	struct kref kref;
>>> +	struct user_namespace *user_ns;
>>> +};
>>> +
>>> +extern struct ima_namespace init_ima_ns;
>>> +
>>> +#ifdef CONFIG_IMA_NS
>>> +
>>> +void free_ima_ns(struct kref *kref);
>>> +
>>> +static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
>>> +{
>>> +	if (ns)
>>> +		kref_get(&ns->kref);
>>> +
>>> +	return ns;
>>> +}
>>> +
>>> +static inline void put_ima_ns(struct ima_namespace *ns)
>>> +{
>>> +	if (ns) {
>>> +		pr_debug("DEREF   ima_ns: 0x%p  ctr: %d\n", ns, kref_read(&ns->kref));
>>> +		kref_put(&ns->kref, free_ima_ns);
>>> +	}
>>> +}
>>> +
>>> +struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
>>> +				  struct user_namespace *user_ns);
>>> +
>>> +static inline struct ima_namespace *get_current_ns(void)
>>> +{
>>> +	return current_user_ns()->ima_ns;
>>> +}
>>> +
>>> +#else
>>> +
>>> +static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
>>> +{
>>> +	return ns;
>>> +}
>>> +
>>> +static inline void put_ima_ns(struct ima_namespace *ns)
>>> +{
>>> +}
>>> +
>>> +static inline struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
>>> +						struct user_namespace *user_ns)
>>> +{
>>> +	return old_ns;
>>> +}
>>> +
>>> +static inline struct ima_namespace *get_current_ns(void)
>>> +{
>>> +	return &init_ima_ns;
>>> +}
>>> +#endif /* CONFIG_IMA_NS */
>>> +
>>>   #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
>>>   extern bool ima_appraise_signature(enum kernel_read_file_id func);
>>>   #else
>>> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
>>> index 33a4240e6a6f..5249db04d62b 100644
>>> --- a/include/linux/user_namespace.h
>>> +++ b/include/linux/user_namespace.h
>>> @@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
>>>   #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
>>>   
>>>   struct ucounts;
>>> +struct ima_namespace;
>>>   
>>>   enum ucount_type {
>>>   	UCOUNT_USER_NAMESPACES,
>>> @@ -99,6 +100,9 @@ struct user_namespace {
>>>   #endif
>>>   	struct ucounts		*ucounts;
>>>   	long ucount_max[UCOUNT_COUNTS];
>>> +#ifdef CONFIG_IMA
>>> +	struct ima_namespace	*ima_ns;
>>> +#endif
>>>   } __randomize_layout;
>>>   
>>>   struct ucounts {
>>> diff --git a/init/Kconfig b/init/Kconfig
>>> index 11f8a845f259..27890607e8cb 100644
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -1242,6 +1242,16 @@ config NET_NS
>>>   	  Allow user space to create what appear to be multiple instances
>>>   	  of the network stack.
>>>   
>>> +config IMA_NS
>>> +	bool "IMA namespace"
>>> +	depends on USER_NS
>>> +	depends on IMA
>>> +	default y
>>> +	help
>>> +	  Allow the creation of IMA namespaces for each user namespace.
>>> +	  Namespaced IMA enables having IMA features work separately
>>> +	  in each IMA namespace.
>>> +
>>>   endif # NAMESPACES
>>>   
>>>   config CHECKPOINT_RESTORE
>>> diff --git a/kernel/user.c b/kernel/user.c
>>> index e2cf8c22b539..b5dc803a033d 100644
>>> --- a/kernel/user.c
>>> +++ b/kernel/user.c
>>> @@ -20,6 +20,10 @@
>>>   #include <linux/user_namespace.h>
>>>   #include <linux/proc_ns.h>
>>>   
>>> +#ifdef CONFIG_IMA
>>> +extern struct ima_namespace init_ima_ns;
>>> +#endif
>>> +
>>>   /*
>>>    * userns count is 1 for root user, 1 for init_uts_ns,
>>>    * and 1 for... ?
>>> @@ -55,7 +59,7 @@ struct user_namespace init_user_ns = {
>>>   			},
>>>   		},
>>>   	},
>>> -	.ns.count = REFCOUNT_INIT(3),
>>> +	.ns.count = REFCOUNT_INIT(4),
>>>   	.owner = GLOBAL_ROOT_UID,
>>>   	.group = GLOBAL_ROOT_GID,
>>>   	.ns.inum = PROC_USER_INIT_INO,
>>> @@ -67,6 +71,9 @@ struct user_namespace init_user_ns = {
>>>   	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
>>>   	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
>>>   #endif
>>> +#ifdef CONFIG_IMA
>>> +	.ima_ns = &init_ima_ns,
>>> +#endif
>>>   };
>>>   EXPORT_SYMBOL_GPL(init_user_ns);
>>>   
>>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>>> index 6b2e3ca7ee99..c26885343b19 100644
>>> --- a/kernel/user_namespace.c
>>> +++ b/kernel/user_namespace.c
>>> @@ -20,6 +20,7 @@
>>>   #include <linux/fs_struct.h>
>>>   #include <linux/bsearch.h>
>>>   #include <linux/sort.h>
>>> +#include <linux/ima.h>
>>>   
>>>   static struct kmem_cache *user_ns_cachep __read_mostly;
>>>   static DEFINE_MUTEX(userns_state_mutex);
>>> @@ -141,8 +142,20 @@ int create_user_ns(struct cred *new)
>>>   	if (!setup_userns_sysctls(ns))
>>>   		goto fail_keyring;
>>>   
>>> +#if CONFIG_IMA
>>> +	ns->ima_ns = copy_ima_ns(parent_ns->ima_ns, ns);
>>> +	if (IS_ERR(ns->ima_ns)) {
>>> +		ret = PTR_ERR(ns->ima_ns);
>>> +		goto fail_userns_sysctls;
>>> +	}
>>> +#endif
>>> +
>>>   	set_cred_user_ns(new, ns);
>>>   	return 0;
>>> +#if CONFIG_IMA
>>> +fail_userns_sysctls:
>>> +	retire_userns_sysctls(ns);
>>> +#endif
> If you rewrite copy_ima_ns() put_ima_ns() a little you can remove all
> the ifdefs in here and make this patch tiny.
>
> Make copy_ima_ns() return an int. Afaict, you can remove passing the
> parent ima_ns completely but if you have to pass through the
> parent_userns.
> Then you can initialize new_userns->ima_ns inside of copy_ima_ns() and
> the ifdef will only need to be visible inside copy_ima_ns() and not in
> create_user_ns(). Similar put_ima_ns() is only called in a single place
> namely kernel/user_namespace.c. Make it take a user_namespace argument
> and you can remove the ifdef in __put_user_ns() for put_ima_ns() too.
>
> So something -- COMPLETELY UNTESTED -- like the below should work:

Thanks. I did this now for v5.

    Stefan


