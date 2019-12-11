Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B1711A097
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 02:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLKBkj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 20:40:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727332AbfLKBki (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 20:40:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB1aart029312
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 20:40:37 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtdp3ntca-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 20:40:37 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 11 Dec 2019 01:40:35 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Dec 2019 01:40:31 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBB1dmil37749236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 01:39:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63141A404D;
        Wed, 11 Dec 2019 01:40:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2179CA4040;
        Wed, 11 Dec 2019 01:40:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.214.111])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Dec 2019 01:40:29 +0000 (GMT)
Subject: Re: [PATCH v1 2/2] IMA: Call workqueue functions to measure queued
 keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 10 Dec 2019 20:40:28 -0500
In-Reply-To: <20191206012936.2814-3-nramas@linux.microsoft.com>
References: <20191206012936.2814-1-nramas@linux.microsoft.com>
         <20191206012936.2814-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121101-4275-0000-0000-0000038DC884
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121101-4276-0000-0000-000038A17B60
Message-Id: <1576028428.4579.78.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_08:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110013
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-05 at 17:29 -0800, Lakshmi Ramasubramanian wrote:
> Measuring keys requires a custom IMA policy to be loaded.
> Keys should be queued for measurement if a custom IMA policy
> is not yet loaded. Keys queued for measurement, if any, should be
> processed when a custom IMA policy is loaded.
> 
> This patch updates the IMA hook function ima_post_key_create_or_update()
> to queue the key if a custom IMA policy has not yet been loaded.
> And, ima_update_policy() function, which is called when
> a custom IMA policy is loaded, is updated to process queued keys.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_asymmetric_keys.c | 9 +++++++++
>  security/integrity/ima/ima_policy.c          | 6 ++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index fbdbe9c261cb..510b29d17a7b 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -155,6 +155,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  				   const void *payload, size_t payload_len,
>  				   unsigned long flags, bool create)
>  {
> +	bool key_queued = false;
> +
>  	/* Only asymmetric keys are handled by this hook. */
>  	if (key->type != &key_type_asymmetric)
>  		return;
> @@ -162,6 +164,13 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  	if (!payload || (payload_len == 0))
>  		return;
>  
> +	if (!ima_process_keys_for_measurement)
> +		key_queued = ima_queue_key_for_measurement(keyring, payload,
> +							   payload_len);
> +
> +	if (key_queued)
> +		return;
> +
>  	/*
>  	 * keyring->description points to the name of the keyring
>  	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 73030a69d546..4dc8fb9957ac 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -808,6 +808,12 @@ void ima_update_policy(void)
>  		kfree(arch_policy_entry);
>  	}
>  	ima_update_policy_flag();
> +
> +	/*
> +	 * Custom IMA policies have been setup.

^has been loaded.

> +	 * Process key(s) queued up for measurement now.

The function name ima_process_queued_keys_for_measurement() provides a
clear indication that the keys will be processed.  We don't comment
the obvious.  Please remove the above comment.

Mimi

> +	 */
> +	ima_process_queued_keys_for_measurement();
>  }
>  
>  /* Keep the enumeration in sync with the policy_tokens! */

