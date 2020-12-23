Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C22E10DD
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 01:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgLWAt3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 19:49:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbgLWAt2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 19:49:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BN0Ur45131527;
        Tue, 22 Dec 2020 19:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=yX4u3TsiaR+dHf00AtWdm0Ob3ShwkyqY8C7skDPUdcA=;
 b=qUw3gybXeFmDLxDw4i6e/VMbb+Y/SHAmLoBDxukwTqfoE/2A+JfoVBACdKmdqW7kI4PG
 tNgcwsU/slF95EkTCEbWreP9DqX/P5cGXMOAVG9GRiEVDq+SRudXDohBpJsA4OJvWTDK
 kVYfgnI2HzCIs5eGWzlpuIGEQbimrZRmxvZlS7t6OQEYYwPxhCaacQGpW4zwRRD6jVG7
 evems8n0cbU0HCmlPTF2HlRqe2p3iisuKgRJR5QUkgNloVFt+BOJu+6AW7R0XyL2v0mp
 ySgeev2hCAZGmFgxknVwOkFVp3BBNv3iov65LVUGuemoiIBMDcu1dEyi0WesbFK7ofnK yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35ku9wrd38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 19:48:16 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BN0mFps195475;
        Tue, 22 Dec 2020 19:48:16 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35ku9wrd2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 19:48:15 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BN0jFD4005772;
        Wed, 23 Dec 2020 00:48:14 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 35km4gtka9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 00:48:14 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BN0mBnN26935638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 00:48:11 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50123BE054;
        Wed, 23 Dec 2020 00:48:11 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BDA3BE051;
        Wed, 23 Dec 2020 00:48:04 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.219.136])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Dec 2020 00:48:03 +0000 (GMT)
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
Date:   Tue, 22 Dec 2020 21:48:02 -0300
Message-ID: <875z4tl54t.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_13:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220175
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Actually, I have one more comment on this patch:

Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
> index 956bcb2d1ec2..9f3ec0b239ef 100644
> --- a/arch/powerpc/kexec/file_load.c
> +++ b/arch/powerpc/kexec/file_load.c
> @@ -20,7 +20,6 @@
>  #include <linux/of_fdt.h>
>  #include <linux/libfdt.h>
>  #include <asm/setup.h>
> -#include <asm/ima.h>
>  
>  #define SLAVE_CODE_SIZE		256	/* First 0x100 bytes */
>  
> @@ -163,12 +162,6 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
>  	if (ret)
>  		goto err;
>  
> -	ret = setup_ima_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
> -	if (ret) {
> -		pr_err("Error setting up the new device tree.\n");
> -		return ret;
> -	}
> -
>  	return 0;
>  
>  err:

With this change, setup_new_fdt() is nothing more than a call to
of_kexec_setup_new_fdt(). It should be removed, and its caller should
call of_kexec_setup_new_fdt() directly.

This change could be done in patch 4 of this series, to keep this patch
simpler.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
