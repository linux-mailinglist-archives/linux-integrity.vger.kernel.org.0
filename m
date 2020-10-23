Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EB52968E4
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Oct 2020 05:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369886AbgJWDsk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Oct 2020 23:48:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2508690AbgJWDsk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Oct 2020 23:48:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09N3Vn1m091859;
        Thu, 22 Oct 2020 23:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=xAYDfmymI+Ty800nDVHYH/CaeH2ar053zNVW+bwUMn8=;
 b=lKiNhpQA7ySDrEkM2LUts/UM5STTnISQXZMuGhk1bjqgo2/1S7fF2ngySOb946cOqB7w
 L9pDsESCZVqlMP8UjIfBEwGqTPZ36S0+lAu/O+liCx1JUXiwIwudL//6dtgtCmSxa+17
 trYsuwBLGXUbvCb+Tw+Av7E+Y3qCH68yL7NWr0e/6nyFkIt/OYOrx56GivSba1b8/L43
 dfBiRzPQM8Erv215AvN6z2S2OgLPOzW8PtrADzRl/PFcU9fFZrH7T9r2l9lACqufxnFW
 rwdeay0aT06ACw2gXJDzGAkRmvIa30RifUnpwsIDI+fZCTQFK4/CjigPWLkc4sXFX/xm lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34b0vsfyde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 23:47:12 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09N3Vopn092412;
        Thu, 22 Oct 2020 23:47:11 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34b0vsfycr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 23:47:11 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09N3l0Gs028042;
        Fri, 23 Oct 2020 03:47:10 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 34bhyqaen5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 03:47:10 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09N3l1N539518582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Oct 2020 03:47:01 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0413C605B;
        Fri, 23 Oct 2020 03:47:08 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BE50C6055;
        Fri, 23 Oct 2020 03:47:01 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.157.146])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 23 Oct 2020 03:47:01 +0000 (GMT)
References: <20200930205941.1576-1-nramas@linux.microsoft.com>
 <20200930205941.1576-2-nramas@linux.microsoft.com>
 <bfaadaffafa3b8c12fce7e8491ea77e22a5821a8.camel@linux.ibm.com>
 <81c4a9ce-c363-a87a-06de-4a8729702b97@linux.microsoft.com>
 <a6c3e3ecb5c1c6f35b747f1ea4d8261667f9a376.camel@linux.ibm.com>
 <af13db86-09c1-db12-330e-57e24bd07b9a@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [PATCH v7 1/4] powerpc: Refactor kexec functions to move arch
 independent code to kernel
In-reply-to: <af13db86-09c1-db12-330e-57e24bd07b9a@linux.microsoft.com>
Date:   Fri, 23 Oct 2020 00:46:58 -0300
Message-ID: <87v9f1eh8t.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-23_01:2020-10-20,2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=2 impostorscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230024
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hello Lakshmi,

Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> On 10/20/20 8:17 PM, Mimi Zohar wrote:
>> On Tue, 2020-10-20 at 19:25 -0700, Lakshmi Ramasubramanian wrote:
>>> On 10/20/20 1:00 PM, Mimi Zohar wrote:
>>>> Hi Lakshmi,
>>>>
>>>> On Wed, 2020-09-30 at 13:59 -0700, Lakshmi Ramasubramanian wrote:
>>>>> The functions remove_ima_buffer() and delete_fdt_mem_rsv() that handle
>>>>> carrying forward the IMA measurement logs on kexec for powerpc do not
>>>>> have architecture specific code, but they are currently defined for
>>>>> powerpc only.
>>>>>
>>>>> remove_ima_buffer() and delete_fdt_mem_rsv() are used to remove
>>>>> the IMA log entry from the device tree and free the memory reserved
>>>>> for the log. These functions need to be defined even if the current
>>>>> kernel does not support carrying forward IMA log across kexec since
>>>>> the previous kernel could have supported that and therefore the current
>>>>> kernel needs to free the allocation.
>>>>>
>>>>> Rename remove_ima_buffer() to remove_ima_kexec_buffer().
>>>>> Define remove_ima_kexec_buffer() and delete_fdt_mem_rsv() in kernel.
>>>>> A later patch in this series will use these functions to free
>>>>> the allocation, if any, made by the previous kernel for ARM64.
>>>>>
>>>>> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
>>>>> "linux,ima-kexec-buffer", that is added to the DTB to hold
>>>>> the address and the size of the memory reserved to carry
>>>>> the IMA measurement log.
>>>>
>>>>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>>> Reported-by: kernel test robot <lkp@intel.com> error: implicit declaration of function 'delete_fdt_mem_rsv' [-Werror,-Wimplicit-function-declaration]
>>>>
>>>> Much better!  This version limits unnecessarily changing the existing
>>>> code to adding a couple of debugging statements, but that looks to be
>>>> about it.
>>> Yes Mimi - that's correct.
>>>
>>>>
>>>> Based on Chester Lin's "ima_arch" support for arm64 discussion, the IMA generic
>>>> EFI support will be defined in ima/ima-efi.c.  Similarly, I think it would make sense to put the generic device tree support in ima/ima_kexec_fdt.c or ima/ima_fdt.c, as opposed to kernel/.  (Refer to my comments on 2/4 about the new file named ima_kexec_fdt.c.)
>>>
>>> The functions remove_ima_kexec_buffer() and delete_fdt_mem_rsv(), which
>>> are defined in kernel/ima_kexec.c and kernel/kexec_file_fdt.c
>>> respectively, are needed even when CONFIG_IMA is not defined. These
>>> functions need to be called by the current kernel to free the ima kexec
>>> buffer resources allocated by the previous kernel. This is the reason,
>>> these functions are defined under "kernel" instead of
>>> "security/integrity/ima".
>>>
>>> If there is a better location to move the above C files, please let me
>>> know. I'll move them.
>> Freeing the previous kernel measurement list is currently called from
>> ima_load_kexec_buffer(), only after the measurement list has been
>> restored.  The only other time the memory is freed is when the
>> allocated memory size isn't sufficient to hold the measurement list,
>> which could happen if there is a delay between loading and executing
>> the kexec.
>> 
>
> There are two "free" operations we need to perform with respect to ima buffer on
> kexec:
>
> 1, The ima_free_kexec_buffer() called from ima_load_kexec_buffer() - the one you
> have stated above.
>
> Here we remove the "ima buffer" node from the "OF" tree and free the memory
> pages that were allocated for the measurement list.
>
> This one is already present in ima and there's no change in that in my patches.
>
> 2, The other one is remove_ima_kexec_buffer() called from setup_ima_buffer()
> defined in "arch/powerpc/kexec/ima.c"
>
>  This function removes the "ima buffer" node from the "FDT" and also frees the
> physical memory reserved for the "ima measurement list" by the previous kernel.
>
>  This "free" operation needs to be performed even if the current kernel does not
> support IMA kexec since the previous kernel could have passed the IMA
> measurement list (in FDT and reserved physical memory).
>
> For this reason, remove_ima_kexec_buffer() cannot be defined in "ima" but some
> other place which will be built even if ima is not enabled. I chose to define
> this function in "kernel" since that is guaranteed to be always built.
>
> thanks,
>  -lakshmi

That is true. I believe a more fitting place for these functions is
drivers/of/fdt.c rather than these new files in kernel/. Both CONFIG_PPC
and CONFIG_ARM64 select CONFIG_OF and CONFIG_OF_FLATTREE (indirectly,
via CONFIG_OF_EARLY_FLATTREE) so they will both build that file.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
