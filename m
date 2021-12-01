Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288784654E1
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhLASRU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 13:17:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352186AbhLASPE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 13:15:04 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1GINI7009875;
        Wed, 1 Dec 2021 18:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sUo8WZ8ln6Z2WyqkaAi0ICSQDU0CQWS0/QaltxNDTcE=;
 b=JE00RCd14wbXlNGhNpAF8e90ZVvPQGV51GyVFuZeOikzvQVEVwgpmyy1ohuAQWgDGEia
 +9zemunP68uClJFSLm8ZLTie2rlXY/FUfAk56PNlQXLcyCX3IiCMplhwIJCCee9D4e/e
 PUou5C3FKayMt9XO/93IsBOPMlwuhYU0vLQysGOTa7YeZZVO6hjM0hfOriNjNh6LWDWc
 t49dulRO7pimrzSkivIs7DQnW/nrbMQNoKQ1hJUl07+7uW6U1sEREVsAP9c3Nc8HIL+6
 sxaLAFPTDPtEOcXAvdhDXKzh2h5zW5pY4j4ABOltOvWMg4R2KKFw8mPDO997LKTCl+Eh jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpcf2jf6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 18:11:22 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1HTNtB000697;
        Wed, 1 Dec 2021 18:11:21 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpcf2jf67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 18:11:21 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1I7fNo024082;
        Wed, 1 Dec 2021 18:11:20 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3ckcabtfhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 18:11:20 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1IBIb028181170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 18:11:18 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C15FC6065;
        Wed,  1 Dec 2021 18:11:18 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 154C3C6062;
        Wed,  1 Dec 2021 18:11:15 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 18:11:15 +0000 (GMT)
Message-ID: <f2113d60-49d3-2e2d-7dbe-b831035f96a1@linux.ibm.com>
Date:   Wed, 1 Dec 2021 13:11:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 20/20] ima: Setup securityfs_ns for IMA namespace
Content-Language: en-US
To:     jejb@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-21-stefanb@linux.ibm.com>
 <6599ac61289e3316bff53602a0bc5970133251aa.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <6599ac61289e3316bff53602a0bc5970133251aa.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UHQxxmy77f3hdc0I9ZV4JnVZkU8lfUbG
X-Proofpoint-GUID: l47Hah_wjPmOSf99Mug13tL3_P8dIJdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxscore=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010098
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/1/21 12:56, James Bottomley wrote:
> On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
> [...]
>> +
>> +/*
>> + * Fix the ownership (uid/gid) of the dentry's that couldn't be set
>> at the
>> + * time of their creation because the user namespace wasn't
>> configured, yet.
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
>> +int ima_fs_ns_permission(struct user_namespace *mnt_userns, struct
>> inode *inode,
>> +			 int mask)
>> +{
>> +	ima_fs_ns_fixup_uid_gid(get_current_ns());
>> +	return generic_permission(mnt_userns, inode, mask);
>> +}
>> +
>> +const struct inode_operations ima_fs_ns_inode_operations = {
>> +	.lookup		= simple_lookup,
>> +	.permission	= ima_fs_ns_permission,
>> +};
>> +
> In theory this uid/gid shifting should have already been done for you
> and all of the above code should be unnecessary.  What is supposed to
> happen is that the mount of securityfs_ns in the new user namespace
> should pick up a superblock s_user_ns for that new user namespace.  Now
> inode_alloc() uses i_uid_write(inode, 0) which maps back through the
> s_user_ns to obtain the owner of the user namespace.
>
> What can happen is that if you do the inode allocation before (or even
> without) writing to the uid_map file, it maps back through an empty map
> and ends up with -1 for i_uid ... is this what you're seeing?

I tried this with runc and a user namespace active mapping uid 1000 on 
the host to uid 0 in the container. There I run into the problem that 
all of the files and directories without the above work-around are 
mapped to 'nobody', just like all the files in sysfs in this case are 
also mapped to nobody. This code resolved the issue.


sh-5.1# ls -l /sys/
total 0
drwxr-xr-x.   2 nobody nobody  0 Dec  1 18:06 block
drwxr-xr-x.  28 nobody nobody  0 Dec  1 18:06 bus
drwxr-xr-x.  54 nobody nobody  0 Dec  1 18:06 class
drwxr-xr-x.   4 nobody nobody  0 Dec  1 18:06 dev
drwxr-xr-x.  15 nobody nobody  0 Dec  1 18:06 devices
drwxrwxrwt.   2 root   root   40 Dec  1 18:06 firmware
drwxr-xr-x.   9 nobody nobody  0 Dec  1 18:06 fs
drwxr-xr-x.  16 nobody nobody  0 Dec  1 18:06 kernel
drwxr-xr-x. 161 nobody nobody  0 Dec  1 18:06 module
drwxr-xr-x.   3 nobody nobody  0 Dec  1 18:06 power

sh-5.1# ls -l /sys/kernel/security/
total 0
lr--r--r--. 1 nobody nobody 0 Dec  1 18:06 ima -> integrity/ima
drwxr-xr-x. 3 nobody nobody 0 Dec  1 18:06 integrity

sh-5.1# ls -l /sys/kernel/security/ima/
total 0
-r--r-----. 1 root root 0 Dec  1 18:06 ascii_runtime_measurements
-r--r-----. 1 root root 0 Dec  1 18:06 binary_runtime_measurements
-rw-------. 1 root root 0 Dec  1 18:06 policy
-r--r-----. 1 root root 0 Dec  1 18:06 runtime_measurements_count
-r--r-----. 1 root root 0 Dec  1 18:06 violations

The nobody's are obviously sufficient to cd into the directories, but 
for file accesses I wanted to see root and no changes to permissions.

     Stefan

>
> James
>
>
