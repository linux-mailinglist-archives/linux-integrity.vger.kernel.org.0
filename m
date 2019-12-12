Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8611C704
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 09:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfLLITO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 03:19:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728202AbfLLITN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 03:19:13 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC8CDhD105362
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2019 03:19:12 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsrdr4n32-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2019 03:19:12 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 12 Dec 2019 08:19:10 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Dec 2019 08:19:06 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBC8INZR36176334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 08:18:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87C24AE051;
        Thu, 12 Dec 2019 08:19:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FDCAAE053;
        Thu, 12 Dec 2019 08:19:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.137.139])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Dec 2019 08:19:04 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] IMA: Define workqueue for early boot "key"
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Thu, 12 Dec 2019 03:19:03 -0500
In-Reply-To: <20191211185116.2740-2-nramas@linux.microsoft.com>
References: <20191211185116.2740-1-nramas@linux.microsoft.com>
         <20191211185116.2740-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121208-4275-0000-0000-0000038E2C42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121208-4276-0000-0000-000038A1E422
Message-Id: <1576138743.4579.147.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_01:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=2 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120057
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-11 at 10:51 -0800, Lakshmi Ramasubramanian wrote:
> Measuring keys requires a custom IMA policy to be loaded.
> Keys created or updated before a custom IMA policy is loaded should
> be queued and the keys should be processed after a custom policy
> is loaded.
> 
> This patch defines workqueue for queuing keys when a custom IMA policy
> has not yet been loaded.
> 
> A flag namely ima_process_keys is used to check if the key should be
> queued or should be processed immediately.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h                 |  15 +++
>  security/integrity/ima/ima_asymmetric_keys.c | 110 +++++++++++++++++++
>  2 files changed, 125 insertions(+)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index f06238e41a7c..97f8a4078483 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -205,6 +205,21 @@ extern const char *const func_tokens[];
>  
>  struct modsig;
>  
> +#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +/*
> + * To track keys that need to be measured.
> + */
> +struct ima_key_entry {
> +	struct list_head list;
> +	void *payload;
> +	size_t payload_len;
> +	char *keyring_name;
> +};
> +void ima_process_queued_keys(void);
> +#else
> +static inline void ima_process_queued_keys(void) {}
> +#endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
> +
>  /* LIM API function definitions */
>  int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
>  		   int mask, enum ima_hooks func, int *pcr,
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index fea2e7dd3b09..ba01e04ec025 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -14,6 +14,116 @@
>  #include <keys/asymmetric-type.h>
>  #include "ima.h"
>  
> +/*
> + * Flag to indicate whether a key can be processed
> + * right away or should be queued for processing later.
> + */
> +bool ima_process_keys;
> +
> +/*
> + * To synchronize access to the list of keys that need to be measured
> + */
> +static DEFINE_MUTEX(ima_keys_mutex);
> +static LIST_HEAD(ima_keys);
> +
> +static void ima_free_key_entry(struct ima_key_entry *entry)
> +{
> +	if (entry) {
> +		kfree(entry->payload);
> +		kfree(entry->keyring_name);
> +		kfree(entry);
> +	}
> +}
> +
> +static struct ima_key_entry *ima_alloc_key_entry(
> +	struct key *keyring,
> +	const void *payload, size_t payload_len)
> +{
> +	int rc = 0;
> +	struct ima_key_entry *entry;
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (entry) {
> +		entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
> +		entry->keyring_name = kstrdup(keyring->description,
> +					      GFP_KERNEL);
> +		entry->payload_len = payload_len;
> +	}
> +
> +	if ((entry == NULL) || (entry->payload == NULL) ||
> +	    (entry->keyring_name == NULL)) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	INIT_LIST_HEAD(&entry->list);
> +
> +out:
> +	if (rc) {
> +		ima_free_key_entry(entry);
> +		entry = NULL;
> +	}
> +
> +	return entry;
> +}
> +
> +bool ima_queue_key(struct key *keyring, const void *payload,
> +		   size_t payload_len)
> +{
> +	bool queued = false;
> +	struct ima_key_entry *entry;
> +
> +	entry = ima_alloc_key_entry(keyring, payload, payload_len);
> +	if (!entry)
> +		return false;
> +
> +	mutex_lock(&ima_keys_mutex);
> +	if (!ima_process_keys) {
> +		list_add_tail(&entry->list, &ima_keys);
> +		queued = true;
> +	}
> +	mutex_unlock(&ima_keys_mutex);
> +
> +	if (!queued)
> +		ima_free_key_entry(entry);
> +
> +	return queued;
> +}
> +
> +/*
> + * ima_process_queued_keys() - process keys queued for measurement
> + *
> + * This function sets ima_process_keys to true and processes queued keys.
> + * From here on keys will be processed right away (not queued).
> + */
> +void ima_process_queued_keys(void)
> +{
> +	struct ima_key_entry *entry, *tmp;
> +	LIST_HEAD(temp_ima_keys);
> +
> +	if (ima_process_keys)
> +		return;
> +
> +	ima_process_keys = true;
> +
> +	INIT_LIST_HEAD(&temp_ima_keys);
> +
> +	mutex_lock(&ima_keys_mutex);
> +
> +	list_for_each_entry_safe(entry, tmp, &ima_keys, list)
> +		list_move_tail(&entry->list, &temp_ima_keys);
> +
> +	mutex_unlock(&ima_keys_mutex);


The v1 comment, which explained the need for using a temporary
keyring, is an example of an informative comment.  If you don't
object, instead of re-posting this patch, I can insert it.

Mimi

> +
> +	list_for_each_entry_safe(entry, tmp, &temp_ima_keys, list) {
> +		process_buffer_measurement(entry->payload, entry->payload_len,
> +					   entry->keyring_name, KEY_CHECK, 0,
> +					   entry->keyring_name);
> +		list_del(&entry->list);
> +		ima_free_key_entry(entry);
> +	}
> +}
> +
>  /**
>   * ima_post_key_create_or_update - measure asymmetric keys
>   * @keyring: keyring to which the key is linked to

