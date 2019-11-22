Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 864FC1075A0
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Nov 2019 17:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfKVQSq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Nov 2019 11:18:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24093 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727487AbfKVQSo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Nov 2019 11:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574439523;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENffYn5INttrwveCQGty9euWtF1hMlls+aNPcfjNNGY=;
        b=D3KLQXwAWjzBzFXkgztvo8zQZt2IIhwQkmkUV6CTB4vGSwlPgXQHXPe7xzpJDUR/1v9fE4
        V8aIWDFUa1/8d6IFCcfzOUgZ40a83RXKWRgPnDw8w+4cxg5UHmltmSl1jWzkt3Erf7m8AV
        o0KWGlYLasP8mU5kd2hV5pFwG7WvzaM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-zGtM4ZsENuSDuuX4hjnkqA-1; Fri, 22 Nov 2019 11:18:42 -0500
Received: by mail-pj1-f70.google.com with SMTP id e12so3195697pjt.15
        for <linux-integrity@vger.kernel.org>; Fri, 22 Nov 2019 08:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=jyu3bPky/B7E4tms6aRjpp2QjMTmF1mpdf8LouFgjf4=;
        b=j/QxgEku/MULjbQ8ENjPolPjczSWoa6B38n+CLMGQupcKSTdx+DsAiV2KNFX4V/35t
         9SQRZAhypR3NpyQXSpnfVrhq2skPVsRwonwyZtNUtzJmBZtK3ppHC3/6yOpHrVHfR0Na
         WgaUzAM650iE+uJK/niBXyjQ+n826UM7qL8mJqogWuDfrOZwhSHUQ6zFhMfWada1T1Sj
         sqcdt3dfujgU0h48DZRd8zMbA8914+VQ2UaUF8CmJaLe/nM+R74TKi5jaaz968iUVWwK
         Dou0eSQKh1v7O2JHRIYjw8lV94sFGQ0OPnUewLtSQjl+Ti9G2FtOUdYMzThAHE8p87Oq
         U5Ew==
X-Gm-Message-State: APjAAAWbDojD1SD6ZvWDOeS/sKTHXcw9y51IS8jSoWtYGuoqNdNlhEku
        o0md9P9Itqths6Bv2nCT+MWGJuxFuk1RgBtH+pz8LmqpkBT4rowNnfBkZCHbQOJtuKcPJioqYYz
        3DgIMavYO7q/Ha7oNUgp6GJvDkoFG
X-Received: by 2002:a63:4a50:: with SMTP id j16mr17254550pgl.308.1574439520897;
        Fri, 22 Nov 2019 08:18:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhBmRwVMqoq2I8LNEpJ2S13So1jowh6mWVRKlV5RrVIWpCn6wfiIk9q6QVc7jgCP4akW+Mng==
X-Received: by 2002:a63:4a50:: with SMTP id j16mr17254356pgl.308.1574439518546;
        Fri, 22 Nov 2019 08:18:38 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x2sm8019786pfn.167.2019.11.22.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 08:18:37 -0800 (PST)
Date:   Fri, 22 Nov 2019 09:18:36 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.4
Message-ID: <20191122161836.ry3cbon2iy22ftoc@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
References: <20190902143121.pjnykevzlajlcrh6@linux.intel.com>
 <CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com>
X-MC-Unique: zGtM4ZsENuSDuuX4hjnkqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Nov 20 19, Dan Williams wrote:
>On Mon, Sep 2, 2019 at 7:34 AM Jarkko Sakkinen
><jarkko.sakkinen@linux.intel.com> wrote:
>>
>> Hi
>>
>> A new driver for fTPM living inside ARM TEE was added this round. In
>> addition to that, there is three bug fixes and one clean up.
>>
>> /Jarkko
>>
>> The following changes since commit 8fb8e9e46261e0117cb3cffb6dd8bb7e08f86=
49b:
>>
>>   Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git=
/rdma/rdma (2019-08-30 09:23:45 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-2019=
0902
>>
>> for you to fetch changes up to e8bd417aab0c72bfb54465596b16085702ba0405:
>>
>>   tpm/tpm_ftpm_tee: Document fTPM TEE driver (2019-09-02 17:08:35 +0300)
>>
>> ----------------------------------------------------------------
>> tpmdd updates for Linux v5.4
>>
>> ----------------------------------------------------------------
>> Jarkko Sakkinen (1):
>>       tpm: Remove a deprecated comments about implicit sysfs locking
>>
>> Lukas Bulwahn (1):
>>       MAINTAINERS: fix style in KEYS-TRUSTED entry
>>
>> Sasha Levin (2):
>>       tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE
>>       tpm/tpm_ftpm_tee: Document fTPM TEE driver
>>
>> Stefan Berger (2):
>>       tpm_tis_core: Turn on the TPM before probing IRQ's
>>       tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts
>
>Hi Jarrko,
>
>I'm replying here because I can't find the patches to reply to
>directly from LKML.
>
>Commit 7f064c378e2c "tpm_tis_core: Turn on the TPM before probing
>IRQ's" in the v5.3-stable tree caused a regression on a pre-release
>platform with a TPM2 device. The interrupt starts screaming when the
>driver is loaded and does not stop until the device is force unbond
>from the driver by:
>
>     echo IFX0740:00 > /sys/bus/platform/drivers/tpm_tis/unbind
>
>I checked v5.4-rc8 and it has the same problem. I tried reverting:
>
>1ea32c83c699 tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interr=
upts
>5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's
>
>Which silenced the screaming interrupt problem, but now the TPM is reporti=
ng:
>
>[    3.725131] tpm_tis IFX0740:00: 2.0 TPM (device-id 0x1B, rev-id 16)
>[    3.725358] tpm tpm0: tpm_try_transmit: send(): error -5
>[    3.725359] tpm tpm0: [Firmware Bug]: TPM interrupt not working,
>polling instead
>
>...at load, where it was not reporting this previously. Can you take a loo=
k?
>

We've had an issue reported for a Lenovo t490s getting an interrupt storm
with the Fedora 5.3 stable kernel, so it appears to be impacting a number o=
f
systems.

