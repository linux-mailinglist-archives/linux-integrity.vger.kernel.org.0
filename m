Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E74B35E5
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 09:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfIPHtG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 03:49:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47469 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726648AbfIPHtF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 03:49:05 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 03:49:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568620145;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMjxedG6j/Sqvf7X/seo3H3aOlm3bMRW95XYZ+qiDnY=;
        b=QO3u+29KYR1IwBolVWrPsPtlnBCl2WdqY1lFA8lgn4QlJuH7xyBSoKoh95kDQzT/nqbB7S
        tqyvYmQpxYbl5ihv4khVRINAqWv1y0xYatphV+oVNwFxblRCKxJ6VCVHSnk9UQQwHtxgxG
        x7MLx0IlhCWBBaTxnMJl3RilP++/mwY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-RLThyT3uNtOs2PhvZuTwBQ-1; Mon, 16 Sep 2019 03:42:29 -0400
Received: by mail-pg1-f197.google.com with SMTP id h10so4067467pgh.11
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 00:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qJ2XTavf6xVfCeXhsCAHQas4XZ5kl+p1989SW7A7oqQ=;
        b=K8BG1GB4ql1FT2VxQQN+ooJvp0+4ng8GbdYxPZu/U7345O7/J5eUmAA9P5vQ+xGcKE
         XG/55/3/M8YcZ7DFFJMih8YNRv3VsRiO22TZi1etUbF98h3kMaksX3ZBe+tqxP5haZ0v
         2+hdinUR95fKH9ZKk4W9paEQ95fyThhscpywKZKwYmmfC+vyFn94FjJ2CJebYv7YIFwc
         gqveZjM9Yygew68wzDF+pq6z/V1m1RwBGs/e0kIPbmuDPH0TOB/Uf0GEVIxFQKp0VadP
         F9C+72nvDIH33t6SvWiwkdBx4yLHKtIyuJmgZR24Sw+oPHUbF/FhUkbTvlpZex8h64sp
         9Pfg==
X-Gm-Message-State: APjAAAXAMqSPIutsKXmvzgisBLgg3mBX44sLHzfAVmOgCckYDNHgLMpF
        euDtxp1zS6sSJ3BroNPlHosyHRLJvy7WEyj1z4/OlD4ugv1riFLj2UB+iob89nJW4rS/D5bZ/9j
        s9T+vbDmIXcZNxVhh/sAWKUHWeMOa
X-Received: by 2002:a17:90a:332c:: with SMTP id m41mr7277852pjb.22.1568619747796;
        Mon, 16 Sep 2019 00:42:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzl1MY0H4oL9NJZ/e4bdULzxRM7J9QfEJZpCZa4TK38YBNrdK5lM7zavCuuhOYQC+W/uTIrlg==
X-Received: by 2002:a17:90a:332c:: with SMTP id m41mr7277832pjb.22.1568619747444;
        Mon, 16 Sep 2019 00:42:27 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 30sm11584042pjk.25.2019.09.16.00.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 00:42:26 -0700 (PDT)
Date:   Mon, 16 Sep 2019 00:42:25 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20190916074225.fouluhpylge6fmlj@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
 <1568157876.4991.3.camel@linux.ibm.com>
 <1568203240.5783.8.camel@linux.ibm.com>
 <20190913140820.GC29755@linux.intel.com>
 <1568580742.5055.0.camel@linux.ibm.com>
 <1568604471.4975.8.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1568604471.4975.8.camel@linux.ibm.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: RLThyT3uNtOs2PhvZuTwBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun Sep 15 19, Mimi Zohar wrote:
>On Sun, 2019-09-15 at 16:52 -0400, Mimi Zohar wrote:
>> On Fri, 2019-09-13 at 15:08 +0100, Jarkko Sakkinen wrote:
>> > On Wed, Sep 11, 2019 at 08:00:40AM -0400, Mimi Zohar wrote:
>> > > On Tue, 2019-09-10 at 19:24 -0400, Mimi Zohar wrote:
>> > > > On Tue, 2019-09-10 at 19:18 -0400, Mimi Zohar wrote:
>> > > > > Create, save and load trusted keys test
>> > > >
>> > > > Creating trusted keys is failing with the following messages.  Any=
 idea why?
>> > > >
>> > > > [  147.014653] tpm tpm0: A TPM error (34) occurred attempting to a=
 send a command
>> > > > [  147.014678] trusted_key: srkseal failed (-1)
>> > > > [  147.014687] trusted_key: key_seal failed (-1)
>> > >
>> > > This is a regression, that needs to be resolved. =A0The test works o=
n
>> > > kernels prior to 5.1.
>> >
>> > It breaks on 5.2?
>>
>> No, the regression is in 5.1.
>>
>> >
>> > Can you bisect the failing commit?
>>
>> git bisect start -- drivers/char/tpm/
>> git bisect bad
>> git bisect good v5.0=A0
>>
>> # first bad commit: [412eb585587a1dc43c9622db79de9663b6c4c238] tpm:
>> use tpm_buf in tpm_transmit_cmd() as the IO parameter
>
>In tpm_send(), setting buf.data directly to cmd, instead of calling
>tpm_buf_init() fixes the problem.
>
>Mimi
>
>

The problem is that the command buffer is copied into the tpm_buf with
the memcpy, but after the tpm_transmit_cmd, nothing gets copied back
to be used by the code path that called tpm_send. There is code that
looks at that buffer after trusted_tpm_send returns. Both
security/keys/trusted.c and crypto/asymmetric_keys/asym_tpm.c run into
this.

While playing around with it, adding a memcpy() after the transmit
call worked for me as well as setting buf.data directly instead of the
tpm_buf_init/memcpy/tpm_buf_destroy calls.

I'm wondering if it would be worthwhile to convert the
security/keys/trusted.c and crypto/asymmertic_keys/aym_tpm.c code to
use the same tpm_buf and tpm_buf manipulation code as gets used in
drivers/char/tpm.

