Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116C7405A19
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhIIPVn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 11:21:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233473AbhIIPVk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 11:21:40 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189F3FHX048023;
        Thu, 9 Sep 2021 11:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=lpgD5vGEmIaRlhyfMXPRmGy9zj9rf8ajeuGtr4XPduY=;
 b=bw8f8en2UXaRxE+/+5vgFZJpeYlXD97XTnewnEK1ERTUvBPn0vx8hd4hQc6EmdtFYEJO
 goSChKyGUg1DjUSqKfglO3yL2gYJ7Y/d+veQJEgrSTR3Y4Y6IgRr1vjL/xP3EMQA/zgV
 SaI2JC0qovKkpX6alJpljFXapg6MfqJNJH+Jo8xLr349dZWrsM5GrhMwZ0nY72gxjVjh
 4tkJV96edNg/P/PwUd77fYDbi+Apok4MRhaPkRIphmEf/EzHw6w7sxTo/OWa1YwXNiZh
 mWwwh7UdqlPou6l7eav8NpGdslgSRNAVL+rSLJIhjwo2c7BZZhDNyS7xrit/lJOviA9p oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ayhwr5jqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 11:19:55 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 189F4CKI052407;
        Thu, 9 Sep 2021 11:19:54 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ayhwr5jpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 11:19:54 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 189FIEn0025560;
        Thu, 9 Sep 2021 15:19:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3axcnkew6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 15:19:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 189FFTKS14156272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 15:15:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97F1D4204D;
        Thu,  9 Sep 2021 15:19:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE4B842041;
        Thu,  9 Sep 2021 15:19:44 +0000 (GMT)
Received: from sig-9-65-72-231.ibm.com (unknown [9.65.72.231])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Sep 2021 15:19:44 +0000 (GMT)
Message-ID: <02024a370f3180e5a6668282e5843ab58bf2a073.camel@linux.ibm.com>
Subject: Re: [PATCH v5 01/12] integrity: Introduce a Linux keyring called
 machine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Thu, 09 Sep 2021 11:19:43 -0400
In-Reply-To: <20210907160110.2699645-2-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <20210907160110.2699645-2-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wspITacEcQ5vvoXOSzWgB8P8y2gYDHE7
X-Proofpoint-ORIG-GUID: TI866xkV7-3Gg1LO0soUIQh1MMBaIjNY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_05:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090093
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-09-07 at 12:00 -0400, Eric Snowberg wrote:
> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
> Boot DB and MOK keys to validate the next step in the boot chain.  The
> MOK facility can be used to import user generated keys.  These keys can
> be used to sign an end-users development kernel build.  When Linux
> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
> .platform keyring.
> 
> Add a new Linux keyring called machine.  This keyring shall contain just

^Define

> MOK CA keys and not the remaining keys in the platform keyring. This new
> machine keyring will be used in follow on patches.  Unlike keys in the
> platform keyring, keys contained in the machine keyring will be trusted
> within the kernel if the end-user has chosen to do so.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v1: Initial version
> v2: Removed destory keyring code
> v3: Unmodified from v2
> v4: Add Kconfig, merged in "integrity: add add_to_mok_keyring" 
> v5: Rename to machine keyring
> ---
>  security/integrity/Kconfig                    | 11 +++++
>  security/integrity/Makefile                   |  1 +
>  security/integrity/digsig.c                   |  1 +
>  security/integrity/integrity.h                | 12 +++++-
>  .../platform_certs/machine_keyring.c          | 42 +++++++++++++++++++
>  5 files changed, 66 insertions(+), 1 deletion(-)
>  create mode 100644 security/integrity/platform_certs/machine_keyring.c
> 
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 71f0177e8716..52193b86768a 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -62,6 +62,17 @@ config INTEGRITY_PLATFORM_KEYRING
>           provided by the platform for verifying the kexec'ed kerned image
>           and, possibly, the initramfs signature.
>  
> +config INTEGRITY_MACHINE_KEYRING
> +	bool "Provide a keyring to which CA Machine Owner Keys may be added"
> +	depends on SECONDARY_TRUSTED_KEYRING
> +	depends on INTEGRITY_ASYMMETRIC_KEYS
> +	depends on SYSTEM_BLACKLIST_KEYRING
> +	help
> +	 If set, provide a keyring to which CA Machine Owner Keys (MOK) may
> +	 be added. This keyring shall contain just CA MOK keys.  Unlike keys
> +	 in the platform keyring, keys contained in the .machine keyring will
> +	 be trusted within the kernel.

No sense in creating the ".machine" keyring, unless it is possible to
safely load CA certificates on it.  At least for the time being, this
should also be dependent on EFI.

<snip>

> +++ b/security/integrity/platform_certs/machine_keyring.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Machine keyring routines.
> + *
> + * Copyright (c) 2021, Oracle and/or its affiliates.
> + */
> +
> +#include "../integrity.h"
> +
> +static __init int machine_keyring_init(void)
> +{
> +	int rc;
> +
> +	rc = integrity_init_keyring(INTEGRITY_KEYRING_MACHINE);
> +	if (rc)
> +		return rc;
> +
> +	pr_notice("Machine keyring initialized\n");
> +	return 0;
> +}
> +device_initcall(machine_keyring_init);
> +
> +void __init add_to_machine_keyring(const char *source, const void *data, size_t len)
> +{
> +	key_perm_t perm;
> +	int rc;
> +
> +	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
> +	rc = integrity_load_cert(INTEGRITY_KEYRING_MACHINE, source, data, len, perm);
> +
> +	/*
> +	 * Some MOKList keys may not pass the machine keyring restrictions.
> +	 * If the restriction check does not pass and the platform keyring
> +	 * is configured, try to add it into that keyring instead.
> +	 */
> +	if (rc)

In addition to the comment, also test to see if the ".platform" keyring
is configured.

thanks,

Mimi

> +		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
> +					 data, len, perm);
> +
> +	if (rc)
> +		pr_info("Error adding keys to machine keyring %s\n", source);
> +}


