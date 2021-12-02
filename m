Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEE94664BF
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 14:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358354AbhLBN4X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 08:56:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346917AbhLBN4V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 08:56:21 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2DPJSZ017947;
        Thu, 2 Dec 2021 13:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=odNM1SuCcKK6sCNzJJneZ0ovpnjIH9BAQkTZy7joDRY=;
 b=Rk3+Vm4+s5x/MNVGxwQE8KApdLXYxFCuHBZol2PWdD165qiVIj3WywpTpbyViQSOvpkN
 5r3i05WIkRsAZ0X0jyqo29Kx53PEz0Xbryr/UcnSFTrWive7pkIoFHnhg3StGaaWMd2w
 998lAT78sVJY6byxDbSEov1212C7Ug5ljXFCfx/9twJfeIi7zeW6qhjW0Kqls9Esm0/x
 Uj5tnAPrmxTjlvREPams+7juXb2bPERSllm1ZQSwGx6HE5iLI/AGfwcmtS5mDdS21OPS
 LbcDpN0hb1llEOkIDZ3kVyGcHv1VUWNsqVuARYiT0HojaakfP72Cti6HVsHKAfL7bZvy jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpxhy99c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 13:52:46 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2DQQiN020701;
        Thu, 2 Dec 2021 13:52:45 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpxhy99bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 13:52:45 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2Dj8Z4011454;
        Thu, 2 Dec 2021 13:52:44 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 3ckcacp4wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 13:52:43 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2DqfE139780624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 13:52:41 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48E72136061;
        Thu,  2 Dec 2021 13:52:41 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10170136059;
        Thu,  2 Dec 2021 13:52:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 13:52:37 +0000 (GMT)
Message-ID: <9b95d629-3d17-dbdc-05f1-205e50ec9e95@linux.ibm.com>
Date:   Thu, 2 Dec 2021 08:52:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 20/20] ima: Setup securityfs_ns for IMA namespace
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
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-21-stefanb@linux.ibm.com>
 <20211202131818.ygzsywwfu4rfcbuy@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211202131818.ygzsywwfu4rfcbuy@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yG9PQRou744qZr4gUqx54ql_n5sAv8Za
