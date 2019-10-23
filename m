Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69EA9E1C63
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405795AbfJWNXV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 09:23:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391326AbfJWNXU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 09:23:20 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NDKs2b004563
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 09:23:19 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vtq349uc7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 09:23:19 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 23 Oct 2019 14:23:17 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 14:23:13 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9NDNCu915204484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 13:23:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B962A4065;
        Wed, 23 Oct 2019 13:23:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79CEDA4060;
        Wed, 23 Oct 2019 13:23:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.174])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 13:23:11 +0000 (GMT)
Subject: Re: [PATCH v1 5/6] KEYS: measure queued keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Wed, 23 Oct 2019 09:23:10 -0400
In-Reply-To: <20191023001818.3684-6-nramas@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
         <20191023001818.3684-6-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102313-0016-0000-0000-000002BC2203
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102313-0017-0000-0000-0000331D61EE
Message-Id: <1571836990.5104.96.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230136
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-10-22 at 17:18 -0700, Lakshmi Ramasubramanian wrote:
> Call process_buffer_measurement to measure keys that
> are added and updated in the system.

This patch description doesn't describe what the patch actually does
(eg. it not only calls process_buffer_measurement, but defines the IMA
hook itself.)

The ordering of this patch set is awkward.  It should first introduce
a generic method for measuring keys based on the keyring.  Then add
the additional support needed for the specific builtin_trusted_keys
keyring usecase.

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_main.c  | 23 +++++++++++++++++++++
>  security/integrity/ima/ima_queue.c | 32 ++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 8e965d18fb21..7c2afb954f19 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -678,6 +678,29 @@ void ima_kexec_cmdline(const void *buf, int size)
>  	}
>  }
>  
> +/*
> + * ima_post_key_create_or_update
> + * @keyring points to the keyring to which the key belongs
> + * @key points to the key being created or updated
> + * @cred cred structure
> + * @flags flags passed to key_create_or_update function
> + * @create flag to indicate whether the key was created or updated
> + *
> + * IMA hook called when a new key is created or updated.
> + *
> + * On success return 0.
> + * Return appropriate error code on error
> + */
> +int ima_post_key_create_or_update(struct key *keyring, struct key *key,
> +				  const struct cred *cred,
> +				  unsigned long flags, bool create)
> +{
> +	if (key->type != &key_type_asymmetric)
> +		return 0;
> +
> +	return ima_measure_key(keyring, key);
> +}
> +

Here is the new IMA hook, not "[PATCH v1 3/6] KEYS: ima hook to
measure builtin_trusted_keys".  The new hook should call
process_buffer_measurement() directly.  A subsequent patch, based on
the keyring, would determine if it needs to be queued.

Mimi


>  static int __init init_ima(void)
>  {
>  	int error;
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index a262e289615b..0da11a292f99 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -322,7 +322,12 @@ static struct ima_trusted_key_entry *ima_alloc_trusted_queue_entry(
>  int ima_measure_key(struct key *keyring, struct key *key)
>  {
>  	int rc = 0;
> +	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +	struct ima_template_desc *template_desc = ima_template_desc_current();
> +	int action;
>  	struct ima_trusted_key_entry *entry = NULL;
> +	const struct public_key *pk;
> +	u32 secid;
>  	enum ima_hooks func;
>  	bool queued = false;
>  
> @@ -344,16 +349,43 @@ int ima_measure_key(struct key *keyring, struct key *key)
>  
>  	mutex_unlock(&ima_trusted_keys_mutex);
>  
> +	if ((rc == 0) && !queued) {
> +		security_task_getsecid(current, &secid);
> +		action = ima_get_action(NULL, current_cred(), secid, 0,
> +					func, &pcr, &template_desc);
> +		if (action & IMA_MEASURE) {
> +			pk = key->payload.data[asym_crypto];
> +			process_buffer_measurement(pk->key, pk->keylen,
> +						   key->description,
> +						   pcr, template_desc);
> +		}
> +	}
> +
>  	return rc;
>  }
>  
>  void ima_measure_queued_trusted_keys(void)
>  {
>  	struct ima_trusted_key_entry *entry, *tmp;
> +	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +	struct ima_template_desc *template_desc = ima_template_desc_current();
> +	int action;
> +	u32 secid;
>  
>  	mutex_lock(&ima_trusted_keys_mutex);
>  
>  	list_for_each_entry_safe(entry, tmp, &ima_trusted_keys, list) {
> +		security_task_getsecid(current, &secid);
> +		action = ima_get_action(NULL, current_cred(), secid, 0,
> +					entry->func, &pcr,
> +					&template_desc);
> +		if (action & IMA_MEASURE) {
> +			process_buffer_measurement(entry->public_key,
> +						   entry->public_key_len,
> +						   entry->key_description,
> +						   pcr,
> +						   template_desc);
> +		}
>  		list_del(&entry->list);
>  		ima_free_trusted_key_entry(entry);
>  	}

