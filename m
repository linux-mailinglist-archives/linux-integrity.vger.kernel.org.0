Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E721C0949
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgD3VcW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 17:32:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35730 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727047AbgD3VcW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 17:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588282340;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Jzrv5wRZ4K7XtvWDWWDISsbmjMxGQe+9BSaROBXcFYM=;
        b=AgVmoz4kBlZy6j8mVFtcHDi/MREwcnra0ZYiYpOMC5tu4MtZQGh7al1TqkILD3YB6cmDsc
        hrPfJGyUTh9oGLtbTLDw7hhJirXzaIHMcTPzo/qBFCnZ83iEtxGM541kxSKLF7QBNditQT
        +xcJkbh3/EO0E91aGGanPmuemdVQ64M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-4TeCbQeNOw-lCGd_7Xp-ow-1; Thu, 30 Apr 2020 17:32:18 -0400
X-MC-Unique: 4TeCbQeNOw-lCGd_7Xp-ow-1
Received: by mail-qk1-f197.google.com with SMTP id d15so7902676qkl.10
        for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2020 14:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Jzrv5wRZ4K7XtvWDWWDISsbmjMxGQe+9BSaROBXcFYM=;
        b=FTtIDinZcaFTjEAMDPKnEBefDEPLcJoGwJY2boZPmT9qIbARtOhh9l0JgGRFni8/4p
         ZGa9ykWPHOhfyD/jSxR1AfElmb0sod5+IVp/qzlI7JwS/oJyL7EgV+J0hj0dHqH4r9eO
         F4fwOTHhVSWoboyyTb4W9kJf/Vgz9YI52uh/+BriFOSiR/ElU/G0kG/h7YPbOWeZkwia
         Gw88KVelT7Zf1km2B8T8lepHuVQQHqtT+DgJe4GjpjM88qrFSRKgQEfkEtGj5ICt29pI
         QOttK6uRR2VYEpk7rKBuzGfT4aezg7ORlizXBxO0lfE0/MlWf5AcMKmZlWQYEtWeBG0u
         UWCw==
X-Gm-Message-State: AGi0PuYhQaHCYkccs9TLPvKWWK/hZlLq1Z7m37VqMdiARL0GQR8y3Uny
        aMZSEU7aPVQtsfb1yeMpGjxYdP/kXrooUSRWJ6gB2YyspV8johSiOtE2PRlhZk3/oIxnsPzen0a
        gCOpgUPA1hpqbWmkTKWHMAqQK1rOQ
X-Received: by 2002:a37:5846:: with SMTP id m67mr569362qkb.78.1588282338118;
        Thu, 30 Apr 2020 14:32:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypJZ/+p/l03HZUTw9TAzxeelMsC2X0K+JlusH68UBd280GrosJOpL9Xmkh0soQ588iZsWL59bA==
X-Received: by 2002:a37:5846:: with SMTP id m67mr569335qkb.78.1588282337907;
        Thu, 30 Apr 2020 14:32:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x16sm1077258qkh.14.2020.04.30.14.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:32:17 -0700 (PDT)
Date:   Thu, 30 Apr 2020 14:32:15 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "# 3.4.x" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/tpm: fix section mismatch warning
Message-ID: <20200430213215.jqt2rj452hawj3j7@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity@vger.kernel.org, "# 3.4.x" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200429190119.43595-1-arnd@arndb.de>
 <20200430211516.gkwaefjrzj2dypmr@cantor>
 <CAK8P3a1xk9b9Ntsf302EUP2Sp+yWe5UEsbf973=xmYRkiN1KuQ@mail.gmail.com>
 <CAMj1kXHc0uzzTKp7oj23_=X9ek2KNrKMq1gL09X7cTnjhV=nXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXHc0uzzTKp7oj23_=X9ek2KNrKMq1gL09X7cTnjhV=nXQ@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Apr 30 20, Ard Biesheuvel wrote:
>On Thu, 30 Apr 2020 at 23:21, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Apr 30, 2020 at 11:15 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>> >
>> > On Wed Apr 29 20, Arnd Bergmann wrote:
>> > >Building with gcc-10 causes a harmless warning about a section mismatch:
>> > >
>> > >WARNING: modpost: vmlinux.o(.text.unlikely+0x5e191): Section mismatch in reference from the function tpm2_calc_event_log_size() to the function .init.text:early_memunmap()
>> > >The function tpm2_calc_event_log_size() references
>> > >the function __init early_memunmap().
>> > >This is often because tpm2_calc_event_log_size lacks a __init
>> > >annotation or the annotation of early_memunmap is wrong.
>> > >
>> > >Add the missing annotation.
>> > >
>> > >Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after successful event log parsing")
>> > >Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> >
>> > Minor thing, but should the Fixes be c46f3405692d ("tpm: Reserve the TPM final events table")? Or what am I missing
>> > about e658c82be556 that causes this? Just trying to understand what I did. :)
>>
>> You are right, I misread the git history. Can you fix it up when applying the
>> patch, or should I resend it?
>>
>
>I can fix it up, no worries.
>

With the fix applied:

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

