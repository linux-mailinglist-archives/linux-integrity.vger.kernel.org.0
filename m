Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA735396F9
	for <lists+linux-integrity@lfdr.de>; Tue, 31 May 2022 21:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbiEaT1R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 May 2022 15:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiEaT1P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 May 2022 15:27:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A72851324;
        Tue, 31 May 2022 12:27:13 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VHOgWb010757;
        Tue, 31 May 2022 19:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0i13K6S4RX30Jw1cMxVp7UgOOnAiK4TbUeW/yC0pBkA=;
 b=KdqLyJR9ZwgYsadrcAMw0khLnSkuiK5y1msC4M6tavbkT+bsOeck1bK5ROS7LDOAkRZG
 w0Xi0mvzd6dAoCNRg6lWJj0Wx+UBWQbfPrd83UVxj7S5lyYz8nEsh8ctepaH6R//7ZZG
 6CoVf5GJAKcHUzJXGW9O8SLAAUqJRfxwe9ybQ3HTGUXxyHKe6qYctHpaxc49LZKxy3F4
 1PjtUIR37fy3ktRYM4dZBfQVIBJAF5/zd6lKnTlAeYshJasXFGOskmESHWwerjvntUpI
 o0xum9XNWQ8owR/CdHC2wN4lSN024fj84owK3nuypVFnI0xtL1CUq1KritFg7bohrwr7 Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdq5gasfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 19:26:24 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24VJQ0fb007764;
        Tue, 31 May 2022 19:26:24 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdq5gases-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 19:26:24 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24VJKAO2007276;
        Tue, 31 May 2022 19:26:22 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01wdc.us.ibm.com with ESMTP id 3gbcbhx7ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 19:26:22 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24VJQLAv44958008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 19:26:21 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C665F2805E;
        Tue, 31 May 2022 19:26:21 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B60F28059;
        Tue, 31 May 2022 19:26:21 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 31 May 2022 19:26:21 +0000 (GMT)
Message-ID: <7e3f497e-fe51-bdc8-54c9-96b5e059935f@linux.ibm.com>
Date:   Tue, 31 May 2022 15:26:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v12 21/26] ima: Setup securityfs for IMA namespace
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christian Brauner <brauner@kernel.org>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-22-stefanb@linux.ibm.com>
 <20220530011610.GA7909@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220530011610.GA7909@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NHXGye_mCzRaBmikV0hacZ0ZdkEbN1yC
X-Proofpoint-ORIG-GUID: FlgReY-G9z2PI-PKjfNvet3Z688iMNMm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310085
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/29/22 21:16, Serge E. Hallyn wrote:
> On Wed, Apr 20, 2022 at 10:06:28AM -0400, Stefan Berger wrote:
>> Setup securityfs with symlinks, directories, and files for IMA
>> namespacing support. The same directory structure that IMA uses on the
>> host is also created for the namespacing case.
>>
>> The securityfs file and directory ownerships cannot be set when the
>> IMA namespace is initialized. Therefore, delay the setup of the file
>> system to a later point when securityfs is in securityfs_fill_super.
>>
>> Introduce a variable ima_policy_removed in ima_namespace that is used to
>> remember whether the policy file has previously been removed and thus
>> should not be created again in case of unmounting and again mounting
>> securityfs inside an IMA namespace.
>>
>> This filesystem can now be mounted as follows:
>>
>> mount -t securityfs /sys/kernel/security/ /sys/kernel/security/
>>
>> The following directories, symlinks, and files are available
>> when IMA namespacing is enabled, otherwise it will be empty:
>>
>> $ ls -l sys/kernel/security/
>> total 0
>> lr--r--r--. 1 root root 0 Dec  2 00:18 ima -> integrity/ima
>> drwxr-xr-x. 3 root root 0 Dec  2 00:18 integrity
>>
>> $ ls -l sys/kernel/security/ima/
>> total 0
>> -r--r-----. 1 root root 0 Dec  2 00:18 ascii_runtime_measurements
>> -r--r-----. 1 root root 0 Dec  2 00:18 binary_runtime_measurements
>> -rw-------. 1 root root 0 Dec  2 00:18 policy
>> -r--r-----. 1 root root 0 Dec  2 00:18 runtime_measurements_count
>> -r--r-----. 1 root root 0 Dec  2 00:18 violations
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Acked-by: Christian Brauner <brauner@kernel.org>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
> 
> but a nit below

