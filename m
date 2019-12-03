Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9198310F3BD
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2019 01:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfLCACR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 19:02:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725853AbfLCACQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 19:02:16 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB302DsG009777
        for <linux-integrity@vger.kernel.org>; Mon, 2 Dec 2019 19:02:15 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6xau3nw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Dec 2019 19:02:15 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 3 Dec 2019 00:02:13 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 00:02:09 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB3029CR47775858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 00:02:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0616CA4054;
        Tue,  3 Dec 2019 00:02:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5792A405B;
        Tue,  3 Dec 2019 00:02:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.147.107])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 00:02:07 +0000 (GMT)
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Mon, 02 Dec 2019 19:02:07 -0500
In-Reply-To: <20191127025212.3077-2-nramas@linux.microsoft.com>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
         <20191127025212.3077-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120300-0016-0000-0000-000002CFFE06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120300-0017-0000-0000-00003331F4C5
Message-Id: <1575331327.4793.469.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=2 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020206
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Tue, 2019-11-26 at 18:52 -0800, Lakshmi Ramasubramanian wrote:
> Keys created or updated in the system before IMA is initialized
> should be queued up. And, keys (including any queued ones)
> should be processed when IMA initialization is completed.
> 
> This patch defines functions to queue and dequeue keys for
> measurement. A flag namely ima_process_keys_for_measurement
> is used to check if the key should be queued or should be
> processed immediately.
> 
> ima_policy_flag cannot be relied upon to make queuing decision
> because ima_policy_flag will be set to 0 when either IMA is
> not initialized or when the IMA policy itself is empty.

Already commented on the patch description.  Some additional minor
comments below.

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h                 |  15 +++
>  security/integrity/ima/ima_asymmetric_keys.c | 135 ++++++++++++++++++-
>  2 files changed, 146 insertions(+), 4 deletions(-)
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
> index ca895f9a6504..10deb77b22a0 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -14,12 +14,139 @@
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
> +	struct ima_measure_key_entry *entry = NULL;
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (entry) {
> +		entry->payload =
> +			kmemdup(payload, payload_len, GFP_KERNEL);
> +		entry->keyring_name =
> +			kstrdup(keyring->description, GFP_KERNEL);

No need to break up the assignments like this.  Neither line when
joined is greater than 80 bytes.

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
> +	rc = 0;

"rc" was initialized in the declaration.

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
> +	struct ima_measure_key_entry *entry = NULL;

No need to initialize ima_measure_key_entry here, as the first
statement sets it.
> +
> +	entry = ima_alloc_measure_key_entry(keyring, payload, payload_len);
> +	if (entry) {

If we're ignoring failure to allocate memory, why not just return?

> +		/*
> +		 * ima_measure_keys_mutex should be taken before checking
> +		 * ima_process_keys_for_measurement flag to avoid the race
> +		 * condition between the IMA hook checking this flag and
> +		 * calling ima_queue_key_for_measurement() to queue
> +		 * the key and ima_process_queued_keys_for_measurement()
> +		 * setting this flag.
> +		 */
> +		mutex_lock(&ima_measure_keys_mutex);
> +		if (!ima_process_keys_for_measurement) {
> +			list_add_tail(&entry->list, &ima_measure_keys);
> +			queued = true;
> +		}
> +		mutex_unlock(&ima_measure_keys_mutex);
> +
> +		if (!queued)
> +			ima_free_measure_key_entry(entry);
> +	}
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
> +	mutex_lock(&ima_measure_keys_mutex);
> +	list_for_each_entry_safe(entry, tmp, &ima_measure_keys, list) {
> +		list_move_tail(&entry->list, &temp_ima_measure_keys);
> +	}

Parenthesis not needed.

> +	mutex_unlock(&ima_measure_keys_mutex);
> +
> +	list_for_each_entry_safe(entry, tmp,
> +				 &temp_ima_measure_keys, list) {

No need to break up this line either.  The joined line is not greater
than 80 bytes.

> +		process_buffer_measurement(entry->payload,
> +					   entry->payload_len,
> +					   entry->keyring_name,
> +					   KEY_CHECK, 0,
> +					   entry->keyring_name);
> +		list_del(&entry->list);
> +		ima_free_measure_key_entry(entry);
> +	}
> +}
> +

