Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79C02F404F
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 01:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbhALXcV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 18:32:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbhALXcU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 18:32:20 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10CN8lP8015650;
        Tue, 12 Jan 2021 18:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=zcctC6u50OwF40P9bFjCjFt0z0OsHU9Qruu5jchxGwE=;
 b=dD8ekQZ59kLhhue60rAZvCgDsSBvN4X4ek//NHWpNwFEcyNg1DZVpagQC6GcankUgR13
 XOPmPudM5F7XZyzL6WqfmiNB0l4rLQy8rOBvKskGT/5np+uNLeEVhe4IUomqKkNa8HwT
 omckRbVfOEtXnzpQz2uDIWpuC/TLDoA4KGhv1biqnXf7ZBsfLM6J0xRmt4pq9YG6n5C7
 t3RRk60NhbCCGfwkHQQQ9zWtxkzwRxTsx/iX1eRn+tmUAOsDQ8vUwAqSePloX0oFKVFv
 X7ezWDwQYxkahe0N3dau39LUOUf2dXSV1IJRscq7nleLY5UfWSJOY1ULngJCf+LHCuty Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361hj4x2aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 18:31:07 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10CN9neQ022641;
        Tue, 12 Jan 2021 18:31:06 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361hj4x299-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 18:31:06 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10CNRI09010322;
        Tue, 12 Jan 2021 23:31:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 35y447va5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 23:31:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10CNUtAv19136784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 23:30:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 914204203F;
        Tue, 12 Jan 2021 23:31:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A758642047;
        Tue, 12 Jan 2021 23:30:54 +0000 (GMT)
Received: from sig-9-65-221-171.ibm.com (unknown [9.65.221.171])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jan 2021 23:30:54 +0000 (GMT)
Message-ID: <1f7db82ccf8e18306c9b51312b3e1f5d51f85cdb.camel@linux.ibm.com>
Subject: Re: [PATCH v14 4/6] powerpc: Delete unused functions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@vger.kernel.org
Date:   Tue, 12 Jan 2021 18:30:53 -0500
In-Reply-To: <20210104192602.10131-5-nramas@linux.microsoft.com>
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
         <20210104192602.10131-5-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_19:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120132
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Mon, 2021-01-04 at 11:26 -0800, Lakshmi Ramasubramanian wrote:

> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index a05c19b3cc60..3cab318aa3b9 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -17,6 +17,7 @@
>  #include <linux/kexec.h>
>  #include <linux/of_fdt.h>
>  #include <linux/libfdt.h>
> +#include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/memblock.h>
>  #include <linux/slab.h>
> @@ -944,7 +945,8 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>  	struct crash_mem *umem = NULL, *rmem = NULL;
>  	int i, nr_ranges, ret;
>  
> -	ret = setup_new_fdt(image, fdt, initrd_load_addr, initrd_len, cmdline);
> +	ret = of_kexec_setup_new_fdt(image, fdt, initrd_load_addr, initrd_len,
> +				     cmdline);
>  	if (ret)
>  		goto out;
>  

The "powerpc: Move arch independent ima kexec functions to
drivers/of/kexec.c" moved setup_ima_buffer() to
of_kexec_setup_new_fdt().  Defering making the change from
setup_new_fdt() to of_kexec_setup_new_fdt() here, is not bisect safe.

Mimi

