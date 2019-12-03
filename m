Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB4310F3C4
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2019 01:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLCADS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 19:03:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbfLCADS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 19:03:18 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3039oK115890
        for <linux-integrity@vger.kernel.org>; Mon, 2 Dec 2019 19:03:17 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6uyugr5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Dec 2019 19:03:12 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 3 Dec 2019 00:02:39 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 00:02:35 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB302YKW8192114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 00:02:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C79245204E;
        Tue,  3 Dec 2019 00:02:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.147.107])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AE5EF5205A;
        Tue,  3 Dec 2019 00:02:33 +0000 (GMT)
Subject: Re: [PATCH v0 2/2] IMA: Call queue functions to measure keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Mon, 02 Dec 2019 19:02:33 -0500
In-Reply-To: <20191127025212.3077-3-nramas@linux.microsoft.com>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
         <20191127025212.3077-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120300-0016-0000-0000-000002CFFE0B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120300-0017-0000-0000-00003331F4CA
Message-Id: <1575331353.4793.471.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912020206
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Tue, 2019-11-26 at 18:52 -0800, Lakshmi Ramasubramanian wrote:
> Keys should be queued for measurement if custom IMA policies have
> not yet been applied. Keys queued for measurement, if any, need to be
> processed when custom IMA policies have been applied.

Please start with the problem description.  For example, measuring
keys requires loading a custom IMA policy.

> 
> This patch adds the call to ima_queue_key_for_measurement() in
> the IMA hook function if ima_process_keys_for_measurement flag is set
> to false. And, the call to ima_process_queued_keys_for_measurement()
> when custom IMA policies have been applied in ima_update_policy().

This reads like pseudo code.  Please summarize the purpose of this
patch.

> 
> NOTE:
> If the kernel is built with CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> enabled then the IMA policy should be applied as custom IMA policies.
> 
> Keys will be queued up until custom policies are applied and processed
> when custom policies have been applied.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_asymmetric_keys.c | 16 ++++++++++++++++
>  security/integrity/ima/ima_policy.c          | 12 ++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index 10deb77b22a0..adb7a307190f 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -157,6 +157,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  				   const void *payload, size_t payload_len,
>  				   unsigned long flags, bool create)
>  {
> +	bool key_queued = false;
> +
>  	/* Only asymmetric keys are handled by this hook. */
>  	if (key->type != &key_type_asymmetric)
>  		return;
> @@ -164,6 +166,20 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  	if (!payload || (payload_len == 0))
>  		return;
>  
> +	if (!ima_process_keys_for_measurement)
> +		key_queued = ima_queue_key_for_measurement(keyring,
> +							   payload,
> +							   payload_len);
> +
> +	/*
> +	 * Need to check again if the key was queued or not because
> +	 * ima_process_keys_for_measurement could have flipped from
> +	 * false to true after it was checked above, but before the key
> +	 * could be queued by ima_queue_key_for_measurement().
> +	 */

You're describing a race condition.

> +	if (key_queued)
> +		return;
> +
>  	/*
>  	 * keyring->description points to the name of the keyring
>  	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 78b25f083fe1..a2e30a90f97d 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -812,6 +812,18 @@ void ima_update_policy(void)
>  		kfree(arch_policy_entry);
>  	}
>  	ima_update_policy_flag();
> +
> +	/*
> +	 * Custom IMA policies have been setup.
> +	 * Process key(s) queued up for measurement now.
> +	 *
> +	 * NOTE:
> +	 *   Custom IMA policies always overwrite builtin policies
> +	 *   (policies compiled in code). If one wants measurement
> +	 *   of asymmetric keys then it has to be configured in
> +	 *   custom policies and updated here.
> +	 */

The "NOTE" is over commenting the code and belongs in the patch
description.

> +	ima_process_queued_keys_for_measurement();

Overwriting the initial policy is highly recommended, but not everyone
defines a custom policy.  Should there be a time limit or some other
criteria before deleting the key measurement queue?

Mimi

>  }
>  
>  /* Keep the enumeration in sync with the policy_tokens! */

