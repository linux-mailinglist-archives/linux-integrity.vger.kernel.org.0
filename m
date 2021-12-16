Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F0D4768D9
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 04:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhLPDxt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 22:53:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233429AbhLPDxt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 22:53:49 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG2anlZ023412;
        Thu, 16 Dec 2021 03:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Biu7Dla4iXeNIwuQAlBBrzK1AiPQVo5tAHAVQkn3vZY=;
 b=bm2iXyRwafFUUxRmICsOR4Caq5PNs5cgkbOdH1uuSeyYOQmDXFnEhH10vUahMDSPxkru
 o5AXYoyCczGwImwkM94ELun544srk5dmP1ZdhruuSeD7N96BNl9RFEnHNRsOrLLmCZSI
 yiTK/ZfP/qQqvPKZV/4sUZUrBddS7vupKsu5gzabSNYXrvX3QEAEnOkRqfEVUzYHbObz
 y1xJ4abyzsMTpeY/GVuLV/AJwYyeplB9wY5Qto7IiBEqbMByLiFoO1K4jsREF6G5Jv+0
 pb2KpmR22YLmBodtHugfrjVeMfVy3Pp/3kEcXBGjg0JOL679OK8ptNpxhUnus5uyhzMU Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cy2tqegm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 03:53:35 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG3eZ3x013227;
        Thu, 16 Dec 2021 03:53:35 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cy2tqegkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 03:53:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG3ksfr004984;
        Thu, 16 Dec 2021 03:53:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3cy7jr2kdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 03:53:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG3jS9x49414526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 03:45:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E1BCA4060;
        Thu, 16 Dec 2021 03:53:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E76D7A405F;
        Thu, 16 Dec 2021 03:53:26 +0000 (GMT)
Received: from sig-9-65-74-182.ibm.com (unknown [9.65.74.182])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 03:53:26 +0000 (GMT)
Message-ID: <7cd23e2c058752a97f04c23a4a5243a3471e2cd6.camel@linux.ibm.com>
Subject: Re: [PATCH v6 02/17] ima: Define ns_status for storing namespaced
 iint data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Date:   Wed, 15 Dec 2021 22:53:26 -0500
In-Reply-To: <29381ebc-0bf7-59c5-6d16-16958e2dfcb1@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
         <20211210194736.1538863-3-stefanb@linux.ibm.com>
         <7586b43739f121041b294d9bea60bf9b1bd71f7c.camel@linux.ibm.com>
         <29381ebc-0bf7-59c5-6d16-16958e2dfcb1@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TW7sgdOL6d5GYIKJ3rGKUTLpaiwDnybB
X-Proofpoint-ORIG-GUID: i7nUz84qBMLmyS42mDxtLKSMWo1ExXLN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 mlxlogscore=996 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160018
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-12-15 at 21:37 -0500, Stefan Berger wrote:
> On 12/15/21 16:12, Mimi Zohar wrote:
> > Hi Stefan,
> >
> > On Fri, 2021-12-10 at 14:47 -0500, Stefan Berger wrote:
> >> From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
> >>
> >> This patch adds an rbtree to the IMA namespace structure that stores a
> >> namespaced version of iint->flags in ns_status struct. Similar to the
> >> integrity_iint_cache, both the iint ns_struct are looked up using the
> >> inode pointer value. The lookup, allocate, and insertion code is also
> >> similar, except ns_struct is not free'd when the inode is free'd.
> >> Instead, the lookup verifies the i_ino and i_generation fields are also a
> >> match.
> >>
> >> Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Again, hopefully it isn't premature for generic comments:
> >
> > - Function/inline comments would be appreciated, especially when the
> > code differs from the original code.  Example below.
> >
> >> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> >> index f820686baf9f..08781a44f7bf 100644
> >> --- a/security/integrity/ima/ima_init_ima_ns.c
> >> +++ b/security/integrity/ima/ima_init_ima_ns.c
> >> @@ -14,11 +14,18 @@
> >>   #include <linux/user_namespace.h>
> >>   #include <linux/ima.h>
> >>   #include <linux/proc_ns.h>
> >> +#include <linux/slab.h>
> >>   
> >>   #include "ima.h"
> >>   
> >>   int ima_init_namespace(struct ima_namespace *ns)
> >>   {
> >> +	ns->ns_status_tree = RB_ROOT;
> >> +	rwlock_init(&ns->ns_status_lock);
> >> +	ns->ns_status_cache = KMEM_CACHE(ns_status, SLAB_PANIC);
> >> +	if (!ns->ns_status_cache)
> >> +		return -ENOMEM;
> >> +
> > For example, using KMEM_CACHE() is probably correct here, at least for
> > now, but it is different than the original code which uses
> > kmem_cache_alloc() with init_once().  Memory cleanup is done on free,

^  kmem_cache_create() with init_once.

> > before it is re-used.
> 
> KMEM_CACHE + kmem_cache_alloc/zalloc() are pretty common. What kind of 
> comment would be helpful here?

The original reason for using kmem_cache_create() with init_once and
deferring memory cleanup to free was for performance.  Using
KMEM_CACHE() and kmem_cache_zalloc() instead could be for simplicity. 
The comment should note the change.

Mimi

