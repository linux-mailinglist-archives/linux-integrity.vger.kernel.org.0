Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED16318478
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 06:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhBKFIo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 00:08:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64640 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhBKFIo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 00:08:44 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11B535q4050007;
        Thu, 11 Feb 2021 00:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=GeKdXRTnblLQLgKS12NhNK/KcHc7JYx6PvJg6YHGkK8=;
 b=LD4/C3Ci4f2wLKRjATxW5V16aXB4ZjDLC7zxw6RCQuMPJRChLpdLYa+l8u1h2YyuwR65
 14h446q9TbbTEKUlYT2Yt1G8L9VAbzDaxYEsONDvNHdEdtxuhVcNKHYb/wsT5fXIU1BS
 rlRziEOjEKpe+8ytYZ/ExPMV8JBO9j2C7/A08J96kKRHV7oEdi0v1Vqu/2LumK8mwSuL
 J0o4+taMvEM1zBwyev+ORrP2G+TXfu4N8gy7qilKTYK4MVj9Zq4DRc9MdZBDHZ3lxoKP
 36A9bFnSRhia9/YE1uJNw6yqouRYFelR+z2qxrKSdyGuw9i5kUbRtpfBgeVnK5YN/I6/ EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mwsygjad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 00:07:24 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11B53ebk053143;
        Thu, 11 Feb 2021 00:07:23 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mwsygj9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 00:07:23 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11B53vGC023278;
        Thu, 11 Feb 2021 05:07:22 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 36hjr9k9r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 05:07:22 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11B57LLW24576256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:07:21 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A62AABE04F;
        Thu, 11 Feb 2021 05:07:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 724F4BE058;
        Thu, 11 Feb 2021 05:07:12 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.160.95.194])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 11 Feb 2021 05:07:12 +0000 (GMT)
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-8-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v17 07/10] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
In-reply-to: <20210209182200.30606-8-nramas@linux.microsoft.com>
Date:   Thu, 11 Feb 2021 02:07:09 -0300
Message-ID: <87lfbvnqf6.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_04:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=815 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110035
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
> Move remove_ima_buffer() and setup_ima_buffer() calls into
> of_kexec_alloc_and_setup_fdt() defined in "drivers/of/kexec.c".
>
> Move the remaining architecture independent functions from
> "arch/powerpc/kexec/ima.c" to "drivers/of/kexec.c".
> Delete "arch/powerpc/kexec/ima.c" and "arch/powerpc/include/asm/ima.h".
> Remove references to the deleted files and functions in powerpc and
> in ima.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/ima.h    |  27 ----
>  arch/powerpc/include/asm/kexec.h  |   3 -
>  arch/powerpc/kexec/Makefile       |   7 -
>  arch/powerpc/kexec/file_load.c    |  25 ----
>  arch/powerpc/kexec/file_load_64.c |   4 -
>  arch/powerpc/kexec/ima.c          | 202 -------------------------
>  drivers/of/kexec.c                | 239 ++++++++++++++++++++++++++++++
>  include/linux/of.h                |   2 +
>  security/integrity/ima/ima.h      |   4 -
>  9 files changed, 241 insertions(+), 272 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/ima.h
>  delete mode 100644 arch/powerpc/kexec/ima.c

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
