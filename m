Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 257ADEAFD8
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 13:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfJaMKm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 08:10:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbfJaMKm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 08:10:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VCAF9E083775
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2019 08:10:40 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vyv2s7dfr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2019 08:10:39 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Oct 2019 12:10:38 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Oct 2019 12:10:34 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9VC9xXx34668934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 12:09:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0EEE11C05E;
        Thu, 31 Oct 2019 12:10:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0302E11C04C;
        Thu, 31 Oct 2019 12:10:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.194.174])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 12:10:31 +0000 (GMT)
Subject: Re: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key
 create or update
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
Date:   Thu, 31 Oct 2019 08:10:31 -0400
In-Reply-To: <20191031011910.2574-2-nramas@linux.microsoft.com>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
         <20191031011910.2574-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19103112-0016-0000-0000-000002BF7A23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103112-0017-0000-0000-00003320DD7B
Message-Id: <1572523831.5028.43.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-10-30 at 18:19 -0700, Lakshmi Ramasubramanian wrote:
> Asymmetric keys used for verifying file signatures or certificates
> are currently not included in the IMA measurement list.
> 
> This patch defines a new IMA hook namely ima_post_key_create_or_update()
> to measure asymmetric keys.

It's not enough for the kernel to be able to compile the kernel after
applying all the patches in a patch set.  After applying each patch,
the kernel should build properly, otherwise it is not bi-sect safe.
 Refer to "3) Separate your changes" of
"Documentation/process/submitting-patches.rst.
 
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h      |  2 ++
>  security/integrity/ima/ima_main.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 997a57137351..22d0628faf56 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -21,6 +21,8 @@
>  #include <linux/tpm.h>
>  #include <linux/audit.h>
>  #include <crypto/hash_info.h>
> +#include <crypto/public_key.h>
> +#include <keys/asymmetric-type.h>
>  
>  #include "../integrity.h"
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 492b8f241d39..18e1bc105be7 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -635,6 +635,9 @@ void process_buffer_measurement(const void *buf, int size,
>  	int action = 0;
>  	u32 secid;
>  
> +	if (!ima_policy_flag)
> +		return;
> +
>  	if (func) {
>  		security_task_getsecid(current, &secid);
>  		action = ima_get_action(NULL, current_cred(), secid, 0, func,
> @@ -695,6 +698,29 @@ void ima_kexec_cmdline(const void *buf, int size)
>  	}
>  }
>  
> +/**
> + * ima_post_key_create_or_update - measure asymmetric keys
> + * @keyring: keyring to which the key is linked to
> + * @key: created or updated key
> + * @flags: key flags
> + * @create: flag indicating whether the key was created or updated
> + *
> + * Keys can only be measured, not appraised.
> + */
> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> +				   unsigned long flags, bool create)
> +{
> +	const struct public_key *pk;
> +
> +	if (key->type != &key_type_asymmetric)
> +		return;
> +
> +	pk = key->payload.data[asym_crypto];
> +	process_buffer_measurement(pk->key, pk->keylen,
> +				   keyring->description,
> +				   NONE, 0);

This patch should also define the new "func".

Mimi

> +}
> +
>  static int __init init_ima(void)
>  {
>  	int error;

