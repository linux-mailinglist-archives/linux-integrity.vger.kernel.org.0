Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6737F2207
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2019 23:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKFWov (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 17:44:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732411AbfKFWov (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 17:44:51 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6Mgl4U139381
        for <linux-integrity@vger.kernel.org>; Wed, 6 Nov 2019 17:44:50 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w4608tfnc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 06 Nov 2019 17:44:50 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 6 Nov 2019 22:44:48 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Nov 2019 22:44:43 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA6MigNn36372620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Nov 2019 22:44:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2E1AAE068;
        Wed,  6 Nov 2019 22:44:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B01EFAE056;
        Wed,  6 Nov 2019 22:44:41 +0000 (GMT)
Received: from dhcp-9-31-102-173.watson.ibm.com (unknown [9.31.102.173])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Nov 2019 22:44:41 +0000 (GMT)
Subject: Re: [PATCH v4 08/10] IMA: Defined functions to queue and dequeue
 keys for measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Nov 2019 17:44:41 -0500
In-Reply-To: <20191106190116.2578-9-nramas@linux.microsoft.com>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
         <20191106190116.2578-9-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110622-0012-0000-0000-000003615CB3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110622-0013-0000-0000-0000219CBB5F
Message-Id: <1573080281.5028.314.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911060218
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-06 at 11:01 -0800, Lakshmi Ramasubramanian wrote:

> +int ima_queue_or_process_key_for_measurement(struct key *keyring,
> +					     struct key *key)
> +{
> +	int rc = 0;
> +	struct ima_measure_key_entry *entry = NULL;
> +	const struct public_key *pk;
> +
> +	if (key->type != &key_type_asymmetric)
> +		return 0;
> +
> +	mutex_lock(&ima_measure_keys_mutex);

Unless the key is being queued, there's no reason to take the lock. 

> +
> +	if (ima_initialized) {

ima_initialized is being set in ima_init(), before a custom policy is
loaded.  I would think that is too early.  ima_update_policy() is
called after loading a custom policy.  Please see how to detect when a
custom policy is loaded.

> +		/*
> +		 * keyring->description points to the name of the keyring
> +		 * (such as ".builtin_trusted_keys", ".ima", etc.) to
> +		 * which the given key is linked to.
> +		 *
> +		 * The name of the keyring is passed in the "eventname"
> +		 * parameter to process_buffer_measurement() and is set
> +		 * in the "eventname" field in ima_event_data for
> +		 * the key measurement IMA event.
> +		 *
> +		 * The name of the keyring is also passed in the "keyring"
> +		 * parameter to process_buffer_measurement() to check
> +		 * if the IMA policy is configured to measure a key linked
> +		 * to the given keyring.
> +		 */
> +		pk = key->payload.data[asym_crypto];
> +		process_buffer_measurement(pk->key, pk->keylen,
> +					   keyring->description,
> +					   KEYRING_CHECK, 0,
> +					   keyring->description);

Measuring the key should be done in ima_post_key_create_or_update()
unless, it is being deferred.  Please update the function name to
reflect this.

Mimi


> +	} else {
> +		entry = ima_alloc_measure_key_entry(keyring, key);
> +		if (entry != NULL) {
> +			INIT_LIST_HEAD(&entry->list);
> +			list_add_tail(&entry->list, &ima_measure_keys);
> +		} else
> +			rc = -ENOMEM;
> +	}
> +
> +	mutex_unlock(&ima_measure_keys_mutex);
> +
> +	return rc;
> +}

