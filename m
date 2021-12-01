Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46527465867
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 22:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbhLAVi3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 16:38:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64688 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343497AbhLAVi1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 16:38:27 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Kq6Sc024247;
        Wed, 1 Dec 2021 21:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FEJKSDLY6YremZ5eT33paAkzYcl/bTHsuNc/MZzchQI=;
 b=hh/5gRUQ6YVVMGYmTQXDf8T652tLgv1FdXd2gYg+4GyUKcTCCAPoHW3XOUC9GW1lVj8i
 Zzv3j+QTafZIb1ET6z1olILYvsTRJ/q84+IQKgqPGk5bCxaPv5zNIb10jPl6r6ZQ6kTh
 GfpaEo740iDCwFcrzHekcn9TDCgBQDnoUB4Xn5LwUR9KpJWjlZm7bXfpcZUE5ZsnhcTH
 1fskSUI7gEuxPoYnA69PlUsaBxOjNWOAheuisw73DeHoo5DqT/7L90n3AJzRHIzKhUb/
 LuY3/FXa0qVIj3Nw7JMO33DZJ6+Ewm0dQHSntd//LmA46wMlbXHax3hZ6OuDFvES8JuH ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpgfbruaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 21:34:50 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1LDpKL008462;
        Wed, 1 Dec 2021 21:34:50 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpgfbrua4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 21:34:50 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LCkoc000913;
        Wed, 1 Dec 2021 21:34:49 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 3ckcacyaty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 21:34:48 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1LYcnn52232488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 21:34:38 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46DC9C608A;
        Wed,  1 Dec 2021 21:34:38 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12AD3C6072;
        Wed,  1 Dec 2021 21:34:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 21:34:35 +0000 (GMT)
Message-ID: <8d7b6d47-9001-1f47-bce8-e7fae28fafcf@linux.ibm.com>
Date:   Wed, 1 Dec 2021 16:34:35 -0500
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
 <f2113d60-49d3-2e2d-7dbe-b831035f96a1@linux.ibm.com>
 <f5e3101e8dee2aa0064e7b68992afe0143e22058.camel@linux.ibm.com>
 <9631d4b3-15f6-46f1-6441-98c1192be6b4@linux.ibm.com>
 <c6d7b9363991b80b2f55bbdb7e44c18ea45489da.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <c6d7b9363991b80b2f55bbdb7e44c18ea45489da.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eRY5LWvZdWtXnSQq_0cEzGGjNO8tV0Mw
X-Proofpoint-ORIG-GUID: pLTEL_44cgVR9rYdeaQvd_4tEQJtXCX-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/1/21 16:11, James Bottomley wrote:
> On Wed, 2021-12-01 at 15:25 -0500, Stefan Berger wrote:
>> On 12/1/21 14:21, James Bottomley wrote:
>>> On Wed, 2021-12-01 at 13:11 -0500, Stefan Berger wrote:
>>>> On 12/1/21 12:56, James Bottomley wrote:
>>> [...]
>>>> I tried this with runc and a user namespace active mapping uid
>>>> 1000 on the host to uid 0 in the container. There I run into the
>>>> problem that  all of the files and directories without the above
>>>> work-around are mapped to 'nobody', just like all the files in
>>>> sysfs in this case are also mapped to nobody. This code resolved
>>>> the issue.
>>> So I applied your patches with the permission shift commented out
>>> and instrumented inode_alloc() to see where it might be failing and
>>> I actually find it all works as expected for me:
>>>
>>> ejb@testdeb:~> unshare -r --user --mount --ima
>>> root@testdeb:~# mount -t securityfs_ns none /sys/kernel/security
>>> root@testdeb:~# ls -l /sys/kernel/security/ima/
>>> total 0
>>> -r--r----- 1 root root 0 Dec  1 19:11 ascii_runtime_measurements
>>> -r--r----- 1 root root 0 Dec  1 19:11 binary_runtime_measurements
>>> -rw------- 1 root root 0 Dec  1 19:11 policy
>>> -r--r----- 1 root root 0 Dec  1 19:11 runtime_measurements_count
>>> -r--r----- 1 root root 0 Dec  1 19:11 violations
>>>
>>> I think your problem is something to do with how runc is installing
>>> the uid/gid mappings.  If it's installing them after the
>>> security_ns inodes are created then they get the -1 value (because
>>> no mappings exist in s_user_ns).  I can even demonstrate this by
>>> forcing unshare to enter the IMA namespace before writing the
>>> mapping values and I'll see "nobody nogroup" above like you do.
>> I am surprised you get this mapping even after commenting the
>> permission adjustments... it doesn't work for me when I comment them
>> out:
>>
>> [stefanb@ima-ns-dev rootfs]$ unshare -r --user --mount
>> [root@ima-ns-dev rootfs]# mount -t securityfs_ns none
>> /sys/kernel/security/
>> [root@ima-ns-dev rootfs]# cd /sys/kernel/security/ima/
>> [root@ima-ns-dev ima]# ls -l
>> total 0
>> -r--r-----. 1 nobody nobody 0 Dec  1 15:20 ascii_runtime_measurements
>> -r--r-----. 1 nobody nobody 0 Dec  1 15:20
>> binary_runtime_measurements
>> -rw-------. 1 nobody nobody 0 Dec  1 15:20 policy
>> -r--r-----. 1 nobody nobody 0 Dec  1 15:20 runtime_measurements_count
>> -r--r-----. 1 nobody nobody 0 Dec  1 15:20 violations
>> [root@ima-ns-dev ima]# cat /proc/self/uid_map
>>            0       1000          1
>> [root@ima-ns-dev ima]# cat /proc/self/gid_map
>>            0       1000          1
>>
>> The initialization of securityfs and setup of files and directories
>> happens at the same time as the IMA namespace is created. At this
>> time there are no user mappings available, so that's why I need to
>> make the adjustments 'late'.
> There is one other possible difference:  To get the correct s_user_ns

I am currently wondering why I cannot re-create your setup while 
disabling the remapping...




> on the securityfs_ns mount, the mount namespace itself has to be owned
> by the user namespace ... is runc doing that correctly?  I always

Following an strace of 'runc create' I see an unshare(CLONE_NEWUSER) by 
a process before it does an 
unshare(CLONE_NEWNS|CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWPID|CLONE_NEWNET), 
so this seems to be doing it in the order you suggest.

Also, runc seems to have its own set of struggles. I am not sure we 
would be able to ask them to accommodate us to do it 'correctly' - it 
doesn't sound so 'easy' for them either to get everything under the hood:

https://github.com/opencontainers/runc/blob/master/libcontainer/nsenter/nsexec.c#L919

      * In order for this unsharing code to be more extensible we need 
to split
      * up unshare(CLONE_NEWUSER) and clone() in various ways. The ideal 
case
      * would be if we did clone(CLONE_NEWUSER) and the other namespaces
      * separately, but because of SELinux issues we cannot really do 
that. But

[...]

      * However, if we unshare(2) the user namespace *before* we 
clone(2), then
      * all hell breaks loose.

sounds like fun

So, I am not quite sure whether I am working around an issue of runc but 
for that I would like to first be able to re-create your successful 
setup to see what's different.

    Stefan


> forget this detail because unshare does it correctly automatically but
> it means you must unshare the user namespace first and then unshare the
> mount namespace (or do it in the same sys call because the kernel will
> get the correct order).
>
> James
>
>
