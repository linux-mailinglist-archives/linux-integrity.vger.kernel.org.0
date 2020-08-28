Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B1B255FF7
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 19:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgH1RqP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 13:46:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57694 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1RqO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 13:46:14 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9706920B7178;
        Fri, 28 Aug 2020 10:46:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9706920B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598636773;
        bh=m37BaxWxUXh3A97LPLILcR9FmKnNZX9n5ZLW8ZhgKzA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DxLnbNzw0LBuLnBudQJkFay0TVSMAkA5Yfunem0PmWAqYVz3/cqwFwnhU3nC7DRpo
         z/f4oaZ4BZcwekMW5SNIARBu3FkcG/5NgHAS6kjA2roHwpV8XreNzuXEJixg7i7nE3
         4pThmLJOor1xMgZ1Ul0ziOdPp2z/vn4B4lu9KPG8=
Subject: Re: [PATCH v4 2/5] powerpc: Use libfdt functions to fetch IMA buffer
 properties
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
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
References: <20200819172134.11243-1-nramas@linux.microsoft.com>
 <20200819172134.11243-3-nramas@linux.microsoft.com>
 <8736478x7l.fsf@morokweng.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <53685243-60b6-b21b-7f48-827bb296aa72@linux.microsoft.com>
Date:   Fri, 28 Aug 2020 10:46:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8736478x7l.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/27/20 4:50 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> @@ -63,7 +29,22 @@ void remove_ima_buffer(void *fdt, int chosen_node)
>>   	if (!prop)
>>   		return;
>>   
>> -	ret = do_get_kexec_buffer(prop, len, &addr, &size);
>> +	ret = fdt_address_cells(fdt, chosen_node);
> 
> This change was already present in the previous version of the patch but
> it was just today that I noticed a problem: there's no #address-cells
> property in /chosen. This code will still work though because if there's
> no property this function returns 2 which is the correct value for
> ppc64. But it's conceptually wrong. You need to pass the node offset for
> / so that it gets the #address-cells property from there.

Thanks for the info.
Will fix this.

> 
>> +	if (ret < 0)
>> +		return;
>> +	addr_cells = ret;
>> +
>> +	ret = fdt_size_cells(fdt, chosen_node);
> 
> Here we're not so lucky. The default value returned when no #size-cells
> property is present is 1, which is wrong for ppc64 so this change
> introduces a bug. You also need to pass the node offset for / here.

Will fix this.

> 
>> +	if (ret < 0)
>> +		return;
>> +	size_cells = ret;
>> +
>> +	if (len < 4 * (addr_cells + size_cells))
>> +		return;
>> +
>> +	addr = of_read_number(prop, addr_cells);
>> +	size = of_read_number(prop + 4 * addr_cells, size_cells);
>> +
>>   	fdt_delprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER);
>>   	if (ret)
>>   		return;
>> @@ -129,9 +110,15 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>>   	if (!image->arch.ima_buffer_size)
>>   		return 0;
>>   
>> -	ret = get_addr_size_cells(&addr_cells, &size_cells);
>> -	if (ret)
>> +	ret = fdt_address_cells(fdt, chosen_node);
>> +	if (ret < 0)
>> +		return ret;
>> +	addr_cells = ret;
>> +
>> +	ret = fdt_size_cells(fdt, chosen_node);
>> +	if (ret < 0)
>>   		return ret;
>> +	size_cells = ret;
>>   
>>   	entry_size = 4 * (addr_cells + size_cells);
> 
> Ditto here.
> 

Will fix this.

thanks,
  -lakshmi
