Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C828476459
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Dec 2021 22:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhLOVMk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 16:12:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229555AbhLOVMj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 16:12:39 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFLAXpf001981;
        Wed, 15 Dec 2021 21:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Nfdowbr6bBG5mw0WiDlIFu0SvbATShOKhAzw/Z+5sv4=;
 b=O+eDTlHvTihou4mNRF6pEkpol9cgrH4Xnpb0GevE/lJJRGnXQwE9IIPg0JMVxaEdZ8fJ
 wUVpN6FUs2omHl6qbwlUHyOSwXbmYWLzj//kRTP1sJjQa5Uhfz765TaKBNOL0Wo+lpVD
 1aPPAmGR7X9/5InaKqCV44m6Jfh53pLn7ZIa/v70ducti1r6sj3nzg3caI30DpWACQwi
 XAvlBPDKsAMRhD6AnRmTYSguuAqP4jCOBrDLqWe1jy0QYo810eVATpKVOS/lnHyejPZq
 EzTuu4A3DVbGGRnrTR9bLW6VUMLJqrWhHVRLLOQBEP4qAVQoyWm4dWb9I+Fgvqu7NU28 kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyr21r16y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 21:12:26 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BFLBGUk007150;
        Wed, 15 Dec 2021 21:12:25 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyr21r16h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 21:12:25 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BFL2q6N026877;
        Wed, 15 Dec 2021 21:12:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3cy78e95sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 21:12:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BFLCKbk46137810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 21:12:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84E1E11C050;
        Wed, 15 Dec 2021 21:12:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F20DF11C04C;
        Wed, 15 Dec 2021 21:12:17 +0000 (GMT)
Received: from sig-9-65-74-182.ibm.com (unknown [9.65.74.182])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Dec 2021 21:12:17 +0000 (GMT)
Message-ID: <7586b43739f121041b294d9bea60bf9b1bd71f7c.camel@linux.ibm.com>
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
Date:   Wed, 15 Dec 2021 16:12:17 -0500
In-Reply-To: <20211210194736.1538863-3-stefanb@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
         <20211210194736.1538863-3-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NjnYum8eRZ0ysdSMiIR9o50UN3qMKZBO
X-Proofpoint-ORIG-GUID: SV9eWpraFtU7B_6JvjpuZWDfUujYXoNg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_12,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150116
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Fri, 2021-12-10 at 14:47 -0500, Stefan Berger wrote:
> From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
> 
> This patch adds an rbtree to the IMA namespace structure that stores a
> namespaced version of iint->flags in ns_status struct. Similar to the
> integrity_iint_cache, both the iint ns_struct are looked up using the
> inode pointer value. The lookup, allocate, and insertion code is also
> similar, except ns_struct is not free'd when the inode is free'd.
> Instead, the lookup verifies the i_ino and i_generation fields are also a
> match.
> 
> Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Again, hopefully it isn't premature for generic comments:

- Function/inline comments would be appreciated, especially when the
code differs from the original code.  Example below.

> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index f820686baf9f..08781a44f7bf 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -14,11 +14,18 @@
>  #include <linux/user_namespace.h>
>  #include <linux/ima.h>
>  #include <linux/proc_ns.h>
> +#include <linux/slab.h>
>  
>  #include "ima.h"
>  
>  int ima_init_namespace(struct ima_namespace *ns)
>  {
> +	ns->ns_status_tree = RB_ROOT;
> +	rwlock_init(&ns->ns_status_lock);
> +	ns->ns_status_cache = KMEM_CACHE(ns_status, SLAB_PANIC);
> +	if (!ns->ns_status_cache)
> +		return -ENOMEM;
> +

For example, using KMEM_CACHE() is probably correct here, at least for
now, but it is different than the original code which uses
kmem_cache_alloc() with init_once().  Memory cleanup is done on free,
before it is re-used.

thanks,

Mimi

>  	return 0;
>  }

