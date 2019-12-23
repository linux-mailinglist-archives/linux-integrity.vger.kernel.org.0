Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938FA12988D
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Dec 2019 17:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLWQCz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Dec 2019 11:02:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbfLWQCz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Dec 2019 11:02:55 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFvKi1090184
        for <linux-integrity@vger.kernel.org>; Mon, 23 Dec 2019 11:02:54 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x21kg6w4m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 23 Dec 2019 11:02:53 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 23 Dec 2019 16:02:52 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Dec 2019 16:02:49 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBNG2mlV40435772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 16:02:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 408A542047;
        Mon, 23 Dec 2019 16:02:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E92D142041;
        Mon, 23 Dec 2019 16:02:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.238.12])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Dec 2019 16:02:46 +0000 (GMT)
Subject: Re: [PATCH v1] IMA: Defined timer to free queued keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Mon, 23 Dec 2019 11:02:46 -0500
In-Reply-To: <20191223032454.2797-1-nramas@linux.microsoft.com>
References: <20191223032454.2797-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19122316-0012-0000-0000-000003779FA5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122316-0013-0000-0000-000021B39D1C
Message-Id: <1577116966.5241.116.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_07:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=2
 mlxlogscore=999 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912230135
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2019-12-22 at 19:24 -0800, Lakshmi Ramasubramanian wrote:
> keys queued for measurement should still be processed even if
> a custom IMA policy was not loaded. Otherwise, the keys will
> remain queued forever consuming kernel memory.
> 
> This patch defines a timer to handle the above scenario. The timer
> is setup to expire 5 minutes after IMA initialization is completed.
> 
> If a custom IMA policy is loaded before the timer expires, the timer
> is removed and any queued keys are processed for measurement.
> But if a custom policy was not loaded, on timer expiration
> any queued keys are just freed.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

This patch description, and the comments below, read as though the
queued keys are measured based on policy.  The queued keys should be
removed, not "processed".  Please rewrite this patch description and
update the comments below.

> ---
>  security/integrity/ima/ima.h                 |  2 +
>  security/integrity/ima/ima_asymmetric_keys.c | 46 ++++++++++++++++++--
>  security/integrity/ima/ima_init.c            |  8 +++-
>  3 files changed, 52 insertions(+), 4 deletions(-)
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
> index 4124f10ff0c2..e1c4e1e7d9a1 100644
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
> @@ -26,6 +27,34 @@ static bool ima_process_keys;
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
> +
> +/*
> + * This timer callback function processes keys that may still be
> + * queued up in case custom IMA policy was not loaded.
> + */

"processes keys" implies measuring keys based on policy.  Please
update this and the comment below.

> +static void ima_timer_handler(struct timer_list *timer)
> +{
> +	ima_process_queued_keys();
> +}
> +
> +/*
> + * This function sets up a timer to process queued keys in case
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
> @@ -100,6 +129,7 @@ void ima_process_queued_keys(void)
>  {
>  	struct ima_key_entry *entry, *tmp;
>  	bool process = false;
> +	int timer_removed;
>  
>  	if (ima_process_keys)
>  		return;
> @@ -120,10 +150,20 @@ void ima_process_queued_keys(void)
>  	if (!process)
>  		return;
>  
> +	/*
> +	 * Timer is no longer needed. If the timer was removed
> +	 * (i.e., the timer had not expired) the queued keys are
> +	 * processed for measurement. Else, the keys are just freed.
> +	 */
> +	timer_removed = del_timer(&ima_key_queue_timer);

Interesting, but wouldn't it be simpler to define a static variable
named timer_expired and set it in ima_timer_handler()?  With that
change, the code would be easier to read and this comment would be
superfluous.

Mimi

> +
>  	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
> -		process_buffer_measurement(entry->payload, entry->payload_len,
> -					   entry->keyring_name, KEY_CHECK, 0,
> -					   entry->keyring_name);
> +		if (timer_removed)
> +			process_buffer_measurement(entry->payload,
> +						   entry->payload_len,
> +						   entry->keyring_name,
> +						   KEY_CHECK, 0,
> +						   entry->keyring_name);
>  		list_del(&entry->list);
>  		ima_free_key_entry(entry);
>  	}

