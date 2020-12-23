Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704D62E114A
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 02:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgLWBTI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 20:19:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLWBTH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 20:19:07 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BN1Ctlq051015;
        Tue, 22 Dec 2020 20:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=Xqj4XnC91lloERXo758sMR6xKYMKm2wGq3qvpsAxQ1E=;
 b=M4MQzIhJ6rkD1twjow4VT1fj/PAvEIzGA+oPDoomT+b1ngtfAD8l7DxcfdeZG7JSsRVn
 9kBhqT6wDdbjtboSRKfpGWxqOmX0VuTfrehUyHoKbqVRwYnwp4xXkTnyDQFXpKmfxEOX
 aJyhE8RuomKpiGr/TtHejveOKYVJv1JKS2rFPJ6BlMuv4ZNZSzkdznmXjl/TQ2SDeCr7
 MPEE226j1Up1K2mWG15CZ46oJKKZvVXKXrYCQ1519mrn++cz8huLQdLmYQLkUJfBWOmb
 rUQqVFmgb39j993ypShia2iaqPi63NKWUQkwbr2SSeqSRv13UDAHq7P3Q05Wvt7dv1bq ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kv1g02rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 20:17:58 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BN1EuqW058860;
        Tue, 22 Dec 2020 20:17:57 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kv1g02rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 20:17:57 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BN1DEon004574;
        Wed, 23 Dec 2020 01:17:56 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 35kj7qvbyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 01:17:56 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BN1Ht9A27460002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 01:17:55 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55434BE053;
        Wed, 23 Dec 2020 01:17:55 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8397BBE051;
        Wed, 23 Dec 2020 01:17:46 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.219.136])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Dec 2020 01:17:46 +0000 (GMT)
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
 <20201219175713.18888-7-nramas@linux.microsoft.com>
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v13 6/6] arm64: Add IMA log information in kimage used
 for kexec
In-reply-to: <20201219175713.18888-7-nramas@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 22:17:44 -0300
Message-ID: <87sg7xjp6v.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_13:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012230003
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> Address and size of the buffer containing the IMA measurement log need
> to be passed from the current kernel to the next kernel on kexec.
>
> Any existing "linux,ima-kexec-buffer" property in the device tree
> needs to be removed and its corresponding memory reservation in
> the currently running kernel needs to be freed. The address and
> size of the current kernel's IMA measurement log need to be added
> to the device tree's IMA kexec buffer node and memory for the buffer
> needs to be reserved for the log to be carried over to the next kernel
> on the kexec call.
>
> Add address and size fields to "struct kimage_arch" for ARM64 platform
> to hold the address and size of the IMA measurement log buffer. Remove
> any existing "linux,ima-kexec-buffer" property in the device tree and
> free the corresponding memory reservation in the currently running
> kernel. Add "linux,ima-kexec-buffer" property to the device tree and
> reserve the memory for storing the IMA log that needs to be passed from
> the current kernel to the next one.
>
> Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to indicate
> that the IMA measurement log information is present in the device tree
> for ARM64.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/arm64/Kconfig             | 1 +
>  arch/arm64/include/asm/kexec.h | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1d466addb078..c85d18b1f2fd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1094,6 +1094,7 @@ config KEXEC
>  config KEXEC_FILE
>  	bool "kexec file based system call"
>  	select KEXEC_CORE
> +	select HAVE_IMA_KEXEC
>  	help
>  	  This is new version of kexec system call. This system call is
>  	  file based and takes file descriptors as system call argument

As I suggested in the other email, this should be:

	select HAVE_IMA_KEXEC if IMA

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
