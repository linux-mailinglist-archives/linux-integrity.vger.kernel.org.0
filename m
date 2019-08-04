Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F364D80BA0
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Aug 2019 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfHDQMg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Aug 2019 12:12:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38642 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfHDQMg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Aug 2019 12:12:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so49452660wmj.3
        for <linux-integrity@vger.kernel.org>; Sun, 04 Aug 2019 09:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VanA4arzx1pKLCBPTthhxDPqngslBUn68r1ZMhO+zus=;
        b=jeZx+bohmvcz1jT5o6SFnkp1AaCdK+6BJlUJtGD3KSt+dT+XnnFz30swU/c04vU30M
         6uB2ELLZ1t59ImFIghv6IiQH+L0fBJ+9J2AjL07P+8ebp6PWKzy6quG3bnJEU+cSmW1R
         ghzFYcNVNiuNBooXV3WNTU+bFhuF/ADSM7WdVw7DIN/+/1TUf0Z9dawsriW4DNsZYeBH
         uxYdupr5vbWmtDPuRfoRlr/LyJwWHzYUX0pbx8Zq5W5TqxEImXycgVvfU3ESe609jQWl
         II7CgDpCUz3hH2Yb7olEbZwWQnA8noz0IN+SKHD4h9zob0m1Enj0Z3siUcK6MeN2zgHk
         q3CQ==
X-Gm-Message-State: APjAAAUpUFjkxkCDHRkvpg89xRb8UHRYWjMPR1A6R+0OGJ3FsbFT8YbS
        ZmTQNByQiv1a1r28R21szhtbbg==
X-Google-Smtp-Source: APXvYqyui6X2NxaOd0H8eIaOJhvyabkDxZbqr3kyLDs9QTwtaV3BSwC3mF1xdmSMEORCyA02T/5PyA==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr14240302wma.120.1564935154008;
        Sun, 04 Aug 2019 09:12:34 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c7sm74215923wro.70.2019.08.04.09.12.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 09:12:33 -0700 (PDT)
Subject: Re: 5.3 boot regression caused by 5.3 TPM changes
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <b20dd437-790a-aad9-0515-061751d46e53@redhat.com>
 <CAKv+Gu8p47SHEtTHQu_3agQJDH2yYjQJ5xUvE+oTiLaY=sZdUA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ff73efc3-1951-2982-3ddf-e77005c5fddb@redhat.com>
Date:   Sun, 4 Aug 2019 18:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8p47SHEtTHQu_3agQJDH2yYjQJ5xUvE+oTiLaY=sZdUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 04-08-19 17:33, Ard Biesheuvel wrote:
> Hi Hans,
> 
> On Sun, 4 Aug 2019 at 13:00, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> While testing 5.3-rc2 on an Irbis TW90 Intel Cherry Trail based
>> tablet I noticed that it does not boot on this device.
>>
>> A git bisect points to commit 166a2809d65b ("tpm: Don't duplicate
>> events from the final event log in the TCG2 log")
>>
>> And I can confirm that reverting just that single commit makes
>> the TW90 boot again.
>>
>> This machine uses AptIO firmware with base component versions
>> of: UEFI 2.4 PI 1.3. I've tried to reproduce the problem on
>> a Teclast X80 Pro which is also CHT based and also uses AptIO
>> firmware with the same base components. But it does not reproduce
>> there. Neither does the problem reproduce on a CHT tablet using
>> InsideH20 based firmware.
>>
>> Note that these devices have a software/firmware TPM-2.0
>> implementation, they do not have an actual TPM chip.
>>
>> Comparing TPM firmware setting between the 2 AptIO based
>> tablets the settings are identical, but the troublesome
>> TW90 does have some more setting then the X80, it has
>> the following settings which are not shown on the X80:
>>
>> Active PCR banks:           SHA-1         (read only)
>> Available PCR banks:        SHA-1,SHA256  (read only)
>> TPM2.0 UEFI SPEC version:   TCG_2         (other possible setting: TCG_1_2
>> Physical Presence SPEC ver: 1.2           (other possible setting: 1.3)
>>
>> I have the feeling that at least the first 2 indicate that
>> the previous win10 installation has actually used the
>> TPM, where as on the X80 the TPM is uninitialized.
>> Note this is just a hunch I could be completely wrong.
>>
>> I would be happy to run any commands to try and debug this
>> or to build a kernel with some patches to gather more info.
>>
>> Note any kernel patches to printk some debug stuff need
>> to be based on 5.3 with 166a2809d65b reverted, without that
>> reverted the device will not boot, and thus I cannot collect
>> logs without it reverted.
>>
> 
> Are you booting a 64-bit kernel on 32-bit firmware?

Yes you are right, I must say that this is somewhat surprising
most Cherry Trail devices do use 64 bit firmware (where as Bay Trail
typically uses 32 bit). But I just checked efibootmgr output and it
says it is booting: \EFI\FEDORA\SHIMIA32.EFI so yeah 32 bit firmware.

Recent Fedora releases take care of this so seamlessly I did not
even realize...

Regards,

Hans
