Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8373062E1
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 19:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhA0SA0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 13:00:26 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52150 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhA0SAU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 13:00:20 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8887120B7192;
        Wed, 27 Jan 2021 09:59:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8887120B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611770379;
        bh=u6YDtCnPbqCR0gis78ss8Y7oDmOQBhIrTOjdneH59BY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I8l5HtBlTBedrIQBGerHNcZYLR35V9yPxqkGcZTZfVC0F5ANK7kYqJko9VbWh+e4B
         WyL8zYfK6cVs+7f5JIUpGAoDBqNXBX/k77L3StP9OpEO0arTI6RNBm0OBKhV02U7da
         3QrrsCCB5/Mu3bh4h0E8igoAVJJmAiIbLxoo4p9A=
Subject: Re: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
To:     Will Deacon <will@kernel.org>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
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
        linuxppc-dev@lists.ozlabs.org
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
 <20210115173017.30617-10-nramas@linux.microsoft.com>
 <20210127165208.GA358@willie-the-truck>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <d3330793-6054-6e59-b727-44bf8e5653cd@linux.microsoft.com>
Date:   Wed, 27 Jan 2021 09:59:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127165208.GA358@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/27/21 8:52 AM, Will Deacon wrote:

Hi Will,

> On Fri, Jan 15, 2021 at 09:30:16AM -0800, Lakshmi Ramasubramanian wrote:
>> create_dtb() function allocates kernel virtual memory for
>> the device tree blob (DTB).  This is not consistent with other
>> architectures, such as powerpc, which calls kmalloc() for allocating
>> memory for the DTB.
>>
>> Call kmalloc() to allocate memory for the DTB, and kfree() to free
>> the allocated memory.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   arch/arm64/kernel/machine_kexec_file.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index 7de9c47dee7c..51c40143d6fa 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -29,7 +29,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>>   
>>   int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>   {
>> -	vfree(image->arch.dtb);
>> +	kfree(image->arch.dtb);
>>   	image->arch.dtb = NULL;
>>   
>>   	vfree(image->arch.elf_headers);
>> @@ -59,19 +59,21 @@ static int create_dtb(struct kimage *image,
>>   			+ cmdline_len + DTB_EXTRA_SPACE;
>>   
>>   	for (;;) {
>> -		buf = vmalloc(buf_size);
>> +		buf = kmalloc(buf_size, GFP_KERNEL);
> 
> Is there a functional need for this patch? I build the 'dtbs' target just
> now and sdm845-db845c.dtb is approaching 100K, which feels quite large
> for kmalloc().

Changing the allocation from vmalloc() to kmalloc() would help us 
further consolidate the DTB setup code for powerpc and arm64.

thanks,
  -lakshmi


