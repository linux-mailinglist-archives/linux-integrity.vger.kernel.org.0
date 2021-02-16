Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9931C79D
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 09:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhBPIvX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 03:51:23 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:52375 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229662AbhBPIvW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 03:51:22 -0500
Received: from [192.168.0.6] (ip5f5aea7e.dynamic.kabel-deutschland.de [95.90.234.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 91F6420647912;
        Tue, 16 Feb 2021 09:50:40 +0100 (CET)
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in tpm_tis_gen_interrupt()
 and tpm_get_timeouts()
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, Lukasz Majczak <lma@semihalf.com>,
        Laurent Bigonville <bigon@debian.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
References: <20210216081750.191250-1-jarkko@kernel.org>
 <5bd42a4c-56db-3be5-953f-a85336fe0175@molgen.mpg.de>
 <YCuEwiBmV5067AYj@kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <bcd119a8-e4e7-395f-f88d-1f4789a13bc1@molgen.mpg.de>
Date:   Tue, 16 Feb 2021 09:50:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCuEwiBmV5067AYj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Jarko,


Am 16.02.21 um 09:39 schrieb Jarkko Sakkinen:
> On Tue, Feb 16, 2021 at 09:26:49AM +0100, Paul Menzel wrote:

>> Am 16.02.21 um 09:17 schrieb Jarkko Sakkinen:
>>> From: Lukasz Majczak <lma@semihalf.com>
>>>
>>> This is shown with Samsung Chromebook Pro (Caroline) with TPM 1.2
>>> (SLB 9670):
>>>
>>> [    4.324298] TPM returned invalid status
>>> [    4.324806] WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:275 tpm_tis_status+0x86/0x8f
>>>
>>> Background
>>> ==========
>>>
>>> TCG PC Client Platform TPM Profile (PTP) Specification, paragraph 6.1 FIFO
>>> Interface Locality Usage per Register, Table 39 Register Behavior Based on
>>> Locality Setting for FIFO - a read attempt to TPM_STS_x Registers returns
>>> 0xFF in case of lack of locality. The described situation manifests itself
>>> with the following warning trace:
>>
>> Did you miss to paste the trace?
>>
>> […]

> There is partial trace, which I took from the Lukasz patch. IMHO that is
> sufficient.

Reading the paragraph with “ with the following warning trace:” (and 
colon), I would expect to see some trace, and not the next section 
header *The fix*.

> And I have no means to generate the full trace anyway.

No problem.


Kind regards,

Paul
