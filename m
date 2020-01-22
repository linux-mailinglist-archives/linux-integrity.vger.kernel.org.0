Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20EA1449F2
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jan 2020 03:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAVCjf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jan 2020 21:39:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727141AbgAVCjf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jan 2020 21:39:35 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00M2bGkq068277
        for <linux-integrity@vger.kernel.org>; Tue, 21 Jan 2020 21:39:34 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xp0s7h9sw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 21 Jan 2020 21:39:33 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 22 Jan 2020 02:39:32 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Jan 2020 02:39:29 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00M2dSiO62914734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jan 2020 02:39:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 261C142042;
        Wed, 22 Jan 2020 02:39:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70AEA4203F;
        Wed, 22 Jan 2020 02:39:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.198.160])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jan 2020 02:39:27 +0000 (GMT)
Subject: Re: [PATCH] IMA: Use delayed work to free queued keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Jan 2020 21:39:26 -0500
In-Reply-To: <20200121172829.15152-1-nramas@linux.microsoft.com>
References: <20200121172829.15152-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012202-4275-0000-0000-00000399C202
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012202-4276-0000-0000-000038ADCBDD
Message-Id: <1579660766.5182.7.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=2 mlxlogscore=999 phishscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001220019
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lackshmi,

In the subject line and the patch description please refer to the
construct as "delayed workqueue" or even abbreviated as "delayed wq",
even though the struct itself is named "delayed_work.

On Tue, 2020-01-21 at 09:28 -0800, Lakshmi Ramasubramanian wrote:
> A timer is used to free queued keys if a custom IMA policy is not

^to free the queued keys,

> loaded within 5 minutes after IMA subsystem is initialized. Timer

^after the IMA subsystem
^The timer handler

> handler is called in interrupt context. Due to this a spinlock has
> to be used to synchronize access to critical section. A mutex cannot
> be used since a mutex can sleep.
> 
> This patch uses a delayed work to free queued keys. Since a delayed
> work handler is called in process context a mutex can be used.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Fixes: 8f5d2d06f217 ("IMA: Defined timer to free queued keys")

Thank you.  This is definitely better.

Mimi

> ---
>  security/integrity/ima/ima_asymmetric_keys.c | 33 ++++++++++----------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index 381f51708e7b..fa1bdd54a9ff 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -11,7 +11,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/timer.h>
> +#include <linux/workqueue.h>
>  #include <keys/asymmetric-type.h>
>  #include "ima.h"
>  
> @@ -24,37 +24,37 @@ static bool ima_process_keys;
>  /*
>   * To synchronize access to the list of keys that need to be measured
>   */
> -static DEFINE_SPINLOCK(ima_keys_lock);
> +static DEFINE_MUTEX(ima_keys_lock);
>  static LIST_HEAD(ima_keys);
>  
>  /*
>   * If custom IMA policy is not loaded then keys queued up
> - * for measurement should be freed. This timer is used
> + * for measurement should be freed. This worker is used
>   * for handling this scenario.
>   */
>  static long ima_key_queue_timeout = 300000; /* 5 Minutes */
> -static struct timer_list ima_key_queue_timer;
> +static void ima_keys_handler(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(ima_keys_delayed_work, ima_keys_handler);
>  static bool timer_expired;
>  
>  /*
> - * This timer callback function frees keys that may still be
> + * This worker function frees keys that may still be
>   * queued up in case custom IMA policy was not loaded.
>   */
> -static void ima_timer_handler(struct timer_list *timer)
> +static void ima_keys_handler(struct work_struct *work)
>  {
>  	timer_expired = true;
>  	ima_process_queued_keys();
>  }
>  
>  /*
> - * This function sets up a timer to free queued keys in case
> + * This function sets up a worker to free queued keys in case
>   * custom IMA policy was never loaded.
>   */
>  void ima_init_key_queue(void)
>  {
> -	timer_setup(&ima_key_queue_timer, ima_timer_handler, 0);
> -	mod_timer(&ima_key_queue_timer,
> -		  jiffies + msecs_to_jiffies(ima_key_queue_timeout));
> +	schedule_delayed_work(&ima_keys_delayed_work,
> +			      msecs_to_jiffies(ima_key_queue_timeout));
>  }
>  
>  static void ima_free_key_entry(struct ima_key_entry *entry)
> @@ -103,18 +103,17 @@ static bool ima_queue_key(struct key *keyring, const void *payload,
>  {
>  	bool queued = false;
>  	struct ima_key_entry *entry;
> -	unsigned long flags;
>  
>  	entry = ima_alloc_key_entry(keyring, payload, payload_len);
>  	if (!entry)
>  		return false;
>  
> -	spin_lock_irqsave(&ima_keys_lock, flags);
> +	mutex_lock(&ima_keys_lock);
>  	if (!ima_process_keys) {
>  		list_add_tail(&entry->list, &ima_keys);
>  		queued = true;
>  	}
> -	spin_unlock_irqrestore(&ima_keys_lock, flags);
> +	mutex_unlock(&ima_keys_lock);
>  
>  	if (!queued)
>  		ima_free_key_entry(entry);
> @@ -132,7 +131,6 @@ void ima_process_queued_keys(void)
>  {
>  	struct ima_key_entry *entry, *tmp;
>  	bool process = false;
> -	unsigned long flags;
>  
>  	if (ima_process_keys)
>  		return;
> @@ -143,17 +141,18 @@ void ima_process_queued_keys(void)
>  	 * First one setting the ima_process_keys flag to true will
>  	 * process the queued keys.
>  	 */
> -	spin_lock_irqsave(&ima_keys_lock, flags);
> +	mutex_lock(&ima_keys_lock);
>  	if (!ima_process_keys) {
>  		ima_process_keys = true;
>  		process = true;
>  	}
> -	spin_unlock_irqrestore(&ima_keys_lock, flags);
> +	mutex_unlock(&ima_keys_lock);
>  
>  	if (!process)
>  		return;
>  
> -	del_timer(&ima_key_queue_timer);
> +	if (!timer_expired)
> +		cancel_delayed_work_sync(&ima_keys_delayed_work);
>  
>  	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
>  		if (!timer_expired)

