Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4276E2D7DEE
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 19:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393134AbgLKSVa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 13:21:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392900AbgLKSVS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 13:21:18 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BBI4s17139690;
        Fri, 11 Dec 2020 13:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=qpGm3kQ0ZbvtzQ9CK1gFqWjG/Rnaoq8h7KtEQcDd1jg=;
 b=kZ3n3qO27kMYXvJfJDI+ePWP6N/Eb0rVXIoHPBnpUA8Vl6wg6GrlSTnj1MU5ZTuMy3uA
 PwIVNe2vU8xnihmAwmzW+i7QAqWk3VNFmmEM4EqiLwk/Wx057kju/00oAjIJOOtceW+n
 6oQbn/2dH+My9o9wn6leFW6FAp4oefNqusfRdA3KtlgOlufYV9vWEOXCxdyjJVOvWC0W
 6FIERIZe4VLFi/qviS7ak2gnr7F8OybRhFn0yVBXicn93yHvUSsl0MQg6kU5zavjqdSI
 n5DKvG+IuERdxG5V6B6fTpn+zNuLkEYY0Jsny0zCCoIWEPzyeTxq2sl6X4OkFEgEgS0c mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35cbx63p3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 13:19:56 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BBI567Q144454;
        Fri, 11 Dec 2020 13:19:55 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35cbx63p2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 13:19:55 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BBID6aF009324;
        Fri, 11 Dec 2020 18:19:54 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 3581uadvdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 18:19:54 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BBIJrdO20644190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Dec 2020 18:19:53 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4237BBE053;
        Fri, 11 Dec 2020 18:19:53 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46D2ABE051;
        Fri, 11 Dec 2020 18:19:43 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.160.59.9])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 11 Dec 2020 18:19:42 +0000 (GMT)
References: <20201204195149.611-1-nramas@linux.microsoft.com>
 <20201204195149.611-3-nramas@linux.microsoft.com>
 <87ft4louto.fsf@manicouagan.localdomain>
 <40f8c03a-f08f-d49e-b404-9a6d79873dd1@linux.microsoft.com>
 <4a8a9d8f-22b8-0961-7c31-39eb1fe9cb65@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, gregkh@linuxfoundation.org,
        james.morse@arm.com, catalin.marinas@arm.com, sashal@kernel.org,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [PATCH v10 2/8] powerpc: Move delete_fdt_mem_rsv() to
 drivers/of/kexec.c
