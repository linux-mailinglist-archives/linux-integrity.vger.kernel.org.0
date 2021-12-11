Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AAC471728
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 23:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhLKWbz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 17:31:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229605AbhLKWbz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 17:31:55 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BBLRga1009829;
        Sat, 11 Dec 2021 22:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vZwRmxJHS2djvC909S2q557bysZtD55kpYOBLkUN0eo=;
 b=Q/NIGh6CH+hqps/7UbCwgUN4m260GNUMjbDFKmFKsLW7z31sz/d/VN+nowfCbHZfc219
 lKoiCEqZpuFAN+0gca4m1DODbDQMgKEpWnkI4OnmchxsMV9axsiufsR0y4gm9mzTR/3G
 oFNrAWmYNOk2IbW5NuRmRQ0/EvvEbw2oERbsG4mh0hL/c2h+EaFDSjCcI6TXTkvXWFD2
 CJQ+JZqiJetKlBXUezSLI1MSdBGPN/OcqoUxWGhVB87qJtsO77sPD4+Td2kA6ZYCYQ6Q
 eMYfjOyTEvDNonuxkUcFbtj9FSlsE/7wFjTQ+Cb/BJSw6uNxOypjPVbq5Dnig88xdoZR iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cw3wxgk2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 22:31:40 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BBMULlF018289;
        Sat, 11 Dec 2021 22:31:40 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cw3wxgk29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 22:31:40 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BBMSo78016166;
        Sat, 11 Dec 2021 22:31:38 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 3cvkm90s17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 22:31:38 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BBMVbhO31523132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 22:31:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74AF9B20A7;
        Sat, 11 Dec 2021 22:31:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3C2CB2066;
        Sat, 11 Dec 2021 22:31:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 11 Dec 2021 22:31:36 +0000 (GMT)
Message-ID: <7a2fdc4a-a55c-06d9-5c28-8cc2651a147e@linux.ibm.com>
Date:   Sat, 11 Dec 2021 17:31:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 12/17] securityfs: Extend securityfs with namespacing
 support
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
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
 <20211210194736.1538863-13-stefanb@linux.ibm.com>
 <20211211105026.pq5stw23gh5na3eq@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211211105026.pq5stw23gh5na3eq@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1UDO_Ua3JJAxSoZBQANTJJTU-FWVqZAh
X-Proofpoint-GUID: Ox20ex9AZAyV79EdBbcFwmbyfqp3uvCK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-11_10,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112110130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/11/21 05:50, Christian Brauner wrote:
> On Fri, Dec 10, 2021 at 02:47:31PM -0500, Stefan Berger wrote:
>> Extend 'securityfs' for support of IMA namespacing so that each
>> IMA (user) namespace can have its own front-end for showing the currently
>> active policy, the measurement list, number of violations and so on.
>>
>> Drop the addition dentry reference and simplify cleanup to work without
>> the additional reference. This enables simple cleanup of dentries upon
>> umount.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> ---
>>   security/inode.c | 14 ++++----------
>>   1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/security/inode.c b/security/inode.c
>> index fee01ff4d831..c77ae8ecc464 100644
>> --- a/security/inode.c
>> +++ b/security/inode.c
>> @@ -54,7 +54,7 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>   
>>   static int securityfs_get_tree(struct fs_context *fc)
>>   {
>> -	return get_tree_single(fc, securityfs_fill_super);
>> +	return get_tree_keyed(fc, securityfs_fill_super, fc->user_ns);
>>   }
>>   
>>   static const struct fs_context_operations securityfs_context_ops = {
>> @@ -72,6 +72,7 @@ static struct file_system_type fs_type = {
>>   	.name =		"securityfs",
>>   	.init_fs_context = securityfs_init_fs_context,
>>   	.kill_sb =	kill_litter_super,
>> +	.fs_flags =	FS_USERNS_MOUNT,
>>   };
>>   
>>   /**
>> @@ -168,7 +169,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
>>   		inode->i_fop = fops;
>>   	}
>>   	d_instantiate(dentry, inode);
>> -	dget(dentry);
>>   	inode_unlock(dir);
>>   	return dentry;
>>   
>> @@ -306,23 +306,17 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
>>   void securityfs_remove(struct dentry *dentry)
>>   {
>>   	struct user_namespace *ns;
>> -	struct inode *dir;
>>   
>>   	if (!dentry || IS_ERR(dentry))
>>   		return;
>>   
>>   	ns = dentry->d_sb->s_user_ns;
>>   
>> -	dir = d_inode(dentry->d_parent);
>> -	inode_lock(dir);
>>   	if (simple_positive(dentry)) {
>> -		if (d_is_dir(dentry))
>> -			simple_rmdir(dir, dentry);
>> -		else
>> -			simple_unlink(dir, dentry);
>> +		d_delete(dentry);
>>   		dput(dentry);
> In
> https://lore.kernel.org/lkml/20211210114934.tacjnwryihrsx6ln@wittgenstein
> I explained why d_delete()+d_put() only is wrong and how to fix it.


Fixed for v7.

