Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9A3CC460
	for <lists+linux-integrity@lfdr.de>; Sat, 17 Jul 2021 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhGQQNF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 17 Jul 2021 12:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhGQQNF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 17 Jul 2021 12:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626538208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpxIhUFCIoKGexnXKikwy4qlOGj/cvbhZX1SMz32jSA=;
        b=LOZx5ZqUj8RQ3uOjjU8t75X1iVr3bM7bEIY+8a4D7KTKPFCureswuBcQqaBToHQL5T3fRL
        3K7RS3fPUZOI045RI5QUsv5BjtEcRKox1xgX1RkSkJ0QUuo3XlvmKbd0zWYL/VMQ2wUbUw
        c84MmrCV/3fGU0TJIHVra4x/u6kjtl0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-7PobV3W5PeWtL81my4usZQ-1; Sat, 17 Jul 2021 12:10:06 -0400
X-MC-Unique: 7PobV3W5PeWtL81my4usZQ-1
Received: by mail-ed1-f70.google.com with SMTP id x16-20020aa7d6d00000b02903a2e0d2acb7so6468373edr.16
        for <linux-integrity@vger.kernel.org>; Sat, 17 Jul 2021 09:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tpxIhUFCIoKGexnXKikwy4qlOGj/cvbhZX1SMz32jSA=;
        b=D8QuhBrGTw6DaF25L1lgfg10m9bZcWClCkJMzpE6zJPceEebZY0EI1LQ+TsrTxZfdO
         mt7q8C6tkFaCVY2QIQzJUvGaZ3tlB4EI8voJvb6cWoWXO83Tl/kId03UMYgOBlffcD9s
         KKQ56z1FHRbq1A//gCdnc1KRgFucE1XMScD9atsp4tjMjVawA6aRgOYbxMBmxGCKztU3
         EB1+9zP7yoIJc4VxeBFTWqi5CCMsK/5QCOAqPoNW2Hd+0INjiO5pPq6ViOGOpDmHrq1h
         GwAnGGuw8RjDy30PDn1VYPoxbkLRatUDtAIfCBDFWfRZx+uLh+KoCW+UMn9Y3o0KBfEr
         rPZA==
X-Gm-Message-State: AOAM531AwqEittELQ09EuUzfPc/DQPCB980YggGgEHfrEEngSa1JcKLH
        Rf++NGvlIjp5OKdOkHHlAET+LpzlqE+hUs5GrSDlOolNxVFerDOf12KUoA7N8+VTxv9t5LlFIOC
        7947Z5VjTjWsd+w+jbXFulzyPjjqf
X-Received: by 2002:a17:907:990d:: with SMTP id ka13mr18012329ejc.392.1626538205430;
        Sat, 17 Jul 2021 09:10:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdfHXK6LuHOvjZogLudZiHx69cxYtYi7lQZqJZGETY/aDfJKb1ypChxUqXluTJQhgvL3fzJA==
X-Received: by 2002:a17:907:990d:: with SMTP id ka13mr18012303ejc.392.1626538205150;
        Sat, 17 Jul 2021 09:10:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y11sm3999851ejr.14.2021.07.17.09.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 09:10:04 -0700 (PDT)
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel
 backtraces]
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
 <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
 <49bfb4a7-eb3c-77f9-ff8e-b37617a26195@redhat.com>
 <20210623134054.45gjj2wbgz7jpjmy@kernel.org>
 <90ed51b4-66d4-fb10-ca8e-d99532028fab@redhat.com>
 <20210629180445.oind62rsktevm45q@kernel.org>
 <b4398c5b-38dc-d511-ea29-0847bfca60b4@redhat.com>
 <20210629220516.xm3jvjy7v2uw3fvz@kernel.org>
 <29e72255-b995-9ffe-f379-5e9e349bee07@redhat.com>
 <8819200d-e468-7b09-2e08-e44f5f2ed59f@redhat.com>
 <20210709184426.7yftmufrmw3tp24s@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fa61681f-b07f-9d31-b193-9d42cd23167a@redhat.com>
