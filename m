Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F544C1D5E
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 21:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbiBWUys (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 15:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbiBWUys (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 15:54:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355244A3F2;
        Wed, 23 Feb 2022 12:54:19 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NK0QcJ022365;
        Wed, 23 Feb 2022 20:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CFPoUZYSAGJFsYIc1aXuJflFBjjX2GY7rRSh8KMQsGY=;
 b=JO9WlQ+WpcQC6jJvD5uU8WEo6fibQx+Wg9t/KeIHKJlEa4f0lebxbecTEdMbyUOpS4un
 9sxT25alciNsSit+DwPcEKLwwAyNDyJ06M+JE7ydwsDn8CRmxEPyPrLC2lGdO84H14+4
 hSk3CK9r9WwKvhe2LxFgfIXcRS66Jf+MdtkviEyoav3m7sy3LPHdT+n0YPxiIsUVNO51
 fTPgLWNncU3vKf+RChkbdHSrvY+ChLjdbm2xcBSnYkILQK/xEybrTFlkQL+tJKZu30/x
 fvMB09rqjhMg/RP96FfIkTEf+9cgXltESis3skTbDQu/QlsLwDculxzZOZoFou3mg/bJ 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eduas9e1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 20:54:03 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NJureY010193;
        Wed, 23 Feb 2022 20:54:03 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eduas9e1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 20:54:03 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NKqaN4029685;
        Wed, 23 Feb 2022 20:54:02 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3ear6b90v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 20:54:02 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NKrvhI45285730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 20:53:57 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3375AE06A;
        Wed, 23 Feb 2022 20:53:56 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8583AAE060;
        Wed, 23 Feb 2022 20:53:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 20:53:56 +0000 (GMT)
Message-ID: <d5d51d9e-4b38-c144-76fb-988104ce9bf2@linux.ibm.com>
Date:   Wed, 23 Feb 2022 15:53:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 27/27] ima: Enable IMA namespaces
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-28-stefanb@linux.ibm.com>
 <20220223175854.GB10272@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220223175854.GB10272@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A4OIF9P1OAg6rb42mp1x3UQ798eBqWfm
X-Proofpoint-ORIG-GUID: pZBr7XFOSUAcIftIoXSRF3wkmkT306Gv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_09,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202230116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/23/22 12:58, Serge E. Hallyn wrote:
> On Tue, Feb 01, 2022 at 03:37:35PM -0500, Stefan Berger wrote:
>> Introduce the IMA_NS in Kconfig for IMA namespace enablement.
>>
>> Enable the lazy initialization of an IMA namespace when a user mounts
>> SecurityFS and writes '1' into IMA's 'active' securityfs file. A
>> user_namespace will now get a pointer to an ima_namespace and therefore
>> implement get_current_ns() for the namespacing case that returns this
>> pointer. Use get_current_ns() in those places that require access to the
>> current IMA namespace. In some places, primarily those related to
>> IMA-appraisal and changes to file attributes, keep the pointer to
>> init_ima_ns, since there flags related to file measurements may be
>> affected, which are not supported in IMA namespaces, yet.
>>
>> Before using the ima_namespace pointer test it with ns_is_active()
>> to check whether it is NULL and whether the ima_namespace is active.
>> If it's not active, it cannot be used, yet. Therefore, return early
>> from those functions that may now get either get a NULL pointer from
>> this call or where ns->active is still 0. The init_ima_ns is always
>> set to be active, thus passing the check.
>>
>> Implement ima_ns_from_file() for SecurityFS-related files where we can
>> now get the IMA namespace via the user namespace pointer associated
>> with the superblock of the SecurityFS filesystem instance.
>>
>> Return -EACCES to IMA's securityfs files, except for the 'active' file,
>> until the IMA namespace has been set to active.
>>
>> Switch access to userns->ima_ns to use acquire/release semantics to ensure
>> that a newly created ima_namespace structure is fully visible upon access.
>>
>> Only emit the kernel log message 'policy update completed' for the
>> init_ima_ns.
>>
>> When parsing an IMA policy rule use the user namespace of the opener
>> to translate uid and gid values to kernel values rather than the user
>> namespace of the writer.
>>
>> Gate access to ima_appraise variable to init_ima_ns in ima_load_data()
>> and ima_write_policy().
>>
>> Gate access to temp_ima_appraise variable to init_ima_ns in
>> ima_delete_rules().
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> ---
>> v10:
>>   - dropped ima_ns_to_user_ns(); using current_user_ns() instead
>>   - Pass user_namespace of file opener into ima_parse_rule and propagate
>>     this parameter back all the way to the initial caller in the chain
>>   - Gate access to ima_appraise to init_ima_ns in ima_write_policy()
>>
>> v9:
>>   - ima_post_key_create_or_update: Only handle key if in init_ima_ns
>>   - Removed ns == NULL checks where user_namespace is now passed
>>   - Defer setting of user_ns->ima_ns until end of ima_fs_ns_init();
>>     required new ima_free_imans() and new user_ns_set_ima_ns()
>>   - Only emit log message 'policy update completed' for init_ima_ns
>>   - Introduce get_current_ns() only in this patch
>>   - Check for ns == &init_ima_ns in ima_load_data()
>> ---
>>   include/linux/ima.h                          |  1 +
>>   init/Kconfig                                 | 13 +++
>>   kernel/user_namespace.c                      |  2 +
>>   security/integrity/ima/ima.h                 | 55 +++++++++++--
>>   security/integrity/ima/ima_appraise.c        |  3 +
>>   security/integrity/ima/ima_asymmetric_keys.c |  6 +-
>>   security/integrity/ima/ima_fs.c              | 87 ++++++++++++++++----
>>   security/integrity/ima/ima_init.c            |  2 +-
>>   security/integrity/ima/ima_init_ima_ns.c     |  2 +
>>   security/integrity/ima/ima_main.c            | 34 +++++---
>>   security/integrity/ima/ima_ns.c              | 15 +++-
>>   security/integrity/ima/ima_policy.c          | 43 ++++++----
>>   12 files changed, 202 insertions(+), 61 deletions(-)
>>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index c584527c0f47..a8cb2c269f61 100644
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
>> index 05e2de7697da..73df1d8a2ece 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -337,10 +337,10 @@ int ima_match_policy(struct ima_namespace *ns,
>>   		     int mask, int flags, int *pcr,
>>   		     struct ima_template_desc **template_desc,
>>   		     const char *func_data, unsigned int *allowed_algos);
>> -void ima_init_policy(struct ima_namespace *ns);
>> +void ima_init_policy(struct user_namespace *user_ns);
>>   void ima_update_policy(struct ima_namespace *ns);
>>   void ima_update_policy_flags(struct ima_namespace *ns);
>> -ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
>> +ssize_t ima_parse_add_rule(struct user_namespace *user_ns, char *rule);
>>   void ima_delete_rules(struct ima_namespace *ns);
>>   int ima_check_policy(struct ima_namespace *ns);
>>   void ima_free_policy_rules(struct ima_namespace *ns);
>> @@ -538,32 +538,70 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
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
>> +	/* Pairs with smp_store_releases() in user_ns_set_ima_ns(). */
>> +	return smp_load_acquire(&user_ns->ima_ns);
>>   }
>>   
>> -#ifdef CONFIG_IMA_NS
>> +static inline void user_ns_set_ima_ns(struct user_namespace *user_ns,
>> +				      struct ima_namespace *ns)
>> +{
>> +	/* Pairs with smp_load_acquire() in ima_ns_from_user_ns() */
>> +	smp_store_release(&user_ns->ima_ns, ns);
>> +}
>> +
>> +static inline struct ima_namespace *get_current_ns(void)
>> +{
>> +	return ima_ns_from_user_ns(current_user_ns());
>> +}
>>   
>>   struct ima_namespace *create_ima_ns(void);
>>   
>> +void ima_free_ima_ns(struct ima_namespace *ns);
>> +
>>   struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
>>   				    struct inode *inode,
>>   				    struct integrity_iint_cache *iint);
>>   
>>   void ima_free_ns_status_tree(struct ima_namespace *ns);
>>   
>> +static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
>> +{
> Why is it ok here to dereference userns->ima_ns without
> going through ima_ns_from_user_ns() to do the smp_load_acquire()?

Good catch! Fixed.

     Stefan


