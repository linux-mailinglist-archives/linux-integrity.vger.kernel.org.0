Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3462E2044
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 19:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgLWR7A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Dec 2020 12:59:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgLWR7A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Dec 2020 12:59:00 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BNHVPRV091361;
        Wed, 23 Dec 2020 12:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=zY13Isl4eHDOTHr/bXGeVpPtRMPZqkTm/pxQ4NqEEM0=;
 b=YwEqN0xKlcTfx+Z/B+VlhvvBOBMpqjGvAZ4dxWa2n7nVC3KjUVVUIPTgaWhG93KkBpDN
 1XQ5H743NCe86bBqC0HpdfNcgVUi1bEYbdEUo3EiwcjenbItntnYlXVhukfFWA0RJaoq
 hSFak8sALxNFqPlxelAKNVTvLM+UJCJuoZec0LMXFkHSHCms98v0gu3H9Z6z3q4QSr0i
 8lKONTgpGUsYD6BtSfb1F8cUftczOuP8AYfMZj7a6TCn1nx+hOCAcqhQSmzmn2Nte4V2
 F/gA5exhWoKoIOgofJBJUsHN9uE841jqv2lHQT2q+hX+pOWFIQD9slqCu8xppAt4TLED Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35m652yq1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 12:57:34 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BNHVmUE092710;
        Wed, 23 Dec 2020 12:57:33 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35m652yq10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 12:57:33 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BNHrT3r004614;
        Wed, 23 Dec 2020 17:57:32 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 35m96crhy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 17:57:32 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BNHvVF425297344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 17:57:31 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5DC4BE056;
        Wed, 23 Dec 2020 17:57:31 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13BCFBE054;
        Wed, 23 Dec 2020 17:57:23 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.205.254])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Dec 2020 17:57:23 +0000 (GMT)
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
 <20201219175713.18888-3-nramas@linux.microsoft.com>
 <87blell6g2.fsf@manicouagan.localdomain>
 <6d7e0147-b5e4-d364-af7d-c089217e3fb0@linux.microsoft.com>
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
Subject: Re: [PATCH v13 2/6] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
In-reply-to: <6d7e0147-b5e4-d364-af7d-c089217e3fb0@linux.microsoft.com>
Date:   Wed, 23 Dec 2020 14:57:21 -0300
Message-ID: <87r1ngv20u.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-23_08:2020-12-23,2020-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 phishscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012230126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> On 12/22/20 4:19 PM, Thiago Jung Bauermann wrote:
>> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
>> 
>>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>>> index 6ebefec616e4..7c3947ad3773 100644
>>> --- a/security/integrity/ima/ima.h
>>> +++ b/security/integrity/ima/ima.h
>>> @@ -24,10 +24,6 @@
>>>     #include "../integrity.h"
>>>   -#ifdef CONFIG_HAVE_IMA_KEXEC
>>> -#include <asm/ima.h>
>>> -#endif
>>> -
>>>   enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
>>>   		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
>>>   enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
>> This belongs in patch 1.
>
> No - the reference to "asm/ima.h" cannot be removed in Patch #1 since
> ima_get_kexec_buffer() and ima_free_kexec_buffer() are still declared in 
> this header. They are moved in this patch only (Patch #2).

Indeed, you are right. My mistake.

>>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>>> index 38bcd7543e27..8a6712981dee 100644
>>> --- a/security/integrity/ima/ima_kexec.c
>>> +++ b/security/integrity/ima/ima_kexec.c
>>> @@ -10,6 +10,7 @@
>>>   #include <linux/seq_file.h>
>>>   #include <linux/vmalloc.h>
>>>   #include <linux/kexec.h>
>>> +#include <linux/of.h>
>>>   #include <linux/ima.h>
>>>   #include "ima.h"
>> This include isn't necessary.
>
> This change is necessary because ima_get_kexec_buffer() and
> ima_free_kexec_buffer() are now declared in "linux/of.h".

You are right here as well. Before I made the suggestion, I had tested
building the kernel without the include above and it worked fine, but
that's because <linux/of.h> is being included indirectly by some other
header file. It's better to include it explicitly.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
