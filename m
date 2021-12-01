Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14E4658C2
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 23:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbhLAWFd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 17:05:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353321AbhLAWF0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 17:05:26 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LlVUi022004;
        Wed, 1 Dec 2021 22:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=qE6QX51y7YaBUntEkch4cCylQ4WIkOTYIZnT12bWmPQ=;
 b=maproXgjCAf6DLZW7ke+plCWcjXvrp42wpQe/suxAs7lvZe0xdJpVDqA7lw163trNy6O
 qw07ikGlnIrtWkMjoRKc46ZA8MMfkVIVRlZ9yfoEa2TDbsaoAuj55rYeAiPYqrJgQ+S4
 SeMC6IBtLU5/ZHvaEzBDspg7WiGiiY6WiK4Sg/VXg/Uq5OQabQFzuR+ltqsgcuyQt4Av
 /s1DxfVzoNFuRKJAEYJNlUkIBglvy9FND2fqjBhmA3E+9+xwDCxO2GhfdMkqMmhfz1MH
 eAdQbPca1ph5PL0K72Z5TO3DiD4G4ROceISgGuEF2g1HiuskBJmkXJA4hi9+HesEzdXy 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cph9br8bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 22:01:48 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1M1m3h015834;
        Wed, 1 Dec 2021 22:01:48 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cph9br8bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 22:01:48 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LveUU019424;
        Wed, 1 Dec 2021 22:01:46 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3ckcabyx4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 22:01:46 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1M1jCB20775548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 22:01:45 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0994F78066;
        Wed,  1 Dec 2021 22:01:45 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD8A37806A;
        Wed,  1 Dec 2021 22:01:42 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 22:01:42 +0000 (GMT)
Message-ID: <38458eee904713824b85a2dcef248e752634f67c.camel@linux.ibm.com>
Subject: Re: [RFC 20/20] ima: Setup securityfs_ns for IMA namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Wed, 01 Dec 2021 17:01:41 -0500
In-Reply-To: <8d7b6d47-9001-1f47-bce8-e7fae28fafcf@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
         <20211130160654.1418231-21-stefanb@linux.ibm.com>
         <6599ac61289e3316bff53602a0bc5970133251aa.camel@linux.ibm.com>
         <f2113d60-49d3-2e2d-7dbe-b831035f96a1@linux.ibm.com>
         <f5e3101e8dee2aa0064e7b68992afe0143e22058.camel@linux.ibm.com>
         <9631d4b3-15f6-46f1-6441-98c1192be6b4@linux.ibm.com>
         <c6d7b9363991b80b2f55bbdb7e44c18ea45489da.camel@linux.ibm.com>
         <8d7b6d47-9001-1f47-bce8-e7fae28fafcf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uBL13FUpvze-MNJ1Jjcs7PmM4tNy16Yi
X-Proofpoint-GUID: ZaFZmizjt3ENAbh_pt7SLHaPs6EEr4ui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-12-01 at 16:34 -0500, Stefan Berger wrote:
> On 12/1/21 16:11, James Bottomley wrote:
> > On Wed, 2021-12-01 at 15:25 -0500, Stefan Berger wrote:
> > > On 12/1/21 14:21, James Bottomley wrote:
> > > > On Wed, 2021-12-01 at 13:11 -0500, Stefan Berger wrote:
> > > > > On 12/1/21 12:56, James Bottomley wrote:
> > > > [...]
> > > > > I tried this with runc and a user namespace active mapping
> > > > > uid
> > > > > 1000 on the host to uid 0 in the container. There I run into
> > > > > the
> > > > > problem that  all of the files and directories without the
> > > > > above
> > > > > work-around are mapped to 'nobody', just like all the files
> > > > > in
> > > > > sysfs in this case are also mapped to nobody. This code
> > > > > resolved
> > > > > the issue.
> > > > So I applied your patches with the permission shift commented
> > > > out
> > > > and instrumented inode_alloc() to see where it might be failing
> > > > and
> > > > I actually find it all works as expected for me:
> > > > 
> > > > ejb@testdeb:~> unshare -r --user --mount --ima
> > > > root@testdeb:~# mount -t securityfs_ns none
> > > > /sys/kernel/security
> > > > root@testdeb:~# ls -l /sys/kernel/security/ima/
> > > > total 0
> > > > -r--r----- 1 root root 0 Dec  1 19:11
> > > > ascii_runtime_measurements
> > > > -r--r----- 1 root root 0 Dec  1 19:11
> > > > binary_runtime_measurements
> > > > -rw------- 1 root root 0 Dec  1 19:11 policy
> > > > -r--r----- 1 root root 0 Dec  1 19:11
> > > > runtime_measurements_count
> > > > -r--r----- 1 root root 0 Dec  1 19:11 violations
> > > > 
> > > > I think your problem is something to do with how runc is
> > > > installing
> > > > the uid/gid mappings.  If it's installing them after the
> > > > security_ns inodes are created then they get the -1 value
> > > > (because
> > > > no mappings exist in s_user_ns).  I can even demonstrate this
> > > > by
> > > > forcing unshare to enter the IMA namespace before writing the
> > > > mapping values and I'll see "nobody nogroup" above like you do.
> > > I am surprised you get this mapping even after commenting the
> > > permission adjustments... it doesn't work for me when I comment
> > > them
> > > out:
> > > 
> > > [stefanb@ima-ns-dev rootfs]$ unshare -r --user --mount
> > > [root@ima-ns-dev rootfs]# mount -t securityfs_ns none
> > > /sys/kernel/security/
> > > [root@ima-ns-dev rootfs]# cd /sys/kernel/security/ima/
> > > [root@ima-ns-dev ima]# ls -l
> > > total 0
> > > -r--r-----. 1 nobody nobody 0 Dec  1 15:20
> > > ascii_runtime_measurements
> > > -r--r-----. 1 nobody nobody 0 Dec  1 15:20
> > > binary_runtime_measurements
> > > -rw-------. 1 nobody nobody 0 Dec  1 15:20 policy
> > > -r--r-----. 1 nobody nobody 0 Dec  1 15:20
> > > runtime_measurements_count
> > > -r--r-----. 1 nobody nobody 0 Dec  1 15:20 violations
> > > [root@ima-ns-dev ima]# cat /proc/self/uid_map
> > >            0       1000          1
> > > [root@ima-ns-dev ima]# cat /proc/self/gid_map
> > >            0       1000          1
> > > 
> > > The initialization of securityfs and setup of files and
> > > directories
> > > happens at the same time as the IMA namespace is created. At this
> > > time there are no user mappings available, so that's why I need
> > > to
> > > make the adjustments 'late'.
> > There is one other possible difference:  To get the correct
> > s_user_ns
> 
> I am currently wondering why I cannot re-create your setup while 
> disabling the remapping...

OK, I think I figured it out.  When I applied your patches, it was on
top of my existing ones, so I had to massage them a bit.

Your problem is the securityfs inode creation is triggered inside
create_user_ns, which means it happens *before* ushare writes to the
proc/self/uid_map file, so the securityfs_inodes are always created on
an empty mapping and i_write_uid always sets the inode uid to -1.

I don't see this because my setup for everything is triggered off the
first use of the IMA namespace.  You'd need to have some type of lazy
setup of the inodes as well to give unshare time to install the uid/gid
mappings.

James


