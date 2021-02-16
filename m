Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CBD31CDDA
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 17:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhBPQTM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 11:19:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhBPQTK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 11:19:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7230464E07;
        Tue, 16 Feb 2021 16:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613492309;
        bh=iZbIesyRl1dC/YMJT/zU1neU4e0qJhRQ6wHOqM57q4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMoXY3k0CWFGNbzRsfn+89gv8gHw+ASPeVoxttY3+olpNhXBWxSba+GaScPtA+9xQ
         E7aEbB4kbZT7EoIYskYWhch81J+qVCDmfBn4QAjPqQtlbvTqM+ks4bQZyzqo48UgUE
         gKeNqOWj2+85Sjx8tCkkWJ6yC/zCaipB+g8p4J0Y/y6SHI8dZiqomOMqWf7VEpczEJ
         vXk36IX58ZYDkqNfpedVXX1YdnE4m47QNd9qx9iQl3f6R4KYfpSsaTblaY8XRTGoaC
         3F6k0X9CRdCpjHT7ik76GeN+6btspISHTnOoDoKglPJ8fNfn/X3fmDtn/jF2omSQoz
         qjwCImdPwKoDg==
Date:   Tue, 16 Feb 2021 18:18:17 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Laurent Bigonville <bigon@debian.org>,
        linux-integrity@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in
 tpm_tis_gen_interrupt() and tpm_get_timeouts()
Message-ID: <YCvwSS9zV4lQqYom@kernel.org>
References: <20210216081750.191250-1-jarkko@kernel.org>
 <ccb8ff69-5223-c293-bdda-46f041b7b770@debian.org>
 <CAFJ_xbooQp5FqEuSGu3ChqdKj0YfLzfhLYMYUDfOiQ+vaVnOdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFJ_xbooQp5FqEuSGu3ChqdKj0YfLzfhLYMYUDfOiQ+vaVnOdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 16, 2021 at 03:09:49PM +0100, Lukasz Majczak wrote:
> Hi Laurent,
> 
> I think your case is different, as the trace shows the issue occurs in
> the place already guarded by tpm_chip_start()/stop() - tpm2_probe().
> Can you paste more dmesg log? (With tpm prefix?). I believe
> tpm_tis_status() might return something different than 0xff here.
> Please ensure you have applied Jarkko's patch that logs status
> (https://patchwork.kernel.org/project/linux-integrity/patch/20210202222150.120664-1-jarkko@kernel.org/)


I would politely ask you:

- Not to top-post. Quote and reponse properly.
- No HTML emails.

> Best regards
> Lukasz


/Jarkko
