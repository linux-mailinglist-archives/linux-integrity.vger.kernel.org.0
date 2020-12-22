Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07EB2E0FF6
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Dec 2020 22:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgLVV5K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 16:57:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbgLVV5K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 16:57:10 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BMLfxX9136729;
        Tue, 22 Dec 2020 16:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=FAc1IQmdafHY9AKekQNsVmVp6hRooYpZU9GsWSMzLKI=;
 b=ZS2aXl5pKqKvZqjgR2J76L0P9n0DYw43FLf4LdIEnT7u7CSE752ZYpeQUkBmNXAc0xnG
 15wmdYpycAat6n6/NIrP3IcWuZSaH7irSkUAy20siWiR81a9sWOjy7tOpsRLKr15HH1Z
 ERin9eS++SV46pSTMrUZtxSuzr0MslirdmfShrufauhWM3lJqaWELKyTIAg//IhkJAuQ
 sRNqrRefR09QkIdnLiTKMpjoY0jMHAyRE9fpO5T9WWhUfzkjYQDLlkkJnutBzq74ZvZU
 S0OjWkp5etkyWwKUSxMw2RGmv8UViT7ik4jXEKIZ/kZQOr4oIIjWFh3+9N2IbhtTRw6S GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35krxj07a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 16:55:59 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BMLtPHQ180183;
        Tue, 22 Dec 2020 16:55:58 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35krxj079v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 16:55:58 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMLbZwQ008813;
        Tue, 22 Dec 2020 21:55:57 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 35kh8etxg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 21:55:57 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMLtuSG21561846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 21:55:56 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CE2CC6059;
        Tue, 22 Dec 2020 21:55:56 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09829C6057;
        Tue, 22 Dec 2020 21:55:48 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.219.136])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Dec 2020 21:55:48 +0000 (GMT)
References: <20201211221006.1052453-1-robh@kernel.org>
 <20201211221006.1052453-5-robh@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        takahiro.akashi@linaro.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, zohar@linux.ibm.com,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [RFC PATCH 4/4] powerpc: Use common of_kexec_setup_new_fdt()
In-reply-to: <20201211221006.1052453-5-robh@kernel.org>
Date:   Tue, 22 Dec 2020 18:55:46 -0300
Message-ID: <87h7odld3x.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_11:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012220153
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Rob Herring <robh@kernel.org> writes:

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>
> After the IMA changes, delete_fdt_mem_rsv() can also be removed.
>
>  arch/powerpc/kexec/file_load.c | 125 ++-------------------------------
>  1 file changed, 6 insertions(+), 119 deletions(-)

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Shouldn't this series also be Cc'd to the linuxppc-dev mailing list?

I just noticed that the ARM64 IMA kexec series hasn't been copying the
linuxppc-dev mailing list, so perhaps this is why this series isn't
doing that, either.

> diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
> index e452b11df631..956bcb2d1ec2 100644
> --- a/arch/powerpc/kexec/file_load.c
> +++ b/arch/powerpc/kexec/file_load.c
> @@ -16,6 +16,7 @@
>
>  #include <linux/slab.h>
>  #include <linux/kexec.h>
> +#include <linux/of.h>
>  #include <linux/of_fdt.h>
>  #include <linux/libfdt.h>
>  #include <asm/setup.h>

It's possible to remove the <linux/of_fdt.h> include now.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
