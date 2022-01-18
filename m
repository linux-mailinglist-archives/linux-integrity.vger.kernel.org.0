Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F957492F0A
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 21:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbiARUNX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 15:13:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4820 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348488AbiARUNS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 15:13:18 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IHRDhv010575;
        Tue, 18 Jan 2022 20:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=APUYDznO3Quaz+Sc0s0sZb+MiLSW6FJB7cBY6Cn3RU8=;
 b=ObkN5+WSWaysDU41ut+nVvODrD7MO2qpmHSCN9bE1sn8UfYMjbUkYF339tZ1YXVI1L7j
 L7v4tSZQCL8uaNLgx4M4WXZp04y0FtPHINkf5thG3x/9PX4oMG1zBHtPXvhzGQ+3Ujdr
 k2lWrcdt/mDP1CoWKaQCsvyhn5czaSA3nYNmFZDJNL/ljbcnIz1yCVwNCPhPQ+5TGqQp
 6QV7lVzPZOEaowdKH7Zhc7Bew0d1iY6IFMqto2UfjJaWfKEVbE90LXGJH/+VKJDZgaIA
 oZKw5Vqwu5dX0HQRKB5/si1G5UnIxAoVQsFRbfdmmU53Jp1v+0qM0BLk2R+1EEhOztXm Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dp1yavjt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 20:13:05 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20IJZuSU004306;
        Tue, 18 Jan 2022 20:13:05 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dp1yavjsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 20:13:05 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20IK1xJP012541;
        Tue, 18 Jan 2022 20:13:04 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 3dknwasc5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 20:13:04 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20IKD3U815466788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 20:13:03 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6372BE05A;
        Tue, 18 Jan 2022 20:13:02 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C635BE059;
        Tue, 18 Jan 2022 20:13:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jan 2022 20:13:00 +0000 (GMT)
Message-ID: <d53a66a2-17e2-54b3-f115-efd7c58080a7@linux.ibm.com>
Date:   Tue, 18 Jan 2022 15:12:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 07/19] ima: Move dentry into ima_namespace and others
 onto stack
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-8-stefanb@linux.vnet.ibm.com>
 <a7c5ac94b4c4d87b407353f74ff87bc0b13542a4.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <a7c5ac94b4c4d87b407353f74ff87bc0b13542a4.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3HaX4pOfEpqkwQI_nTwVgEtt-lcLRJrf
X-Proofpoint-GUID: HTpAqsbImGmRNkb9a8LkaDtqEYrZAuWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_05,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/13/22 15:28, Mimi Zohar wrote:
> Hi Stefan,
>
> Nobody refers to the IMA securityfs files as dentries.  The Subject
> line is suppose to provide a hint about the patch.  How about changing
> the "Subject" line to "ima: Move IMA securityfs files into
> ima_namespaces or onto stack".
>
> On Tue, 2022-01-04 at 12:04 -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Move the policy file dentry into the ima_namespace for reuse by
>> virtualized SecurityFS and for being able to remove it from
>> the filesystem. Move the other dentries onto the stack.
> Missing is an explanation why the other IMA securityfs files can be on
> the stack.  Maybe start out by saying that the ns_ima_init securityfs
> files are never deleted.  Then transition into the IMA namespaced
> securityfs files and how they will be deleted.

How about this:

ima: Move IMA securityfs files into ima_namespace or onto stack

Move the IMA policy file's dentry into the ima_namespace for reuse by
virtualized securityfs and for being able to remove the file from the
filesystem using securityfs_remove().

Move the other files' dentries onto the stack since they are not needed
outside the function where they are created in. Also, their cleanup is
automatically handled by the filesystem upon umount of a virtualized
secruityfs instance, so they don't need to be explicitly freed anymore.

When moving the dentry 'ima_policy' into ima_namespace rename it to
'policy_dentry' to clarify its datatype and avoid a name clash with
'int ima_policy' from ima_policy.c.

    Stefan



>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   security/integrity/ima/ima.h    |  2 ++
>>   security/integrity/ima/ima_fs.c | 32 ++++++++++++++++++--------------
>>   2 files changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 82b3f6a98320..224b09617c52 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -140,6 +140,8 @@ struct ima_namespace {
>>   	struct mutex ima_write_mutex;
>>   	unsigned long ima_fs_flags;
>>   	int valid_policy;
>> +
>> +	struct dentry *policy_dentry;
> None of the other securityfs files are renamed.  Why is "ima_policy"
> being renamed to "policy_dentry"?  If there is a need, it should be
> documented in the patch description.
>
> thanks,
>
> Mimi
>
>>   } __randomize_layout;
>>   extern struct ima_namespace init_ima_ns;
>>
