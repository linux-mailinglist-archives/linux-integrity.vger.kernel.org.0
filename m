Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6AB1F7E0A
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jun 2020 22:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFLUYA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 16:24:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgFLUYA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 16:24:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CJaJ11142959;
        Fri, 12 Jun 2020 16:23:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31mg0v96wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 16:23:58 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05CKLMwq178341;
        Fri, 12 Jun 2020 16:23:57 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31mg0v96vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 16:23:57 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05CKLTIr027621;
        Fri, 12 Jun 2020 20:23:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 31g2s83w5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 20:23:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05CKMacX64160150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 20:22:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33B3452050;
        Fri, 12 Jun 2020 20:23:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.133.187])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4D0675204F;
        Fri, 12 Jun 2020 20:23:52 +0000 (GMT)
Message-ID: <1591993431.11061.116.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] IMA: Add audit log for failure conditions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        sgrubb@redhat.com, paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Date:   Fri, 12 Jun 2020 16:23:51 -0400
In-Reply-To: <20200611000400.3771-2-nramas@linux.microsoft.com>
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
         <20200611000400.3771-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_23:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 cotscore=-2147483648 malwarescore=0 phishscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110174
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

I haven't yet tested the patch.  Below are a couple of comments.

On Wed, 2020-06-10 at 17:04 -0700, Lakshmi Ramasubramanian wrote:
> The final log statement in process_buffer_measurement() for failure
> condition is at debug level. This does not log the message unless
> the system log level is raised which would significantly increase
> the messages in the system log. Change this to an audit message to
> audit integrity failures with the "op" field of the audit message
> set to indicate the measurement operation that failed.

The problem with the existing "pr" level is kind of irrelevant.   You
could keep the existing pr_debug() statement, if you wanted to.  The
reason for auditing a failure is because it is "integrity" relevant or
more generically "security" relevant.  The first patch addresses the
change in the audit message format.

> 
> Also, add an audit message for failures in ima_alloc_key_entry().
> 
> Sample audit messages:
> 
> [    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=kernel
> op=measuring_kexec_cmdline cause=alloc_entry errno=-12
> comm="swapper/0" name="kexec-cmdline" res=0
> 
> [    8.017126] audit: type=1804 audit(1591756725.360:10): pid=1
> uid=0 auid=4294967295 ses=4294967295
> subj=system_u:system_r:init_t:s0 op=measuring_key
> cause=hashing_error errno=-22 comm="systemd"
> name=".builtin_trusted_keys" res=0
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima.h            | 48 ++++++++++++++++---------
>  security/integrity/ima/ima_main.c       | 18 +++++++---
>  security/integrity/ima/ima_policy.c     |  2 +-
>  security/integrity/ima/ima_queue_keys.c |  5 +++
>  4 files changed, 51 insertions(+), 22 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index df93ac258e01..e42101eebd69 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -186,27 +186,43 @@ static inline unsigned int ima_hash_key(u8 *digest)
>  	return (digest[0] | digest[1] << 8) % IMA_MEASURE_HTABLE_SIZE;
>  }
>  
> -#define __ima_hooks(hook)		\
> -	hook(NONE)			\
> -	hook(FILE_CHECK)		\
> -	hook(MMAP_CHECK)		\
> -	hook(BPRM_CHECK)		\
> -	hook(CREDS_CHECK)		\
> -	hook(POST_SETATTR)		\
> -	hook(MODULE_CHECK)		\
> -	hook(FIRMWARE_CHECK)		\
> -	hook(KEXEC_KERNEL_CHECK)	\
> -	hook(KEXEC_INITRAMFS_CHECK)	\
> -	hook(POLICY_CHECK)		\
> -	hook(KEXEC_CMDLINE)		\
> -	hook(KEY_CHECK)			\
> -	hook(MAX_CHECK)
> -#define __ima_hook_enumify(ENUM)	ENUM,
> +#define __ima_hooks(hook)				\
> +	hook(NONE, none)				\
> +	hook(FILE_CHECK, file)				\
> +	hook(MMAP_CHECK, mmap)				\
> +	hook(BPRM_CHECK, bprm)				\
> +	hook(CREDS_CHECK, creds)			\
> +	hook(POST_SETATTR, post_setattr)		\
> +	hook(MODULE_CHECK, module)			\
> +	hook(FIRMWARE_CHECK, firmware)			\
> +	hook(KEXEC_KERNEL_CHECK, kexec_kernel)		\
> +	hook(KEXEC_INITRAMFS_CHECK, kexec_initramfs)	\
> +	hook(POLICY_CHECK, policy)			\
> +	hook(KEXEC_CMDLINE, kexec_cmdline)		\
> +	hook(KEY_CHECK, key)				\
> +	hook(MAX_CHECK, none)
> +
> +#define __ima_hook_enumify(ENUM, str)	ENUM,
> +#define __ima_stringify(arg) (#arg)
> +#define __ima_hook_measuring_stringify(ENUM, str) \
> +		(__ima_stringify(measuring_ ##str)),
>  
>  enum ima_hooks {
>  	__ima_hooks(__ima_hook_enumify)
>  };
>  
> +static const char * const ima_hooks_measure_str[] = {
> +	__ima_hooks(__ima_hook_measuring_stringify)
> +};
> +
> +static inline const char *ima_hooks_func_measure_str(enum ima_hooks func)

"ima_hooks_func_measure_str" is a bit long.  There's no reason for
having both "hooks" and "func" in the name.  Also this is a static
function, so it doesn't really need to be prefixed with "ima_".  Maybe
truncate it to "func_measure_str()", similar to "func_token".

Mimi

> +{
> +	if (func >= MAX_CHECK)
> +		return ima_hooks_measure_str[NONE];
> +
> +	return ima_hooks_measure_str[func];
> +}
> +
>  extern const char *const func_tokens[];

