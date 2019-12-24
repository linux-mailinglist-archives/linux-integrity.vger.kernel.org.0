Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A766312A419
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Dec 2019 21:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfLXUf0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Dec 2019 15:35:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbfLXUf0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Dec 2019 15:35:26 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBOKR32J048959
        for <linux-integrity@vger.kernel.org>; Tue, 24 Dec 2019 15:35:24 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x21wcrrc8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 24 Dec 2019 15:35:24 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 24 Dec 2019 20:35:22 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Dec 2019 20:35:17 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBOKZGoE32571470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Dec 2019 20:35:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D684D11C04A;
        Tue, 24 Dec 2019 20:35:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93B5F11C04C;
        Tue, 24 Dec 2019 20:35:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.204.221])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Dec 2019 20:35:15 +0000 (GMT)
Subject: Re: [PATCH v2] IMA: Defined timer to free queued keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
In-Reply-To: <20191224180114.2772-1-nramas@linux.microsoft.com>
References: <20191224180114.2772-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 24 Dec 2019 15:35:04 -0500
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19122420-0016-0000-0000-000002D7E582
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122420-0017-0000-0000-0000333A3BA6
Message-Id: <1577219704.4487.2.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-24_06:2019-12-24,2019-12-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 mlxscore=0 suspectscore=2 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912240180
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-24 at 10:01 -0800, Lakshmi Ramasubramanian wrote:
> keys queued for measurement should be freed if a custom IMA policy
> was not loaded. Otherwise, the keys will remain queued forever
> consuming kernel memory.
> 
> This patch defines a timer to handle the above scenario. The timer
> is setup to expire 5 minutes after IMA initialization is completed.
> 
> If a custom IMA policy is loaded before the timer expires, the timer
> is removed and any queued keys are processed for measurement.
> But if a custom policy was not loaded, on timer expiration
> queued keys are just freed.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Thanks.  This patch is now queued in next-integrity-testing.

Mimi

> ---
>  security/integrity/ima/ima.h                 |  2 +
>  security/integrity/ima/ima_asymmetric_keys.c | 42 ++++++++++++++++++--
>  security/integrity/ima/ima_init.c            |  8 +++-
>  3 files changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 97f8a4078483..c483215a9ee5 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -216,8 +216,10 @@ struct ima_key_entry {
>  	char *keyring_name;
>  };
>  void ima_process_queued_keys(void);
> +void ima_init_key_queue(void);
>  #else
>  static inline void ima_process_queued_keys(void) {}
> +static inline void ima_init_key_queue(void) {}
>  #endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
>  
>  /* LIM API function definitions */
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index 4124f10ff0c2..9ea2233c911a 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -11,6 +11,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/timer.h>
>  #include <keys/asymmetric-type.h>
>  #include "ima.h"
>  
> @@ -26,6 +27,36 @@ static bool ima_process_keys;
>  static DEFINE_MUTEX(ima_keys_mutex);
>  static LIST_HEAD(ima_keys);
>  
> +/*
> + * If custom IMA policy is not loaded then keys queued up
> + * for measurement should be freed. This timer is used
> + * for handling this scenario.
> + */
> +static long ima_key_queue_timeout = 300000; /* 5 Minutes */
> +static struct timer_list ima_key_queue_timer;
> +static bool timer_expired;
> +
> +/*
> + * This timer callback function frees keys that may still be
> + * queued up in case custom IMA policy was not loaded.
> + */
> +static void ima_timer_handler(struct timer_list *timer)
> +{
> +	timer_expired = true;
> +	ima_process_queued_keys();
> +}
> +
> +/*
> + * This function sets up a timer to free queued keys in case
> + * custom IMA policy was never loaded.
> + */
> +void ima_init_key_queue(void)
> +{
> +	timer_setup(&ima_key_queue_timer, ima_timer_handler, 0);
> +	mod_timer(&ima_key_queue_timer,
> +		  jiffies + msecs_to_jiffies(ima_key_queue_timeout));
> +}
> +
>  static void ima_free_key_entry(struct ima_key_entry *entry)
>  {
>  	if (entry) {
> @@ -120,10 +151,15 @@ void ima_process_queued_keys(void)
>  	if (!process)
>  		return;
>  
> +	del_timer(&ima_key_queue_timer);
> +
>  	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
> -		process_buffer_measurement(entry->payload, entry->payload_len,
> -					   entry->keyring_name, KEY_CHECK, 0,
> -					   entry->keyring_name);
> +		if (!timer_expired)
> +			process_buffer_measurement(entry->payload,
> +						   entry->payload_len,
> +						   entry->keyring_name,
> +						   KEY_CHECK, 0,
> +						   entry->keyring_name);
>  		list_del(&entry->list);
>  		ima_free_key_entry(entry);
>  	}
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 5d55ade5f3b9..195cb4079b2b 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -131,5 +131,11 @@ int __init ima_init(void)
>  
>  	ima_init_policy();
>  
> -	return ima_fs_init();
> +	rc = ima_fs_init();
> +	if (rc != 0)
> +		return rc;
> +
> +	ima_init_key_queue();
> +
> +	return rc;
>  }

