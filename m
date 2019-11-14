Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F73FCB2B
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 17:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKNQ4b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 11:56:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33491 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfKNQ4b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 11:56:31 -0500
Received: by mail-qk1-f193.google.com with SMTP id 71so5603436qkl.0
        for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2019 08:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LEt7mE3NlmcSAYBrfWxXnm5oc1z08XQBzX7blFZW3YM=;
        b=Ln3NbCfyyphUGctMBJPN1Evy417y1ng2dQdPseF+6NAmTNHhXfiLYSSYq8f06fkIpr
         MbyAqVa5yVDn1Cu9ukeg2CoNrPRQP9jzws0w8malWAqGe345/FP/lZpuk7iQUDYHchJY
         obluI9BCLAoJA5ics3DqOTe07uO7+JAxpLKiwmxZwLycwfNbH3AmvCw9ZBvyfjRX8OJX
         7eSKd3mbJRSBEUlhAzO3E2p4I+oa/lF6OFHqXrdXT279oiut1So/+fshDGXK+/P6L8QA
         wgWNz9l1LcJwow1YGMIYM9kqKI7o6rRlJ1nCUUiNWmTAYyKkfMdBCBxNfKJoLGQ4ZEKZ
         TgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LEt7mE3NlmcSAYBrfWxXnm5oc1z08XQBzX7blFZW3YM=;
        b=dAi58I6gvlNaciXdz28VKiULzDDZmU3x/F+XzypyCg+hG4IRMO3NacQ64PzEym7KCH
         Qjf8GLooao1p6lonzmdRZ79QiPGV0PU4nhzE6B38Kut0DhfffBQ1dulskKzCM8Z+c0X+
         lRS3EoR+BNbxbnHPjmMlkRic8Yg/iaE2GipxN0F6p7NxZCGcSJJdHfvD89TDPPJ25Ado
         QU5z8lNYP3Isjt0pkA4ITngKL/aM5uyO6nPR3B+hD84H7JJTvVm83FsHOjadP5NS8wJJ
         1LAUT9CPcxeRvA6brYzOHqIk8do+GgDIzpB74Lp4khsVA7eYjxZQ3rohz9WiFqibigTt
         rMgA==
X-Gm-Message-State: APjAAAWfJzEmCT/9h2UUhCFLZfyad4s/B8SKFXREpM7Rub0fIQoP/o0p
        Q+BkYZCBNeSpLI34tRfgqXhnxg==
X-Google-Smtp-Source: APXvYqxQE8WRBdBn+hiiaggtDJLmt7PKFZoGbqsJ3pDo6paBnbA6yB0zHjIFvPCFefq7Mjd0Dfp+ag==
X-Received: by 2002:a37:6189:: with SMTP id v131mr7847602qkb.489.1573750590124;
        Thu, 14 Nov 2019 08:56:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 27sm3554067qtu.71.2019.11.14.08.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 08:56:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVIQ1-00044H-Av; Thu, 14 Nov 2019 12:56:29 -0400
Date:   Thu, 14 Nov 2019 12:56:29 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Message-ID: <20191114165629.GC26068@ziepe.ca>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
 <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
 <20191112202623.GB5584@ziepe.ca>
 <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
 <20191114165357.GA11107@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114165357.GA11107@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 14, 2019 at 06:55:06PM +0200, Jarkko Sakkinen wrote:
> > Would it function with the timeout values set at the beginning of
> > tpm_tis_core_init (max values)?
> 
> tpm_get_timeouts() should be replaced with:
> 
> if (tpm_chip_start()) {
> 	dev_err(dev, "Could not get TPM timeouts and durations\n");
> 	rc = -ENODEV;
> 	goto out_err;
> }
> 
> tpm_stop_chip(chip);
> 
> tpm_get_timeouts() is called by tpm_auto_startup(). Also the function
> should be moved to tpm_chip.c and converted to a static function so
> that it won't be called from random cal sites like above.

Careful, the design here was to allow a driver to do only
get_timeouts, then additional setup work, then do auto_startup()

Forcing a driver to do auto_startup too early may not be good.

Jason
