Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFE4658ED
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 23:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353402AbhLAWMq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 17:12:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240347AbhLAWMo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 17:12:44 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Klc6K023854;
        Wed, 1 Dec 2021 22:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=g22G9ZGEm1pklnTKfjiXq9r8Yr3tI37S11UQC4hW+gs=;
 b=e/JeOpZjV1+wx5HoinlbF+c0XhAwbxriGmiCz9pEZ/C7ZSLM90kv6AEa9XW11AUBE66S
 k97JhmSMWEDiGkgNZwUsT1sr4cQG0nWXYGuVN4qm/O8EzXGEQ5oFDxRLFlw7hd3n0Rs3
 Jd7iubLODzfx4Hwm0LWH7MNCSiKKOg8HZBq9XCR03QeJPWhByg0etLhh4jPIxHAcWrKX
 0vVbsNnHwsoyusjISi+aLZveqzdTYJdcmZ/C7pdX9a3ZUg/MHonFhmUL19OH6qfLYnsz
 Z+hY/SeO+l4AT7srhGLAUa3nSX76PjWr+9WuMgjVZu9ucQOWwXBEEvUtIHXm3JKT/6hX xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpgd91f0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 22:09:12 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1LxsWM032021;
        Wed, 1 Dec 2021 22:09:12 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpgd91f0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 22:09:12 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1M7EVG025932;
        Wed, 1 Dec 2021 22:09:10 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma05wdc.us.ibm.com with ESMTP id 3ckcac03nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 22:09:10 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1M99N860752194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 22:09:09 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECFE5C6074;
        Wed,  1 Dec 2021 22:09:08 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94996C61DF;
        Wed,  1 Dec 2021 22:09:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 22:09:06 +0000 (GMT)
Message-ID: <b8c21064-05f3-91a9-d23c-0417f046f4cc@linux.ibm.com>
Date:   Wed, 1 Dec 2021 17:09:05 -0500
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
 <f2113d60-49d3-2e2d-7dbe-b831035f96a1@linux.ibm.com>
 <f5e3101e8dee2aa0064e7b68992afe0143e22058.camel@linux.ibm.com>
 <9631d4b3-15f6-46f1-6441-98c1192be6b4@linux.ibm.com>
 <c6d7b9363991b80b2f55bbdb7e44c18ea45489da.camel@linux.ibm.com>
 <8d7b6d47-9001-1f47-bce8-e7fae28fafcf@linux.ibm.com>
 <38458eee904713824b85a2dcef248e752634f67c.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <38458eee904713824b85a2dcef248e752634f67c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uOb6R4g3PGVvr1wmbGIY2YrwBE7CLy2T