In-reply-to: <4a8a9d8f-22b8-0961-7c31-39eb1fe9cb65@linux.microsoft.com>
Date:   Fri, 11 Dec 2020 15:19:40 -0300
Message-ID: <878sa49pdv.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_05:2020-12-11,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=2 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110118
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Lakshmi,

Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> On 12/6/20 5:50 PM, Lakshmi Ramasubramanian wrote:
>
> Hi Thiago,
>
>> On 12/4/20 6:22 PM, Thiago Jung Bauermann wrote
>>>
>>> Hello Lakshmi,
>>>
>>> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
>>>
>>>> delete_fdt_mem_rsv() retrieves the memory reserve map entry, for
>>>> the given starting address and size, from the device tree blob, and
>>>> removes the entry from the device tree blob. This function is called
>>>> to free the resources reserved for the buffer used for carrying forward
>>>> the IMA measurement logs on kexec. This function does not have
>>>> architecture specific code, but is currently limited to powerpc.
>>>>
>>>> Move delete_fdt_mem_rsv() to "drivers/of/kexec_fdt.c" so that it is
>>>
>>> s/kexec_fdt.c/kexec.c/
>> Missed that in the patch description. Will fix it. Thanks.
>> 
>>>> accessible for other architectures as well.
>>>>
>>>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>> ---
>>>>   arch/powerpc/include/asm/kexec.h |  1 -
>>>>   arch/powerpc/kexec/file_load.c   | 32 -----------------
>>>>   drivers/of/Makefile              |  1 +
>>>>   drivers/of/kexec.c               | 61 ++++++++++++++++++++++++++++++++
>>>>   include/linux/kexec.h            |  5 +++
>>>>   5 files changed, 67 insertions(+), 33 deletions(-)
>>>>   create mode 100644 drivers/of/kexec.c
>>>>
>>>> diff --git a/arch/powerpc/include/asm/kexec.h
>>>> b/arch/powerpc/include/asm/kexec.h
>>>> index 55d6ede30c19..7c223031ecdd 100644
>>>> --- a/arch/powerpc/include/asm/kexec.h
>>>> +++ b/arch/powerpc/include/asm/kexec.h
>>>> @@ -126,7 +126,6 @@ int setup_purgatory(struct kimage *image, const void
>>>> *slave_code,
>>>>   int setup_new_fdt(const struct kimage *image, void *fdt,
>>>>             unsigned long initrd_load_addr, unsigned long initrd_len,
>>>>             const char *cmdline);
>>>> -int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
>>>>   #ifdef CONFIG_PPC64
>>>>   struct kexec_buf;
>>>> diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
>>>> index 9a232bc36c8f..9efc98b1e2ae 100644
>>>> --- a/arch/powerpc/kexec/file_load.c
>>>> +++ b/arch/powerpc/kexec/file_load.c
>>>> @@ -109,38 +109,6 @@ int setup_purgatory(struct kimage *image, const void
>>>> *slave_code,
>>>>       return 0;
>>>>   }
>>>> -/**
>>>> - * delete_fdt_mem_rsv - delete memory reservation with given address and
>>>> size
>>>> - *
>>>> - * Return: 0 on success, or negative errno on error.
>>>> - */
>>>> -int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
>>>> -{
>>>> -    int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
>>>> -
>>>> -    for (i = 0; i < num_rsvs; i++) {
>>>> -        uint64_t rsv_start, rsv_size;
>>>> -
>>>> -        ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
>>>> -        if (ret) {
>>>> -            pr_err("Malformed device tree.\n");
>>>> -            return -EINVAL;
>>>> -        }
>>>> -
>>>> -        if (rsv_start == start && rsv_size == size) {
>>>> -            ret = fdt_del_mem_rsv(fdt, i);
>>>> -            if (ret) {
>>>> -                pr_err("Error deleting device tree reservation.\n");
>>>> -                return -EINVAL;
>>>> -            }
>>>> -
>>>> -            return 0;
>>>> -        }
>>>> -    }
>>>> -
>>>> -    return -ENOENT;
>>>> -}
>>>> -
>>>>   /*
>>>>    * setup_new_fdt - modify /chosen and memory reservation for the next
>>>> kernel
>>>>    * @image:        kexec image being loaded.
>>>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>>>> index 6e1e5212f058..77d24712c0c8 100644
>>>> --- a/drivers/of/Makefile
>>>> +++ b/drivers/of/Makefile
>>>> @@ -13,5 +13,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>>>>   obj-$(CONFIG_OF_RESOLVE)  += resolver.o
>>>>   obj-$(CONFIG_OF_OVERLAY) += overlay.o
>>>>   obj-$(CONFIG_OF_NUMA) += of_numa.o
>>>> +obj-$(CONFIG_OF_FLATTREE) += kexec.o
>>>
>>> Isn't this too broad? kexec.o will only be useful to kernel configs
>>> which enable CONFIG_KEXEC_FILE, so perhaps do:
>>>
>>> ifdef CONFIG_OF_FLATTREE
>>> ifdef CONFIG_KEXEC_FILE
>>> obj-y += kexec.o
>>> endif
>>> endif
>>>
>>> What do you think?
>> Per Rob's feedback on v9 patch set, I have moved all the architecture 
>> independent ima kexec functions to a single file "drivers/of/kexec.c"
>> Since these functions are enabled on different kernel CONFIGs, I have 
>> used IS_ENABLED(CONFIG_XYZ) macro instead of "#ifdef" in the C file to
>> conditionally compile.
> Per Rob's feedback on the v9 patch, I'll keep the ima kexec functions in a
> single file (in "drivers/of/kexec.c") and use IS_ENABLED() macro to handle the
> function calls.
>
> I'll make the other changes you'd suggested on v10 patches and will post v11
> patch set shortly.

From a cursory look at the use of functions in this file, I got the
impression that there wouldn't be any reference to them in kernel
configs that didn't have CONFIG_KEXEC_FILE enabled, which is why I
suggested the change above. I think you can make it without any other
changes to the code.

I could be wrong though, and there could be some config which tried to
use some of these functions even when CONFIG_KEXEC_FILE is disabled. In
that case, the customary way to resolve it is to provide static inline
stub versions in a header file (not in a .c file) of just those
functions that are needed.

The reason why placing stub functions in header files is better is that
then the compiler has visibility of the dummy function when compiling
the source file which uses the function, and is able to eliminate the
dead code that arises from the function always returning one value.

Using IS_ENABLED() to do an early return as the first operation in the
function in a separate .c file means that the compiler doesn't know
anything and has to put a jump to the dummy function (only to
immediately return), and retain the code that deals with the possibility
of different values being returned.

It's not a big deal in this case because none of these functions is in a
hot path, but it does make the kernel text a tiny bit bigger than
necessary.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
