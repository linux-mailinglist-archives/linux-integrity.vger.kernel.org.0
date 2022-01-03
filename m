Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AFE4831B2
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jan 2022 15:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiACOKK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jan 2022 09:10:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232091AbiACOKK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jan 2022 09:10:10 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203DDart028657;
        Mon, 3 Jan 2022 14:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=v2ghILQ+1jhsJwkVkfQ4PDvXvqOTFTxfb49TgDMC0dg=;
 b=TVs7eLyhQ5pfpRACGjD2c0PDMReATd9YCt6ukUuudUKmv77UH65en0sx1yzLuEzThJ9P
 I6Lhkt3QccJfVhJK+7yVxJ6eQKzMtiaUq5AXSA4sYkwQDjbdLiHvuuJNzLrwp2XFjWEf
 ARgJntRz9jzI6ssBXv1wDQE+vnR80e1HCNAPmZiXPhIMyRG11EWPcNkp/IGM5lofg3lK
 80T9xIPWYsfM2EIdfdxpOH7tFgo2EtqVtDy1uDZETfUgettaYqxz2EnYuPvF195ng2v6
 CdPE0CdD0sj8jD9OTtbqcVHkwg7Es0xB99fZZEkqf9WMapLefLdVBGDE579bZMCtvfz1 HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dc1uf0vcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 14:09:44 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 203Dptg6011938;
        Mon, 3 Jan 2022 14:09:43 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dc1uf0vcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 14:09:43 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 203E8G6X003424;
        Mon, 3 Jan 2022 14:09:42 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3daekahcch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 14:09:42 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 203E9fdE36438500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jan 2022 14:09:41 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04E9E13605E;
        Mon,  3 Jan 2022 14:09:41 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88F83136059;
        Mon,  3 Jan 2022 14:09:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jan 2022 14:09:38 +0000 (GMT)
Message-ID: <0626de21-d22f-329c-fc64-ecd7eab1331a@linux.ibm.com>
Date:   Mon, 3 Jan 2022 09:09:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v7 10/14] securityfs: Extend securityfs with namespacing
 support
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
 <20211216054323.1707384-11-stefanb@linux.vnet.ibm.com>
 <20211216134027.33sprdmhol2tbctf@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211216134027.33sprdmhol2tbctf@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jsA1Gn0Zs6K0t0IbxU9x7rtF5PCW93Ws
X-Proofpoint-ORIG-GUID: uXiAfUfvBh1c5O8bgcGxgWWeD9yraZ7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-03_05,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201030096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/16/21 08:40, Christian Brauner wrote:
> On Thu, Dec 16, 2021 at 12:43:19AM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Extend 'securityfs' for support of IMA namespacing so that each
>> IMA (user) namespace can have its own front-end for showing the currently
>> active policy, the measurement list, number of violations and so on.
>>
>> Drop the addition dentry reference to enable simple cleanup of dentries
>> upon umount.
>>
>> Prevent mounting of an instance of securityfs in another user namespace
>> than it belongs to. Also, prevent accesses to directories when another
>> user namespace is active than the one that the instance of securityfs
>> belongs to.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> ---
>>   security/inode.c | 37 ++++++++++++++++++++++++++++++++++---
>>   1 file changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/inode.c b/security/inode.c
>> index fee01ff4d831..a0d9f086e3d5 100644
>> --- a/security/inode.c
>> +++ b/security/inode.c
>> @@ -26,6 +26,29 @@
>>   static struct vfsmount *init_securityfs_mount;
>>   static int init_securityfs_mount_count;
>>   
>> +static int securityfs_permission(struct user_namespace *mnt_userns,
>> +				 struct inode *inode, int mask)
>> +{
>> +	int err;
>> +
>> +	err = generic_permission(&init_user_ns, inode, mask);
>> +	if (!err) {
>> +		if (inode->i_sb->s_user_ns != current_user_ns())
>> +			err = -EACCES;
> I really think the correct semantics is to grant all callers access
> whose user namespace is the same as or an ancestor of the securityfs
> userns. It's weird to deny access to callers who are located in an
> ancestor userns.

Ok, will be using current_in_userns() or the more explicit in_userns() 
for the check.


>
> For example, a privileged process on the host should be allowed to setns
> to the userns of an unprivileged container and inspect its securityfs
> instance.
>
> We're mostly interested to block such as scenarios where two sibling
> unprivileged containers are created in the initial userns and an fd
> proxy or something funnels a file descriptor from one sibling container
> to the another one and the receiving sibling container can use readdir()
> or openat() on this fd. (I'm not even convinced that this is actually a
> problem but stricter semantics at the beginning can't hurt. We can
> always relax this later.)
