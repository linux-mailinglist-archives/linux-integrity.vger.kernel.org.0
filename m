Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DFE2F41A4
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 03:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbhAMCRu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 21:17:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727798AbhAMCRu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 21:17:50 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10D23JDL010083;
        Tue, 12 Jan 2021 21:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=DeR1Ge39KPlmbMnjjYgg5xHfkOIDQOcFsTFA55GzuBs=;
 b=S1POk2zrBEerLJte5x69oMYXGI/CHSy7D+fhej+U4hk20o6U9CtgaY13AUXkHhwP+ehq
 XX3HC+owXQoTou0STCMjlU5X2DouO0fjqPDLX2AAkeOQC3dEC6s4HacWf885HDfguxkn
 RCoHnQRPm/cvr/qpN90UPPGEsnWwwhv0s22B3wPkzYbk9eYTinSn8GTJGn3za/phDOdv
 Ukwiux40MPTfO9ktYBu9GJIbqysvusFJxCzUZ+Qx9QftByVQ4sQ9ckyydsgYtjw9tZVp
 OSFYm0zSzLr28wwq23gSnIIyi3/K9CnRHJMfGvPWPvbzkI0fsQMyST/XiHqs+q+dmAu1 RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361qeygm60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 21:16:39 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10D24hBr015132;
        Tue, 12 Jan 2021 21:16:38 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361qeygm5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 21:16:38 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10D2CW4h022162;
        Wed, 13 Jan 2021 02:16:37 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 35y4499105-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 02:16:37 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10D2GaJv11534710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 02:16:36 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0189AC059;
        Wed, 13 Jan 2021 02:16:36 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC438AC062;
        Wed, 13 Jan 2021 02:16:29 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.217.205])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Jan 2021 02:16:29 +0000 (GMT)
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
 <20210104192602.10131-7-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v14 6/6] arm64: Add IMA log information in kimage used
 for kexec
In-reply-to: <20210104192602.10131-7-nramas@linux.microsoft.com>
Date:   Tue, 12 Jan 2021 23:16:28 -0300
Message-ID: <875z41shs3.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_21:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130009
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

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
