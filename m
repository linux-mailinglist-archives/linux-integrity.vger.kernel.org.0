Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBB92E10BE
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 01:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgLWAVP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 19:21:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18558 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbgLWAVP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 19:21:15 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BN03Fmk096601;
        Tue, 22 Dec 2020 19:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=FA2R8FGvQ3oXchyFVhZ2m1CpE/JjhFLNqwf7Z3lLGd0=;
 b=hZBp4GWpZYI2WLl/i6sooWsjPoIe5ZIq+DuynO1BlrlwZINRIzdrb8YrzUMySmtG2NEB
 ClruhVb7xGswuRd4DdrArPygpCwTOBXtlaqGRd0PAHs7M3fsFcf3IjCoBhe5rAhLTNny
 6msSf6oDxBzmCMLe2hhOCnSDZr9Mhv5650uVwMzAEf0t6IXErx7D+88Ol8tEgSYElf65
 vxCL6mpQfiI8iil3gO2xtJFpsCq49swqo83nuB0buCoNKXF7zyY3BTcJM9vvXShJXlj3
 pjd7TpDkvPHAOnhZgpEXQT4iAwBpw8yxUHO0O/luUbxNzi/7YgTtUI0Zir41DjJHsHkF +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kty5gaed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 19:19:55 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BN03P9S097316;
        Tue, 22 Dec 2020 19:19:55 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kty5gae7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 19:19:55 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BN0CM3I025995;
        Wed, 23 Dec 2020 00:19:54 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 35km4gteqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 00:19:53 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BN0JqQg24642004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 00:19:52 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65727C6055;
        Wed, 23 Dec 2020 00:19:52 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AB3CC605A;
        Wed, 23 Dec 2020 00:19:43 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.219.136])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Dec 2020 00:19:43 +0000 (GMT)
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
 <20201219175713.18888-3-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v13 2/6] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
In-reply-to: <20201219175713.18888-3-nramas@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 21:19:41 -0300
Message-ID: <87blell6g2.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_13:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220175
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> The functions defined in "arch/powerpc/kexec/ima.c" handle setting up
> and freeing the resources required to carry over the IMA measurement
> list from the current kernel to the next kernel across kexec system call.
> These functions do not have architecture specific code, but are
> currently limited to powerpc.
>
> Move setup_ima_buffer() call into of_kexec_setup_new_fdt() defined in
> "drivers/of/kexec.c".
>
> Move the remaining architecture independent functions from
> "arch/powerpc/kexec/ima.c" to "drivers/of/kexec.c".
> Delete "arch/powerpc/kexec/ima.c" and "arch/powerpc/include/asm/ima.h".
> Remove references to the deleted files in powerpc and in ima.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/ima.h     |  27 ----
>  arch/powerpc/kexec/Makefile        |   7 -
>  arch/powerpc/kexec/file_load.c     |   7 -
>  arch/powerpc/kexec/ima.c           | 202 -------------------------
>  drivers/of/kexec.c                 | 235 +++++++++++++++++++++++++++++
>  include/linux/of.h                 |   2 +
>  security/integrity/ima/ima.h       |   4 -
>  security/integrity/ima/ima_kexec.c |   1 +
>  8 files changed, 238 insertions(+), 247 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/ima.h
>  delete mode 100644 arch/powerpc/kexec/ima.c

This looks good, provided the changes from the discussion with Mimi are
made. Also, minor nits below.

> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 6ebefec616e4..7c3947ad3773 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -24,10 +24,6 @@
>  
>  #include "../integrity.h"
>  
> -#ifdef CONFIG_HAVE_IMA_KEXEC
> -#include <asm/ima.h>
> -#endif
> -
>  enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
>  		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
>  enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };

This belongs in patch 1.

> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 38bcd7543e27..8a6712981dee 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -10,6 +10,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kexec.h>
> +#include <linux/of.h>
>  #include <linux/ima.h>
>  #include "ima.h"

This include isn't necessary.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
