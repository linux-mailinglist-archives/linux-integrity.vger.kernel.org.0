Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED0B8891
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Sep 2019 02:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391734AbfITAcG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Sep 2019 20:32:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33192 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391700AbfITAcG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Sep 2019 20:32:06 -0400
Received: from [10.200.157.35] (unknown [131.107.174.35])
        by linux.microsoft.com (Postfix) with ESMTPSA id 021A920B718D;
        Thu, 19 Sep 2019 17:32:04 -0700 (PDT)
Subject: Re: [RFC PATCH v1 1/1] Add support for arm64 to carry ima measurement
 log in kexec_file_load
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de,
        takahiro.akashi@linaro.org, sboyd@kernel.org,
        catalin.marinas@arm.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        kristina.martsenko@arm.org, duwe@lst.de, allison@lohutok.net,
        james.morse@arm.org, linux-integrity@vger.kernel.org,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
References: <20190913225009.3406-1-prsriva@linux.microsoft.com>
 <20190913225009.3406-2-prsriva@linux.microsoft.com>
 <1568816111.16709.68.camel@linux.ibm.com>
 <1568841696.4733.3.camel@linux.ibm.com>
 <871rwd2ay8.fsf@morokweng.localdomain>
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
Message-ID: <ed2dc633-c691-6789-9c70-e7d37f436a49@linux.microsoft.com>
Date:   Thu, 19 Sep 2019 17:32:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <871rwd2ay8.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/18/2019 8:59 PM, Thiago Jung Bauermann wrote:
> Mimi Zohar <zohar@linux.ibm.com> writes:
>
>> On Wed, 2019-09-18 at 10:15 -0400, Mimi Zohar wrote:
>>
>>>> +	uint64_t tmp_start, tmp_end;
>>>> +
>>>> +	propStart = of_find_property(of_chosen, "linux,ima-kexec-buffer",
>>>> +				     NULL);
>>>> +	if (propStart) {
>>>> +		tmp_start = fdt64_to_cpu(*((const fdt64_t *) propStart));
>>>> +		ret = of_remove_property(of_chosen, propStart);
>>>> +		if (!ret) {
>>>> +			return ret;
>>>> +		}
>>>> +
>>>> +		propEnd = of_find_property(of_chosen,
>>>> +					   "linux,ima-kexec-buffer-end", NULL);
>>>> +		if (!propEnd) {
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		tmp_end = fdt64_to_cpu(*((const fdt64_t *) propEnd));
>>>> +
>>>> +		ret = of_remove_property(of_chosen, propEnd);
>>>> +		if (!ret) {
>>>> +			return ret;
>>>> +		}
>>> There seems to be quite a bit of code duplication in this function and
>>> in ima_get_kexec_buffer().  It could probably be cleaned up with some
>>> refactoring.
>> Sorry, my mistake.  One calls of_get_property(), while the other calls
>> of_find_property().
> of_get_property() is a thin wrapper around of_find_property(), so if
> that's the only difference I think they can still be merged.

I will move to using of_get_property and see if i can reduce the code 
further.

Also address other comments by Mimi in my next iteration.

Thanks,

Prakhar Srivastava

