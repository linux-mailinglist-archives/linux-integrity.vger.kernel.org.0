Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E290A2E0FED
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Dec 2020 22:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgLVVtk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 16:49:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727851AbgLVVtj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 16:49:39 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BMLWF8v009787;
        Tue, 22 Dec 2020 16:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=Hgf1i+Wh3yiW1rvV/bB1osgr6+rdIPucMbnT7oTGS5c=;
 b=Mxd5f/R9w9/mXh+HgzT5CtuNMtvN1sOPwhODNYPv3yKjDTieM8pWhy8u8j1B4NjK9foD
 arLEeKU6QFSKMqe+sTp1Butn/whapP+YpunYu+LRau6ACeqiMBk4OfuISPizdoJrZt02
 SMq3iGbcri2DuxYC6UyktLHdXugYwG3YRGKeXa1pDtRuK0cEdVuNlfXzIteXtHhTh7Cp
 A7iUKx4lOOu2fzt1cqc3PseQuN2r9qBmnIPo5sAM66lp1PiHJ7g3P7NfoADuzm7vkoCP
 McXoAbQuhh8yZBpPvFVYbfS2ZdatCYpJckjJ5MfxO2BQQxGNynWo4KJ152Al/4zXhuQc kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kqaxtc0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 16:48:26 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BMLXDXo012462;
        Tue, 22 Dec 2020 16:48:26 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kqaxtc00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 16:48:26 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMLbCbE027959;
        Tue, 22 Dec 2020 21:48:25 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 35k02etxhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 21:48:25 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMLmOmc20250956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 21:48:24 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10452C6057;
        Tue, 22 Dec 2020 21:48:24 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58626C6055;
        Tue, 22 Dec 2020 21:48:16 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.219.136])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Dec 2020 21:48:15 +0000 (GMT)
References: <20201211221006.1052453-1-robh@kernel.org>
 <20201211221006.1052453-3-robh@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        takahiro.akashi@linaro.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, zohar@linux.ibm.com,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [RFC PATCH 2/4] of: Add a common kexec FDT setup function
In-reply-to: <20201211221006.1052453-3-robh@kernel.org>
Date:   Tue, 22 Dec 2020 18:48:14 -0300
Message-ID: <87mty5ldgh.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_11:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220153
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Rob Herring <robh@kernel.org> writes:

> Both arm64 and powerpc do essentially the same FDT /chosen setup for
> kexec. We can simply combine everything each arch does. The differences
> are either omissions that arm64 should have or additional properties
> that will be ignored.
>
> The differences relative to the arm64 version:
> - If /chosen doesn't exist, it will be created (should never happen).
> - Any old dtb and initrd reserved memory will be released.
> - The new initrd and elfcorehdr are marked reserved.
> - "linux,booted-from-kexec" is set.
>
> The differences relative to the powerpc version:
> - "kaslr-seed" and "rng-seed" may be set.
> - "linux,elfcorehdr" is set.

I especially like the elfcorehdr property. It always bothered me that we
pass it on the kernel command line, since it's not something that could
or should be set by an admin.

> - Any existing "linux,usable-memory-range" is removed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This could be taken a step further and do the allocation of the new
> FDT. The difference is arm64 uses vmalloc and powerpc uses kmalloc. The
> arm64 version also retries with a bigger allocation. That seems
> unnecessary.
> ---
>  drivers/of/Makefile |   1 +
>  drivers/of/kexec.c  | 228 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h  |   5 +
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/of/kexec.c

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
