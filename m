Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6A32E10D4
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 01:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgLWAlz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 19:41:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49872 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbgLWAly (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 19:41:54 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BN0VvdO159797;
        Tue, 22 Dec 2020 19:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=LQNrZt7cXaf8edxCI1c85/3rx53hHhlzwFwn6ESYwPA=;
 b=F3zc6jfoE6T5bwHaXkaVqB70dnNzDYKuD1o+vB9/mAI21EY3+0O3yoF89cx0jQmsCy94
 lGSdCljH8wSrRfZQgTi9OJ1H1U93BW3rG/moAwRKoDDg+7fD4waKtC62jfTI3vrMhUdN
 H/ktE6VioQmvH/Ihybq8kz+TeVxKH2BFWx8a+BQGyuaw7ST3JPSCIuwtZIVDZjfvhZhL
 82ZxLysO+kupDFuS1v/YV/l+aXjOa1x2vG1U9tqnXqUcXu2fb7zf2S2BF+OUSrJUaM0I
 Szo9iCTIEJNXVzoWLuKhKaKDdzReRV++KrycJsnpjYKzr5eKcIm/DWs4/iwXZllzwjRN NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kt0a1tu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 19:40:45 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BN0YAqq164499;
        Tue, 22 Dec 2020 19:40:44 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kt0a1ttu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 19:40:44 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BN0XMbc011912;
        Wed, 23 Dec 2020 00:40:43 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma05wdc.us.ibm.com with ESMTP id 35kferccxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 00:40:43 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BN0eg6t16974200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 00:40:43 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0AEBBE056;
        Wed, 23 Dec 2020 00:40:42 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01D7FBE053;
        Wed, 23 Dec 2020 00:40:34 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.219.136])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Dec 2020 00:40:34 +0000 (GMT)
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
 <20201219175713.18888-3-nramas@linux.microsoft.com>
 <a1a4526c0759eb3b5d70fb8edc89360718376def.camel@linux.ibm.com>
 <e0d9398b-1b46-8115-7bf0-28e9826fcd6b@linux.microsoft.com>
 <7a347c8f2a76fc80551a3dfcb66b0eec9b024a90.camel@linux.ibm.com>
 <71764175-4007-2828-f882-9215c062330a@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v13 2/6] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
In-reply-to: <71764175-4007-2828-f882-9215c062330a@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 21:40:32 -0300
Message-ID: <878s9pl5hb.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_13:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220175
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> On 12/22/20 11:45 AM, Mimi Zohar wrote:
>> On Tue, 2020-12-22 at 10:53 -0800, Lakshmi Ramasubramanian wrote:
>>> On 12/22/20 6:26 AM, Mimi Zohar wrote:
>>>
>>> Hi Mimi,
>>>
>>>>
>>>> On Sat, 2020-12-19 at 09:57 -0800, Lakshmi Ramasubramanian wrote:
>>>>>
>>>>> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
>>>>> index 4aff6846c772..b6c52608cb49 100644
>>>>> --- a/arch/powerpc/kexec/Makefile
>>>>> +++ b/arch/powerpc/kexec/Makefile
>>>>> @@ -9,13 +9,6 @@ obj-$(CONFIG_PPC32)		+= relocate_32.o
>>>>>       obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o
>>>>> file_load_$(BITS).o elf_$(BITS).o
>>>>>    -ifdef CONFIG_HAVE_IMA_KEXEC
>>>>> -ifdef CONFIG_IMA
>>>>> -obj-y				+= ima.o
>>>>> -endif
>>>>> -endif
>>>>
>>>> Notice how "kexec/ima.o" is only included if the architecture supports
>>>> it and IMA is configured.  In addition only if CONFIG_IMA_KEXEC is
>>>> configured, is the IMA measurement list carried across kexec.  After
>>>> moving the rest of ima.c to drivers/of/kexec.c, this changes.   Notice
>>>> how drivers/of/Kconfig includes kexec.o:
>>>>
>>>> obj-$(CONFIG_KEXEC_FILE) += kexec.o
>>>>
>>>> It is not dependent on CONFIG_HAVE_IMA_KEXEC.  Shouldn't all of the
>>>> functions defined in ima.c being moved to kexec.o be defined within a
>>>> CONFIG_HAVE_IMA_KEXEC ifdef?
>>>>
>>>
>>> Thanks for reviewing the changes.
>>>
>>> In "drivers/of/kexec.c" the function remove_ima_buffer() is defined
>>> under "#ifdef CONFIG_HAVE_IMA_KEXEC"
>>>
>>> setup_ima_buffer() is defined under "#ifdef CONFIG_IMA_KEXEC" - the same
>>> way it was defined in "arch/powerpc/kexec/ima.c".
>>>
>>> As you know, CONFIG_IMA_KEXEC depends on CONFIG_HAVE_IMA_KEXEC (as
>>> defined in "security/integrity/ima/Kconfig").
>>>
>>> ima_get_kexec_buffer() and ima_free_kexec_buffer() are unconditionally
>>> defined in "drivers/of/kexec.c" even though they are called only when
>>> CONFIG_HAVE_IMA_KEXEC is enabled. I will update these two functions to
>>> be moved under "#ifdef CONFIG_HAVE_IMA_KEXEC"
>> The issue is the reverse.  CONFIG_HAVE_IMA_KEXEC may be enabled without
>> CONFIG_IMA_KEXEC being enabled.  This allows the architecture to
>> support carrying the measurement list across kexec, but requires
>> enabling it at build time.
>> Only if CONFIG_HAVE_IMA_KEXEC is enabled should any of these functions
>> be compiled at build.  This allows restoring the previous IMA
>> measurement list, even if CONFIG_IMA_KEXEC is not enabled.
>> Only if CONFIG_IMA_KEXEC is enabled, should carrying the measurement
>> list across kexec be enabled.  See how arch_ima_add_kexec_buffer,
>> write_number, setup_ima_buffer are ifdef'ed in
>> arch/powerpc/kexec/ima.c.
>> 
>
> Yes - I agree. I will make the following changes:
>
> => Enable the functions moved from "arch/powerpc/kexec/ima.c" to
> "drivers/of/kexec.c" only when CONFIG_HAVE_IMA_KEXEC is enabled.
>
> => Also, compile write_number() and setup_ima_buffer() only when
> CONFIG_IMA_KEXEC is enabled.

Sounds good, with one additional change:

So far, CONFIG_HAVE_IMA_KEXEC was tested only in files that were built
when CONFIG_IMA was set. With this series this is not the case anymore
(in drivers/of/kexec.c). The simplest way to keep this consistent is to
only enable CONFIG_HAVE_IMA_KEXEC if CONFIG_IMA is also set.

For example, with this:

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e9f13fe08492..4ddd17215ecf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -548,7 +548,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
-	select HAVE_IMA_KEXEC
+	select HAVE_IMA_KEXEC if IMA
 	select BUILD_BIN2C
 	select KEXEC_ELF
 	depends on PPC64

And then the same thing on the arm64 patch.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
