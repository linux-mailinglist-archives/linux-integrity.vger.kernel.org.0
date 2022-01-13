Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C6F48DEDE
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jan 2022 21:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiAMU1Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jan 2022 15:27:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232562AbiAMU1Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jan 2022 15:27:24 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DJpwAY020538;
        Thu, 13 Jan 2022 20:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=5dWrKAUhgUEBU9SwdPioCU6ft6T7G3y3e0+T9mnYyP4=;
 b=kIZD/WrhvFL2mOL5QB+2Gk4ZlteCvveJNNd1Bdn006MMNqJ2Lz/YnQuSg2xq/zEbAY6D
 jxx+QEKdPh3czAER6Elc6kzbIpIPRiwEJ1bM0FyTQ2ybsVhrkJhWiV1SVtnupwJxxUrm
 10noQgkdbLnAvMaljzPdBHfS68CcvsOnMDvZTEqcSFxtzRjQ6TcH3oRxIgLB4BNu87aZ
 V22Q5usZrteX5LYZD8muQNoe/J742Lb//SDaykT1pXwn1TGTV5BAlh0YfdJryEF8QcTG
 irCbT/xyJb3/qukxeIydHMF7aEBOQ0SBj4vKeE17IfLt4udAryMm6uDTdPOTUdKo4w4/ 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djtm2rt5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:27:01 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20DJqQpo022200;
        Thu, 13 Jan 2022 20:27:00 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djtm2rt4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:27:00 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DK8Rqs012516;
        Thu, 13 Jan 2022 20:26:58 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3df28a85q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:26:57 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DKQs4h23920942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 20:26:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D737F42068;
        Thu, 13 Jan 2022 20:26:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EDC54204D;
        Thu, 13 Jan 2022 20:26:51 +0000 (GMT)
Received: from sig-9-65-68-109.ibm.com (unknown [9.65.68.109])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 20:26:51 +0000 (GMT)
Message-ID: <150cb51f95c3fe54e94edc5b96b2e15edb3bf399.camel@linux.ibm.com>
Subject: Re: [PATCH v8 03/19] ima: Move policy related variables into
 ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 13 Jan 2022 15:26:51 -0500
In-Reply-To: <20220104170416.1923685-4-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
         <20220104170416.1923685-4-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 180RLcFUDhkcHwTM1IEWXECOOOMN0Osl
X-Proofpoint-ORIG-GUID: Fkrfi4gnFQS76AmMXASepKeK8fahk7XZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_09,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Tue, 2022-01-04 at 12:04 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Move variables related to the IMA policy into the ima_namespace. This way
> the IMA policy of an IMA namespace can be set and displayed using a
> front-end like SecurityFS.
> 
> Implement ima_ns_from_file() to get the IMA namespace via the user
> namespace of the SecurityFS superblock that a file belongs to.
> 
> To get the current ima_namespace use get_current_ns() when a function
> that is related to a policy rule is called. In other cases where functions
> are called due file attribute modifications, use init_ima_ns, since these
> functions are related to IMA appraisal and changes to file attributes are
> only relevant to the init_ima_ns until IMA namespaces also support IMA
> appraisal. In ima_file_free() use init_ima_ns since in this case flags
> related to file measurements may be affected, which is not supported in
> IMA namespaces, yet.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Please split this patch into "ima: pass through ima namespace", or some
other name,  and "ima: Move policy related variables into
ima_namespace".  The other option is to combine the "pass through ima
namespace" with the 2nd patch, like Christian's example.

> ---
>  security/integrity/ima/ima.h                 |  49 ++++---
>  security/integrity/ima/ima_api.c             |   8 +-
>  security/integrity/ima/ima_appraise.c        |  28 ++--
>  security/integrity/ima/ima_asymmetric_keys.c |   4 +-
>  security/integrity/ima/ima_fs.c              |  16 ++-
>  security/integrity/ima/ima_init.c            |   8 +-
>  security/integrity/ima/ima_init_ima_ns.c     |   6 +
>  security/integrity/ima/ima_main.c            |  83 +++++++----
>  security/integrity/ima/ima_policy.c          | 142 ++++++++++---------
>  security/integrity/ima/ima_queue_keys.c      |  11 +-
>  10 files changed, 213 insertions(+), 142 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c4af3275f015..0b3dc9425076 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -20,6 +20,7 @@
>  #include <linux/hash.h>
>  #include <linux/tpm.h>
>  #include <linux/audit.h>
> +#include <linux/user_namespace.h>
>  #include <crypto/hash_info.h>
>  
>  #include "../integrity.h"
> @@ -43,9 +44,6 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
>  
>  #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
>  
> -/* current content of the policy */
> -extern int ima_policy_flag;
> -
>  /* bitset of digests algorithms allowed in the setxattr hook */
>  extern atomic_t ima_setxattr_allowed_hash_algorithms;
>  
> @@ -120,6 +118,14 @@ struct ima_kexec_hdr {
>  };
>  
>  struct ima_namespace {
> +	struct list_head ima_default_rules;
> +	/* ns's policy rules */

Thank you for adding comments.  Why is the ima_default_rules not
considered "ns's policy rules"?   Will this come later or is it limited
to init_ima_ns?

> +	struct list_head ima_policy_rules;
> +	struct list_head ima_temp_rules;
> +	/* Pointer to ns's current policy */
> +	struct list_head __rcu *ima_rules;

Since "Pointer to ns's current policy" only refers to ima_rules, append
it to the variable definition.

> +	/* current content of the policy */
> +	int ima_policy_flag;

Similarly here append the comment to the variable definition.

>  } __randomize_layout;
>  extern struct ima_namespace init_ima_ns;

thanks,

Mimi


