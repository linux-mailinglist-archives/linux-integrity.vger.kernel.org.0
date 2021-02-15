Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD1231C3AD
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 22:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBOVfb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 16:35:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229652AbhBOVfa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 16:35:30 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FLWkgC151283;
        Mon, 15 Feb 2021 16:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=EtYhEByWEWQgIibHhbeegrXgRIy0mefOYeZ80CEwiyw=;
 b=sNfaT+ix3tDtWIhUzm0Tm755PpnGjYI/OyYxaEDvDG2xHE16lXSr9e1I3mDBlud9/CMz
 pr7tAP2obY8qfz2JEO3Lx6sszx5zsYUr8pdX9NzV4gAOedzhioMJghzeOJ4Sw+ML/qIk
 a34dWPQp1CYLdksdWgHeqzCBAP+gTJDpai9xSp9X52oF8LKtHfREgnJ+tduUlQdeaKD4
 AYet3n1DgxjQH7zIR4wEvSGar3DUyi77f//SdHTdAcA1x2mgnHQ8FIfqQsuT79NxWLHS
 52FosH6Zjm3tGFqXO+Yz0x2Gr0vtZE/8iMIVnYarLrUAlA8Iy59MLE20UHmXgOsYYhCT qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36r0p9gd5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:34:15 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FLWrqm151495;
        Mon, 15 Feb 2021 16:34:14 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36r0p9gd53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:34:14 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FLXimA029202;
        Mon, 15 Feb 2021 21:34:13 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 36p6d8sung-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 21:34:13 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FLYCrx16122186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 21:34:12 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74A4EC6059;
        Mon, 15 Feb 2021 21:34:12 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAEB1C6057;
        Mon, 15 Feb 2021 21:34:04 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.173.121])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Feb 2021 21:34:04 +0000 (GMT)
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
 <20210213161049.6190-3-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org, joe@perches.com,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v18 02/11] arm64: Rename kexec elf_headers_mem to
 elf_load_addr
In-reply-to: <20210213161049.6190-3-nramas@linux.microsoft.com>
Date:   Mon, 15 Feb 2021 18:34:02 -0300
Message-ID: <8735xxrp6d.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150160
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> The architecture specific field, elf_headers_mem in struct kimage_arch,
> that holds the address of the buffer in memory for ELF core header for
> arm64 has a different name than the one used for powerpc.  This makes
> it hard to have a common code for setting up the device tree for
> kexec system call.
>
> Rename elf_headers_mem to elf_load_addr to align with powerpc name so
> common code can use it.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/arm64/include/asm/kexec.h         | 2 +-
>  arch/arm64/kernel/machine_kexec_file.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
