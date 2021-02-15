Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E975631C3E2
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 23:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBOWAN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 17:00:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229662AbhBOWAM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 17:00:12 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FLgr0N062512;
        Mon, 15 Feb 2021 16:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=/oRTogH8po3yrn0yk1VD9C6sW7iDA6T0y17mhJA1WJo=;
 b=IqHTfUVme3a04JuafM75XANvIB90U3EKdFBBMX+qzHAUatGh5sWkpEz1B/i+oLiLtErk
 j2NJ/Xc3oxJyVb32NMNhFhIeMXkRENqauQAWcInw4o7qOdjcHIcArXqzO6ismtWmQ/Br
 28fOnQMoSe1e1Z2KDylxsK7fPN6JHn2rDKDNs3qLYdgsmreKiLq2uOABGDee+lPn9xrY
 4kKf/jZaK5mQ1W+Q+K8N0xhBSoWOnUdMmDTrK5t2SeIkYKbJTuEn/pZmSiKLLX++rTzJ
 faU3mZK9Cpg6Bppn0Cvy2criJ5FmwGUMG54b4Zx/YmTdvKQrGkP691UsqGgLgrpxtU+Y Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r13w8994-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:58:54 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FLk07d070184;
        Mon, 15 Feb 2021 16:58:53 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r13w898k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:58:53 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FLtFlC032460;
        Mon, 15 Feb 2021 21:58:52 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 36p6d8hxcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 21:58:52 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FLwn8L21692706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 21:58:49 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8224C605D;
        Mon, 15 Feb 2021 21:58:49 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7983FC6055;
        Mon, 15 Feb 2021 21:58:41 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.173.121])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Feb 2021 21:58:41 +0000 (GMT)
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
 <20210213161049.6190-7-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v18 06/11] powerpc: Move ima buffer fields to struct kimage
In-reply-to: <20210213161049.6190-7-nramas@linux.microsoft.com>
Date:   Mon, 15 Feb 2021 18:58:37 -0300
Message-ID: <87r1lhq9gy.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxlogscore=889 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150160
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> The fields ima_buffer_addr and ima_buffer_size in "struct kimage_arch"
> for powerpc are used to carry forward the IMA measurement list across
> kexec system call.  These fields are not architecture specific, but are
> currently limited to powerpc.
>
> arch_ima_add_kexec_buffer() defined in "arch/powerpc/kexec/ima.c"
> sets ima_buffer_addr and ima_buffer_size for the kexec system call.
> This function does not have architecture specific code, but is
> currently limited to powerpc.
>
> Move ima_buffer_addr and ima_buffer_size to "struct kimage".
> Set ima_buffer_addr and ima_buffer_size in ima_add_kexec_buffer()
> in security/integrity/ima/ima_kexec.c.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Will Deacon <will@kernel.org>
> ---
>  arch/powerpc/include/asm/ima.h     |  3 ---
>  arch/powerpc/include/asm/kexec.h   |  5 -----
>  arch/powerpc/kexec/ima.c           | 29 ++++++-----------------------
>  include/linux/kexec.h              |  3 +++
>  security/integrity/ima/ima_kexec.c |  8 ++------
>  5 files changed, 11 insertions(+), 37 deletions(-)

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
