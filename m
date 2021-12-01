Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E445465710
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 21:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352783AbhLAU3E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 15:29:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245591AbhLAU3C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 15:29:02 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1JMfHU010372;
        Wed, 1 Dec 2021 20:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=INbwm39RfA+5ApgY5ogB2nlX0oAMfixW5R80bf1w9Wo=;
 b=UZg+3LmNkW5YOyQ5YNUyVFRrUq+UGpSCseRF1LGz5Ol1fG3u0qj9uS0O5Ixvk7JmVxNU
 kjkCqVWOdeNnPLskYsQxncRUmy5L45xiA5SP7PtG2XJ7Q+CokkAh+lCE43z4E5B3i9xc
 Elmgy1svel80mpZTAz21DsSAsxbIK3Q6tU4Ip//n6L5fXC0HxXUVGDj4L5kfOT0E47SR
 8WTrLnR+1MqkFyG8UlEUFmwfEkqSNxGLGmppKTWuJ1vMDcMh3e8ruyaZiSycYYj2r1wC
 Sz8JlWBdt9Q0UFCCOlHRl+CYLF2rtpGoUJdq9mOifMqsV02rSCOiEjRF7UVC4c/B4sXm 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpf5e9aun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 20:25:28 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1JMpjc011773;
        Wed, 1 Dec 2021 20:25:27 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpf5e9au2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 20:25:27 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1KDeUa014135;
        Wed, 1 Dec 2021 20:25:26 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3ckcabwt3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 20:25:26 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1KPOZl57934086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 20:25:25 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA37178078;
        Wed,  1 Dec 2021 20:25:24 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6735878067;
        Wed,  1 Dec 2021 20:25:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 20:25:22 +0000 (GMT)
Message-ID: <9631d4b3-15f6-46f1-6441-98c1192be6b4@linux.ibm.com>
Date:   Wed, 1 Dec 2021 15:25:21 -0500
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <f5e3101e8dee2aa0064e7b68992afe0143e22058.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zq1ffEfzM8dWnQDvAfxVqiKINNjtB4sW
X-Proofpoint-ORIG-GUID: YIU7QCMOWoTBSDj4cQQJUI-k6-Wyhv5U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/1/21 14:21, James Bottomley wrote:
> On Wed, 2021-12-01 at 13:11 -0500, Stefan Berger wrote:
>> On 12/1/21 12:56, James Bottomley wrote:
> [...]
>> I tried this with runc and a user namespace active mapping uid 1000
>> on the host to uid 0 in the container. There I run into the problem
>> that  all of the files and directories without the above work-around
>> are mapped to 'nobody', just like all the files in sysfs in this case
>> are also mapped to nobody. This code resolved the issue.
> So I applied your patches with the permission shift commented out and
> instrumented inode_alloc() to see where it might be failing and I
> actually find it all works as expected for me:
>
> ejb@testdeb:~> unshare -r --user --mount --ima
> root@testdeb:~# mount -t securityfs_ns none /sys/kernel/security
> root@testdeb:~# ls -l /sys/kernel/security/ima/
> total 0
> -r--r----- 1 root root 0 Dec  1 19:11 ascii_runtime_measurements
> -r--r----- 1 root root 0 Dec  1 19:11 binary_runtime_measurements
> -rw------- 1 root root 0 Dec  1 19:11 policy
> -r--r----- 1 root root 0 Dec  1 19:11 runtime_measurements_count
> -r--r----- 1 root root 0 Dec  1 19:11 violations
>
> I think your problem is something to do with how runc is installing the
> uid/gid mappings.  If it's installing them after the security_ns inodes
> are created then they get the -1 value (because no mappings exist in
> s_user_ns).  I can even demonstrate this by forcing unshare to enter
> the IMA namespace before writing the mapping values and I'll see
> "nobody nogroup" above like you do.

I am surprised you get this mapping even after commenting the permission 
adjustments... it doesn't work for me when I comment them out:

[stefanb@ima-ns-dev rootfs]$ unshare -r --user --mount
[root@ima-ns-dev rootfs]# mount -t securityfs_ns none /sys/kernel/security/
[root@ima-ns-dev rootfs]# cd /sys/kernel/security/ima/
[root@ima-ns-dev ima]# ls -l
total 0
-r--r-----. 1 nobody nobody 0 Dec  1 15:20 ascii_runtime_measurements
-r--r-----. 1 nobody nobody 0 Dec  1 15:20 binary_runtime_measurements
-rw-------. 1 nobody nobody 0 Dec  1 15:20 policy
-r--r-----. 1 nobody nobody 0 Dec  1 15:20 runtime_measurements_count
-r--r-----. 1 nobody nobody 0 Dec  1 15:20 violations
[root@ima-ns-dev ima]# cat /proc/self/uid_map
          0       1000          1
[root@ima-ns-dev ima]# cat /proc/self/gid_map
          0       1000          1

The initialization of securityfs and setup of files and directories 
happens at the same time as the IMA namespace is created. At this time 
there are no user mappings available, so that's why I need to make the 
adjustments 'late'.

    Stefan


