Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455042A500C
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 20:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgKCTX4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 14:23:56 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59230 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgKCTX4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 14:23:56 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id AE7C320B4905;
        Tue,  3 Nov 2020 11:23:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE7C320B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604431435;
        bh=cs89L/JSwQ4PBZQ9fMSdMK2jKgvcRPsdCyr6JSRaH3M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GKn7Me70XCoz1djbJxVdpP5W78oyHhN77zDj5VwRM/ygOVttppLfAwYfrsowfXBSS
         Kn73G43Jiuo9J19WlT4CQfKThwAgv1m7alRvQgBJkbdIiI/2PbChAJx2rJn44pxuJG
         KwnQ9+7ewrIUz5EPQPkwZUWqcmxQ0mapDGv92nsc=
Subject: Re: [PATCH v8 2/4] powerpc: Refactor kexec functions to move arch
 independent code to ima
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
References: <20201030174429.29893-1-nramas@linux.microsoft.com>
 <20201030174429.29893-3-nramas@linux.microsoft.com>
 <87f63dc12739b346d556f85537324d3ae055097d.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <397f1bbf-46bf-b522-616b-2e006ef30e70@linux.microsoft.com>
Date:   Tue, 3 Nov 2020 11:23:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87f63dc12739b346d556f85537324d3ae055097d.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/3/20 6:55 AM, Mimi Zohar wrote:

Hi Mimi,

> 
> On Fri, 2020-10-30 at 10:44 -0700, Lakshmi Ramasubramanian wrote:
>> The functions ima_get_kexec_buffer() and ima_free_kexec_buffer(),
>> that handle carrying forward the IMA measurement logs on kexec for
>> powerpc do not have architecture specific code, but they are currently
>> defined for powerpc only.
>>
>> Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to IMA
>> subsystem. A later patch in this series will use these functions for
>> carrying forward the IMA measurement log for ARM64.
>>
>> With the above refactoring arch/powerpc/kexec/ima.c contains only
>> functions used when CONFIG_IMA_KEXEC is enabled. Update Makefile
>> in arch/powerpc/kexec to include arch/powerpc/kexec/ima.c only
>> when CONFIG_IMA_KEXEC is enabled.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> Similar comments to 1/4.
> -  Last line of first paragraph can be rephrased like " ... on kexec,
> do not contain architecture specific code, but are currently limited to
> powerpc."
Sure.

> -  This patch should be limited to moving existing functions.
> Truncate the Subject line to "Move arch independent IMA kexec functions
> to ima_kexec.c."
Will do.

> - Don't refer to a later patch, but explain the purpose here.  For
> example, "Move ... , making them accessible to other archs."
Sure.

> - The definition of "FDT_PROP_IMA_KEXEC_BUFFER" should be made as a
> separate, prepartory patch, prior to the existing 1/4.  The resulting
> code being moved in this patch (and similarly for 1/4) will be exactly
> the same as the code being deleted.

Definition of FDT_PROP_IMA_KEXEC_BUFFER will be made as a preparatory 
patch as you'd mentioned in the comments for [PATCH 1/4].

Will split [PATCH 2/4] as listed below:

PATCH #1: Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to 
IMA, along with deleting them in arch/powerpc/kexec/ima.c

PATCH #2: Update arch/powerpc/kexec/Makefile and
           arch/powerpc/kexec/ima.c
           to compile when CONFIG_IMA_KEXEC is defined.

thanks,
  -lakshmi
