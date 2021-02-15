Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C8731C3A2
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 22:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBOVcf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 16:32:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7908 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229872AbhBOVcd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 16:32:33 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FLHAWU149306;
        Mon, 15 Feb 2021 16:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=CNTDqlv4xdf1Xplvt/uc/S/HoRq+X45qobe1yMVrGx8=;
 b=j7jUi7lamdk684WYmZvSx2ceN2qFGK5u8Iyd6JGyNju5ahwWop8OmbQBxFJ0ZVc3686C
 HDIhDF1IKycwRKu0AL1bh/CadVenJefIRbHYSLSfz/66A7To1Rb1Z6SulaXyuopBIqos
 SGOHjDnRUoDS+kKcdgAXvAz0Kz76ffDJViNNwDSY1sQJvX4/sqEVrKJ5zpjH3xsF/Fh/
 Su5AO226JHb5GwljLgfANZ94RY8ltUUi6KJyi4JQFqtzQlr8+fuqphPGh1qCH5gLwFlF
 eqBpkJwuYJsOt+c1ZWxo55M1amjnnsccoZOmGKClMaSEUp/A0VLk30Y0qDPFvy2NgSv7 sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r0r4071v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:31:12 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FLPXAJ177959;
        Mon, 15 Feb 2021 16:31:11 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r0r4071f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:31:11 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FLS6oe013614;
        Mon, 15 Feb 2021 21:31:10 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 36p6d96aax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 21:31:10 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FLV9HA40632614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 21:31:09 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 518FD112062;
        Mon, 15 Feb 2021 21:31:09 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AA0F112063;
        Mon, 15 Feb 2021 21:31:02 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.173.121])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Feb 2021 21:31:02 +0000 (GMT)
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
 <20210213161049.6190-2-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v18 01/11] powerpc: Rename kexec elfcorehdr_addr to
 elf_load_addr
In-reply-to: <20210213161049.6190-2-nramas@linux.microsoft.com>
Date:   Mon, 15 Feb 2021 18:31:00 -0300
Message-ID: <875z2trpbf.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150156
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> From: Rob Herring <robh@kernel.org>
>
> The architecture specific field, elfcorehdr_addr in struct kimage_arch,
> that holds the address of the buffer in memory for ELF core header for
> powerpc has a different name than the one used for x86_64.  This makes
> it hard to have a common code for setting up the device tree for
> kexec system call.
>
> Rename elfcorehdr_addr to elf_load_addr to align with x86_64 name so
> common code can use it.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/kexec.h  | 2 +-
>  arch/powerpc/kexec/file_load.c    | 4 ++--
>  arch/powerpc/kexec/file_load_64.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
