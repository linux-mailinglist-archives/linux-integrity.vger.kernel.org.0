Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A16F465420
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 18:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243819AbhLARjr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 12:39:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241521AbhLARjq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 12:39:46 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1FN4uv007781;
        Wed, 1 Dec 2021 17:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kD37SXOY+QMYrgd+aXqsCcHyPQL/S5ffpT7+1+JtUPs=;
 b=A+l3pqSt3aUUDkXl9wYgLjxkPgVl2JqAtVaJsvkCMktiC23w0IaiumlUvsseKkxdNX3V
 f6h6VRkFfnpgee9lNKLCDyxtK402mY+h+0j1fLpPW9vfSZ9d2EtiOjdqU8+z+qiC2Z95
 jF3jzMcu7uWzS92GAP7CxwT1lNNukV9EW4o2Y3hHbukO9ilsLPefBGRawoTqyyRFx9LY
 JSCLC9SBJc3AygiYZFvBVs6JSqqeObdqhZCD+HQJompxPDY3WUMKzl/YgehswfbOE696
 zWIN5SPa6QH0ZMdEadF4UltvBAw5cwI+PvpaXuuuarORrP3eOnOxHhw6bXs1AZshf+u+ xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpbn32xju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 17:36:00 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1Gj4hO008320;
        Wed, 1 Dec 2021 17:36:00 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpbn32xj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 17:35:59 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1HLKIY009345;
        Wed, 1 Dec 2021 17:35:58 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne2baya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 17:35:58 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1HZu5s59245030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 17:35:56 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EA64136053;
        Wed,  1 Dec 2021 17:35:56 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E51DB13606A;
        Wed,  1 Dec 2021 17:35:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 17:35:52 +0000 (GMT)
Message-ID: <34085058-ff5f-c28e-c716-6f4fa71747a3@linux.ibm.com>
Date:   Wed, 1 Dec 2021 12:35:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 17/20] ima: Use integrity_admin_ns_capable() to check
 corresponding capability
Content-Language: en-US
To:     jejb@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-18-stefanb@linux.ibm.com>
 <7c751783b28766412f158e5ca074748ed18070bd.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <7c751783b28766412f158e5ca074748ed18070bd.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zyjazCBWbjknxzEUzdBa2lqledxsz3rc
X-Proofpoint-GUID: ECjQQxNaT_J0q-jcqUVwfvVlwejvOUls
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010094
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/1/21 11:58, James Bottomley wrote:
> On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
>> From: Denis Semakin <denis.semakin@huawei.com>
>>
>> Use integrity_admin_ns_capable() to check corresponding capability to
>> allow read/write IMA policy without CAP_SYS_ADMIN but with
>> CAP_INTEGRITY_ADMIN.
>>
>> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
>> ---
>>   security/integrity/ima/ima_fs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/integrity/ima/ima_fs.c
>> b/security/integrity/ima/ima_fs.c
>> index fd2798f2d224..6766bb8262f2 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -393,7 +393,7 @@ static int ima_open_policy(struct inode *inode,
>> struct file *filp)
>>   #else
>>   		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>>   			return -EACCES;
>> -		if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
>> +		if (!integrity_admin_ns_capable(ns->user_ns))
> so this one is basically replacing what you did in RFC 16/20, which
> seems a little redundant.
>
> The question I'd like to ask is: is there still a reason for needing
> CAP_INTEGRITY_ADMIN?  My thinking is that now IMA is pretty much tied
> to requiring a user (and a mount, because of securityfs_ns) namespace,
> there might not be a pressing need for an admin capability separated
> from CAP_SYS_ADMIN because the owner of the user namespace passes the
> ns_capable(..., CAP_SYS_ADMIN) check.  The rationale in

Casey suggested using CAP_MAC_ADMIN, which I think would also work.

     CAP_MAC_ADMIN (since Linux 2.6.25)
               Allow MAC configuration or state changes. Implemented for
               the Smack Linux Security Module (LSM).


Down the road I think we should cover setting file extended attributes 
with the same capability as well for when a user signs files or installs 
packages with file signatures.  A container runtime could hold 
CAP_SYS_ADMIN while setting up a container and mounting filesystems and 
drop it for the first process started there. Since we are using the user 
namespace to spawn an IMA namespace, we would then require 
CAP_SYSTEM_ADMIN to be left available so that the user can do IMA 
related stuff in the container (set or append to the policy, write file 
signatures). I am not sure whether that should be the case or rather 
give the user something finer grained, such as CAP_MAC_ADMIN. So, it's 
about granularity...


>
> https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerations
>
> Is effectively "because CAP_SYS_ADMIN is too powerful" but that's no
> longer true of the user namespace owner.  It only passes the ns_capable
> () check not the capable() one, so while it does get CAP_SYS_ADMIN, it
> can only use it in a few situations which represent quite a power
> reduction already.

At least docker containers drop CAP_SYS_ADMIN. I am not sure what the 
decision was based on but probably they don't want to give the user what 
is not absolutely necessary, but usage of user namespaces (with IMA 
namespaces) would kind of force it to be available then to do 
IMA-related stuff ...

Following this man page here 
https://man7.org/linux/man-pages/man7/user_namespaces.7.html

CAP_SYS_ADMIN in a user namespace is about

- bind-mounting filesystems

- mounting /proc filesystems

- creating nested user namespaces

- configuring UTS namespace

- configuring whether setgroups() can be used

- usage of setns()


Do we want to add '- only way of *setting up* IMA related stuff' to this 
list?

   Stefan


>
> James
>
>
