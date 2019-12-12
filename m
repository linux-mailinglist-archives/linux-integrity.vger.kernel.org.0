Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53EBC11C31D
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 03:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfLLCS3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 21:18:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41997 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfLLCS3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 21:18:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so849635otd.9
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2019 18:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPsu8XmzlYK8Y32ptaZLTsIwREbpto/xHjCbnxTIgwQ=;
        b=hHpBpD+jolyXkfvnd+Bw0vywrP0DCPLUgI2ACbOE2xZxt8vvxkZ3aG6AIWdf7cyFTF
         Z8w0WJEkiYZbZbqjciHdvUvMn3mBE9ONALf+pKjRX3Xzpy//aCDvfQFyqCYjiwEkWZmk
         AyFr8LRX7Ek+LInXFAcPEMifXMUcr1sEmGTKSCsTiE2PBEBFje3mmLb8hK30IWnc+wR1
         cr+fENqt8ryUl05GWGUQAP08hGFBcKQ0+rXLMdIPGlKZJ7cr3oVhte9sIoyUaKCdJAgx
         UcytK+eqnNpseRPMCM8MtNRHBQgGYJRpEJu2HD4sSQDQurlCBMI8/FbLGK5oQ13t0Lgc
         VMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPsu8XmzlYK8Y32ptaZLTsIwREbpto/xHjCbnxTIgwQ=;
        b=WFFf/JqI8ShXoJfn3l44kD40BJphxfAtdGQgG8a0Un206nyJi9AvW1BWKFQBpeLCsv
         KkgbWw1d7ZvzcgjUUY7IMqjlyvClHcTjCZSekVsPYTPyL23G1RvUAVeOur+8ZtXA/yTU
         IOBY//D2FBCLltqjoFqTsEpfBlJCsu59GsCPVAy0JerP8C3WZZkYHPpw4wDOeczq5BFh
         veW9RT3xPgYU7CvjI2Z46EM2q8DNLzzZM63UlSwApWVOXXKfl46yDZMZtnHmNggp4Gex
         UhX77QHpZXAvDmG63cocuxGmp9CbYb3k9YH2UHo7a6qiZUBQzb4FH/djffl4rQ3G3jXU
         YLtg==
X-Gm-Message-State: APjAAAWYEiSZp8Dnh4g7X7BkCmk2lwHMcqqEg69zhZd9QJ4V0doAGjGc
        eSpTThUp9D3Gk02FZBXOfmX0QqArhGvZC6+soNuzWQ==
X-Google-Smtp-Source: APXvYqzwryCWAY6+cdtnheUjR8VU/s/FHdoPKfFKkJwCWIw+ekq+u0gj4D0WpI79MMEUyl/kYcj1karou9SKRNbisD4=
X-Received: by 2002:a9d:4789:: with SMTP id b9mr4976910otf.247.1576117108678;
 Wed, 11 Dec 2019 18:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20191211231758.22263-1-jsnitsel@redhat.com> <20191211235455.24424-1-jsnitsel@redhat.com>
 <CAPcyv4j_FJ9teSyfodCjXs5Wz2Pj7BjqKX6Mx53OtPnVu0mjGA@mail.gmail.com>
In-Reply-To: <CAPcyv4j_FJ9teSyfodCjXs5Wz2Pj7BjqKX6Mx53OtPnVu0mjGA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Dec 2019 18:18:17 -0800
Message-ID: <CAPcyv4jUz9X-eyf7M78dfS-7pzi4Xqs+LdpUSD=eoeQjd1kxug@mail.gmail.com>
Subject: Re: [PATCH v2] tpm_tis: reserve chip for duration of tpm_tis_core_init
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 11, 2019 at 6:15 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Dec 11, 2019 at 3:56 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> >
> > Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
> > issuing commands to the tpm during initialization, just reserve the
> > chip after wait_startup, and release it when we are ready to call
> > tpm_chip_register.
> >
> > Cc: Christian Bundy <christianbundy@fraction.io>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > Cc: stable@vger.kernel.org
> > Cc: linux-integrity@vger.kernel.org
> > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
>
> Ugh, sorry, I guess this jinxed it. This patch does not address the
> IRQ storm on the platform I reported earlier.

Are the reverts making their way upstream?