X-Proofpoint-GUID: o2a_UNAkqbdnTh3bp-Q3BF3VlzQtdpct
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-12-02_07,2021-12-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/2/21 08:18, Christian Brauner wrote:
> On Tue, Nov 30, 2021 at 11:06:54AM -0500, Stefan Berger wrote:
>> Setup securityfs_ns with symlinks, directories, and files for IMA
>> namespacing support. The same directory structure that IMA uses on the
>> host is also created for the namespacing case.
>>
>> Increment the user namespace's refcount_teardown value by '1' once
>> securityfs_ns has been successfully setup since the initialization of the
>> filesystem causes an additional reference to the user namespace to be
>> taken. The early teardown function will delete the file system and release
>> the additional reference.
>>
>> The securityfs_ns file and directory ownerships cannot be set when the
>> filesystem is setup since at this point the user namespace has not been
>> configured yet by the user and therefore the ownership mappings are not
>> available, yet. Therefore, adjust the file and directory ownerships when
>> an inode's function for determining the permissions of a file or directory
>> is accessed.
>>
>> This filesystem can now be mounted as follows:
>>
>> mount -t securityfs_ns /sys/kernel/security/ /sys/kernel/security/
>>
>> The following directories, symlinks, and files are then available.
>>
>> $ ls -l sys/kernel/security/
>> total 0
>> lr--r--r--. 1 nobody nobody 0 Nov 27 06:44 ima -> integrity/ima
>> drwxr-xr-x. 3 nobody nobody 0 Nov 27 06:44 integrity
>>
>> $ ls -l sys/kernel/security/ima/
>> total 0
>> -r--r-----. 1 root root 0 Nov 27 06:44 ascii_runtime_measurements
>> -r--r-----. 1 root root 0 Nov 27 06:44 binary_runtime_measurements
>> -rw-------. 1 root root 0 Nov 27 06:44 policy
>> -r--r-----. 1 root root 0 Nov 27 06:44 runtime_measurements_count
>> -r--r-----. 1 root root 0 Nov 27 06:44 violations
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   include/linux/ima.h                      |  17 +++
>>   security/integrity/ima/ima.h             |   2 +
>>   security/integrity/ima/ima_fs.c          | 178 ++++++++++++++++++++++-
>>   security/integrity/ima/ima_init_ima_ns.c |   6 +-
>>   security/integrity/ima/ima_ns.c          |   4 +-
>>   5 files changed, 203 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index fe08919df326..a2c5e516f706 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -221,6 +221,18 @@ struct ima_h_table {
>>   	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
>>   };
>>   
>> +enum {
>> +	IMAFS_DENTRY_INTEGRITY_DIR = 0,
>> +	IMAFS_DENTRY_DIR,
>> +	IMAFS_DENTRY_SYMLINK,
>> +	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
>> +	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
>> +	IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT,
>> +	IMAFS_DENTRY_VIOLATIONS,
>> +	IMAFS_DENTRY_IMA_POLICY,
>> +	IMAFS_DENTRY_LAST
>> +};
>> +
>>   struct ima_namespace {
>>   	struct kref kref;
>>   	struct user_namespace *user_ns;
>> @@ -267,6 +279,11 @@ struct ima_namespace {
>>   	struct mutex ima_write_mutex;
>>   	unsigned long ima_fs_flags;
>>   	int valid_policy;
>> +
>> +	struct dentry *dentry[IMAFS_DENTRY_LAST];
>> +	struct vfsmount *mount;
>> +	int mount_count;
>> +	bool file_ownership_fixes_done;
>>   };
>>   
>>   extern struct ima_namespace init_ima_ns;
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index bb9763cd5fb1..9bcd71bb716c 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -139,6 +139,8 @@ struct ns_status {
>>   /* Internal IMA function definitions */
>>   int ima_init(void);
>>   int ima_fs_init(void);
>> +int ima_fs_ns_init(struct ima_namespace *ns);
>> +void ima_fs_ns_free(struct ima_namespace *ns);
>>   int ima_add_template_entry(struct ima_namespace *ns,
>>   			   struct ima_template_entry *entry, int violation,
>>   			   const char *op, struct inode *inode,
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index 6766bb8262f2..9a14be520268 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/parser.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/ima.h>
>> +#include <linux/namei.h>
>>   
>>   #include "ima.h"
>>   
>> @@ -436,8 +437,13 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>>   
>>   	ima_update_policy(ns);
>>   #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
>> -	securityfs_remove(ima_policy);
>> -	ima_policy = NULL;
>> +	if (ns == &init_ima_ns) {
>> +		securityfs_remove(ima_policy);
>> +		ima_policy = NULL;
>> +	} else {
>> +		securityfs_ns_remove(ns->dentry[IMAFS_DENTRY_POLICY]);
>> +		ns->dentry[IMAFS_DENTRY_POLICY] = NULL;
>> +	}
>>   #elif defined(CONFIG_IMA_WRITE_POLICY)
>>   	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
>>   #elif defined(CONFIG_IMA_READ_POLICY)
>> @@ -509,3 +515,171 @@ int __init ima_fs_init(void)
>>   	securityfs_remove(ima_policy);
>>   	return -1;
>>   }
>> +
>> +/*
>> + * Fix the ownership (uid/gid) of the dentry's that couldn't be set at the
>> + * time of their creation because the user namespace wasn't configured, yet.
>> + */
>> +static void ima_fs_ns_fixup_uid_gid(struct ima_namespace *ns)
>> +{
>> +	struct inode *inode;
>> +	size_t i;
>> +
>> +	if (ns->file_ownership_fixes_done ||
>> +	    ns->user_ns->uid_map.nr_extents == 0)
>> +		return;
>> +
>> +	ns->file_ownership_fixes_done = true;
>> +	for (i = 0; i < IMAFS_DENTRY_LAST; i++) {
>> +		if (!ns->dentry[i])
>> +			continue;
>> +		inode = ns->dentry[i]->d_inode;
>> +		inode->i_uid = make_kuid(ns->user_ns, 0);
>> +		inode->i_gid = make_kgid(ns->user_ns, 0);
>> +	}
>> +}
>> +
>> +/* Fix the permissions when a file is opened */
>> +int ima_fs_ns_permission(struct user_namespace *mnt_userns, struct inode *inode,
>> +			 int mask)
>> +{
>> +	ima_fs_ns_fixup_uid_gid(get_current_ns());
> As noted later in the thread if this is required it means something is
> buggy in the current code. That shouldn't be needed.
I fixed this yesterday with late initialization: 
https://lkml.org/lkml/2021/12/1/1181
>
> I think there's a more fundamental issue here. The correct way to do all
> this would be to restructure securityfs at least how it works inside of
> user namespaces. Currently, securityfs works like debugfs: a single
> shared superblock that is pinned by each new inode that is created via:
>
> 	simple_pin_fs(&fs_type, &mount, &mount_count);
> 	simple_release_fs(&mount, &mount_count);
>
> and each mount surfaces the same superblock. Ideally making securityfs
> mountable inside of user namespaces should get you a new superblock.
> Functions that create files for the ima ns would then be called inside
> ->fill_super etc.

So this would be the wrong place to do it? I moved it there because this 
is called late (upon mounting) when the configuration of the user 
namespace has completed.

static int securityfs_ns_init_fs_context(struct fs_context *fc)
{
          int rc;

          if (fc->user_ns->ima_ns->late_fs_init) {
                  rc = fc->user_ns->ima_ns->late_fs_init(fc->user_ns);
                  if (rc)
                          return rc;
          }
          fc->ops = &securityfs_ns_context_ops;
          return 0;
}


Stefan