Thanks for all the tags, I took all of them.
Would I need to worry about the other reviewerss' tags regardig the nit 
below? I'd rather leave it as-is otherwise.

    Stefan


> 
>>
>> ---
>>
>> v9:
>>   - rename policy_dentry_removed to ima_policy_removed
>> ---
>>   include/linux/ima.h             | 13 ++++++++++
>>   security/inode.c                |  6 ++++-
>>   security/integrity/ima/ima.h    |  1 +
>>   security/integrity/ima/ima_fs.c | 46 +++++++++++++++++++++++----------
>>   4 files changed, 52 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index b9301e2aaa8b..0cbf0434bc93 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -41,6 +41,7 @@ extern int ima_measure_critical_data(const char *event_label,
>>   				     const char *event_name,
>>   				     const void *buf, size_t buf_len,
>>   				     bool hash, u8 *digest, size_t digest_len);
>> +extern int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root);
>>   
>>   #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>>   extern void ima_appraise_parse_cmdline(void);
>> @@ -227,6 +228,12 @@ void free_ima_ns(struct user_namespace *ns);
>>   
>>   void ima_free_ns_status_list(struct list_head *head, rwlock_t *ns_list_lock);
>>   
>> +static inline int ima_securityfs_init(struct user_namespace *user_ns,
>> +				      struct dentry *root)
>> +{
>> +	return ima_fs_ns_init(user_ns, root);
>> +}
>> +
>>   #else
>>   
>>   static inline void free_ima_ns(struct user_namespace *user_ns)
>> @@ -238,6 +245,12 @@ static inline void ima_free_ns_status_list(struct list_head *head,
>>   {
>>   }
>>   
>> +static inline int ima_securityfs_init(struct user_namespace *ns,
>> +				      struct dentry *root)
>> +{
>> +	return 0;
>> +}
>> +
>>   #endif /* CONFIG_IMA_NS */
>>   
>>   #endif /* _LINUX_IMA_H */
>> diff --git a/security/inode.c b/security/inode.c
>> index 84c9396792a9..e81f55f054dc 100644
>> --- a/security/inode.c
>> +++ b/security/inode.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/fs_context.h>
>>   #include <linux/mount.h>
>>   #include <linux/pagemap.h>
>> +#include <linux/ima.h>
>>   #include <linux/init.h>
>>   #include <linux/namei.h>
>>   #include <linux/security.h>
>> @@ -82,7 +83,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	sb->s_op = &securityfs_super_operations;
>>   	sb->s_root->d_inode->i_op = &securityfs_dir_inode_operations;
>>   
>> -	return 0;
>> +	if (ns != &init_user_ns)
>> +		error = ima_securityfs_init(ns, sb->s_root);
>> +
>> +	return error;
>>   }
>>   
>>   static int securityfs_get_tree(struct fs_context *fc)
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index cb48fc1d5b80..801dc3c8bfde 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -152,6 +152,7 @@ struct ima_namespace {
>>   	int valid_policy;
>>   
>>   	struct dentry *ima_policy;
>> +	bool ima_policy_removed;
>>   
>>   	struct notifier_block ima_lsm_policy_notifier;
>>   } __randomize_layout;
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index c41aa61b7393..84cd02a9e19b 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/rcupdate.h>
>>   #include <linux/parser.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/ima.h>
>>   
>>   #include "ima.h"
>>   
>> @@ -433,6 +434,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>>   #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
>>   	securityfs_remove(ns->ima_policy);
>>   	ns->ima_policy = NULL;
>> +	ns->ima_policy_removed = true;
>>   #elif defined(CONFIG_IMA_WRITE_POLICY)
>>   	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
>>   #elif defined(CONFIG_IMA_READ_POLICY)
>> @@ -449,9 +451,11 @@ static const struct file_operations ima_measure_policy_ops = {
>>   	.llseek = generic_file_llseek,
>>   };
>>   
>> -static int __init ima_fs_ns_init(struct ima_namespace *ns)
>> +int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>>   {
>> -	struct dentry *ima_dir;
>> +	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
>> +	struct dentry *int_dir;
>> +	struct dentry *ima_dir = NULL;
>>   	struct dentry *ima_symlink = NULL;
>>   	struct dentry *binary_runtime_measurements = NULL;
>>   	struct dentry *ascii_runtime_measurements = NULL;
>> @@ -459,11 +463,22 @@ static int __init ima_fs_ns_init(struct ima_namespace *ns)
>>   	struct dentry *violations = NULL;
>>   	int ret;
>>   
>> -	ima_dir = securityfs_create_dir("ima", integrity_dir);
>> -	if (IS_ERR(ima_dir))
>> -		return PTR_ERR(ima_dir);
>> +	/* FIXME: update when evm and integrity are namespaced */
>> +	if (user_ns != &init_user_ns) {
>> +		int_dir = securityfs_create_dir("integrity", root);
>> +		if (IS_ERR(int_dir))
>> +			return PTR_ERR(int_dir);
>> +	} else {
>> +		int_dir = integrity_dir;
>> +	}
>>   
>> -	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
>> +	ima_dir = securityfs_create_dir("ima", int_dir);
>> +	if (IS_ERR(ima_dir)) {
>> +		ret = PTR_ERR(ima_dir);
>> +		goto out;
>> +	}
>> +
>> +	ima_symlink = securityfs_create_symlink("ima", root, "integrity/ima",
>>   						NULL);
>>   	if (IS_ERR(ima_symlink)) {
>>   		ret = PTR_ERR(ima_symlink);
>> @@ -505,12 +520,15 @@ static int __init ima_fs_ns_init(struct ima_namespace *ns)
>>   		goto out;
>>   	}
>>   
>> -	ns->ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
>> -						ima_dir, NULL,
>> -						&ima_measure_policy_ops);
>> -	if (IS_ERR(ns->ima_policy)) {
>> -		ret = PTR_ERR(ns->ima_policy);
>> -		goto out;
>> +	if (!ns->ima_policy_removed) {
> 
> It would be nicer to avoid this indent level by just doing
> 
> 	if (ns->ima_policy_removed)
> 		return 0;
> 
> above the securityfs_create_file().
> 
>> +		ns->ima_policy =
>> +		    securityfs_create_file("policy", POLICY_FILE_FLAGS,
>> +					   ima_dir, NULL,
>> +					   &ima_measure_policy_ops);
>> +		if (IS_ERR(ns->ima_policy)) {
>> +			ret = PTR_ERR(ns->ima_policy);
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	return 0;
>> @@ -522,11 +540,13 @@ static int __init ima_fs_ns_init(struct ima_namespace *ns)
>>   	securityfs_remove(binary_runtime_measurements);
>>   	securityfs_remove(ima_symlink);
>>   	securityfs_remove(ima_dir);
>> +	if (user_ns != &init_user_ns)
>> +		securityfs_remove(int_dir);
>>   
>>   	return ret;
>>   }
>>   
>>   int __init ima_fs_init(void)
>>   {
>> -	return ima_fs_ns_init(&init_ima_ns);
>> +	return ima_fs_ns_init(&init_user_ns, NULL);
>>   }
>> -- 
>> 2.34.1
>>
