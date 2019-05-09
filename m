Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC3B718D2E
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2019 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfEIPmq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 May 2019 11:42:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726659AbfEIPmq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 May 2019 11:42:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49FdJu1047491
        for <linux-integrity@vger.kernel.org>; Thu, 9 May 2019 11:42:45 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2scnahdgbh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 09 May 2019 11:42:36 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 9 May 2019 16:42:30 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 May 2019 16:42:25 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x49FgOKc61472792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 May 2019 15:42:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83835A4040;
        Thu,  9 May 2019 15:42:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32B28A4055;
        Thu,  9 May 2019 15:42:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.107])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 May 2019 15:42:22 +0000 (GMT)
Subject: Re: [PATCH v10 01/12] MODSIGN: Export module signature definitions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date:   Thu, 09 May 2019 11:42:08 -0400
In-Reply-To: <20190418035120.2354-2-bauerman@linux.ibm.com>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
         <20190418035120.2354-2-bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050915-0008-0000-0000-000002E4F703
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050915-0009-0000-0000-000022517E40
Message-Id: <1557416528.10635.62.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090090
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
> IMA will use the module_signature format for append signatures, so export
> the relevant definitions and factor out the code which verifies that the
> appended signature trailer is valid.
> 
> Also, create a CONFIG_MODULE_SIG_FORMAT option so that IMA can select it
> and be able to use mod_check_sig() without having to depend on either
> CONFIG_MODULE_SIG or CONFIG_MODULES.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Jessica Yu <jeyu@kernel.org>

Just a couple minor questions/comments below.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---

< snip >


> diff --git a/init/Kconfig b/init/Kconfig
> index 4592bf7997c0..a71019553ee1 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1906,7 +1906,7 @@ config MODULE_SRCVERSION_ALL
>  config MODULE_SIG
>  	bool "Module signature verification"
>  	depends on MODULES
> -	select SYSTEM_DATA_VERIFICATION
> +	select MODULE_SIG_FORMAT
>  	help
>  	  Check modules for valid signatures upon load: the signature
>  	  is simply appended to the module. For more information see
> @@ -2036,6 +2036,10 @@ config TRIM_UNUSED_KSYMS
>  
>  endif # MODULES
>  
> +config MODULE_SIG_FORMAT
> +	def_bool n
> +	select SYSTEM_DATA_VERIFICATION

Normally Kconfigs, in the same file, are defined before they are used.
 I'm not sure if that is required or just a convention.


>  config MODULES_TREE_LOOKUP
>  	def_bool y
>  	depends on PERF_EVENTS || TRACING
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 6c57e78817da..d2f2488f80ab 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -57,6 +57,7 @@ endif
>  obj-$(CONFIG_UID16) += uid16.o
>  obj-$(CONFIG_MODULES) += module.o
>  obj-$(CONFIG_MODULE_SIG) += module_signing.o
> +obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
>  obj-$(CONFIG_KALLSYMS) += kallsyms.o
>  obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
>  obj-$(CONFIG_CRASH_CORE) += crash_core.o
> diff --git a/kernel/module.c b/kernel/module.c
> index 985caa467aef..326ddeb364dd 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -19,6 +19,7 @@
>  #include <linux/export.h>
>  #include <linux/extable.h>
>  #include <linux/moduleloader.h>
> +#include <linux/module_signature.h>
>  #include <linux/trace_events.h>
>  #include <linux/init.h>
>  #include <linux/kallsyms.h>
> diff --git a/kernel/module_signature.c b/kernel/module_signature.c
> new file mode 100644
> index 000000000000..6d5e59f27f55
> --- /dev/null
> +++ b/kernel/module_signature.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Module signature checker
> + *
> + * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/printk.h>
> +#include <linux/module_signature.h>
> +#include <asm/byteorder.h>
> +
> +/**
> + * mod_check_sig - check that the given signature is sane
> + *
> + * @ms:		Signature to check.
> + * @file_len:	Size of the file to which @ms is appended.

"name" is missing.

Mimi

> + */

