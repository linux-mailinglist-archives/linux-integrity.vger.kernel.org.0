Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33418323504
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 02:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhBXBLg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 20:11:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234424AbhBXBJP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 20:09:15 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11O15hMh071159;
        Tue, 23 Feb 2021 20:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=fvB3rzAf+nSMX8mMPWYXXuPAPGObMNYcBPw6HsZjV10=;
 b=rGSWdzTokt+BjuGdJizFgnzR1MUUoSsry6lb6/JGEO8CXx7ysUQgOCdndTPlwulgvslA
 XbCa2ZU8rczINW5MofXTdIZbt0TNxzfAXy2Xn3qHtpkHvgBX6zRxI7dp7O2Omwikhg2u
 EL3fSWqXqdJsHg6kP269tD9FoLHmkGzQoBCcuaEeYkQbf/baY5jcK4mqq7tEn8MtLqbC
 Uc+9g5sX2sr97GZPbDVMVFqykOFvmc+NkRtGSGkdTti5nRwY+WNZvabEHqRPgBFet+yl
 eB0tCN//QH0OGqMHJVO4Oe45AVI4ZV2/DVUPI/q21vcymSS9Z9oYcMLIP6K/+U8bi/Up 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wau9anbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 20:08:02 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11O14WF5062184;
        Tue, 23 Feb 2021 20:08:01 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wau9anb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 20:08:01 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11O180nb032208;
        Wed, 24 Feb 2021 01:08:00 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 36tt29tsmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 01:08:00 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11O17xG727460078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 01:07:59 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 354CC7805C;
        Wed, 24 Feb 2021 01:07:59 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85C9478066;
        Wed, 24 Feb 2021 01:07:50 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.200.35])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Feb 2021 01:07:50 +0000 (GMT)
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
 <20210221174930.27324-4-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org, joe@perches.com,
        catalin.marinas@arm.com, mpe@ellerman.id.au, sfr@canb.auug.org.au,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v19 03/13] powerpc: Use ELF fields defined in 'struct
 kimage'
In-reply-to: <20210221174930.27324-4-nramas@linux.microsoft.com>
Date:   Tue, 23 Feb 2021 22:07:48 -0300
Message-ID: <87czwqw9wb.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_12:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102240005
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> ELF related fields elf_headers, elf_headers_sz, and elfcorehdr_addr
> have been moved from 'struct kimage_arch' to 'struct kimage' as
> elf_headers, elf_headers_sz, and elf_load_addr respectively.
>
> Use the ELF fields defined in 'struct kimage'.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Fixes: 33488dc4d61f ("of: Add a common kexec FDT setup function")

This Fixes tag should be removed. It is referencing a patch from the
future (later in the series), and the commit id is meaningless.

> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  arch/powerpc/include/asm/kexec.h  |  4 ----
>  arch/powerpc/kexec/file_load.c    |  6 +++---
>  arch/powerpc/kexec/file_load_64.c | 14 +++++++-------
>  3 files changed, 10 insertions(+), 14 deletions(-)

With that fixed:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
