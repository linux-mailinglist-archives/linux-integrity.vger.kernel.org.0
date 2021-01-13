Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB682F4198
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 03:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbhAMCQS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 21:16:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4676 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbhAMCQS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 21:16:18 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10D2ClZb126584;
        Tue, 12 Jan 2021 21:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=b33gMCYFoiY2cA7DlohE+j9s5rwIBiiXa3jsXsZw+dU=;
 b=LPA0Jihqx013+hCofHhMLCHhTKGHn/cwFsrSpz3lL8nFmMPrOEvISeJBcy9Zq4Zrfw05
 O9a5Vm6PAh275BV8ZWOZkTU5q253yWJBlgW568ur8UHvQpk1+w03zcL1jsn4h6w4AjFr
 YXSEW4nRsh7dn2UBi4XiBtTPKTUtQyq0fzXXvZoh7d3vYBqs3tf+OsYKA9Hsj1RjnE5Q
 VXW6IwA24G+xAlSIapG08xvQcraoGFsfZCYbB6MCmzt0CjudPayKGVkLuMUvZ5xH/lZN
 n6ImG8/JAvPf1RUabeTf72X0PfVZLvD14xPC7DyxYh2M03nkUjBMl7ZSoItOITe/Og6M 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361qvn00tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 21:15:04 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10D2D7bU126823;
        Tue, 12 Jan 2021 21:15:03 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361qvn00tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 21:15:03 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10D2C42M017573;
        Wed, 13 Jan 2021 02:15:02 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 35y449gxdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 02:15:02 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10D2F1k110289646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 02:15:01 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 579697805C;
        Wed, 13 Jan 2021 02:15:01 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4066678060;
        Wed, 13 Jan 2021 02:14:53 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.217.205])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Jan 2021 02:14:52 +0000 (GMT)
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
 <20210104192602.10131-3-nramas@linux.microsoft.com>
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@vger.kernel.org
Subject: Re: [PATCH v14 2/6] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
In-reply-to: <20210104192602.10131-3-nramas@linux.microsoft.com>
Date:   Tue, 12 Jan 2021 23:14:50 -0300
Message-ID: <87bldtshut.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_21:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=820 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130005
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
>  arch/powerpc/Kconfig               |   2 +-
>  arch/powerpc/include/asm/ima.h     |  27 ----
>  arch/powerpc/kexec/Makefile        |   7 -
>  arch/powerpc/kexec/file_load.c     |   7 -
>  arch/powerpc/kexec/ima.c           | 202 ------------------------
>  drivers/of/kexec.c                 | 240 +++++++++++++++++++++++++++++
>  include/linux/of.h                 |   2 +
>  security/integrity/ima/ima.h       |   4 -
>  security/integrity/ima/ima_kexec.c |   1 +
>  9 files changed, 244 insertions(+), 248 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/ima.h
>  delete mode 100644 arch/powerpc/kexec/ima.c

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
