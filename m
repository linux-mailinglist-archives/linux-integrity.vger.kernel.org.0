Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41B047682C
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 03:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhLPChZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 21:37:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229513AbhLPChY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 21:37:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFNdgv1006717;
        Thu, 16 Dec 2021 02:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SIssM00YA41qf3NReiuMQhXG0SzyZ1jV5wtXWr1RJS0=;
 b=TtxIwQa7C1CpUUMcYfA80cPzVHaaYxpCwTogFIEMutTR0IUwF0y6zNLmT36982xj6mvO
 z8OTCVAi/nTkfYEf6hak8kXb7s2FExYWx/BcIkepXtBl9JPDFiV5h/HPhzwnUtzIYb4D
 +A9tkd+QueVLji4IU7n8ymPy+/QNUNGZupLz6WqQA9joe+rZerfizv6IIdMClAVApTVi
 mmO2YANJfwHwLV1jPBExEeQKGhxhV7GaTC80ZWn1QDrGbE36k3umrqTI3KCjFQ+cRZXP
 8j/EjyXdiMtF2Mbc/4MPnHcpmSMydHD0zCv1tPPFGtvX/QwqB9Juo/UECKP7baR5sOUS 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cygmw854r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:37:12 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG2FS6v011541;
        Thu, 16 Dec 2021 02:37:11 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cygmw854n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:37:11 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG2Ynm6008953;
        Thu, 16 Dec 2021 02:37:10 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3cy7e3pgex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:37:10 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG2b94p26149210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 02:37:09 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1669DAC05F;
        Thu, 16 Dec 2021 02:37:09 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E4A3AC062;
        Thu, 16 Dec 2021 02:37:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 02:37:08 +0000 (GMT)
Message-ID: <29381ebc-0bf7-59c5-6d16-16958e2dfcb1@linux.ibm.com>
Date:   Wed, 15 Dec 2021 21:37:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 02/17] ima: Define ns_status for storing namespaced
 iint data
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
 <20211210194736.1538863-3-stefanb@linux.ibm.com>
 <7586b43739f121041b294d9bea60bf9b1bd71f7c.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <7586b43739f121041b294d9bea60bf9b1bd71f7c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NUNVyxg-rY46uoKoWYypekJ-5II7l8Ee
X-Proofpoint-ORIG-GUID: NH_a8Olm-mVyYNMhFfmxnuFIgUCM4qhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_13,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160010
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/15/21 16:12, Mimi Zohar wrote:
> Hi Stefan,
>
> On Fri, 2021-12-10 at 14:47 -0500, Stefan Berger wrote:
>> From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
>>
>> This patch adds an rbtree to the IMA namespace structure that stores a
>> namespaced version of iint->flags in ns_status struct. Similar to the
>> integrity_iint_cache, both the iint ns_struct are looked up using the
>> inode pointer value. The lookup, allocate, and insertion code is also
>> similar, except ns_struct is not free'd when the inode is free'd.
>> Instead, the lookup verifies the i_ino and i_generation fields are also a
>> match.
>>
>> Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Again, hopefully it isn't premature for generic comments:
>
> - Function/inline comments would be appreciated, especially when the
> code differs from the original code.  Example below.
>
>> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
>> index f820686baf9f..08781a44f7bf 100644
>> --- a/security/integrity/ima/ima_init_ima_ns.c
>> +++ b/security/integrity/ima/ima_init_ima_ns.c
>> @@ -14,11 +14,18 @@
>>   #include <linux/user_namespace.h>
>>   #include <linux/ima.h>
>>   #include <linux/proc_ns.h>
>> +#include <linux/slab.h>
>>   
>>   #include "ima.h"
>>   
>>   int ima_init_namespace(struct ima_namespace *ns)
>>   {
>> +	ns->ns_status_tree = RB_ROOT;
>> +	rwlock_init(&ns->ns_status_lock);
>> +	ns->ns_status_cache = KMEM_CACHE(ns_status, SLAB_PANIC);
>> +	if (!ns->ns_status_cache)
>> +		return -ENOMEM;
>> +
> For example, using KMEM_CACHE() is probably correct here, at least for
> now, but it is different than the original code which uses
> kmem_cache_alloc() with init_once().  Memory cleanup is done on free,
> before it is re-used.

KMEM_CACHE + kmem_cache_alloc/zalloc() are pretty common. What kind of 
comment would be helpful here?

    Stefan

>
> thanks,
>
> Mimi
>
>>   	return 0;
>>   }
