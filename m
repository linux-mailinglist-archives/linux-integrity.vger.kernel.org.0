Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0CA2160410
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Feb 2020 13:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgBPMlB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 Feb 2020 07:41:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36425 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728009AbgBPMlB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Feb 2020 07:41:01 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01GCYmZi127425
        for <linux-integrity@vger.kernel.org>; Sun, 16 Feb 2020 07:41:00 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1fc4ft-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 16 Feb 2020 07:40:59 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 16 Feb 2020 12:40:57 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 16 Feb 2020 12:40:54 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01GCerp441746562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Feb 2020 12:40:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E4FEAE04D;
        Sun, 16 Feb 2020 12:40:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E86BAE051;
        Sun, 16 Feb 2020 12:40:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.138.53])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Feb 2020 12:40:52 +0000 (GMT)
Subject: Re: [PATCH v4 3/3] IMA: Remove duplicate pr_fmt definitions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 16 Feb 2020 07:40:51 -0500
In-Reply-To: <20200215014709.3006-4-tusharsu@linux.microsoft.com>
References: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
         <20200215014709.3006-4-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021612-0020-0000-0000-000003AA9E7C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021612-0021-0000-0000-0000220291FF
Message-Id: <1581856851.8515.169.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-16_02:2020-02-14,2020-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002160115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-02-14 at 17:47 -0800, Tushar Sugandhi wrote:
> The #define for formatting log messages, pr_fmt, is duplicated in the
> files under security/integrity.
> 
> This change moves the definition to security/integrity/integrity.h and
> removes the duplicate definitions in the other files under
> security/integrity.

A number of files under security/integrity, "pr_fmt" was not defined.
 As a result of this patch, messages in those files did change.
 Please include in this patch description a list of the updated
messages.  This includes messages in iint.c and under integrity/evm.

thanks,

Mimi

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Joe Perches <joe@perches.com>
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  security/integrity/digsig.c                  | 2 --
>  security/integrity/digsig_asymmetric.c       | 2 --
>  security/integrity/evm/evm_crypto.c          | 2 --
>  security/integrity/evm/evm_main.c            | 2 --
>  security/integrity/evm/evm_secfs.c           | 2 --
>  security/integrity/ima/ima_asymmetric_keys.c | 2 --
>  security/integrity/ima/ima_crypto.c          | 2 --
>  security/integrity/ima/ima_fs.c              | 2 --
>  security/integrity/ima/ima_init.c            | 2 --
>  security/integrity/ima/ima_kexec.c           | 1 -
>  security/integrity/ima/ima_main.c            | 2 --
>  security/integrity/ima/ima_policy.c          | 2 --
>  security/integrity/ima/ima_queue.c           | 2 --
>  security/integrity/ima/ima_queue_keys.c      | 2 --
>  security/integrity/ima/ima_template.c        | 2 --
>  security/integrity/ima/ima_template_lib.c    | 2 --
>  security/integrity/integrity.h               | 6 ++++++
>  17 files changed, 6 insertions(+), 31 deletions(-)
> 
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index ea1aae3d07b3..e9cbadade74b 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -6,8 +6,6 @@
>   * Dmitry Kasatkin <dmitry.kasatkin@intel.com>
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/err.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
> index 55aec161d0e1..4e0d6778277e 100644
> --- a/security/integrity/digsig_asymmetric.c
> +++ b/security/integrity/digsig_asymmetric.c
> @@ -6,8 +6,6 @@
>   * Dmitry Kasatkin <dmitry.kasatkin@intel.com>
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/err.h>
>  #include <linux/ratelimit.h>
>  #include <linux/key-type.h>
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index d485f6fc908e..35682852ddea 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -10,8 +10,6 @@
>   *	 Using root's kernel master key (kmk), calculate the HMAC
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/export.h>
>  #include <linux/crypto.h>
>  #include <linux/xattr.h>
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index f9a81b187fae..d361d7fdafc4 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -11,8 +11,6 @@
>   *	evm_inode_removexattr, and evm_verifyxattr
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/init.h>
>  #include <linux/crypto.h>
>  #include <linux/audit.h>
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index c11c1f7b3ddd..39ad1038d45d 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -10,8 +10,6 @@
>   *	- Get the key and enable EVM
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/audit.h>
>  #include <linux/uaccess.h>
>  #include <linux/init.h>
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index 7678f0e3e84d..aaae80c4e376 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -9,8 +9,6 @@
>   *       create or update.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <keys/asymmetric-type.h>
>  #include "ima.h"
>  
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index 7967a6904851..423c84f95a14 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -10,8 +10,6 @@
>   *	Calculates md5/sha1 file hash, template hash, boot-aggreate hash
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/kernel.h>
>  #include <linux/moduleparam.h>
>  #include <linux/ratelimit.h>
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 2000e8df0301..a71e822a6e92 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -12,8 +12,6 @@
>   *	current measurement list and IMA statistics
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/fcntl.h>
>  #include <linux/slab.h>
>  #include <linux/init.h>
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 195cb4079b2b..567468188a61 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -11,8 +11,6 @@
>   *             initialization and cleanup functions
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/init.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 9e94eca48b89..121de3e04af2 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -6,7 +6,6 @@
>   * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>   * Mimi Zohar <zohar@linux.vnet.ibm.com>
>   */
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index aac1c44fb11b..9d0abedeae77 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -15,8 +15,6 @@
>   *	and ima_file_check.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/module.h>
>  #include <linux/file.h>
>  #include <linux/binfmts.h>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 453427048999..c334e0dc6083 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -7,8 +7,6 @@
>   *	- initialize default measure policy rules
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/fs.h>
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 1ce8b1701566..8753212ddb18 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -15,8 +15,6 @@
>   *       ever removed or changed during the boot-cycle.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/rculist.h>
>  #include <linux/slab.h>
>  #include "ima.h"
> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> index c87c72299191..cb3e3f501593 100644
> --- a/security/integrity/ima/ima_queue_keys.c
> +++ b/security/integrity/ima/ima_queue_keys.c
> @@ -8,8 +8,6 @@
>   *       Enables deferred processing of keys
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/workqueue.h>
>  #include <keys/asymmetric-type.h>
>  #include "ima.h"
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index 6aa6408603e3..062d9ad49afb 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -9,8 +9,6 @@
>   *      Helpers to manage template descriptors.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/rculist.h>
>  #include "ima.h"
>  #include "ima_template_lib.h"
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 32ae05d88257..9cd1e50f3ccc 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -9,8 +9,6 @@
>   *      Library of supported template fields.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include "ima_template_lib.h"
>  
>  static bool ima_template_hash_algo_allowed(u8 algo)
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 73fc286834d7..298b73794d8b 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -6,6 +6,12 @@
>   * Mimi Zohar <zohar@us.ibm.com>
>   */
>  
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/types.h>
>  #include <linux/integrity.h>
>  #include <crypto/sha.h>

