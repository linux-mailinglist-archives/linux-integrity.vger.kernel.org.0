Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E21A46D72C
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 16:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhLHPnx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 10:43:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236171AbhLHPnw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 10:43:52 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8DmBao009451;
        Wed, 8 Dec 2021 15:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dJ6eL9KASyFEqw31fYfpvx/cQeM+e2BlPQVjL8Obfeg=;
 b=EKRlFlK3wnz+TeTJcECzPpPjgOjS3mIbr4362KNxcdZspSz4JoySk6lHe1IUD406pUD2
 i4NDRmbr64xKhWAPxz/1mNIg8GYdRFZOn0/D0AC9uRiWhndphNWipUGXu5Go+B7EIGhT
 6BSFp13yS2gc+VrdlXVsDG/YearsrtujEytMKtwcXF9IiUcDzpZOSBN5UM9Q5qz9WN1R
 3SN1+C3eG7DPsXI67f4rhOWFuulxha+Kq2lJ5tmPRnByoMsCU557oj4Bz75nYfyCRrWp
 CXZgTBQ8/Sv5t25qFFzCA0rSEEbrR+5gJWKiuHt4A95BZNUCZedYmqmpLpkd5h2dXJyA 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ctwwkjguu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 15:39:52 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8FBT85028964;
        Wed, 8 Dec 2021 15:39:52 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ctwwkjgug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 15:39:52 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8FbtNh025374;
        Wed, 8 Dec 2021 15:39:51 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3cqyybq7hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 15:39:50 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8Fdnux29032880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 15:39:49 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48081AE063;
        Wed,  8 Dec 2021 15:39:49 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E991AAE067;
        Wed,  8 Dec 2021 15:39:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 15:39:48 +0000 (GMT)
Message-ID: <711ce320-25c7-5ace-a026-89a55dc7c068@linux.ibm.com>
Date:   Wed, 8 Dec 2021 10:39:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 16/16] ima: Setup securityfs for IMA namespace
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
 <20211207202127.1508689-17-stefanb@linux.ibm.com>
 <20211208125814.hdaghdq7yk5wvvor@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211208125814.hdaghdq7yk5wvvor@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xjtk-5yKnmliebIMvj7Pi2nMksAd8LLc
X-Proofpoint-GUID: bAdUwrA1Aibyo-gZpeQvdbg1ElXMAXo1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_06,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080095
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/8/21 07:58, Christian Brauner wrote:
> On Tue, Dec 07, 2021 at 03:21:27PM -0500, Stefan Berger wrote:
>>   
>>   #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
>> diff --git a/security/inode.c b/security/inode.c
>> index 121ac1874dde..10ee20917f42 100644
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
>> @@ -41,6 +42,7 @@ static const struct super_operations securityfs_super_operations = {
>>   static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>   {
>>   	static const struct tree_descr files[] = {{""}};
>> +	struct user_namespace *ns = fc->user_ns;
>>   	int error;
>>   
>>   	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
>> @@ -49,7 +51,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>   
>>   	sb->s_op = &securityfs_super_operations;
>>   
>> -	return 0;
>> +	if (ns != &init_user_ns)
>> +		error = ima_fs_ns_init(ns, sb->s_root);
>> +
>> +	return error;
>>   }
>>   
>>   static int securityfs_get_tree(struct fs_context *fc)
>> @@ -69,6 +74,11 @@ static int securityfs_init_fs_context(struct fs_context *fc)
>>   
>>   static void securityfs_kill_super(struct super_block *sb)
>>   {
>> +	struct user_namespace *ns = sb->s_fs_info;
>> +
>> +	if (ns != &init_user_ns)
>> +		ima_fs_ns_free_dentries(ns);
> Say securityfs is unmounted. Then all the inodes and dentries become
> invalid. It's not allowed to hold on to any dentries or inodes after the
> super_block is shut down. So I just want to be sure that nothing in ima
> can access these dentries after securityfs is unmounted.

> To put it another way: why are they stored in struct ima_namespace in
> the first place? If you don't pin a filesystem when creating files or
> directories like you do for securityfs in init_ima_ns then you don't
> need to hold on to them as they will be automatically be wiped during
> umount.


The reason was so that securityfs for init_ima_ns and IMA namespaces 
could share the code assigning to dentries to keep around and can clean 
up if an error occurs while creating a dentry.

What about this: We keep the dentries in the ima_namespace, modify the 
code creating the dentries in securityfs_create_dentry() to only take 
the additional reference in case of init_user_ns (I suppose this is what 
you suggest) and then keep 'static void ima_fs_ns_free_dentries()' only 
for removing the dentries for the error case and never call it from 
securityfs_kill_super()? Would that be acceptable?


