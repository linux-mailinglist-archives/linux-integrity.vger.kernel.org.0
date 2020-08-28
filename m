Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17417255FEB
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgH1RnF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 13:43:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57268 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgH1RnE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 13:43:04 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D77FF20B7178;
        Fri, 28 Aug 2020 10:43:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D77FF20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598636583;
        bh=R1teKYMBu8vqBarNApY+0V5H5gqlUpnadI+DlmuIfsE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Eb1mFosaUNV1b7GJ+N7ycdSRcKkXRNZk2TPFWumkuIBTMLHmYXvUsakCrI/APb6NE
         1BQJx48cUzUhwM1mYG3IbKLdRaHjhSTU/JppL9Gzg4Q14y9xprUO3hD+u8blF6P7QG
         5yyVKJuMIRIxHE848wVLyijPOwOmJHyyNfxRENWU=
Subject: Re: [PATCH v4 1/5] powerpc: Refactor kexec functions to move arch
 independent code to IMA
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
 <20200819172134.11243-2-nramas@linux.microsoft.com>
 <87wo1j7ed0.fsf@morokweng.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <80c4ee1b-6bab-237e-503d-556f344f7df9@linux.microsoft.com>
Date:   Fri, 28 Aug 2020 10:43:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87wo1j7ed0.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/27/20 6:23 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> +/**
>> + * ima_get_kexec_buffer - get IMA buffer from the previous kernel
>> + * @addr:	On successful return, set to point to the buffer contents.
>> + * @size:	On successful return, set to the buffer size.
>> + *
>> + * Return: 0 on success, negative errno on error.
>> + */
>> +int ima_get_kexec_buffer(void **addr, size_t *size)
> 
> I just noticed that this function is only called from within
> ima_kexec.c, so it can be made static.

Will do.

> 
>> +{
>> +	int ret, len;
>> +	unsigned long tmp_addr;
>> +	size_t tmp_size;
>> +	const void *prop;
>> +
>> +	prop = of_get_property(of_chosen, FDT_PROP_IMA_KEXEC_BUFFER, &len);
>> +	if (!prop)
>> +		return -ENOENT;
>> +
>> +	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*addr = __va(tmp_addr);
>> +	*size = tmp_size;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ima_free_kexec_buffer - free memory used by the IMA buffer
>> + */
>> +int ima_free_kexec_buffer(void)
> 
> This one can be static as well.

Will do.

  -lakshmi

> 
>> +{
>> +	int ret;
>> +	unsigned long addr;
>> +	size_t size;
>> +	struct property *prop;
>> +
>> +	prop = of_find_property(of_chosen, FDT_PROP_IMA_KEXEC_BUFFER, NULL);
>> +	if (!prop)
>> +		return -ENOENT;
>> +
>> +	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = of_remove_property(of_chosen, prop);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return memblock_free(addr, size);
>> +
>> +}
>> +
>>   #ifdef CONFIG_IMA_KEXEC
>>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   				     unsigned long segment_size)
> 
> 

