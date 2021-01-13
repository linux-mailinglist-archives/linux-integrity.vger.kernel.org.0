Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A732F419A
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 03:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbhAMCQ5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 21:16:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727798AbhAMCQ5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 21:16:57 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10D24Omf101690;
        Tue, 12 Jan 2021 21:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=Bhwaa1SWQZZ61/Tqg0qykNO0LssgKxVw8Rz6WWRN6Ww=;
 b=gMlEwR2Ng4Pdn8YlKhvlFeSutzO45p+CcTPpDXyKnGKkIrUIAl7SN+jO+lp4rqAYfVtU
 x0xUA1JaS9cSrhNNT2BSQunxbNPdrk4bAplLhJIkiwvKYj41lPwYP9z7tOH3Fjxqu0hl
 yUAtH4JIwVXqisraLIoP/yFBaipUxaFAuwGdTioM3ot6Q2FEPHpdSaPWj43sXkAA72VC
 7p26KfAqPsdkKIDbI0whPC5CAlo9jdC0enfoIpyGkW1vxvA0AjxtU8HMjfcUI2ZCKRR3
 TofYUEy7ZbBgR32XjGs0bfXfzueqxATSHpBnBFbO1njlvRwJZ/VRIQkBIh71KpTFtmWm sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361qjd0ef2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 21:15:48 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10D24rjS105387;
        Tue, 12 Jan 2021 21:15:47 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361qjd0eeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 21:15:47 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10D1w8Id008724;
        Wed, 13 Jan 2021 02:15:46 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 35y4492cny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 02:15:46 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10D2Fkxe29294962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 02:15:46 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7437AC060;
        Wed, 13 Jan 2021 02:15:45 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A44CAC059;
        Wed, 13 Jan 2021 02:15:39 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.217.205])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Jan 2021 02:15:38 +0000 (GMT)
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
 <20210104192602.10131-5-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v14 4/6] powerpc: Delete unused functions
In-reply-to: <20210104192602.10131-5-nramas@linux.microsoft.com>
Date:   Tue, 12 Jan 2021 23:15:37 -0300
Message-ID: <878s8xshti.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_21:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=935 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130009
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> delete_fdt_mem_rsv() defined in "arch/powerpc/kexec/file_load.c"
> has been renamed to fdt_find_and_del_mem_rsv(), and moved to
> "drivers/of/kexec.c".
>
> Remove delete_fdt_mem_rsv() in "arch/powerpc/kexec/file_load.c".
>
> Call of_kexec_setup_new_fdt() from setup_new_fdt_ppc64() and
> remove setup_new_fdt() in "arch/powerpc/kexec/file_load.c".
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/kexec.h  |  4 ---
>  arch/powerpc/kexec/file_load.c    | 60 -------------------------------
>  arch/powerpc/kexec/file_load_64.c |  4 ++-
>  3 files changed, 3 insertions(+), 65 deletions(-)

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
