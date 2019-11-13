Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C65BFB96B
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2019 21:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKMUJa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 15:09:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726155AbfKMUJa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 15:09:30 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADK8OrU035080
        for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2019 15:09:29 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w8r91ru6y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2019 15:09:28 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 13 Nov 2019 20:09:27 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Nov 2019 20:09:24 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xADK9Nom41943190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 20:09:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B7B04C04E;
        Wed, 13 Nov 2019 20:09:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12CE84C044;
        Wed, 13 Nov 2019 20:09:22 +0000 (GMT)
Received: from dhcp-9-31-103-201.watson.ibm.com (unknown [9.31.103.201])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Nov 2019 20:09:21 +0000 (GMT)
Subject: Re: [PATCH v6 2/3] IMA: Define an IMA hook to measure keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Nov 2019 15:09:21 -0500
In-Reply-To: <20191113184658.2862-3-nramas@linux.microsoft.com>
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
         <20191113184658.2862-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111320-4275-0000-0000-0000037D7AD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111320-4276-0000-0000-00003890DDFA
Message-Id: <1573675761.4843.13.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911130164
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-13 at 10:46 -0800, Lakshmi Ramasubramanian wrote:
> Measure asymmetric keys used for verifying file signatures,
> certificates, etc.
> 
> This patch defines a new IMA hook namely ima_post_key_create_or_update()
> to measure asymmetric keys.
> 
> Note that currently IMA subsystem can be enabled without
> enabling KEYS subsystem.
> 
> Adding support for measuring asymmetric keys in IMA requires KEYS
> subsystem to be enabled. To handle this dependency a new config
> namely CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS has been added. Enabling
> this config requires the following configs to be enabled:
>     CONFIG_IMA, CONFIG_KEYS, CONFIG_ASYMMETRIC_KEY_TYPE, and
>     CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE.
> 
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is off by default.
> 
> The IMA hook is defined in a new file namely ima_asymmetric_keys.c
> which is built only if CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is enabled.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

All that is is needed is the key and public_key structures, which are
defined in include/linux/keys.h and include/crypto/public_key.h.  If
the keys subsystem is disabled, then the new IMA hook won't be called.
 There's no need for a new Kconfig option or a new file.

Please move the hook to just after ima_kexec_cmdline().

Mimi

> ---
>  security/integrity/ima/Kconfig               | 14 ++++++
>  security/integrity/ima/Makefile              |  1 +
>  security/integrity/ima/ima_asymmetric_keys.c | 51 ++++++++++++++++++++
>  3 files changed, 66 insertions(+)
>  create mode 100644 security/integrity/ima/ima_asymmetric_keys.c
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 838476d780e5..c6d14884bc19 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -310,3 +310,17 @@ config IMA_APPRAISE_SIGNED_INIT
>  	default n
>  	help
>  	   This option requires user-space init to be signed.
> +
> +config IMA_MEASURE_ASYMMETRIC_KEYS
> +	bool "Enable measuring asymmetric keys on key create or update"
> +	depends on IMA
> +	depends on KEYS
> +	depends on ASYMMETRIC_KEY_TYPE
> +	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +	default n
> +	help
> +	   This option enables measuring asymmetric keys when
> +	   the key is created or updated. Additionally, IMA policy
> +	   needs to be configured to either measure keys linked to
> +	   any keyring or only measure keys linked to the keyrings
> +	   specified in the IMA policy through the keyrings= option.
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index 31d57cdf2421..3e9d0ad68c7b 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -12,3 +12,4 @@ ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
>  ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
>  ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>  obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
> +obj-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> new file mode 100644
> index 000000000000..f6884641a622
> --- /dev/null
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Microsoft Corporation
> + *
> + * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
> + *
> + * File: ima_asymmetric_keys.c
> + *       Defines an IMA hook to measure asymmetric keys on key
> + *       create or update.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <crypto/public_key.h>
> +#include <keys/asymmetric-type.h>
> +#include "ima.h"
> +
> +/**
> + * ima_post_key_create_or_update - measure asymmetric keys
> + * @keyring: keyring to which the key is linked to
> + * @key: created or updated key
> + * @flags: key flags
> + * @create: flag indicating whether the key was created or updated
> + *
> + * Keys can only be measured, not appraised.
> + */
> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> +				   unsigned long flags, bool create)
> +{
> +	const struct public_key *pk;
> +
> +	/* Only asymmetric keys are handled by this hook. */
> +	if (key->type != &key_type_asymmetric)
> +		return;
> +
> +	/* Get the public_key of the given asymmetric key to measure. */
> +	pk = key->payload.data[asym_crypto];
> +
> +	/*
> +	 * keyring->description points to the name of the keyring
> +	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
> +	 * which the given key is linked to.
> +	 *
> +	 * The name of the keyring is passed in the "eventname"
> +	 * parameter to process_buffer_measurement() and is set
> +	 * in the "eventname" field in ima_event_data for
> +	 * the key measurement IMA event.
> +	 */
> +	process_buffer_measurement(pk->key, pk->keylen,
> +				   keyring->description, KEY_CHECK, 0);
> +}

