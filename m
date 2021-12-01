Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9418465647
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 20:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbhLATYq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 14:24:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240750AbhLATYq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 14:24:46 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Iuw1m011534;
        Wed, 1 Dec 2021 19:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=/viQJvivRW/Q7qT1hjkoUphydf62GXyd5odwCbZlMqc=;
 b=ouhOOwdPJkZDBuWfkeUQc86iy9uDZkFOFVmEInDOB5r5BYZlmmXk+NljAN311xVJAvjw
 FLEsKvuCmE0L+VM/uz/6DaOopsyBGUmngKLnTGKrhfAvVPc5nEJSbm82IVHov5Ii9L1v
 iY9NHFIHNnpJBIWzA9L/Ph01IsNHwlsRVUoaiF9EprOtoAYGBRytH92I323MUz1bkbjp
 XpAZxeBeP6NvWxoIlad6qbB2YLyeIxSxiD9viB1QSkqHlJ7426OHcgnTzGVOvsHTEJvo
 Wis8KdaCKwnprHKCl8oonjtwOXq1/OUO8Zrh2Eq5omIr2VuoEnjh0VSyG1lXVjQRSuvq rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpes58gc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 19:21:14 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1J0Na9003986;
        Wed, 1 Dec 2021 19:21:13 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpes58gbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 19:21:13 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1JD4el012248;
        Wed, 1 Dec 2021 19:21:12 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 3ckcac4bu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 19:21:12 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1JLA0O46203226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 19:21:10 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E08478081;
        Wed,  1 Dec 2021 19:21:10 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 496BA7809D;
        Wed,  1 Dec 2021 19:21:08 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 19:21:08 +0000 (GMT)
Message-ID: <f5e3101e8dee2aa0064e7b68992afe0143e22058.camel@linux.ibm.com>
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
Date:   Wed, 01 Dec 2021 14:21:07 -0500
In-Reply-To: <f2113d60-49d3-2e2d-7dbe-b831035f96a1@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
         <20211130160654.1418231-21-stefanb@linux.ibm.com>
         <6599ac61289e3316bff53602a0bc5970133251aa.camel@linux.ibm.com>
         <f2113d60-49d3-2e2d-7dbe-b831035f96a1@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j1fsCRYA7lzgC2INRglSwIfK4zRejTUd
X-Proofpoint-ORIG-GUID: ugsPZi-P4V--ble_i3zPBpPVcs-7tLOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010102
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-12-01 at 13:11 -0500, Stefan Berger wrote:
> On 12/1/21 12:56, James Bottomley wrote:
[...]
> I tried this with runc and a user namespace active mapping uid 1000
> on the host to uid 0 in the container. There I run into the problem
> that  all of the files and directories without the above work-around
> are mapped to 'nobody', just like all the files in sysfs in this case
> are also mapped to nobody. This code resolved the issue.

So I applied your patches with the permission shift commented out and
instrumented inode_alloc() to see where it might be failing and I
actually find it all works as expected for me:

ejb@testdeb:~> unshare -r --user --mount --ima
root@testdeb:~# mount -t securityfs_ns none /sys/kernel/security
root@testdeb:~# ls -l /sys/kernel/security/ima/
total 0
-r--r----- 1 root root 0 Dec  1 19:11 ascii_runtime_measurements
-r--r----- 1 root root 0 Dec  1 19:11 binary_runtime_measurements
-rw------- 1 root root 0 Dec  1 19:11 policy
-r--r----- 1 root root 0 Dec  1 19:11 runtime_measurements_count
-r--r----- 1 root root 0 Dec  1 19:11 violations

I think your problem is something to do with how runc is installing the
uid/gid mappings.  If it's installing them after the security_ns inodes
are created then they get the -1 value (because no mappings exist in
s_user_ns).  I can even demonstrate this by forcing unshare to enter
the IMA namespace before writing the mapping values and I'll see
"nobody nogroup" above like you do.

I also see the instrumentation telling me that i_write_uid() is mapping
back to 1000 in the former case and -1 in the latter.

James




