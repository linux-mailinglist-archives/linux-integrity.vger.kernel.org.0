Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E272229F4D
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 20:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbgGVSe2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 14:34:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38104 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGVSe2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 14:34:28 -0400
Received: from [192.168.1.21] (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 53C3B20B4908;
        Wed, 22 Jul 2020 11:34:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53C3B20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595442867;
        bh=lumykPH8Xv1/KoymF5J+Y+VzAg7ZcGzcBw2d6BcnvsE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QrMJjfE7BaMprZE/Ryn0ngnVALf4tLPeP+9Rlu86ipzLCzvS/YngXoguHXyad8FvD
         msditzPnc395I1vXYK9wSyySlfr0w4Awpi44RzdIra1pil8x99uFmcKQtFKL81Xb8t
         DjuOtSPqbzeRk+occtOJMSgatQFbQblsnQdpQ6BA=
Subject: Re: [PATCH v2] IMA: Add test for kexec cmdline measurement
To:     Mimi Zohar <zohar@linux.ibm.com>, pvorel@suse.cz,
        ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
References: <20200722164040.23109-1-t-josne@linux.microsoft.com>
 <1595441389.5211.1.camel@linux.ibm.com>
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
Message-ID: <d1908820-cb58-6196-3ecd-243aa7a652bf@linux.microsoft.com>
Date:   Wed, 22 Jul 2020 14:34:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595441389.5211.1.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thank you for signing off on this patch!

I apologize for the issues on applying. I should've caught the trailing 
spaces, but the inability to apply the README
is actually a result of this patch being based on the custom keyring 
patch that I sent out last Friday [1].

[1]: [PATCH] IMA: Add a test to verify importing a certificate into 
custom keyring

On 7/22/20 2:09 PM, Mimi Zohar wrote:
> On Wed, 2020-07-22 at 12:40 -0400, Lachlan Sneff wrote:
>> IMA policy can be set to measure the command line passed in the kexec system call.
>> There needs to be a test to validate this kexec command line measurement.
>>
>> Add a testcase that verifies that the IMA subsystem has correctly
>> measured the cmdline specified during a kexec.
>>
>> Note that this test does not actually reboot.
>>
>> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> Other than the patch not applying cleanly and leading blanks,
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

