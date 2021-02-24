Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A36323543
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 02:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhBXB11 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 20:27:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232102AbhBXBPh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 20:15:37 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11O14vpw066172;
        Tue, 23 Feb 2021 20:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=xIQ9J5il7IdYFetThadoUWnAsHvBSPOp50LddBTelRU=;
 b=duaKGhtWU7i+UCt8/iUESSbaPSmQIbQ+kILvNrRIw0QfpBBXhXUp7ZK7EaWxVBz0p1rv
 n2Nh+nlVGkft4101lsMbtCHM758dxjepdleHMlIVzV77WZuuLMB2C3228QCeIe4AfeZq
 QhJTSHV/bOM0Qe1kesMe/AF1xKthDM9EgmSRRj0fDom7h4jqUKkVSqwo3m3GjKeohqBw
 VFzcb1FKAnRfxpBvo1tKfg0B6EwTJ62mtt9Q5mgh11jUPkWgn/V1LM+0+dZmWhTCXDsG
 CV8/21dGPUkDXaBVf19vWb4X0QNbbGAS93sEV7u3sSEP6mN3trDrhfJiF0YOJIWAercP Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wau9ard3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 20:14:10 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11O14WGR062184;
        Tue, 23 Feb 2021 20:14:09 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wau9arch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 20:14:09 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11O1Cq0C013566;
        Wed, 24 Feb 2021 01:14:07 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 36tt292uj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 01:14:07 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11O1E7vD29098300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 01:14:07 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01BB1AE05C;
        Wed, 24 Feb 2021 01:14:07 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A32A2AE060;
        Wed, 24 Feb 2021 01:13:59 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.200.35])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Feb 2021 01:13:59 +0000 (GMT)
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
 <20210221174930.27324-5-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v19 04/13] x86: Use ELF fields defined in 'struct kimage'
In-reply-to: <20210221174930.27324-5-nramas@linux.microsoft.com>
Date:   Tue, 23 Feb 2021 22:13:57 -0300
Message-ID: <877dmyw9m2.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_12:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=925 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102240005
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> ELF related fields elf_headers, elf_headers_sz, and elf_load_addr
> have been moved from 'struct kimage_arch' to 'struct kimage'.
>
> Use the ELF fields defined in 'struct kimage'.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Fixes: 33488dc4d61f ("of: Add a common kexec FDT setup function")

Ditto.

> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  arch/x86/include/asm/kexec.h       |  5 -----
>  arch/x86/kernel/crash.c            | 14 +++++++-------
>  arch/x86/kernel/kexec-bzimage64.c  |  2 +-
>  arch/x86/kernel/machine_kexec_64.c |  4 ++--
>  4 files changed, 10 insertions(+), 15 deletions(-)

With that fixed:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
