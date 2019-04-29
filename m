Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60B5FE68A
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2019 17:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfD2Pa5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Apr 2019 11:30:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57926 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbfD2Pa4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Apr 2019 11:30:56 -0400
Received: from [10.91.6.157] (unknown [131.107.159.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id 50C6B32376D4;
        Mon, 29 Apr 2019 08:30:55 -0700 (PDT)
Subject: Re: linux-tpmdd self signed kernel failing to boot with secreboot on
To:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <f9ad2e46-e458-6c78-76da-b85db4601ee3@linux.microsoft.com>
 <CACdnJuuhiQQ8Uq1A_qfidCLVPVQ_3Ty_Kqg+tQPDx2z3P0Yp9w@mail.gmail.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <6373c67f-ea2f-ae1d-0343-4bb774f1d52f@linux.microsoft.com>
Date:   Mon, 29 Apr 2019 08:30:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACdnJuuhiQQ8Uq1A_qfidCLVPVQ_3Ty_Kqg+tQPDx2z3P0Yp9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/25/19 2:47 PM, Matthew Garrett wrote:
> On Wed, Apr 24, 2019 at 11:30 AM 'Jordan' via mjg59 <mjg59@google.com> wrote:
>> Under the following circumstances my kernel will not boot:
> 
> Will it boot under other circumstances (ie, if you disable Secure
> Boot, does it work fine with the patches?)

Yes it works fine if secure boot is disabled.

> 
>> I have traced kernel boot to the call to efi_exit_boot_services in
>> arch/x86/boot/compressed/eboot at which point execution terminates. I
>> see Matthew has made a couple changes in efi_main which calls exit_boot
>> (and in turn calls efi_exit_boot_services).
> 
> Does the boot hang or does the machine reboot?
> 

The boot hangs.

I haven't had a chance yet but I'll try it out with upstream grub this 
week (instead of the Ubuntu package) and see if maybe its grub doing 
something weird.
