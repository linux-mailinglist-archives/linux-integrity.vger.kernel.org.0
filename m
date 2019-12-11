Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D115411A095
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 02:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfLKBkR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 20:40:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbfLKBkR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 20:40:17 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB1aa2M057021
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 20:40:16 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wt2ethcce-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 20:40:15 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 11 Dec 2019 01:40:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Dec 2019 01:40:09 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBB1e80j47775986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 01:40:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3A335205F;
        Wed, 11 Dec 2019 01:40:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.214.111])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BC27E52051;
        Wed, 11 Dec 2019 01:40:07 +0000 (GMT)
Subject: Re: [PATCH v1 1/2] IMA: Define workqueue for early boot "key"
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 10 Dec 2019 20:40:07 -0500
In-Reply-To: <20191206012936.2814-2-nramas@linux.microsoft.com>
References: <20191206012936.2814-1-nramas@linux.microsoft.com>
         <20191206012936.2814-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121101-0012-0000-0000-00000373A8BB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121101-0013-0000-0000-000021AF7D6E
Message-Id: <1576028407.4579.77.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_08:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 suspectscore=2 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912110013
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-05 at 17:29 -0800, Lakshmi Ramasubramanian wrote:
> Measuring keys requires a custom IMA policy to be loaded.
> Keys created or updated before a custom IMA policy is loaded should
> be queued and the keys should be processed after a custom policy
> is loaded.
> 
> This patch defines workqueue for queuing keys when a custom IMA policy
> has not yet been loaded.
> 
> A flag namely ima_process_keys_for_measurement is used to check
> if the key should be queued or should be processed immediately.
> This flag is set to true when queued keys are processed.
> If this flag is set to true, keys created or updated
> will be measured immediately (not queued).

These last two lines explain how "flags" work.  They're unnecessary.

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h                 |  15 +++
>  security/integrity/ima/ima_asymmetric_keys.c | 125 +++++++++++++++++++
>  2 files changed, 140 insertions(+)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index f06238e41a7c..f86371647707 100644
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
> +struct ima_measure_key_entry {
> +	struct list_head list;
> +	void *payload;
> +	size_t payload_len;
> +	char *keyring_name;
> +};
> +void ima_process_queued_keys_for_measurement(void);
> +#else
> +static inline void ima_process_queued_keys_for_measurement(void) {}
> +#endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
> +
>  /* LIM API function definitions */
>  int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
>  		   int mask, enum ima_hooks func, int *pcr,
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index fea2e7dd3b09..fbdbe9c261cb 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -14,6 +14,131 @@
>  #include <keys/asymmetric-type.h>
>  #include "ima.h"
>  
> +/*
> + * Flag to indicate whether a key can be processed
> + * right away or should be queued for processing later.
> + */
> +bool ima_process_keys_for_measurement;
> +
> +/*
> + * To synchronize access to the list of keys that need to be measured
> + */
> +static DEFINE_MUTEX(ima_measure_keys_mutex);
> +static LIST_HEAD(ima_measure_keys);
> +
> +static void ima_free_measure_key_entry(struct ima_measure_key_entry *entry)
> +{
> +	if (entry) {
> +		kfree(entry->payload);
> +		kfree(entry->keyring_name);
> +		kfree(entry);
> +	}
> +}
> +
> +static struct ima_measure_key_entry *ima_alloc_measure_key_entry(
> +	struct key *keyring,
> +	const void *payload, size_t payload_len)
> +{
> +	int rc = 0;
> +	struct ima_measure_key_entry *entry;
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
> +		ima_free_measure_key_entry(entry);
> +		entry = NULL;
> +	}
> +
> +	return entry;
> +}
> +
> +bool ima_queue_key_for_measurement(struct key *keyring,
> +				   const void *payload, size_t payload_len)
> +{
> +	bool queued = false;
> +	struct ima_measure_key_entry *entry;
> +
> +	entry = ima_alloc_measure_key_entry(keyring, payload, payload_len);
> +	if (!entry)
> +		return false;
> +
> +	/*
> +	 * ima_measure_keys_mutex should be taken before checking
> +	 * ima_process_keys_for_measurement flag to avoid the race
> +	 * condition between the IMA hook checking this flag and
> +	 * calling ima_queue_key_for_measurement() to queue
> +	 * the key and ima_process_queued_keys_for_measurement()
> +	 * setting this flag.
> +	 */
> +	mutex_lock(&ima_measure_keys_mutex);
> +	if (!ima_process_keys_for_measurement) {
> +		list_add_tail(&entry->list, &ima_measure_keys);
> +		queued = true;
> +	}
> +	mutex_unlock(&ima_measure_keys_mutex);
> +
> +	if (!queued)
> +		ima_free_measure_key_entry(entry);
> +
> +	return queued;
> +}
> +
> +void ima_process_queued_keys_for_measurement(void)
> +{
> +	struct ima_measure_key_entry *entry, *tmp;
> +	LIST_HEAD(temp_ima_measure_keys);
> +
> +	if (ima_process_keys_for_measurement)
> +		return;
> +
> +	/*
> +	 * Any queued keys will be processed now. From here on
> +	 * keys should be processed right away.
> +	 */
> +	ima_process_keys_for_measurement = true;

This function and the ima_queue_key_for_measurement() are not
exported, so don't require kernel-doc style comments, but at least
this comment should not be here.  It could be included as part of the
function description at the head of the function.

Remember we don't add code comments needlessly.  Refer to section "8)
Commenting" in Documentation/process/coding-style.rst.

Mimi

> +
> +	/*
> +	 * To avoid holding the mutex when processing queued keys,
> +	 * transfer the queued keys with the mutex held to a temp list,
> +	 * release the mutex, and then process the queued keys from
> +	 * the temp list.
> +	 *
> +	 * Since ima_process_keys_for_measurement is set to true above,
> +	 * any new key will be processed immediately and not be queued.
> +	 */
> +	INIT_LIST_HEAD(&temp_ima_measure_keys);
> +
> +	mutex_lock(&ima_measure_keys_mutex);
> +
> +	list_for_each_entry_safe(entry, tmp, &ima_measure_keys, list)
> +		list_move_tail(&entry->list, &temp_ima_measure_keys);
> +
> +	mutex_unlock(&ima_measure_keys_mutex);
> +
> +	list_for_each_entry_safe(entry, tmp, &temp_ima_measure_keys, list) {
> +		process_buffer_measurement(entry->payload, entry->payload_len,
> +					   entry->keyring_name, KEY_CHECK, 0,
> +					   entry->keyring_name);
> +		list_del(&entry->list);
> +		ima_free_measure_key_entry(entry);
> +	}
> +}
> +
>  /**
>   * ima_post_key_create_or_update - measure asymmetric keys
>   * @keyring: keyring to which the key is linked to

