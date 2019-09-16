Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7659B3C00
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 16:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbfIPOAi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 10:00:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27387 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387846AbfIPOAh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 10:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568642435;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0aF91SFxr1M/w3Q8BpQEaz6nNu7eUkvCTjk7VOdGCBY=;
        b=I7tRr7sgUwyGb4O72n8skr6U4gujjg9E6uJBwg35ohN0Ld6frvquG5tr4Omxg9e93wDF5c
        +yarwVHd4FeytPjtgk27wnSJCZ+FwykJsc8jmHkuqCY8d7I0G0J/Z2xlkWvuhhYjWhLlYK
        Fp29CzS4u0oRs6rL//eIcekrXoozQ6w=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-lhfjjyWdOhOgaS8C2FpP-Q-1; Mon, 16 Sep 2019 10:00:34 -0400
Received: by mail-pf1-f197.google.com with SMTP id i28so27093106pfq.16
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 07:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+mWtBj9NE052F+pTtbVetK9KaOXhoG12yf6gAshKO1A=;
        b=B0Lrew9dlY9WPiM7O+GhkdbMeSDUsApGfhaIROhdiLKcfJKIVQogTOQz38kxut7Oz4
         xMAoMVpyBUEpYkODS5Zs9fJslRyNcCAOhQVnYVyQarnd4/7lSpxh7az3WUzThAyGt3vQ
         T6XtCf2vcMZdigvid3bQCOCBUfbDHX5wvKs1vcCdhPWM2MxYBsK5VpTKHQ9mc0AgyI9l
         HylQGpVQlT8Hriza/xpDqjIJFaIr+NWXjj5Rn/veKInTbHmahODdlkOO/nXxXBqu2tya
         1QRTfNKj8s6rO+Eqlm64GLDPpJd/r11lFJsaF3LyoaKn0M2e+BQQexQwHb1mHOSsa+am
         5THg==
X-Gm-Message-State: APjAAAXsaaDiiiePPSEHjRwOMGIj1Lt26MG9oO8xhebOtBR3Bb4Oghgp
        6vU+Q32eEtTsJu+6B8hwlKmWomflYdEqOcuJtjZwjGVLnSVRGSYWscUuoEFdSzXwtlIG16EcOBZ
        MBap0ieb2ScaT4bmptFYunlldgsM/
X-Received: by 2002:aa7:82d9:: with SMTP id f25mr60471559pfn.117.1568642433221;
        Mon, 16 Sep 2019 07:00:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqywhKKngwMXUV0LwuAphfIhri2RlyoOH4E/y7sYaba3fHVT/JYsJRol2lEwK+n3zM+khZrEWg==
X-Received: by 2002:aa7:82d9:: with SMTP id f25mr60471542pfn.117.1568642433028;
        Mon, 16 Sep 2019 07:00:33 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id b10sm16917669pfo.123.2019.09.16.07.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 07:00:32 -0700 (PDT)
Date:   Mon, 16 Sep 2019 07:00:30 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20190916140030.uzx2mfvy4qrzpi4o@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
 <1568157876.4991.3.camel@linux.ibm.com>
 <1568203240.5783.8.camel@linux.ibm.com>
 <20190913140820.GC29755@linux.intel.com>
 <1568580742.5055.0.camel@linux.ibm.com>
 <1568604471.4975.8.camel@linux.ibm.com>
 <20190916074225.fouluhpylge6fmlj@cantor>
 <CAFA6WYMdLLOe87BN5mD78A4vkmXPesco+QZXTY6uDgTYqPnong@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFA6WYMdLLOe87BN5mD78A4vkmXPesco+QZXTY6uDgTYqPnong@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: lhfjjyWdOhOgaS8C2FpP-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Sep 16 19, Sumit Garg wrote:
>On Mon, 16 Sep 2019 at 13:19, Jerry Snitselaar <jsnitsel@redhat.com> wrote=
:
>>
>> On Sun Sep 15 19, Mimi Zohar wrote:
>> >On Sun, 2019-09-15 at 16:52 -0400, Mimi Zohar wrote:
>> >> On Fri, 2019-09-13 at 15:08 +0100, Jarkko Sakkinen wrote:
>> >> > On Wed, Sep 11, 2019 at 08:00:40AM -0400, Mimi Zohar wrote:
>> >> > > On Tue, 2019-09-10 at 19:24 -0400, Mimi Zohar wrote:
>> >> > > > On Tue, 2019-09-10 at 19:18 -0400, Mimi Zohar wrote:
>> >> > > > > Create, save and load trusted keys test
>> >> > > >
>> >> > > > Creating trusted keys is failing with the following messages.  =
Any idea why?
>> >> > > >
>> >> > > > [  147.014653] tpm tpm0: A TPM error (34) occurred attempting t=
o a send a command
>> >> > > > [  147.014678] trusted_key: srkseal failed (-1)
>> >> > > > [  147.014687] trusted_key: key_seal failed (-1)
>> >> > >
>> >> > > This is a regression, that needs to be resolved.  The test works =
on
>> >> > > kernels prior to 5.1.
>> >> >
>> >> > It breaks on 5.2?
>> >>
>> >> No, the regression is in 5.1.
>> >>
>> >> >
>> >> > Can you bisect the failing commit?
>> >>
>> >> git bisect start -- drivers/char/tpm/
>> >> git bisect bad
>> >> git bisect good v5.0
>> >>
>> >> # first bad commit: [412eb585587a1dc43c9622db79de9663b6c4c238] tpm:
>> >> use tpm_buf in tpm_transmit_cmd() as the IO parameter
>> >
>> >In tpm_send(), setting buf.data directly to cmd, instead of calling
>> >tpm_buf_init() fixes the problem.
>> >
>> >Mimi
>> >
>> >
>>
>> The problem is that the command buffer is copied into the tpm_buf with
>> the memcpy, but after the tpm_transmit_cmd, nothing gets copied back
>> to be used by the code path that called tpm_send. There is code that
>> looks at that buffer after trusted_tpm_send returns. Both
>> security/keys/trusted.c and crypto/asymmetric_keys/asym_tpm.c run into
>> this.
>>
>> While playing around with it, adding a memcpy() after the transmit
>> call worked for me as well as setting buf.data directly instead of the
>> tpm_buf_init/memcpy/tpm_buf_destroy calls.
>>
>> I'm wondering if it would be worthwhile to convert the
>> security/keys/trusted.c and crypto/asymmertic_keys/aym_tpm.c code to
>> use the same tpm_buf and tpm_buf manipulation code as gets used in
>> drivers/char/tpm.
>
>This is exactly what patch #2 in this patch-set [1] tries to achieve.
>
>[1] https://lkml.org/lkml/2019/9/16/196
>
>-Sumit

I'll take a look at the patchset today.

Regards,
Jerry

