Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73160E26F6
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 01:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436986AbfJWXUr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 19:20:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55617 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436985AbfJWXUq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 19:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571872846;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1gIIOpWX0kmuV8pGcMJNBdk7solK8ew7ygNzM9f9h4=;
        b=GsXl7K2m4xriGUP6ceO2hR3D5552Qa3vzA0rYtVygl1UmKlxKRsPQkK8THAgfNivz0AaLg
        Xw171WHJSmyTEe0E97LTRed8SeT9PrdTrbWe0Hf2j0eiuVjFa7WtKCvb35w+6EAIP5Wmwr
        4z3udoOIYUAVgN1efzyrtdHz0cFQgis=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-gfyGILhMPp6Rr8T_Y_xPmA-1; Wed, 23 Oct 2019 19:20:42 -0400
Received: by mail-il1-f198.google.com with SMTP id w9so13873064ilo.12
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 16:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BNl9Uy1RmdYWPElsAHF3OHYdNrnKgMqhpn5Eaj07V2k=;
        b=DhZQ8Ha+bCAZQ1xe9HLdOOuIxlzcOzGmr1lRuplWNqyw41nMJj78GETVz7WwgVjAtM
         kYmoswm4jYnIqoKy//uFY7ovhZiIfFEzxkZOBsHkP9ajtXgqMAFMpDBDhzrC5oPfJURb
         KT+WOmWH7IRq6GzaTFGY73Wpz2ClyeYp7ddymzhiyzYAFWKV/raRoa/3o3dewtW4wWrO
         ctfd5Ma4uE4lGLAsrRhJk2XgWJDkQLnaWW+cSFLOPi4AHs/5+5Z+SyGPwAm3DIf5QUIR
         0yxqUEWdY4RZH+434EetvzTkd7y3hbURewB2475GvT3ox8TgR3Gv+pQETVwHbxXVPTh3
         GTlA==
X-Gm-Message-State: APjAAAXgSEzyXX+BumMPqnH8X6VPjTt5bR6tbDi2pl6j/WLWEQz/QuEO
        vJQ5L9Ay7gf3ciWhGMyt/Pw3/hk7c3U3ls71FQETTI/TlPB0KP3bMBQk7DhlTRfaw6fz5BbuIPo
        NX6kMiZOyrhEQOGpkTkBd+UWqlFH9
X-Received: by 2002:a6b:ab03:: with SMTP id u3mr553333ioe.158.1571872841765;
        Wed, 23 Oct 2019 16:20:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyF7qrGiVvCscTOw+aNfXxqYquTIiaVJdbtw612TTKl3QtQMeOf7yuOTCKu3ac4j7p0IUWriw==
X-Received: by 2002:a6b:ab03:: with SMTP id u3mr553307ioe.158.1571872841493;
        Wed, 23 Oct 2019 16:20:41 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id u124sm7731617ioe.63.2019.10.23.16.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:20:40 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:20:35 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     ivan.lazeev@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20191023232035.ir7hmed4m3emovyx@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        ivan.lazeev@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191016182814.18350-1-ivan.lazeev@gmail.com>
 <20191021155735.GA7387@linux.intel.com>
 <20191023115151.GF21973@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191023115151.GF21973@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: gfyGILhMPp6Rr8T_Y_xPmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Oct 23 19, Jarkko Sakkinen wrote:
>On Mon, Oct 21, 2019 at 06:57:35PM +0300, Jarkko Sakkinen wrote:
>> Almost tested this today. Unfortunately the USB stick at hand was
>> broken.  I'll retry tomorrow or Wed depending on which day I visit at
>> the office and which day I WFH.
>>
>> At least the AMI BIOS had all the TPM stuff in it. The hardware I'll be
>> using is Udoo Bolt V8 (thanks Jerry for pointing me out this device)
>> with AMD Ryzen Embedded V1605B [1]
>>
>> Thanks for the patience with your patch.
>>
>> [1] https://en.wikichip.org/wiki/amd/ryzen_embedded/v1605b
>
>Jerry, are you confident to give this tested-by?
>
>I'm still in process of finding what I should put to .config in order
>to get USB keyboard working with UDOO BOLT.
>
>/Jarkko

I ran it through the tpm2 kselftests and it passed:

TAP version 13
1..2
# selftests: tpm2: test_smoke.sh
# test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
# test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
# test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
# test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
# test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
# test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
# test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ok
#
# ----------------------------------------------------------------------
# Ran 9 tests in 12.305s
#
# OK
ok 1 selftests: tpm2: test_smoke.sh
# selftests: tpm2: test_space.sh
# test_flush_context (tpm2_tests.SpaceTest) ... ok
# test_get_handles (tpm2_tests.SpaceTest) ... ok
# test_invalid_cc (tpm2_tests.SpaceTest) ... ok
# test_make_two_spaces (tpm2_tests.SpaceTest) ... ok
#
# ----------------------------------------------------------------------
# Ran 4 tests in 11.355s
#
# OK
ok 2 selftests: tpm2: test_space.sh


I also did some other testing of tpm2-tools commands, creating a
trusted key and encrypted key, and running rngtest against /dev/random
with the current hwrng being tpm-rng-0.

I ran the selftests on an intel nuc as well:

TAP version 13
1..2
# selftests: tpm2: test_smoke.sh
# test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
# test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
# test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
# test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
# test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
# test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
# test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ok
#=20
# ----------------------------------------------------------------------
# Ran 9 tests in 29.620s
#=20
# OK
ok 1 selftests: tpm2: test_smoke.sh
# selftests: tpm2: test_space.sh
# test_flush_context (tpm2_tests.SpaceTest) ... ok
# test_get_handles (tpm2_tests.SpaceTest) ... ok
# test_invalid_cc (tpm2_tests.SpaceTest) ... ok
# test_make_two_spaces (tpm2_tests.SpaceTest) ... ok
#=20
# ----------------------------------------------------------------------
# Ran 4 tests in 26.337s
#=20
# OK
ok 2 selftests: tpm2: test_space.sh


So,

Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>



One thing I've noticed on the bolt and the nuc:

[    0.808935] tpm_tis MSFT0101:00: IRQ index 0 not found

I'm guessing this is Stefan's patches causing this?

1ea32c83c699 | 2019-09-02 | tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before prob=
ing for interrupts (Stefan Berger)
5b359c7c4372 | 2019-09-02 | tpm_tis_core: Turn on the TPM before probing IR=
Q's (Stefan Berger)

I've never noticed tpm_tis messages before on a tpm_crb system, and doublec=
hecked that I don't see it with 5.3.

