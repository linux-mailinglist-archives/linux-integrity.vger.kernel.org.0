Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448B9306C1D
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jan 2021 05:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhA1EQ3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 23:16:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231400AbhA1EQM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 23:16:12 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10S41sEk194154;
        Wed, 27 Jan 2021 23:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=rzdWeCeDaDZ75/E3nrAbc0/tPvq1J7TvmXi13WDek9k=;
 b=ZrfRqqM52DyJ+gPNe88xOWZ5pPCi3RhAnqLFx6ODGpkKfjFMUfHhXa/roKG2/ZVx25f1
 Ex4Kg3rC2vJyWwl5Yucbkdn8GvCXGv0X3Aesas15EM/79OyGS0fVGV8z1QYkxdWGUEg2
 lWWszueNUsZYAzdcyPWyI9iydaWXoJ/+hUZWDazKZpmlxWTZOkM3sQaZ/Nm6o3yUeCPS
 sGeC5OiLGlTfrHoItf6gxuU4STEHSrAwZg3xkUWGC0Qp+ZfLWx8zkJHhlEdHPLjRplz9
 jA2YxxS5EXpXEK2gaoC1O99JaZzVXoDfbE1Erux0AIIwsbDD0PSvf8tfAkvDyjJioH4s dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36becsay0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 23:14:48 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10S42j3X001507;
        Wed, 27 Jan 2021 23:14:48 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36becsay07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 23:14:48 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10S3udQb013671;
        Thu, 28 Jan 2021 04:14:47 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 36a8uhfy03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 04:14:46 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10S4EiPM11403618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 04:14:44 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 776E47805F;
        Thu, 28 Jan 2021 04:14:44 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E3B97805C;
        Thu, 28 Jan 2021 04:14:36 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.200.195])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 28 Jan 2021 04:14:36 +0000 (GMT)
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
 <20210115173017.30617-10-nramas@linux.microsoft.com>
 <20210127165208.GA358@willie-the-truck>
 <d3330793-6054-6e59-b727-44bf8e5653cd@linux.microsoft.com>
 <20210127184319.GA676@willie-the-truck>
 <871re5soof.fsf@manicouagan.localdomain>
 <58d3ffbf-4d80-c893-34d6-366ebfac55bd@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Will Deacon <will@kernel.org>, zohar@linux.ibm.com,
        robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        mpe@ellerman.id.au, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
In-reply-to: <58d3ffbf-4d80-c893-34d6-366ebfac55bd@linux.microsoft.com>
Date:   Thu, 28 Jan 2021 01:14:34 -0300
Message-ID: <87y2gdr93p.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_01:2021-01-27,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280017
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> On 1/27/21 7:52 PM, Thiago Jung Bauermann wrote:
>> Will Deacon <will@kernel.org> writes:
>> 
>>> On Wed, Jan 27, 2021 at 09:59:38AM -0800, Lakshmi Ramasubramanian wrote:
>>>> On 1/27/21 8:52 AM, Will Deacon wrote:
>>>>
>>>> Hi Will,
>>>>
>>>>> On Fri, Jan 15, 2021 at 09:30:16AM -0800, Lakshmi Ramasubramanian wrote:
>>>>>> create_dtb() function allocates kernel virtual memory for
>>>>>> the device tree blob (DTB).  This is not consistent with other
>>>>>> architectures, such as powerpc, which calls kmalloc() for allocating
>>>>>> memory for the DTB.
>>>>>>
>>>>>> Call kmalloc() to allocate memory for the DTB, and kfree() to free
>>>>>> the allocated memory.
>>>>>>
>>>>>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>>>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>>>> ---
>>>>>>    arch/arm64/kernel/machine_kexec_file.c | 12 +++++++-----
>>>>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>>>>>> index 7de9c47dee7c..51c40143d6fa 100644
>>>>>> --- a/arch/arm64/kernel/machine_kexec_file.c
>>>>>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>>>>>> @@ -29,7 +29,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>>>>>>    int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>>>>>    {
>>>>>> -	vfree(image->arch.dtb);
>>>>>> +	kfree(image->arch.dtb);
>>>>>>    	image->arch.dtb = NULL;
>>>>>>    	vfree(image->arch.elf_headers);
>>>>>> @@ -59,19 +59,21 @@ static int create_dtb(struct kimage *image,
>>>>>>    			+ cmdline_len + DTB_EXTRA_SPACE;
>>>>>>    	for (;;) {
>>>>>> -		buf = vmalloc(buf_size);
>>>>>> +		buf = kmalloc(buf_size, GFP_KERNEL);
>>>>>
>>>>> Is there a functional need for this patch? I build the 'dtbs' target just
>>>>> now and sdm845-db845c.dtb is approaching 100K, which feels quite large
>>>>> for kmalloc().
>>>>
>>>> Changing the allocation from vmalloc() to kmalloc() would help us further
>>>> consolidate the DTB setup code for powerpc and arm64.
>>>
>>> Ok, but at the risk of allocation failure. Can powerpc use vmalloc()
>>> instead?
>> I believe this patch stems from this suggestion by Rob Herring:
>> 
>>> This could be taken a step further and do the allocation of the new
>>> FDT. The difference is arm64 uses vmalloc and powerpc uses kmalloc. The
>>> arm64 version also retries with a bigger allocation. That seems
>>> unnecessary.
>> in
>> https://lore.kernel.org/linux-integrity/20201211221006.1052453-3-robh@kernel.org/
>> The problem is that this patch implements only part of the suggestion,
>> which isn't useful in itself. So the patch series should either drop
>> this patch or consolidate the FDT allocation between the arches.
>> I just tested on powernv and pseries platforms and powerpc can use
>> vmalloc for the FDT buffer.
>> 
>
> Thanks for verifying on powerpc platform Thiago.
>
> I'll update the patch to do the following:
>
> => Use vmalloc for FDT buffer allocation on powerpc
> => Keep vmalloc for arm64, but remove the retry on allocation.
> => Also, there was a memory leak of FDT buffer in the error code path on arm64,
> which I'll fix as well.
>
> Did I miss anything?

Yes, you missed the second part of Rob's suggestion I was mentioning,
which is factoring out the code which allocates the new FDT from both
arm64 and powerpc.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
