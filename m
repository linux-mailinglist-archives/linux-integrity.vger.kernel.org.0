Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2FA390FD9
	for <lists+linux-integrity@lfdr.de>; Wed, 26 May 2021 06:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhEZE6T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 May 2021 00:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhEZE6S (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 May 2021 00:58:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CE33613D3;
        Wed, 26 May 2021 04:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622005007;
        bh=Gv/hxdauCqc76+7LQ3UPDSB9Ljk9StS1O6mcvQs6w6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CxHvjd4xK2FrNpdbX8BX0Yu/xEWT0F/0CmS+aJcGFZ4c7RATtBdjtjx9YKzG8VKzr
         TKu4cQR1oiuYocDjQXCMwEcZ8yhAOM14zpzn6SObMFN1+iv6/p+ZpFZ0XHbECdYO67
         S5Fw85PI1pA/sDX3SswbCmvASLvHxjrjotxBfWvKGN+h17uOISwF8+fJmDhKL7k3EX
         MUd9Hte5MkM5jFO5K5nPk0HA3FhDCkBIq22lTfEbP/egKyA1Wex/4QfXzp0lZvMNtI
         EDVm/5F6J5WyH/Qt4AO21ThMHA0i4AzRII2AKFItcdhBScjd1wXBOPZ/yUQOMlEYkm
         bHgXuEM7C8cRA==
Date:   Wed, 26 May 2021 07:56:45 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v4] tpm2: add longer timeout for verify signature command
Message-ID: <YK3VDSiZvaSlca3C@kernel.org>
References: <20210525111325.158790-1-amirmizi6@gmail.com>
 <20210525111325.158790-2-amirmizi6@gmail.com>
 <YK3ToDAiIUQ5whAN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK3ToDAiIUQ5whAN@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 26, 2021 at 07:50:43AM +0300, Jarkko Sakkinen wrote:
> On Tue, May 25, 2021 at 02:13:25PM +0300, amirmizi6@gmail.com wrote:
> > From: Amir Mizinski <amirmizi6@gmail.com>
> > 
> > While running a TPM2_CC_VERIFY_SIGNATURE operation with RSA 3072-bit
> > keys the TPM driver fails with the following error:
> > 
> > "kernel: [ 2416.187522] tpm tpm0: Operation Timed out"
> > 
> > Since the TPM PC Client specification does not specify a number for
> > verify signature operation timeout, and the duration of
> > TPM2_CC_VERIFY_SIGNATURE with RSA 3072-bit keys exceeds the current timeout
> > of TPM_LONG (2 seconds), it is preferable to pick the longest timeout
> > possible.
> > 
> > Therefore, set the duration for TPM2_CC_VERIFY_SIGNATUE to TPM_LONG_LONG
> > (5 minutes).
> > 
> > Link: https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
> > Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> > ---
> 
> Thank you.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>

I mean @kernel.org.

I mangled the short summary as 

"tpm: add longer timeout for TPM2_CC_VERIFY_SIGNATURE"

given that 

1. The subsystem tag was wrong.
2. Always to talk about the *exact thing*. I.e. in this case it's
   preferable to just write the command name, as"verify time signature
   command" does not have any formal menaing.

It's now applied, thanks.

/Jarkko
