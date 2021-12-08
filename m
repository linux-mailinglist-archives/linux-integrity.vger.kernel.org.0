Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7117546D50F
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 15:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhLHOKK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 09:10:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232756AbhLHOKJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 09:10:09 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8Dmk7A027559;
        Wed, 8 Dec 2021 14:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Qs5SCH0g0aSWPuFle2NWMEmcVjuSkMxkydzBopZ1A+M=;
 b=hQUcQB0SjZoz+nB3cmXynmJT0ezQmE+9VcCo498Dd8SHVu87qofkPEY14FFZb2eOOld6
 GJFzinXuviKwfSi2CxL2amS78raUVcAzZdnFAAHAsNqitW0VJhxdBPpab78DRLUI1mf1
 MyrPCUDMW+tas/X8ed7NPAsdBVw0MRR4MeBdXrvPE54bZx6njQN9BeIkLsIF7vPxHdx6
 U35Cwwk2b3tfosB+cZl6ymYDkceZ3JAs/dn0cBRSdle4OVJ6WJjPS4CmaBgHa2EPOkeE
 3jFeB93G/5tyDH3nMmL5Lv/coFAqCjLSgOAVeWKsGxbktdkVwNkkFW7aEUVynh5TmZ9Q 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ctwwnrcs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:06:13 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8DoUxm003671;
        Wed, 8 Dec 2021 14:06:13 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ctwwnrcrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:06:12 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8E4PSO014767;
        Wed, 8 Dec 2021 14:06:12 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 3cqyybm9t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:06:11 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8E3nQA14090892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 14:03:49 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7DD678084;
        Wed,  8 Dec 2021 14:03:49 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3CF57808F;
        Wed,  8 Dec 2021 14:03:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 14:03:45 +0000 (GMT)
Message-ID: <e2090899-9d73-2ec8-b82c-add29555d7bb@linux.ibm.com>
Date:   Wed, 8 Dec 2021 09:03:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 11/16] securityfs: Only use
 simple_pin_fs/simple_release_fs for init_user_ns
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
 <20211207202127.1508689-12-stefanb@linux.ibm.com>
 <20211208115850.wu65ghalpbrjnkfe@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211208115850.wu65ghalpbrjnkfe@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pf46rXEpHTrFM18wJ6rK3s5q41Gcrx2F
X-Proofpoint-GUID: p7td8iEGJT2o25pvS9uYx5uf5WCqJvR-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_05,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080089
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/8/21 06:58, Christian Brauner wrote:
> On Tue, Dec 07, 2021 at 03:21:22PM -0500, Stefan Berger wrote:
>> To prepare for virtualization of SecurityFS, use simple_pin_fs and
>> simpe_release_fs only when init_user_ns is active.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> ---
>>   security/inode.c | 30 +++++++++++++++++++++---------
>>   1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/security/inode.c b/security/inode.c
>> index 6c326939750d..1a720b2c566d 100644
>> --- a/security/inode.c
>> +++ b/security/inode.c
>> @@ -21,9 +21,10 @@
>>   #include <linux/security.h>
>>   #include <linux/lsm_hooks.h>
>>   #include <linux/magic.h>
>> +#include <linux/user_namespace.h>
>>   
>> -static struct vfsmount *mount;
>> -static int mount_count;
>> +static struct vfsmount *securityfs_mount;
>> +static int securityfs_mount_count;
>>   
>>   static void securityfs_free_inode(struct inode *inode)
>>   {
>> @@ -109,6 +110,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
>>   					const struct file_operations *fops,
>>   					const struct inode_operations *iops)
>>   {
>> +	struct user_namespace *ns = current_user_ns();
>>   	struct dentry *dentry;
>>   	struct inode *dir, *inode;
>>   	int error;
>> @@ -118,12 +120,17 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
>>   
>>   	pr_debug("securityfs: creating file '%s'\n",name);
>>   
>> -	error = simple_pin_fs(&fs_type, &mount, &mount_count);
>> -	if (error)
>> -		return ERR_PTR(error);
>> +	if (ns == &init_user_ns) {
>> +		error = simple_pin_fs(&fs_type, &securityfs_mount,
>> +				      &securityfs_mount_count);
>> +		if (error)
>> +			return ERR_PTR(error);
>> +	}
>>   
>> -	if (!parent)
>> -		parent = mount->mnt_root;
>> +	if (!parent) {
>> +		if (ns == &init_user_ns)
>> +			parent = securityfs_mount->mnt_root;
> Wouldn't you want an
>
> 		else
> 			return ERR_PTR(-EINVAL);
>
> in here already?


Fixed.

