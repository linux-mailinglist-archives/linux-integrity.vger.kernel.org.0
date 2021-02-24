Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B643D323503
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 02:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhBXBLW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 20:11:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234387AbhBXBJH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 20:09:07 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11O149is195761;
        Tue, 23 Feb 2021 20:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=8Bsg0m2sf1QnAnX51rDxZ5KDelMOaxrKvzHv4MEyx7A=;
 b=NhK2TsURSi1Xv6JSP+GnNZFrcxzjHudderJF7G1zDlot4j1McQwXBY/TtcWMfM38d7xQ
 5Q6P4WHz5orxB5tVHLrqIDyJC1zW8ZNZ1eoxAAlZovtWeNAZlvwHZe70JmLzObsimSfn
 aRqiMNjXvGzIKJWrLGQps06rJPOGrXwj6/AaNGL014x7en4zM8zKguuiVuoaokfjJzac
 OxDwd3aR6bF2b/MCezD/ZgydPzy1ARbqUHKbymwlZCUpJDhRE4nvGI7GvDt3aw3xKvRM
 Aq0HExNv0Np+tokNE/W8AG8r10ECV6Qi04OAy7kNM3KV8TWiPN6nwM7IYiok4fArCuXG Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkftd744-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 20:07:25 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11O14CtG195816;
        Tue, 23 Feb 2021 20:07:25 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkftd73r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 20:07:24 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11O12L4b009228;
        Wed, 24 Feb 2021 01:07:24 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 36tt2ahg02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 01:07:23 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11O17MF925166108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 01:07:22 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 718117806A;
        Wed, 24 Feb 2021 01:07:22 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F8D87805C;
        Wed, 24 Feb 2021 01:07:14 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.200.35])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Feb 2021 01:07:13 +0000 (GMT)
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
 <20210221174930.27324-3-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v19 02/13] arm64: Use ELF fields defined in 'struct kimage'
In-reply-to: <20210221174930.27324-3-nramas@linux.microsoft.com>
Date:   Tue, 23 Feb 2021 22:07:12 -0300
Message-ID: <87ft1mw9xb.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_12:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=929 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240005
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> ELF related fields elf_headers, elf_headers_sz, and elf_headers_mem
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
>  arch/arm64/include/asm/kexec.h         |  4 ----
>  arch/arm64/kernel/machine_kexec_file.c | 18 +++++++++---------
>  2 files changed, 9 insertions(+), 13 deletions(-)

With that fixed:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
