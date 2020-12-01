Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF8D2CAB4B
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 20:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgLATCG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 14:02:06 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54504 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgLATCD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 14:02:03 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 71EEF20B717A;
        Tue,  1 Dec 2020 11:01:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71EEF20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1606849281;
        bh=thg+G7tmZaXvqu0d76zq83r1bh38JthvhLkJ7f6kO14=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X70fYY32uF3uiNY5vqzOsW0Vs66PjW4ff/oqD1cbN8qmVVylMgPOH29tBQyWwYR9p
         CKetQjtzZFSTLg/AzrsjP6A4pbGqN1BekeZ6qwgQ1VrH2yDNmtGfuo3nGs9HI8JeMV
         2Vvc3qGAuWcj8KORawOhlC1cMPVmeIYAc8XdrdSU=
Subject: Re: [PATCH v9 3/8] ima: Define get_ima_kexec_buffer() in drivers/of
To:     Mimi Zohar <zohar@linux.ibm.com>, bauerman@linux.ibm.com,
        robh@kernel.org, gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
 <20201113192243.1993-4-nramas@linux.microsoft.com>
 <5c2a18f72af861be6494c2f325e83835be8e2f7e.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <56f8a840-a61a-1ab1-bb37-419ac1338e81@linux.microsoft.com>
Date:   Tue, 1 Dec 2020 11:01:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5c2a18f72af861be6494c2f325e83835be8e2f7e.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/1/20 3:37 AM, Mimi Zohar wrote:
> On Fri, 2020-11-13 at 11:22 -0800, Lakshmi Ramasubramanian wrote:
>> The function do_get_kexec_buffer(), defined in arch/powerpc/kexec/ima.c,
>> retrieves the address and size of the given property from the device
>> tree blob. This function does not have architecture specific code, but is
>> currently limited to powerpc. This function correctly handles a device
>> tree property that is a child node of the root node, but not anything
>> other than the immediate root child nodes.
>>
>> Define an architecture independent function, namely
>> get_ima_kexec_buffer(), in "drivers/of/ima_kexec.c". This function
>> retrieves the chosen node, namely "linux,ima-kexec-buffer", from
> 
> Please remove the word "namely", here, and throughout the patch sets.
> 
>> the device tree, and returns the address and size of the buffer used
>> for carrying forward the IMA measurement log across kexec system call.
> 
> get_ima_kexec_buffer() inlines the existing do_get_kexec_buffer() and
> get_addr_size_cells() functions, leaving a local copy of
> get_addr_size_cells().   Duplicating code isn't a good idea.
> 

I'll move get_addr_size_cells() also to drivers/of/ima_kexec.c

thanks,
  -lakshmi


