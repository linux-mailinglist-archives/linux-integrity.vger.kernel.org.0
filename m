Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF37FB3C8B
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 16:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfIPO3L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 10:29:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57326 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727934AbfIPO3L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 10:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568644149;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwXH1ImCPzfrwxi64rILWeatQdSWplanzBU1TQzkPa8=;
        b=NggYRrKypOgCAiLZ5mHQNmhT0wst/otlkCRi6i4h7Hh1QUkRsCKJOwe5yLb10g4A35YD+q
        b2F+fwGB5pimwLgHuzdxs8fIAVE12F4TibDnkJHDz/Sc7IDf/Vv80zJu49UsUQ4CauVigZ
        HlOIEwADJ6DaTCeM1UrUYWG9RIX8KeQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-WcV2t0naNJ6FnKTOuUWwFw-1; Mon, 16 Sep 2019 10:29:01 -0400
Received: by mail-pf1-f199.google.com with SMTP id i28so27156049pfq.16
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 07:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=P86h/jFKIJ/irxhYfYPVmXGgl3ZEyuScOpJV/1WZTds=;
        b=CDrIG9C8njFstaji+rGd3ugR3uA6/oknKMyTWDrekX4GAd++O1KYADbuuaHma+nw0r
         CKXWMW8UH0t/4gdGJYRcrkehLES/FrGCx96VF6E1+V0k5iTEyUN/qHdihBg8Hygv1GFf
         KSBIFgoewLeAO9nd3qypz+8oM1/h0DMglT7A5CiduuJqqhjeUgi4On3MAuD52zWwmEjD
         mRNxRsTu/enleNan1bF0Lg0vxQsnWVlYCNuVXsy/IGueVBGEmanc9TeYwWZOOuNBOpoV
         hsZE3OdI6fTx6UxNTTdGxEnr0f73MJB4Qj9LwYW18Bqx2D/gpKrl1z8pD8Ye54wCJDRy
         6urw==
X-Gm-Message-State: APjAAAUra8UIR+6rkYUYRcRtz+sRbWmlb+9c5GqeN2gr4Q6CMs0Euax2
        3lgEoIJsBRcjPFApxiWVsFUDU5SiJ8A5cGTg2kadmJEl/RswsXsumazLJuvjBZwSP9rTpSlci6W
        I9FUxw6SVNa9bsxm4IGO6owvqbV74
X-Received: by 2002:a17:902:a98a:: with SMTP id bh10mr22945plb.343.1568644140833;
        Mon, 16 Sep 2019 07:29:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzgS5l9+3U9b7hrmryV5elJBUaYZVsmWeD+0BeO4bkO7pqoK3J9x7qTMr5Ly9r4ZnkeYgqDpg==
X-Received: by 2002:a17:902:a98a:: with SMTP id bh10mr22915plb.343.1568644140461;
        Mon, 16 Sep 2019 07:29:00 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id ck13sm9594437pjb.29.2019.09.16.07.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 07:28:59 -0700 (PDT)
Date:   Mon, 16 Sep 2019 07:28:58 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20190916142858.hnyshinbj6hpf2b3@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
 <1568157876.4991.3.camel@linux.ibm.com>
 <1568203240.5783.8.camel@linux.ibm.com>
 <20190913140820.GC29755@linux.intel.com>
 <1568580742.5055.0.camel@linux.ibm.com>
 <1568604471.4975.8.camel@linux.ibm.com>
 <20190916074225.fouluhpylge6fmlj@cantor>
 <1568634746.4975.32.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1568634746.4975.32.camel@linux.ibm.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: WcV2t0naNJ6FnKTOuUWwFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Sep 16 19, Mimi Zohar wrote:
>On Mon, 2019-09-16 at 00:42 -0700, Jerry Snitselaar wrote:
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
>> >> > > This is a regression, that needs to be resolved. =A0The test work=
s on
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
>> >> git bisect good v5.0=A0
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
>
>Thanks! =A0I really appreciate your looking at the problem. =A0I haven't
>yet tried the fix with a TPM 2.0.
>>

I don't know the security/keys/trusted.c code well at all, but it looks
like parts of it are wired up to differentiate between tpm1.2 and tpm2.0,
and others are not. There is a tpm_seal_trusted and tpm_unseal_trusted that
gets used for tpm2, and are called in trusted_instantiate, which does a
tpm_is_tpm2 check, but trusted_update just calls the tpm1.2 code and
has no tpm2 checks from what I can tell.

>> I'm wondering if it would be worthwhile to convert the
>> security/keys/trusted.c and crypto/asymmertic_keys/aym_tpm.c code to
>> use the same tpm_buf and tpm_buf manipulation code as gets used in
>> drivers/char/tpm.
>
>For now, let's keep the regression fix, that is backported, simple and
>straight forward.
>

Agreed, I was just talking about in general. but it looks like Sumit has
already taken that task on.

>Trusted keys is evolving to be more than just TPM based keys. =A0I'm
>sure there will be more changes coming. =A0At least, now, there is a TPM
>1.2 regression test.
>
>thanks,
>
>Mimi
>

