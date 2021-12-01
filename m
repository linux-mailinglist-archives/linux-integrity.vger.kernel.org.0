Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB6465837
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 22:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343850AbhLAVQq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 16:16:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17948 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240746AbhLAVQi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 16:16:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Kq68h024247;
        Wed, 1 Dec 2021 21:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=rs/nQlSVEbJt1pibt4tWqryV/zIXKyEYzA/Y1g8pv5Q=;
 b=oVqJV0WahgYv773NFyCEFhgAMq9HfOwMNS9EkYCIFUX6XLhQ4YgzL3PcE1J4c/h2s9Vf
 13K3/b+8ANmdWLU1yEa8i/lTluwKfZck6HSwj+KvDp2LhJqlldV8T511ShvL5wD/smO0
 yZNIQ4Hk5enzHQozy6qTQmK0y+8P4ZgfLAtNSI4BVXuNDR8flMnGv5r1doriVn5ltNHc
 HsmuKW/Rrrhlj+bqtPcRq0omj/5Qqdh/Xfdm61fS+oSArXDygjMUBCA0zk7V2hEWgqtI
 OFP128dmvpLFRP8mcsPa7DYdxgqHg4tCHwDzjv0Wy4Fw6zDEvwHAXdGK8qO/c7+yWZH5 YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpgfbrbey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 21:11:25 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1KrO89026625;
        Wed, 1 Dec 2021 21:11:24 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpgfbrbeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 21:11:24 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1KrAPq008308;
        Wed, 1 Dec 2021 21:11:23 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3ckcaces8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 21:11:23 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1LBMoI48955748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 21:11:22 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26DC178064;
        Wed,  1 Dec 2021 21:11:22 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC74F78063;
        Wed,  1 Dec 2021 21:11:19 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 21:11:19 +0000 (GMT)
Message-ID: <c6d7b9363991b80b2f55bbdb7e44c18ea45489da.camel@linux.ibm.com>
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
Date:   Wed, 01 Dec 2021 16:11:18 -0500
In-Reply-To: <9631d4b3-15f6-46f1-6441-98c1192be6b4@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
         <20211130160654.1418231-21-stefanb@linux.ibm.com>
         <6599ac61289e3316bff53602a0bc5970133251aa.camel@linux.ibm.com>
         <f2113d60-49d3-2e2d-7dbe-b831035f96a1@linux.ibm.com>
         <f5e3101e8dee2aa0064e7b68992afe0143e22058.camel@linux.ibm.com>
         <9631d4b3-15f6-46f1-6441-98c1192be6b4@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -NPLpM0F8RvYXiE6RZaaWt6DiAdkQCzx
X-Proofpoint-ORIG-GUID: cOqogS45lxu4N5jbf5BBCU3SpzpVpoHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-12-01 at 15:25 -0500, Stefan Berger wrote:
> On 12/1/21 14:21, James Bottomley wrote:
> > On Wed, 2021-12-01 at 13:11 -0500, Stefan Berger wrote:
> > > On 12/1/21 12:56, James Bottomley wrote:
> > [...]
> > > I tried this with runc and a user namespace active mapping uid
> > > 1000 on the host to uid 0 in the container. There I run into the
> > > problem that  all of the files and directories without the above
> > > work-around are mapped to 'nobody', just like all the files in
> > > sysfs in this case are also mapped to nobody. This code resolved
> > > the issue.
> > So I applied your patches with the permission shift commented out
> > and instrumented inode_alloc() to see where it might be failing and
> > I actually find it all works as expected for me:
> > 
> > ejb@testdeb:~> unshare -r --user --mount --ima
> > root@testdeb:~# mount -t securityfs_ns none /sys/kernel/security
> > root@testdeb:~# ls -l /sys/kernel/security/ima/
> > total 0
> > -r--r----- 1 root root 0 Dec  1 19:11 ascii_runtime_measurements
> > -r--r----- 1 root root 0 Dec  1 19:11 binary_runtime_measurements
> > -rw------- 1 root root 0 Dec  1 19:11 policy
> > -r--r----- 1 root root 0 Dec  1 19:11 runtime_measurements_count
> > -r--r----- 1 root root 0 Dec  1 19:11 violations
> > 
> > I think your problem is something to do with how runc is installing
> > the uid/gid mappings.  If it's installing them after the
> > security_ns inodes are created then they get the -1 value (because
> > no mappings exist in s_user_ns).  I can even demonstrate this by
> > forcing unshare to enter the IMA namespace before writing the
> > mapping values and I'll see "nobody nogroup" above like you do.
> 
> I am surprised you get this mapping even after commenting the
> permission adjustments... it doesn't work for me when I comment them
> out:
> 
> [stefanb@ima-ns-dev rootfs]$ unshare -r --user --mount
> [root@ima-ns-dev rootfs]# mount -t securityfs_ns none
> /sys/kernel/security/
> [root@ima-ns-dev rootfs]# cd /sys/kernel/security/ima/
> [root@ima-ns-dev ima]# ls -l
> total 0
> -r--r-----. 1 nobody nobody 0 Dec  1 15:20 ascii_runtime_measurements
> -r--r-----. 1 nobody nobody 0 Dec  1 15:20
> binary_runtime_measurements
> -rw-------. 1 nobody nobody 0 Dec  1 15:20 policy
> -r--r-----. 1 nobody nobody 0 Dec  1 15:20 runtime_measurements_count
> -r--r-----. 1 nobody nobody 0 Dec  1 15:20 violations
> [root@ima-ns-dev ima]# cat /proc/self/uid_map
>           0       1000          1
> [root@ima-ns-dev ima]# cat /proc/self/gid_map
>           0       1000          1
> 
> The initialization of securityfs and setup of files and directories 
> happens at the same time as the IMA namespace is created. At this
> time there are no user mappings available, so that's why I need to
> make the adjustments 'late'.

There is one other possible difference:  To get the correct s_user_ns
on the securityfs_ns mount, the mount namespace itself has to be owned
by the user namespace ... is runc doing that correctly?  I always
forget this detail because unshare does it correctly automatically but
it means you must unshare the user namespace first and then unshare the
mount namespace (or do it in the same sys call because the kernel will
get the correct order).

James


