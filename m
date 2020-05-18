Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF2E1D8941
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2020 22:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgERUeb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 May 2020 16:34:31 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39868 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERUeb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 May 2020 16:34:31 -0400
Received: from [10.0.0.249] (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 57B3620B717B;
        Mon, 18 May 2020 13:34:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57B3620B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1589834070;
        bh=6GRSvZ+sGLVcKGDOcmVDyb0gXRdx/T0QTMk1YgrIXo0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LW4xKvNPjvTQHNTCPc5dw87VMVrDKT0UTsZNlxXJSb2DhjQsGt1aArwi+2Pq25xMN
         S4zSHJ+EQn4yAg/KghG/RYbBFjia5QNFJZWhHHgsJ+dbDFHzqYrmxyRfw7yrJDSiU3
         PE4kQbDFbQkwN9xGgKO718cCWGbRNXaZolR1rV5E=
Subject: Re: [RFC][PATCH 1/2] Add a layer of abstraction to use the memory
 reserved by device tree for ima buffer pass.
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        gregkh@linuxfoundation.org, nramas@linux.microsoft.com,
        tusharsu@linux.microsoft.com, balajib@linux.microsoft.com
References: <20200504203829.6330-1-prsriva@linux.microsoft.com>
 <20200504203829.6330-2-prsriva@linux.microsoft.com>
 <20200512230954.GB2654@bogus>
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
Message-ID: <8b8bb74b-a3ac-1eb8-4b21-d00402a2bf62@linux.microsoft.com>
Date:   Mon, 18 May 2020 13:34:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512230954.GB2654@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/12/20 4:09 PM, Rob Herring wrote:
> On Mon, May 04, 2020 at 01:38:28PM -0700, Prakhar Srivastava wrote:
>> Introduce a device tree layer for to read and store ima buffer
>> from the reserved memory section of a device tree.
> 
> But why do I need 'a layer of abstraction'? I don't like them.
> 
This is a common path for the all architectures to carry over the
IMA measurement logs. A single layer will avoid any code duplication.

>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> ---
>>   drivers/of/Kconfig  |   6 ++
>>   drivers/of/Makefile |   1 +
>>   drivers/of/of_ima.c | 165 ++++++++++++++++++++++++++++++++++++++++++++
> 
> Who are the users of this code and why does it need to be here? Most
> code for specific bindings are not in drivers/of/ but with the user. It
> doesn't sound like there's more than 1 user.
> 
Currently the path is exercised by arm64 kexec_file_load path. A slight
restructuring is needed on the powerpc side to use the same code path 
and other architectures can follow to add carrying over IMA logs over
kexec with just a few function calls.

I have attempted to bring the code path down to the highest common 
layer, however please do suggest if i can move this some where else.

Thanks,
Prakhar

>>   include/linux/of.h  |  34 +++++++++
>>   4 files changed, 206 insertions(+)
>>   create mode 100644 drivers/of/of_ima.c
