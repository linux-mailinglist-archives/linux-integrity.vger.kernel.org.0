Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8271247309B
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 16:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhLMPeB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 10:34:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233023AbhLMPeA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 10:34:00 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEvNcS029197;
        Mon, 13 Dec 2021 15:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0zDUWLPBwDLBj6aIBnL51sF8GxXB2ucIr7960Ok5qfg=;
 b=Bn83DlHtPFMQTcVer+4TsKcj5Z2lMbIqHF+v5wMlLZ87/ROmYanV4GG0+rKclMcqtIxK
 d7qWkb5Ry+pUeSPa8jRrosT6ZAUj+LY3+gTZkgAsEFSoEEo88UpqjcoGicdK7ZvUntLD
 pvnjtX6x8S9AKrgRMVaTQpFJIVy5xaXDMWDp4FzAUyr3OjWiC8FF4Qknm158FKl/J11B
 UCD3WC27E4/LJPkd3Uj/pWoAay5iU88Mc8aAbf348OUJMp/GosRI0/gEEWRXBKkAzosM
 rg8h4MZqrA0gWaQvwr5WuK19Cai/CANEe786AWij+YDsw9AxazPNtMoioyHUY8VKU0Lv YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cx8d40wx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 15:33:45 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BDEvrZ2030121;
        Mon, 13 Dec 2021 15:33:44 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cx8d40wwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 15:33:44 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BDFSNRC010206;
        Mon, 13 Dec 2021 15:33:43 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 3cvkma8fkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 15:33:43 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BDFXfUO34472326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 15:33:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0CC228073;
        Mon, 13 Dec 2021 15:33:40 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD81128067;
        Mon, 13 Dec 2021 15:33:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 13 Dec 2021 15:33:40 +0000 (GMT)
Message-ID: <85b75c98-6452-9706-7549-10b416350b7d@linux.ibm.com>
Date:   Mon, 13 Dec 2021 10:33:40 -0500
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211211095026.i2gvqjy4df3sxq42@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mQ2U5vkmJ59M0Ys8IZdhcgJxd8tivsyz
X-Proofpoint-ORIG-GUID: uTAxU_4kKPYhs-wbXyfjCeLR2r0t9qbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_06,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112130097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/11/21 04:50, Christian Brauner wrote:
> On Fri, Dec 10, 2021 at 08:57:11AM -0500, Stefan Berger wrote:
>>
>>
>> there anything that would prevent us from setns()'ing to that target user
>> namespace so that we would now see that of a user namespace that we are not
>> allowed to see?
> If you're really worried about someone being able to access a securityfs
> instance whose userns doesn't match the userns the securityfs instance
> was mounted in there are multiple ways to fix it. The one that I tend to
> prefer is:
>
>  From e0ff6a8dcc573763568e685dd70d1547efd68df9 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Fri, 10 Dec 2021 11:47:37 +0100
> Subject: !!!! HERE BE DRAGONS - COMPLETELY UNTESTED !!!!
>
> securityfs: only allow access to securityfs from within same namespace
>
> Limit opening of securityfs files to callers located in the same namespace.
>
> ---
>   security/inode.c | 33 +++++++++++++++++++++++++++++++--
>   1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/security/inode.c b/security/inode.c
> index eaccba7017d9..9eaf757c08cb 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -80,6 +80,35 @@ static struct file_system_type fs_type = {
>   	.fs_flags =	FS_USERNS_MOUNT,
>   };
>   
> +static int securityfs_permission(struct user_namespace *mnt_userns,
> +				 struct inode *inode, int mask)
> +{
> +	int err;
> +
> +	err = generic_permission(&init_user_ns, inode, mask);
> +	if (!err) {
> +		if (inode->i_sb->s_user_ns != current_user_ns())
> +			err = -EACCES;
> +	}
> +
> +	return err;
> +}
> +
> +const struct inode_operations securityfs_dir_inode_operations = {
> +	.permission	= securityfs_permission,
> +	.lookup		= simple_lookup,
> +};
> +
> +const struct file_operations securityfs_dir_operations = {
> +	.permission	= securityfs_permission,


This interface function on file operations doesn't exist.

I'll use the inode_operations and also hook it to the root dentry of the 
super_block. Then there's no need to have this check on symlinks and 
files...



> +	.open		= dcache_dir_open,
> +	.release	= dcache_dir_close,
> +	.llseek		= dcache_dir_lseek,
> +	.read		= generic_read_dir,
> +	.iterate_shared	= dcache_readdir,
> +	.fsync		= noop_fsync,
> +};
> +
>   /**
>    * securityfs_create_dentry - create a dentry in the securityfs filesystem
>    *
> @@ -167,8 +196,8 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
>   	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
>   	inode->i_private = data;
>   	if (S_ISDIR(mode)) {
> -		inode->i_op = &simple_dir_inode_operations;
> -		inode->i_fop = &simple_dir_operations;
> +		inode->i_op = &securityfs_dir_inode_operations;
> +		inode->i_fop = &securityfs_dir_operations;
>   		inc_nlink(inode);
>   		inc_nlink(dir);
>   	} else if (S_ISLNK(mode)) {
