Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C034DDF7
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Mar 2021 04:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhC3CE6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Mar 2021 22:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhC3CE2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Mar 2021 22:04:28 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D79BC061762
        for <linux-integrity@vger.kernel.org>; Mon, 29 Mar 2021 19:04:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e14so5340873plj.2
        for <linux-integrity@vger.kernel.org>; Mon, 29 Mar 2021 19:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2pSsnic3t/qGHVZmhzTPe6d1qA6lfThi4vK5Z5MUNk=;
        b=g2vPNCR6AEsS8QXm+Fbl8xBe9cz0bJb8iwIFY43x+hRgr9YgOrJIbQ59xc4ojMNj2T
         VSBdyPA81jO2vI7VyDK2oOZ5tfBZL3T89IRY9lJzXbQ55j3297Mo06J0Blle0xqIkjqR
         lbjHKdUzQCKjmwW4C87kW20zNQGmfuWLGohjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2pSsnic3t/qGHVZmhzTPe6d1qA6lfThi4vK5Z5MUNk=;
        b=ryeugmJkjLWOVaT4dH8RkpiotXlafBpWtVbEsHaLNLMDLNuu8ZD8Uedf6AYaKpMd+J
         G4htCNAfOMbcUl25O2kEm206nJgT7As+Zp03PT4hkIa3ZYrh2CWehFnQdTJjI+zCbjgC
         QIKStB0N9V9xZFQOSJTW5RyGTHpmJ4A1qHapwyIi0fhkmRR3Y8ZULnI59CbNy63cS3hq
         CcgNp+4oBuTmsH+cWlj7e3Am9e+t/hFel/bbe9RbtLkFM9dhkOs05JfN8ccnlNYaKXol
         qRzQMC4H7QnztY11NVc0nekrLoiqSg21RnPtI4C07wJ5UBKtskLJ9zSS8SmgQNxOwHcm
         u6sw==
X-Gm-Message-State: AOAM531n2vUaLas0Q09JlqTCiVBPS7Y8X+q9nfvg8HqvGHPWoRJnNWjS
        Im0fFJIQZ4G2jh3Ek6eDezZNLyClEwWc8A==
X-Google-Smtp-Source: ABdhPJxvqJeDIiYANXuKL76YY9Wp+k9x0HzuW1YdJuxGRlC4gAUXjKXKIsT6kP9DBFUkZ2eGdgUCUQ==
X-Received: by 2002:a17:90b:ed0:: with SMTP id gz16mr1967962pjb.106.1617069866065;
        Mon, 29 Mar 2021 19:04:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x3sm13591741pfn.181.2021.03.29.19.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 19:04:25 -0700 (PDT)
Date:   Mon, 29 Mar 2021 19:04:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Tj (Elloe Linux)" <ml.linux@elloe.vision>,
        linux-integrity@vger.kernel.org, jsnitsel@redhat.com,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: Bug: TPM returned invalid status
Message-ID: <202103291901.F15EA83FB6@keescook>
References: <374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision>
 <YBGpranyEwXaqAUg@kernel.org>
 <YBGqWp5FqKQJK1is@kernel.org>
 <b1e71d07546ccce7957ead9cc80303734251f6c9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e71d07546ccce7957ead9cc80303734251f6c9.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 27, 2021 at 10:11:56AM -0800, James Bottomley wrote:
> On Wed, 2021-01-27 at 20:00 +0200, Jarkko Sakkinen wrote:
> > On Wed, Jan 27, 2021 at 07:58:08PM +0200, Jarkko Sakkinen wrote:
> > > On Mon, Jan 25, 2021 at 09:00:54AM +0000, Tj (Elloe Linux) wrote:
> > > > Seeing this on Lenovo E495's that have:
> > > > 
> > > > AMD Ryzen 7 3700U with Radeon Vega Mobile Gfx
> > > > 
> > > > Linux version 5.11.0-rc4+ (tj@elloe000) (gcc (Ubuntu
> > > > 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu)
> > > > 2.34) #12 SMP PREEMPT Sun Jan 24 11:28:01 GMT 2021
> > > > Command line: BOOT_IMAGE=/vmlinuz-5.11.0-rc4+
> > > > root=/dev/mapper/ELLOE000-rootfs ro acpi_osi=! "acpi_osi=Windows
> > > > 2016" systemd.unified_cgroup_hierarchy=1 nosplash
> > > > ...
> > > > efi: EFI v2.70 by Lenovo
> > > > 
> > > > efi: ACPI=0xbddfd000 ACPI 2.0=0xbddfd014 TPMFinalLog=0xbdc2d000
> > > > SMBIOS=0xba4d7000 SMBIOS 3.0=0xba4ca000 MEMATTR=0xb5611018
> > > > ESRT=0xb9075000 RNG=0xba5c2598 TPMEventLog=0xb13ae
> > > > 018
> > > > ...
> > > > DMI: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12 )
> > > > 12/23/2019
> > > > ...
> > > > tpm_tis NTC0702:00: 2.0 TPM (device-id 0xFC, rev-id 1)
> > > > ------------[ cut here ]------------
> > > > TPM returned invalid status
> > > > WARNING: CPU: 3 PID: 1 at drivers/char/tpm/tpm_tis_core.c:249
> > > 
> > > There's a patch set in cycle that should fix this:
> > > 
> > > https://lore.kernel.org/linux-integrity/20201001180925.13808-1-James.Bottomley@HansenPartnership.com/
> > > 
> > > James, where are we at with this?
> > 
> > I'm interested because I'm yet to send my pr and this is generating
> > constantly bug reports.
> 
> It's part of the enable interrupts series, which there's a lot of
> discussion over.  However, that single patch can be broken out of the
> series if you like.  The specific blocker was the screaming interrupt
> on the Lenovo that Jerry was looking at.  He propose a quirk to fix its
> so perhaps we're now ready to move the entire series forward?

Does this series solve the issue too?

https://lore.kernel.org/linux-integrity/1613955394-13152-1-git-send-email-LinoSanfilippo@gmx.de/

(I haven't had a chance to test either series with my TPM, but I see the
same "TPM returned invalid status" errors recently.)

-- 
Kees Cook
