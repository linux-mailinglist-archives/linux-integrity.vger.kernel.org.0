Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EBE323544
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 02:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhBXB1a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 20:27:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232384AbhBXBW7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 20:22:59 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11O14uaf082271;
        Tue, 23 Feb 2021 20:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=kC/+0aVm8cp01TvLP/jGIzOiZ2VixN4Uazzg13a34iQ=;
 b=MOrjc9khNWyJxSvy9gDpFJ6ruTGJphjx3Ecztx+yD+/LjajhJSNQdnIcs4D4tTctVw9o
 qme9AIdWGcQKqGRkrm3tFTbR90+GvPPHtnjicCkDPyVY+3Knw4Sv4S2Yql2HMpk7+sEe
 k52efMQN6o/JRsB7INf7+/QgPjMVup96fKNMYMCBE8MJKfnSRnmsFoAYUMgD73PU5UQ6
 gLKU1R0s5YaM4oSHv7JYUzqdjQp9mp26bBxP275d6dlKBHLSpgRDp1Y0xHYkvhXdz777
 JH7wxx8kC+V/U4mMrLksdH/73U0Gc6rAq3NN4xPLE+8OxnB8P+QYHaf4hz/mLCRXRPrw HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkf93cc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 20:21:03 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11O1BhFu112037;
        Tue, 23 Feb 2021 20:21:03 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkf93cbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 20:21:03 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11O1GrfJ023830;
        Wed, 24 Feb 2021 01:21:01 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 36tt2a1nc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 01:21:01 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11O1L15328180812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 01:21:01 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 034A5112063;
        Wed, 24 Feb 2021 01:21:01 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3FE7112061;
        Wed, 24 Feb 2021 01:20:53 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.200.35])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Feb 2021 01:20:53 +0000 (GMT)
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
 <20210221174930.27324-6-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v19 05/13] of: Add a common kexec FDT setup function
In-reply-to: <20210221174930.27324-6-nramas@linux.microsoft.com>
Date:   Tue, 23 Feb 2021 22:20:51 -0300
Message-ID: <874ki2w9ak.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_12:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240005
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> From: Rob Herring <robh@kernel.org>
>
> Both arm64 and powerpc do essentially the same FDT /chosen setup for
> kexec.  The differences are either omissions that arm64 should have
> or additional properties that will be ignored.  The setup code can be
> combined and shared by both powerpc and arm64.
>
> The differences relative to the arm64 version:
>  - If /chosen doesn't exist, it will be created (should never happen).
>  - Any old dtb and initrd reserved memory will be released.
>  - The new initrd and elfcorehdr are marked reserved.
>  - "linux,booted-from-kexec" is set.
>
> The differences relative to the powerpc version:
>  - "kaslr-seed" and "rng-seed" may be set.
>  - "linux,elfcorehdr" is set.
>  - Any existing "linux,usable-memory-range" is removed.
>
> Combine the code for setting up the /chosen node in the FDT and updating
> the memory reservation for kexec, for powerpc and arm64, in
> of_kexec_alloc_and_setup_fdt() and move it to "drivers/of/kexec.c".
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Fixes: 33488dc4d61f ("of: Add a common kexec FDT setup function")

A patch cannot fix itself. The world would be a much better place if it
could. :-)

> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/of/Makefile |   6 +
>  drivers/of/kexec.c  | 265 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h  |   5 +
>  3 files changed, 276 insertions(+)
>  create mode 100644 drivers/of/kexec.c

With that fixed:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
