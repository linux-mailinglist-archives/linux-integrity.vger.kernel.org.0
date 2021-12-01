Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE6D465904
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 23:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbhLAWWq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 17:22:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235412AbhLAWWq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 17:22:46 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LlUQo021937;
        Wed, 1 Dec 2021 22:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=aXABSNFDqqDX39gcGw8c/1CTT9sMU7z9/U9rMwDoHnQ=;
 b=XY1fwZlYAAHWEqyznKKJzpc9pgoJt8EAWr8xQlhDSFbcRbSpXC8kvkI9IlZV5lr9ZUHj
 iXvQgyHmHGhkUcpYxtucO8/fxNGTQ54s0EEnypaeY4iPEqo0dque4bUTSy6Ld1K5gzjT
 /js3mFEKPr4HOViUXdbbnLXn1qpa3qXPwhorFbfkZDon844TjOB6Fw4qV1UMm8++SJBQ
 a1y5sZE9lpgr0hhFCopfG24+5MovMZwRT3waGEhT0pjFO9Qc28lewrp3+fwjhhbpcbsA
 ZrV2VODwnvTcazBIeE/mceGVNDsurfhV5YMXw5pHv+XjsopggE/+PoGukxaZe50tIZl8 Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cph9brhdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 22:19:10 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1MAThU024117;
        Wed, 1 Dec 2021 22:19:09 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cph9brhdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 22:19:09 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1MHqfr021235;
        Wed, 1 Dec 2021 22:19:08 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 3cn3k2qwwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 22:19:08 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1MJ6gq66519338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 22:19:06 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D741578067;
        Wed,  1 Dec 2021 22:19:06 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABB5F78079;
        Wed,  1 Dec 2021 22:19:04 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 22:19:04 +0000 (GMT)
Message-ID: <29770c86261bbc7f6380c7c355ecb6a1c9f40980.camel@linux.ibm.com>
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
Date:   Wed, 01 Dec 2021 17:19:03 -0500
In-Reply-To: <b8c21064-05f3-91a9-d23c-0417f046f4cc@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
         <20211130160654.1418231-21-stefanb@linux.ibm.com>
         <6599ac61289e3316bff53602a0bc5970133251aa.camel@linux.ibm.com>
         <f2113d60-49d3-2e2d-7dbe-b831035f96a1@linux.ibm.com>
         <f5e3101e8dee2aa0064e7b68992afe0143e22058.camel@linux.ibm.com>
         <9631d4b3-15f6-46f1-6441-98c1192be6b4@linux.ibm.com>
         <c6d7b9363991b80b2f55bbdb7e44c18ea45489da.camel@linux.ibm.com>
         <8d7b6d47-9001-1f47-bce8-e7fae28fafcf@linux.ibm.com>
         <38458eee904713824b85a2dcef248e752634f67c.camel@linux.ibm.com>
         <b8c21064-05f3-91a9-d23c-0417f046f4cc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QT1x_gWkK1N_l8g4TNPk-WoYda82lw9z
X-Proofpoint-GUID: UqrED-CRKtXdqoiNflCxRJuos1f4PnLZ
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

On Wed, 2021-12-01 at 17:09 -0500, Stefan Berger wrote:
> On 12/1/21 17:01, James Bottomley wrote:
[...]
> > OK, I think I figured it out.  When I applied your patches, it was
> > on top of my existing ones, so I had to massage them a bit.
> > 
> > Your problem is the securityfs inode creation is triggered inside
> > create_user_ns, which means it happens *before* ushare writes to
> > the proc/self/uid_map file, so the securityfs_inodes are always
> > created on an empty mapping and i_write_uid always sets the inode
> > uid to -1.
> 
> Right, the initialization of the filesystem is quite early.
> 
> 
> > I don't see this because my setup for everything is triggered off
> > the first use of the IMA namespace.  You'd need to have some type
> > of lazy setup of the inodes as well to give unshare time to install
> > the uid/gidmappings.
> 
> What could trigger that? A callback while mounting - but I am not
> sure where to hook into then. What is your mechanisms to trigger as
> the 'first use of the IMA namespace'? What is 'use' here?

use for me is first event that gets logged in the new namespace.

However, I don't think this is a good trigger, it's just a random thing
I was playing with.  Perhaps trigger on mount is a good one ... that
could be done from securityfs_ns_init_fs_context?

James