Date:   Sat, 17 Jul 2021 18:10:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709184426.7yftmufrmw3tp24s@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 7/9/21 8:44 PM, Jarkko Sakkinen wrote:
> On Wed, Jun 30, 2021 at 03:36:55PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 6/30/21 2:47 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 6/30/21 12:05 AM, Jarkko Sakkinen wrote:
>>>> On Tue, Jun 29, 2021 at 09:14:39PM +0200, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 6/29/21 8:04 PM, Jarkko Sakkinen wrote:
>>>>>> On Wed, Jun 23, 2021 at 03:54:59PM +0200, Hans de Goede wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 6/23/21 3:40 PM, Jarkko Sakkinen wrote:
>>>>>>>> On Mon, Jun 21, 2021 at 02:04:52PM +0200, Hans de Goede wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On 6/14/21 3:33 PM, Hans de Goede wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On 6/1/21 6:04 PM, Hans de Goede wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
>>>>>>>>>>>>> Interestingly enough the first backtrace is also happening on a:
>>>>>>>>>>>>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
>>>>>>>>>>>>>
>>>>>>>>>>>>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
>>>>>>>>>>>>> all reports are about the XPS 13 9310. I wonder if there is an
>>>>>>>>>>>>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
>>>>>>>>>>>>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
>>>>>>>>>>>>
>>>>>>>>>>>> This is helpful for sure that these all are happening on matching hardware.
>>>>>>>>>>>
>>>>>>>>>>> So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
>>>>>>>>>>> with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
>>>>>>>>>>>
>>>>>>>>>>> 1. Backtrace starting with a call to ima_add_boot_aggregate
>>>>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
>>>>>>>>>>>
>>>>>>>>>>> 2. Backtrace starting with a call to tpm_dev_async_work:
>>>>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
>>>>>>>>>>> (note this one is not easily reproducible)
>>>>>>>>>>>
>>>>>>>>>>> 3. Backtrace starting with a call to rng_dev_read:
>>>>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
>>>>>>>>>>>
>>>>>>>>>>> 3. is the new one. All bugs linked above are public, all 3 backtraces
>>>>>>>>>>> so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
>>>>>>>>>>> and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.
>>>>>>>>>>
>>>>>>>>>> Quick status update, I've got a response from a XPS 13 9310 user in:
>>>>>>>>>>
>>>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
>>>>>>>>>>
>>>>>>>>>> Indicating that a. he can reproduce this with the latest >= 5.12.6 kernels;
>>>>>>>>>> and b. it goes away when specifying tpm_tis.interrupts=0 as I expected
>>>>>>>>>> (I expected this because all the bug-reports started when the interrupt
>>>>>>>>>> code got fixed/re-enabled a while ago).
>>>>>>>>>
>>>>>>>>> One more status update.
>>>>>>>>>
>>>>>>>>> - A new 4th variant of the backtrace has been spotted, where the problem hits
>>>>>>>>> when called from probe() -> tpm2_auto_startup -> tpm2_do_selftest, see:
>>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1958381
>>>>>>>>>
>>>>>>>>> - So far all reports with kernel >= 5.12.6 have been on a Dell XPS 13 9310
>>>>>>>>> models. But the new variant is happening on a Dell XPS 15 9500 and the
>>>>>>>>> backtrace starting at ima_add_boot_aggregate is also being reported on
>>>>>>>>> a Dell XPS 15 9500 (as well as on the XPS 13 9310).
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>>
>>>>>>>>> Hans
>>>>>>>>
>>>>>>>> OK, I'll have to query if I could borrow that laptop from someone. It's
>>>>>>>> fairly common laptop, i.e. might be possible.
>>>>>>>
>>>>>>> In the mean time I've also got a report that this variant of the backtrace:
>>>>>>>
>>>>>>> 1. Backtrace starting with a call to ima_add_boot_aggregate
>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
>>>>>>>
>>>>>>> Is also still happening with recent 5.12.y kernels on
>>>>>>> Dell Precision 7750 laptops. Both the Precision 7750 and the XPS 9500 use
>>>>>>> 10th gen comet lake processors (i7-10750H), where as the XPS 9310 is using
>>>>>>> an icelake processor. So the common denominator seems to be that they are
>>>>>>> all 2020 Dell laptop models using the latest Intel CPUs.
>>>>>>>
>>>>>>> FYI the complete list of models on which some of the 4 backtrace variants
>>>>>>> are still seen on recent 5.12.y kernels is now:
>>>>>>>
>>>>>>> Dell XPS 13 9310
>>>>>>> Dell XPS 15 9500
>>>>>>> Dell Precision 7750
>>>>>>>
>>>>>>> Regards,
>>>>>>>
>>>>>>> Hans
>>>>>>
>>>>>> Does "tpm_tis.interrupts=0" uniformly workaround the issue?
>>>>>
>>>>> I unfortunately have not gotten much replies to my request to test with
>>>>> tpm_tis.interrupts=0, but for those people who have bothered to test
>>>>> (2 reporters IIRC) using tpm_tis.interrupts=0 does avoid the issue.
>>>>
>>>> So we see this in dmesg as first anything from TPM:
>>>>
>>>> [    0.904572] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)
>>>>
>>>> This means that one command is successfully processed by the TPM, i.e.
>>>> tpm2_probe() in tpm_tis_core_init().
>>>>
>>>> My first *guess*  was that IRQ is given by ACPI, would need ACPI dump to
>>>> confirm (e.g. sudo acpidump > acpi.dump). It cannot be so because otherwise
>>>> this code path would be executed:
>>>>
>>>>         if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>>>>                 dev_err(&chip->dev, FW_BUG
>>>>                         "TPM interrupt not working, polling instead\n");
>>>>
>>>>                 disable_interrupts(chip);
>>>>         }
>>>>
>>>> TPM_CHIP_FLAG_IRQ is never set, so you should see this message in dmesg if
>>>> a legit value is given to IRQ by ACPI.  We are probably planning re-enable
>>>> IRQ code after these type of issues are fully resolved, but right now you
>>>> should not end up having it enabled (see tpm_tis_send() function).
>>>>
>>>> To put this together "if (irq != -1) {" path in tpm_tis_core_init() is
>>>> never executed. And early in the same function the interrupt hardware is
>>>> *explicitly* disabled.
>>>>
>>>> For me this looks like a hardware bug right now: interrupts stay enabled
>>>> for some reason.
>>>>
>>>> ACPI dump would be useful to verify some of the assumptions in this.
>>>
>>> Ok, I've added a comment to the Fedora bugs for the 4 different backtrace
>>> variants asking for acpidumps for the Dell XPS 13 9310, Dell XPS 15 9500
>>> and Dell Precision 7750 laptops.
>>
>> 2 XPS 9310 acpidumps have been attached to:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
>> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
>>
>> Note the reporter of the first bug mentions that he is no longer having
>> this issue, but we are definitely still getting reports for kernel version
>>> 5.12.6 (which has the last 2 fixes) from XPS 9310 users...
>>
>> Maybe there are different BIOS versions in play ? It might be interesting
>> to compare the 2 acpidumps...
> 
> ❯ diff -u ../tmp/ssdt7.dsl ../tmp2/ssdt7.dsl
> --- ../tmp/ssdt7.dsl	2021-07-09 21:32:06.473166420 +0300
> +++ ../tmp2/ssdt7.dsl	2021-07-09 21:33:45.065934469 +0300
> @@ -5,7 +5,7 @@
>   * 
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of ssdt7.dat, Fri Jul  9 21:32:06 2021
> + * Disassembly of ssdt7.dat, Fri Jul  9 21:33:45 2021
>   *
>   * Original Table Header:
>   *     Signature        "SSDT"
> @@ -121,7 +121,7 @@
>                      0xFED40000,         // Address Base
>                      0x00005000,         // Address Length
>                      )
> -                Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, _Y58)
> +                Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, _Y55)
>                  {
>                      0x0000000C,
>                  }
> @@ -141,7 +141,7 @@
>                  }
>                  Else
>                  {
> -                    CreateDWordField (RES0, \_SB.TPM._Y58._INT, LIRQ)  // _INT: Interrupts
> +                    CreateDWordField (RES0, \_SB.TPM._Y55._INT, LIRQ)  // _INT: Interrupts
>                      LIRQ = IRQN /* \_SB_.TPM_.IRQN */
>                      Return (RES0) /* \_SB_.TPM_.RES0 */
>                  }
> @@ -152,14 +152,14 @@
>                  If ((IRQN != Zero))
>                  {
>                      CreateDWordField (Arg0, 0x11, IRQ0)
> -                    CreateDWordField (RES0, \_SB.TPM._Y58._INT, LIRQ)  // _INT: Interrupts
> +                    CreateDWordField (RES0, \_SB.TPM._Y55._INT, LIRQ)  // _INT: Interrupts
>                      LIRQ = IRQ0 /* \_SB_.TPM_._SRS.IRQ0 */
>                      IRQN = IRQ0 /* \_SB_.TPM_._SRS.IRQ0 */
>                      CreateBitField (Arg0, 0x79, ITRG)
> -                    CreateBitField (RES0, \_SB.TPM._Y58._HE, LTRG)  // _HE_: High-Edge
> +                    CreateBitField (RES0, \_SB.TPM._Y55._HE, LTRG)  // _HE_: High-Edge
>                      LTRG = ITRG /* \_SB_.TPM_._SRS.ITRG */
>                      CreateBitField (Arg0, 0x7A, ILVL)
> -                    CreateBitField (RES0, \_SB.TPM._Y58._LL, LLVL)  // _LL_: Low Level
> +                    CreateBitField (RES0, \_SB.TPM._Y55._LL, LLVL)  // _LL_: Low Level
>                      LLVL = ILVL /* \_SB_.TPM_._SRS.ILVL */
>                      If ((((TID0 & 0x0F) == Zero) || ((TID0 & 0x0F
>                          ) == 0x0F)))
> 
> This delta from "acpidump for Dell XPS 9310 (with Qualcomm QCA6390)" to
> "acpidump output from a Dell XPS 13 9310 that no longer has a problem"
> in SSDT7. The bug I'm referring to is
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> 
> Looks to me just using a different label.

Yes, although I have the feeling that does indicate that their are possibly
other changes under the hood. The 0x00000000c interrupt referred to seems to
be an interrupt directly on the APIC, which means that it is a GPIO in direct-irq
mode with level vs edge interrupt mode selection (pullup/down settings is all
directly done by the BIOS.

I'm aware that misconfiguring those settings (which Linux cannot see) was
an issue with the TPM IRQ on some Lenovo models, maybe the same is going on
here; and later BIOS versions contain a fix (and this somehow also has
changed the label in the DSDT ?).

> What if we just set "interrupts=0" explicitly for STM0125 HID since the
> workaround seems to work according to the report?

That sounds like a reasonable workaround.

Regards,

Hans

