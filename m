Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D347BD384
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2019 22:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfIXU03 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Sep 2019 16:26:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbfIXU03 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Sep 2019 16:26:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8OKMnQm018744;
        Tue, 24 Sep 2019 16:25:40 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v7qx052qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 16:25:40 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8OKPCJl024377;
        Tue, 24 Sep 2019 20:25:38 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 2v5bg77kp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 20:25:38 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8OKPbxO58261872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 20:25:38 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD1B3C6057;
        Tue, 24 Sep 2019 20:25:37 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D1DCC6055;
        Tue, 24 Sep 2019 20:25:33 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.203.235])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 24 Sep 2019 20:25:32 +0000 (GMT)
References: <20190913225009.3406-1-prsriva@linux.microsoft.com> <20190913225009.3406-2-prsriva@linux.microsoft.com> <87zhiz1x9l.fsf@morokweng.localdomain> <02234482-b095-e064-f4d6-1c6255a4ff9f@linux.microsoft.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     prsriva <prsriva@linux.microsoft.com>
Cc:     mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de,
        takahiro.akashi@linaro.org, sboyd@kernel.org,
        catalin.marinas@arm.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        yamada.masahiro@socionext.com, kristina.martsenko@arm.org,
        duwe@lst.de, allison@lohutok.net, james.morse@arm.org,
        linux-integrity@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 1/1] Add support for arm64 to carry ima measurement log in kexec_file_load
In-reply-to: <02234482-b095-e064-f4d6-1c6255a4ff9f@linux.microsoft.com>
Date:   Tue, 24 Sep 2019 17:25:30 -0300
Message-ID: <87zhit5tmt.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909240166
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hello,

prsriva <prsriva@linux.microsoft.com> writes:

> On 9/19/19 8:07 PM, Thiago Jung Bauermann wrote:
>> Hello Prakhar,
>>
>> Prakhar Srivastava <prsriva@linux.microsoft.com> writes:
>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 3adcec05b1f6..f39b12dbf9e8 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -976,6 +976,13 @@ config KEXEC_VERIFY_SIG
>>>   	  verification for the corresponding kernel image type being
>>>   	  loaded in order for this to work.
>>>
>>> +config HAVE_IMA_KEXEC
>>> +	bool "Carry over IMA measurement log during kexec_file_load() syscall"
>>> +	depends on KEXEC_FILE
>>> +	help
>>> +	  Select this option to carry over IMA measurement log during
>>> +	  kexec_file_load.
>>> +
>>>   config KEXEC_IMAGE_VERIFY_SIG
>>>   	bool "Enable Image signature verification support"
>>>   	default y
>> This is not right. As it stands, HAVE_IMA_KEXEC is essentially a synonym
>> for IMA_KEXEC.
>>
>> It's not meant to be user-visible in the config process. Instead, it's
>> meant to be selected by the arch Kconfig (probably by the ARM64 config
>> symbol) to signal to IMA's Kconfig that it can offer the IMA_KEXEC
>> option.
>>
>> I also mentioned in my previous review that config HAVE_IMA_KEXEC should
>> be defined in arch/Kconfig, not separately in both arch/arm64/Kconfig
>> and arch/powerpc/Kconfig.
>
> I see the entry exists in arch/Kconfig and is overwritten.
> I will remove entries both from powerpc and arm64.
>
> How do i cross-compile for powerpc?

There are some instructions here:

https://github.com/linuxppc/wiki/wiki/Building-powerpc-kernels

>>> diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
>>> new file mode 100644
>>> index 000000000000..e23cee84729f
>>> --- /dev/null
>>> +++ b/arch/arm64/include/asm/ima.h
>>> @@ -0,0 +1,29 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef _ASM_ARM64_IMA_H
>>> +#define _ASM_ARM64_IMA_H
>>> +
>>> +struct kimage;
>>> +
>>> +int ima_get_kexec_buffer(void **addr, size_t *size);
>>> +int ima_free_kexec_buffer(void);
>>> +
>>> +#ifdef CONFIG_IMA
>>> +void remove_ima_buffer(void *fdt, int chosen_node);
>>> +#else
>>> +static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
>>> +#endif
>> I mentioned in my previous review that remove_ima_buffer() should exist
>> even if CONFIG_IMA isn't set. Did you arrive at a different conclusion?
>
> I made the needed changed in makefile, missed removing the
>
> configs here. Thanks for pointing this out.

Thanks.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