X-Proofpoint-ORIG-GUID: gwTNY77Pr0CSuxD47bdNCooWacggwwiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/1/21 17:01, James Bottomley wrote:
> On Wed, 2021-12-01 at 16:34 -0500, Stefan Berger wrote:
>> On 12/1/21 16:11, James Bottomley wrote:
>>> On Wed, 2021-12-01 at 15:25 -0500, Stefan Berger wrote:
>>>> On 12/1/21 14:21, James Bottomley wrote:
>>>>> On Wed, 2021-12-01 at 13:11 -0500, Stefan Berger wrote:
>>>>>> On 12/1/21 12:56, James Bottomley wrote:
>>>>> [...]
>>>>>> I tried this with runc and a user namespace active mapping
>>>>>> uid
>>>>>> 1000 on the host to uid 0 in the container. There I run into
>>>>>> the
>>>>>> problem that  all of the files and directories without the
>>>>>> above
>>>>>> work-around are mapped to 'nobody', just like all the files
>>>>>> in
>>>>>> sysfs in this case are also mapped to nobody. This code
>>>>>> resolved
>>>>>> the issue.
>>>>> So I applied your patches with the permission shift commented
>>>>> out
>>>>> and instrumented inode_alloc() to see where it might be failing
>>>>> and
>>>>> I actually find it all works as expected for me:
>>>>>
>>>>> ejb@testdeb:~> unshare -r --user --mount --ima
>>>>> root@testdeb:~# mount -t securityfs_ns none
>>>>> /sys/kernel/security
>>>>> root@testdeb:~# ls -l /sys/kernel/security/ima/
>>>>> total 0
>>>>> -r--r----- 1 root root 0 Dec  1 19:11
>>>>> ascii_runtime_measurements
>>>>> -r--r----- 1 root root 0 Dec  1 19:11
>>>>> binary_runtime_measurements
>>>>> -rw------- 1 root root 0 Dec  1 19:11 policy
>>>>> -r--r----- 1 root root 0 Dec  1 19:11
>>>>> runtime_measurements_count
>>>>> -r--r----- 1 root root 0 Dec  1 19:11 violations
>>>>>
>>>>> I think your problem is something to do with how runc is
>>>>> installing
>>>>> the uid/gid mappings.  If it's installing them after the
>>>>> security_ns inodes are created then they get the -1 value
>>>>> (because
>>>>> no mappings exist in s_user_ns).  I can even demonstrate this
>>>>> by
>>>>> forcing unshare to enter the IMA namespace before writing the
>>>>> mapping values and I'll see "nobody nogroup" above like you do.
>>>> I am surprised you get this mapping even after commenting the
>>>> permission adjustments... it doesn't work for me when I comment
>>>> them
>>>> out:
>>>>
>>>> [stefanb@ima-ns-dev rootfs]$ unshare -r --user --mount
>>>> [root@ima-ns-dev rootfs]# mount -t securityfs_ns none
>>>> /sys/kernel/security/
>>>> [root@ima-ns-dev rootfs]# cd /sys/kernel/security/ima/
>>>> [root@ima-ns-dev ima]# ls -l
>>>> total 0
>>>> -r--r-----. 1 nobody nobody 0 Dec  1 15:20
>>>> ascii_runtime_measurements
>>>> -r--r-----. 1 nobody nobody 0 Dec  1 15:20
>>>> binary_runtime_measurements
>>>> -rw-------. 1 nobody nobody 0 Dec  1 15:20 policy
>>>> -r--r-----. 1 nobody nobody 0 Dec  1 15:20
>>>> runtime_measurements_count
>>>> -r--r-----. 1 nobody nobody 0 Dec  1 15:20 violations
>>>> [root@ima-ns-dev ima]# cat /proc/self/uid_map
>>>>             0       1000          1
>>>> [root@ima-ns-dev ima]# cat /proc/self/gid_map
>>>>             0       1000          1
>>>>
>>>> The initialization of securityfs and setup of files and
>>>> directories
>>>> happens at the same time as the IMA namespace is created. At this
>>>> time there are no user mappings available, so that's why I need
>>>> to
>>>> make the adjustments 'late'.
>>> There is one other possible difference:  To get the correct
>>> s_user_ns
>> I am currently wondering why I cannot re-create your setup while
>> disabling the remapping...
> OK, I think I figured it out.  When I applied your patches, it was on
> top of my existing ones, so I had to massage them a bit.
>
> Your problem is the securityfs inode creation is triggered inside
> create_user_ns, which means it happens *before* ushare writes to the
> proc/self/uid_map file, so the securityfs_inodes are always created on
> an empty mapping and i_write_uid always sets the inode uid to -1.

Right, the initialization of the filesystem is quite early.


>
> I don't see this because my setup for everything is triggered off the
> first use of the IMA namespace.  You'd need to have some type of lazy
> setup of the inodes as well to give unshare time to install the uid/gid
> mappings.

What could trigger that? A callback while mounting - but I am not sure 
where to hook into then. What is your mechanisms to trigger as the 
'first use of the IMA namespace'? What is 'use' here?

    Stefan



>
> James
>
>
