Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C355256A586
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiGGOe4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiGGOet (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:34:49 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441C33192C;
        Thu,  7 Jul 2022 07:34:44 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EMp7g024940;
        Thu, 7 Jul 2022 14:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=b6yhrdKbF0YKjPkBVtBY5kmJWk0TjiHRvpteUX/lDog=;
 b=PMzU2fckBEfHHfCp0zJoALW5rLTJLtUoHvudatexeBUR0P9yE9QE42BMukF/dVDUtiRl
 higkx8TGCSr03l43wNV3vDfJlWEDXOHoEMDhWF7+Rp94S6/Kr6dwNmkIXOi8lwpcGRz+
 vAC985JBR8Gdw/m9MqanjY0vh3FjMnlK5vu0KbVGAXnO7br7zm7ADcYUovIwvzjwXdIM
 ol30UoafrC/+fJcQA8+yGWiK/Y5JS3Zi2qUpIW0ge7jTT8x5HgyjXNMBJ+QIA9T/PVYB
 0gk0AvMn4SAcmCy3uKIPvGXa/mRkTgskFe1t8iBL26lxNVRuKO+Ityx7KuIyqK7hlfdq uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h60qp1m90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:34:14 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267EMwGr025696;
        Thu, 7 Jul 2022 14:34:13 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h60qp1m8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:34:13 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267EOeXb023503;
        Thu, 7 Jul 2022 14:34:12 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3h4uqy6peg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:34:12 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267EYBXb34668804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:34:11 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55A66BE05D;
        Thu,  7 Jul 2022 14:34:11 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E392CBE051;
        Thu,  7 Jul 2022 14:34:09 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:34:09 +0000 (GMT)
Message-ID: <3e4cd438-4596-1c0c-ac7e-9599d2325683@linux.ibm.com>
Date:   Thu, 7 Jul 2022 10:34:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v12 02/26] securityfs: Extend securityfs with namespacing
 support
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
        jpenumak@redhat.com, Christian Brauner <brauner@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-3-stefanb@linux.ibm.com>
 <20220521022302.GA8575@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220521022302.GA8575@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aRgPd1njpyoQFbwztZCX7-KjHUBD09kX
X-Proofpoint-GUID: F_TjmUJIHRxjc33CqbbpfNQrapvur6FU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_11,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/20/22 22:23, Serge E. Hallyn wrote:
> On Wed, Apr 20, 2022 at 10:06:09AM -0400, Stefan Berger wrote:
>> Enable multiple instances of securityfs by keying each instance with a
>> pointer to the user namespace it belongs to.
>>
>> Since we do not need the pinning of the filesystem for the virtualization
>> case, limit the usage of simple_pin_fs() and simpe_release_fs() to the
>> case when the init_user_ns is active. This simplifies the cleanup for the
>> virtualization case where usage of securityfs_remove() to free dentries
>> is therefore not needed anymore.
>>
>> For the initial securityfs, i.e. the one mounted in the host userns mount,
>> nothing changes. The rules for securityfs_remove() are as before and it is
>> still paired with securityfs_create(). Specifically, a file created via
>> securityfs_create_dentry() in the initial securityfs mount still needs to
>> be removed by a call to securityfs_remove(). Creating a new dentry in the
>> initial securityfs mount still pins the filesystem like it always did.
>> Consequently, the initial securityfs mount is not destroyed on
>> umount/shutdown as long as at least one user of it still has dentries that
>> it hasn't removed with a call to securityfs_remove().
>>
>> Prevent mounting of an instance of securityfs in another user namespace
>> than it belongs to. Also, prevent accesses to files and directories by
>> a user namespace that is neither the user namespace it belongs to
>> nor an ancestor of the user namespace that the instance of securityfs
>> belongs to. Do not prevent access if securityfs was bind-mounted and
>> therefore the init_user_ns is the owning user namespace.
>>
>> Suggested-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>>
>> ---
>> v11:
>>   - Formatted comment's first line to be '/*'
>> ---
>>   security/inode.c | 73 ++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 62 insertions(+), 11 deletions(-)
>>
>> diff --git a/security/inode.c b/security/inode.c
>> index 13e6780c4444..84c9396792a9 100644
>> --- a/security/inode.c
>> +++ b/security/inode.c
>> @@ -21,9 +21,38 @@
>>   #include <linux/security.h>
>>   #include <linux/lsm_hooks.h>
>>   #include <linux/magic.h>
>> +#include <linux/user_namespace.h>
>>   
>> -static struct vfsmount *mount;
>> -static int mount_count;
>> +static struct vfsmount *init_securityfs_mount;
>> +static int init_securityfs_mount_count;
>> +
>> +static int securityfs_permission(struct user_namespace *mnt_userns,
>> +				 struct inode *inode, int mask)
>> +{
>> +	int err;
>> +
>> +	err = generic_permission(&init_user_ns, inode, mask);
>> +	if (!err) {
>> +		/*
>> +		 * Unless bind-mounted, deny access if current_user_ns() is not
>> +		 * ancestor.
> 
> This comment has confused me the last few times I looked at this.  I see
> now you're using "bind-mounted" as a shortcut for saying "bind mounted from
> the init_user_ns into a child_user_ns container".  I do think that needs
> to be made clearer in this comment.


I rephrased the comment now.

    Stefan
