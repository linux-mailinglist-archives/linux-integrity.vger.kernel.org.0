Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A7731C3C5
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 22:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhBOVrp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 16:47:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhBOVro (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 16:47:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FLhK5F127818;
        Mon, 15 Feb 2021 16:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=WwnxfDfiSUvaoRxLjsUAinYso5jcWLMQITma1Y77IiE=;
 b=iqDxSKLvJhg3Za57+JzaQZHvsE5qcCYjQYyb7Tqn5hno/3sNeQi35r8jdXSYJJ0kwFMC
 tX+iKO87ax/v/sZGRozhbDaemHlF5WKY6WdTkmbF44T132su6yRgsP17NwPirvS91NBf
 sqLUqxVJn8r4GUxV+6OoAOKiepy+vIH9ftW0Bhjg5x3VWvwhkREMASTT57Aqeb7sbLlA
 EfmDK+4tuYaWfjp48msPs3CALrlxUpy2j0j1zAuI38Tozl1eomoZZiZKlxNz6Z1c6CbN
 SzuNu6Da+DUo3VTRHRdxXkIn2sHzVMWZ3VyS5Qzyv7TdqimvEaydH2OlndE37AdNODv7 uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r14801s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:46:34 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FLja8n136780;
        Mon, 15 Feb 2021 16:46:33 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r14801s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:46:33 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FLbRD6012876;
        Mon, 15 Feb 2021 21:46:32 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 36p6d8xavy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 21:46:32 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FLkVFk11469338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 21:46:31 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC0C8C6055;
        Mon, 15 Feb 2021 21:46:30 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E56ABC6059;
        Mon, 15 Feb 2021 21:46:22 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.173.121])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Feb 2021 21:46:22 +0000 (GMT)
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
 <20210213161049.6190-5-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v18 04/11] arm64: Use common of_kexec_alloc_and_setup_fdt()
In-reply-to: <20210213161049.6190-5-nramas@linux.microsoft.com>
Date:   Mon, 15 Feb 2021 18:46:20 -0300
Message-ID: <87wnv9qa1f.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=856 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150164
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
> and update the memory reservation for kexec for arm64.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 180 ++-----------------------
>  1 file changed, 8 insertions(+), 172 deletions(-)

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
