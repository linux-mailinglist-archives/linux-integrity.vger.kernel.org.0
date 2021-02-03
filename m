Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E3830E73C
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Feb 2021 00:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhBCXYw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Feb 2021 18:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232745AbhBCXYw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 18:24:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06E3464F67;
        Wed,  3 Feb 2021 23:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612394651;
        bh=1oyq9S0UA3DqFgitDJS5vC9pCBjSVxdBdG5M+j+s4ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u6RbGKN2PpPnH/77HetyS4XjwNlHht+7hgk7IoPPjnhBQqrRuzXzzTFTobzzKa9Op
         SC4+/mBq+7EjjC/gHRbPR/wU+lgwqQFEtsN/RroL9GrFaSkLE7oMLN9SNmAYlp0UsU
         UiejZ9UzxrkKIH6eW67eHq8tezEK6PPKj+tVBrgxffPEGrp4j4IlY3oUkEUe2w7mYv
         yQg/iz3kIbdV3xJQ0By61BpalzYMIYDfYHtL7VYssD3dOgs3Cw1O6qMC3ht+AyBsgV
         J0fcp1m42uArAE2IHmZwH8oMjMprmSZLYbEhXFtQEBwmGHBjjzasAlfOqQstR1AM+W
         FlHNyRJwT4zkw==
Date:   Thu, 4 Feb 2021 01:24:04 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Dirk Gouders <dirk@gouders.net>,
        Guenter Roeck <linux@roeck-us.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tj <ml.linux@elloe.vision>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: Re: [PATCH v3] tpm_tis: Add missing tpm_request/relinquish_locality
 calls
Message-ID: <YBswlPuVINENIoUC@kernel.org>
References: <20210128130753.1283534-1-lma@semihalf.com>
 <20210202155139.521421-1-lma@semihalf.com>
 <ghh7mu1f3p.fsf@gouders.net>
 <gh5z39ml0u.fsf@gouders.net>
 <CAFJ_xbpv3O5f4MPUhZExA3g-4NjPN_vvv7q6Srh1ddqCH4ie9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFJ_xbpv3O5f4MPUhZExA3g-4NjPN_vvv7q6Srh1ddqCH4ie9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 03, 2021 at 02:43:44PM +0100, Lukasz Majczak wrote:
> Hi Jarkko, Dirk,
> 
> Jarkko,
> Thank you for your points - I will try to fix all you have mentioned.
> I think it would be good to clarify a few things, before going with
> the next version. Regarding use tpm_chip_start/stop() around
> tpm2_probe() call - I have followed the similar way it is done in the
> probe_itpm() function, where is also a call to tpm_tis_send_data()
> guarded by request/release_locality(). I have tested it on the Samsung
> Chromebook Pro (which reports TPM 1.2 / Cr50) and it was sufficient
> (e.g. I didn't have to enable the clock) to get rid of a trace
> mentioned in the commit message....but now writing these words I'm
> starting to think that using tpm_chip_start/stop() could be safer from
> a point of view of other TPMs... so if you suggest using
> tpm_chip_start/stop() shall I also add it to the probe_itpm() (instead
> of  request/release_locality()) ?
> 
> Dirk,
> Thanks for the clarification. Regarding the issue you observe - I
> wanted to address at first the one that is generating the trace
> (please check the commit message) because it was leading to returning
> an error in the tpm_tis_status() function causing TPM module not
> initialized at all in the end - requesting locality before the call to
> the tpm_tis_send_data() has helped in my case (my test environment). I
> am aware of the second issue - "TPM interrupt not working, polling
> instead", but as it is not as critical as the first one, I decided to
> work on it later.
> 
> Thank you once again for all your input and sorry for a confusion with
> sending patches.

NP, thanks for doing this. Just take your time and polish the cosmetic
things. Especially for bug fixes a clean changelog is essential.

> Best regards,
> Lukasz

/Jarkko
