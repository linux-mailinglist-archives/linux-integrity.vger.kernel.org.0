Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9415FC2E
	for <lists+linux-integrity@lfdr.de>; Sat, 15 Feb 2020 02:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBOBrt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Feb 2020 20:47:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42368 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgBOBrs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Feb 2020 20:47:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so5721579pfz.9
        for <linux-integrity@vger.kernel.org>; Fri, 14 Feb 2020 17:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guzman.io; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eklhHHzHdyU+LJw4mo3OBFYNn5N8J283Djo2bGhRVOE=;
        b=RwFHF9OJ2wtYdxznzHn1vkOmjERmvfd6nf3Cmt6zh7p4+Z6cDQiIRnokIJHe6r/3NI
         qU+ak4DW1t0o75Sg54xeFWrJvUYOgWQKZRGAbleSUITY+vtdKpjZXeTUsrvpSMUDChYp
         xUEiuAi6VL1deOY8aangoFOI/MxeF9xtIJ9ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eklhHHzHdyU+LJw4mo3OBFYNn5N8J283Djo2bGhRVOE=;
        b=ajMMlw2Ho8pUtuQtRF+Ubxrsr5op99M0G57WbK3AtoMGvKcLSdZpEJWvDxolP0mdH6
         nzBFGphvesk452U4hfZB5mPJq16+2qU/K9BV30i+KIDK6X1EJszMWsSnBqQlIttSh0vz
         cdfh0cQtyslhgEcuM+QiNkcH09Jp6Auyk+WiiJABCO+mOfN41jCPWkfeQwQJRI052zhp
         5BIe1LEVyEBabZec4NzvCvJLgGx1RFJ8lNTR1am1vn3gsUm1bVA2QX2/+PgADeZiDMyI
         EWQIRjWM2+qc+8dq8svrlBA3UK4SS7ZJHevdNGNGZIkuVfnj7Hhg3+bbP0o/ZpEuN6y9
         nzZA==
X-Gm-Message-State: APjAAAUWSCMp/pK5cs+bUhJ5Jtky3OrZgRyhGZ1SLC9Ql+sb8+CBxf7p
        +SFwo8kLBWqApOehD1o080umwA==
X-Google-Smtp-Source: APXvYqzDVzwigbqhLxOIgF8+ogPtqNX1+fNWcJZl/hkq8RBE/fu7hWFuoMAc5LTGpTYtol9njv8mnQ==
X-Received: by 2002:a63:c747:: with SMTP id v7mr6103129pgg.291.1581731266611;
        Fri, 14 Feb 2020 17:47:46 -0800 (PST)
Received: from [172.27.18.57] (mobile-166-171-249-27.mycingular.net. [166.171.249.27])
        by smtp.gmail.com with ESMTPSA id 72sm8793212pfw.7.2020.02.14.17.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 17:47:45 -0800 (PST)
Message-ID: <76b24921c76dbc8fe6ea04b44e695d8a5c89a356.camel@guzman.io>
Subject: Re: Debugging errors with Dell XPS 9560 TPM
From:   Alex Guzman <alex@guzman.io>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Fri, 14 Feb 2020 17:47:44 -0800
In-Reply-To: <1581714273.16860.18.camel@HansenPartnership.com>
References: <CAJ7-PMaLw_H8Fc1tyoT95f5EWpS3nvJt1Wx9=xpuiSotJ2h9VA@mail.gmail.com>
         <CAJ7-PMbJ5fiQAj-5QAzAcFW0eMNkxpQSs=r_wUEfED33XZAPDg@mail.gmail.com>
         <1581712162.16860.8.camel@HansenPartnership.com>
         <20200214210203.dgzhkrvagiozezfi@cantor>
         <1581714273.16860.18.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-02-14 at 16:04 -0500, James Bottomley wrote:
> On Fri, 2020-02-14 at 14:02 -0700, Jerry Snitselaar wrote:
> > On Fri Feb 14 20, James Bottomley wrote:
> > > On Fri, 2020-02-14 at 10:32 -0800, Alex Guzman wrote:
> > > > Looks like someone had a look on the bug tracker
> > > > (https://bugzilla.kernel.org/show_bug.cgi?id=206275#c6)
> > > > and they figure it's definitely a regression in the kernel and
> > > > should
> > > > be reverted or rectified. They advised me to come ping here
> > > > once
> > > > more.
> > > 
> > > Reading the bugzilla, I don't get *what* needs to be
> > > reverted.  The
> > > commit 4d6ebc4c4950595414722dfadd0b361f5a05d37e isn't present in
> > > upstream, so what kernel is it present in, or what is the full
> > > commit message so we can find the upstream commit?
> > > 
> > > James
> > > 
> > > 
> > > > - Alex
> > > > 
> > > > On Sat, Feb 1, 2020 at 4:19 PM Alex Guzman <alex@guzman.io>
> > > > wrote:
> > > > > Hey there! I reported a bug on the bug tracker a bit ago but
> > > > > haven't seen any movement, so I figured I'd drop in here. My
> > > > > XPS 9560 has been having issues with its TPM, and all
> > > > > commands
> > > > > will fail with error 1 when operating on the TPM device. I
> > > > > managed to bisect it back to commit
> > > > > 4d6ebc4c4950595414722dfadd0b361f5a05d37e (tpm: fix
> > > > > invalid locking in NONBLOCKING mode) though it began failing
> > > > > with error 14 (bad address) at that point.
> > > > > 
> > > > > I reported the bug at
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=206275 and
> > > > > attached
> > > > > some dmesg logs from boot there. Does anyone have any
> > > > > suggestions for additional debugging or such to figure out
> > > > > what's happening here?
> > > > > 
> > > > > - Alex
> > 
> > d23d12484307 | 2019-12-17 | tpm: fix invalid locking in NONBLOCKING
> > mode (Tadeusz Struk)
> > 
> > There is a commit that is a fix to this commit:
> > 
> > a430e67d9a2c | 2020-01-08 | tpm: Handle negative priv->response_len
> > in tpm_common_read() (Tadeusz Struk)
> 
> Yes, I suspected it might be that ... in which case upstream should
> have the fix, can we verify that 5.6-rc1 works just fine?
> 
> James
> 

I just tested with 5.6_rc1. The behavior is still present:


ERROR:tcti:src/tss2-tcti/tcti-device.c:290:tcti_device_receive() Failed
to read response from fd 3, got errno 1: Operation not permitted 
ERROR:esys:src/tss2-
esys/api/Esys_GetCapability.c:307:Esys_GetCapability_Finish() Received
a non-TPM Error 
ERROR:esys:src/tss2-
esys/api/Esys_GetCapability.c:107:Esys_GetCapability() Esys Finish
ErrorCode (0x000a000a) 
ERROR: Esys_GetCapability(0xA000A) - tcti:IO failure
ERROR: Unable to run tpm2_getcap

