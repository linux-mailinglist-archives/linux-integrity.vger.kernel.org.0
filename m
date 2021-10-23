Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24439438118
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Oct 2021 02:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhJWAqX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Oct 2021 20:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhJWAqW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Oct 2021 20:46:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E67726108B;
        Sat, 23 Oct 2021 00:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634949844;
        bh=+4Vi1MC1K1F3XsWuzPicDVtkWYPAPgmdz9Dd6mO5l+k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n6Y+a5e7N2H5ZgLY4BZBasI5XP9lIOQ/PpWwmVr4yD4/CJ5AkMliFXZs6dC6pkJq5
         7H1RukQbhLhCSfBa5pmPtPgaR/Jy6gjs4ppGbu9Yk+D+/zDuJ6IJKoq46YTfGhlqSX
         Gmlg1JUSxkrrI6pLy2NOoOEZsihGuBHC8TwZ0IVh9MHB4u2c6F+tAiW7TajUO0ESwk
         O5YR/J3zsTxxlhRk1K6OAh0qyy+3G3FRVyQLmzQaMm/x5/r+oAwVJ4Bqs8KaLFhEfb
         OFW7PKmgTcxTn5SI6K9xfGw70aVkIsd+heXwIWiJHeC/nKDbAJP4GMTWflp0U3AXIK
         d6tQp/XV8usGQ==
Message-ID: <ae373226e1b7b117f2808facdf0c3b6b0f282a39.camel@kernel.org>
Subject: Re: [PATCH v16 1/6] tpm_tis: Fix expected bit handling and send all
 bytes in one shot without last byte in exception
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     amirmizi6@gmail.com, Eyal.Cohen@nuvoton.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        benoit.houyere@st.com, eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Date:   Sat, 23 Oct 2021 03:44:01 +0300
In-Reply-To: <20211021120557.69234-2-amirmizi6@gmail.com>
References: <20211021120557.69234-1-amirmizi6@gmail.com>
         <20211021120557.69234-2-amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-10-21 at 15:05 +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
>=20
> Detected an incorrect implementation of the send command.

Nit: please just remove this sentence.

It tells nothing.

> Currently, the driver polls the TPM_STS.stsValid field until TRUE; then i=
t
> reads TPM_STS register again to verify only that TPM_STS.expect field is
> FALSE (i.e., it ignores TPM_STS.stsValid).
> Since TPM_STS.stsValid represents the TPM_STS.expect validity, a check of
> only one of these fields is wrong. Fix this condition so that both fields
> are checked in the same TPM_STS register read.
>=20
> Modify the signature of 'wait_for_tpm_stat()', adding an additional

Remove single quotes from functions, e.g. just write
wait_form_tpm_stat().

> "result" parameter to its call.
> 'wait_for_tpm_stat()' is now polling the TPM_STS with a mask and waits
> for the value in result. This modification adds the ability to check if
> certain TPM_STS bits have been cleared.
> For example, use the new parameter to check in status that TPM_STS_VALID
> is set and also that TPM_STS_EXPECT is zeroed. This prevents a racy
> check.
>=20
> In addition, the send command was changed to comply with
> TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf as follows:
> - send all command bytes in one loop

What does this mean? Also, please write proper sentences with
the first letter capitalized etc. Also, I'm missing what is the
thing that this patch is complying with, and why we should care?

A bug fix should never do anything else than fix a bug.

> - remove special handling of the last byte

I have no idea what you mean by send command. Please, refer
to some thing that exists, e.g. a function or what ever.

Nit: try not to use passive form in a commit message. E.g.
"Change ... to comply with" would be better.

>=20
> Fixes: 27084efee0c3 (tpm: driver for next generation TPM chips)

This is incorrectly formatted, it is missing double quotes. Have you run
your patches through checkpatch.pl?  Please review "Describe your
changes" section from Documentation/SubmittingPatches.

/Jarkko

