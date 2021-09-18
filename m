Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C50410865
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Sep 2021 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbhIRTin (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 18 Sep 2021 15:38:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45538 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237817AbhIRTim (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 18 Sep 2021 15:38:42 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18IFxfQx018003;
        Sat, 18 Sep 2021 15:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hxxXatR13ZPSWSACiX+1YgmweHCK2i101mpW0hfwPSA=;
 b=m9njVA98/xXxiJJYB6mkqD+7apxJC/oz+OtDsD4BlYPVDcwM1NZ4zWjd/nSsMqzaxcZc
 /yQwWZxuvrVbOhgZTq+CD9yOi9Iaxw0GTHv5S5SjmKiBNINMKxZrCi+O1Q/V8+m/0gxq
 1LUWQWqAmhvx29smeuopvQFlwzXnBNzdl0pjLrugUe9ivxQnoEjB7480QRrhwae0Xz3O
 DgomMlBZR9wPazgzUEP5aCjKTjeM9MzBKxYcpFJoMN1Fj9jTHJV1Kt/3xCc3cDGiOD53
 7K/FCw3OJklH5yMWNPSq8PoaqR7JNLT3WWeuiXt52w4hc8k8nj+kTx0js9Z29SwOG3zO XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b5k88ab8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 15:37:11 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18IJTjgf040875;
        Sat, 18 Sep 2021 15:37:10 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b5k88ab87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 15:37:10 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18IJY1aX006587;
        Sat, 18 Sep 2021 19:37:09 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3b57r91v47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 19:37:09 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18IJb8Dg40239502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 19:37:08 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CA9E136053;
        Sat, 18 Sep 2021 19:37:08 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EDE3136051;
        Sat, 18 Sep 2021 19:37:07 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.163.30.115])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 18 Sep 2021 19:37:06 +0000 (GMT)
Subject: Re: [PATCH v2] integrity: support including firmware ".platform" keys
 at build time
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com,
        seth.forshee@canonical.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20210916125756.89908-1-nayna@linux.ibm.com>
 <8b8678505d4fe299a2f3a82133d81f41b2c527b7.camel@kernel.org>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <be4bd13d-659d-710d-08b9-1a34a65e5c5d@linux.vnet.ibm.com>
Date:   Sat, 18 Sep 2021 15:37:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8b8678505d4fe299a2f3a82133d81f41b2c527b7.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q_9ujqswEIKWVjirp7cyaP7LUag-FqgE
X-Proofpoint-ORIG-GUID: PKUdliW24YKs2KQkCGRo2VWAiqQCa6lj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-18_07,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109180137
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 9/16/21 10:46 AM, Jarkko Sakkinen wrote:
> On Thu, 2021-09-16 at 08:57 -0400, Nayna Jain wrote:
>> Some firmware support secureboot by embedding static keys to verify the
>> Linux kernel during boot. However, these firmware do not expose an
>> interface for the kernel to load firmware keys onto ".platform" keyring.
>> This would prevent kernel signature verification on kexec. For those
>> environments, allow firmware keys to be compiled into the kernel and
>> loaded onto the ".platform" keyring.
> "allow" means absolutely nothing. Just tell what your patch does,
> and approach taken. Already the patch description should roughly
> give idea what and why of code changes. There's nothing here.
>
>> Reported-by: kernel test robot <lkp@intel.com>
> I don't get this reported-by here.
>
>> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
>> ---
>>
>> v2:
>> * Fixed the error reported by kernel test robot
>> * Updated patch description based on Jarkko's feedback.
>>
>>   certs/Makefile                                |  3 ++-
>>   certs/blacklist.c                             |  1 -
>>   certs/common.c                                |  2 +-
>>   certs/common.h                                |  9 -------
>>   certs/system_keyring.c                        |  1 -
>>   include/keys/system_keyring.h                 |  3 +++
>>   security/integrity/Kconfig                    | 10 +++++++
>>   security/integrity/Makefile                   | 17 +++++++++++-
>>   security/integrity/digsig.c                   |  2 +-
>>   security/integrity/integrity.h                |  6 +++++
>>   .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
>>   .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
>>   12 files changed, 88 insertions(+), 15 deletions(-)
>>   delete mode 100644 certs/common.h
>>   create mode 100644 security/integrity/platform_certs/platform_cert.S
>>
>> diff --git a/certs/Makefile b/certs/Makefile
>> index 279433783b10..64ee37f38b85 100644
>> --- a/certs/Makefile
>> +++ b/certs/Makefile
>> @@ -3,7 +3,8 @@
>>   # Makefile for the linux kernel signature checking certificates.
>>   #
>>   
>> -obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o common.o
>> +obj-$(CONFIG_KEYS) += common.o
>> +obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o
>>   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
>>   obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
>>   ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),"")
>> diff --git a/certs/blacklist.c b/certs/blacklist.c
>> index c9a435b15af4..b95e9b19c42f 100644
>> --- a/certs/blacklist.c
>> +++ b/certs/blacklist.c
>> @@ -17,7 +17,6 @@
>>   #include <linux/uidgid.h>
>>   #include <keys/system_keyring.h>
>>   #include "blacklist.h"
>> -#include "common.h"
>>   
>>   static struct key *blacklist_keyring;
>>   
>> diff --git a/certs/common.c b/certs/common.c
>> index 16a220887a53..41f763415a00 100644
>> --- a/certs/common.c
>> +++ b/certs/common.c
>> @@ -2,7 +2,7 @@
>>   
>>   #include <linux/kernel.h>
>>   #include <linux/key.h>
>> -#include "common.h"
> Why this include is removed?
>
> You should include to your commit message *also* the approach
> you are taking. If you export a function, you should mention
> it explicitly.

Thanks Jarrko for the review.

Do you think it would be better to split this patch into two ?

Patch 1: Export load_certificate_list() to be called outside certs/

Patch 2: Add and load compiled-in certificates in ".platform" keyring.

Thanks & Regards,

     - Nayna


