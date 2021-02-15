Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E03731C3CC
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 22:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBOVwf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 16:52:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229662AbhBOVwe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 16:52:34 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FLhE3W062034;
        Mon, 15 Feb 2021 16:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=KjcWjrzpVphFTO5FFSUfC3u1TkMq+mBtwaNHZAkSXQw=;
 b=fkZfmzXSSGZ1pLt7nIAqKdphiTx2RX00y4U/2m31Ar6nmC5/jsP7RohDhhlOKWhVtwcv
 1Z8xKf/BuE26k4Bvl6ZaZIYsXQdl2PmWG+vbM6Je/qMv7C5/ROnHkAIzv9KEPMKmRlwk
 nUB91Ib8QhrLDQUb+ATEYDuVtz/tTfWURZiaB7YVrgH8omfRqX7dbwx9KfjwTQ4pUFGm
 9ZSCUQXybu7qoQLtCEAsmC7NO5Rz+6ijnnIQotqQ6QWcANG6fWTd83BhxDSKOguh7Et+
 8iAyh98kj2SNEJdawkae24ypkcRkTA3ayDo9JTSBWjJe6PsqfOFM2f8I6N09kr/5aQyW gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36r1470487-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:51:07 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FLjZcl066428;
        Mon, 15 Feb 2021 16:51:06 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36r147047q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:51:06 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FLmABZ026281;
        Mon, 15 Feb 2021 21:51:05 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 36p6d8hwjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 21:51:05 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FLp4TZ7537262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 21:51:04 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F4072C6059;
        Mon, 15 Feb 2021 21:51:03 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC117C6057;
        Mon, 15 Feb 2021 21:50:55 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.173.121])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Feb 2021 21:50:55 +0000 (GMT)
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
 <20210213161049.6190-6-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v18 05/11] powerpc: Use common
 of_kexec_alloc_and_setup_fdt()
In-reply-to: <20210213161049.6190-6-nramas@linux.microsoft.com>
Date:   Mon, 15 Feb 2021 18:50:53 -0300
Message-ID: <87tuqdq9tu.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150160
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> From: Rob Herring <robh@kernel.org>
>
> The code for setting up the /chosen node in the device tree
> and updating the memory reservation for the next kernel has been
> moved to of_kexec_alloc_and_setup_fdt() defined in "drivers/of/kexec.c".
>
> Use the common of_kexec_alloc_and_setup_fdt() to setup the device tree
> and update the memory reservation for kexec for powerpc.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/kexec.h  |   1 +
>  arch/powerpc/kexec/elf_64.c       |  30 ++++---
>  arch/powerpc/kexec/file_load.c    | 132 +-----------------------------
>  arch/powerpc/kexec/file_load_64.c |   3 +
>  4 files changed, 26 insertions(+), 140 deletions(-)

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
