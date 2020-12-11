Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68B02D7439
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 11:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393198AbgLKKwP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 05:52:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393447AbgLKKvp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 05:51:45 -0500
Date:   Fri, 11 Dec 2020 12:51:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607683864;
        bh=pHizgzZaAV2YvZFffI4jhiS94/hBYDoDgYLKPSsbO7E=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7fL81o7iLrGo/MSpnnlOay13hmMLN/ScnO/GyjHY0DqLuhAy1keHHIF0H4c4YP3G
         E5iJEzic88FTq8WFq4bbTEjGHODVWw7obzIyu9nj6kMvEP+CZ0K2RgWb7hHtzEL3N2
         vWsrJBMPyyisKy7LaljejcCzdf3VVSReM6zmnOaORunugBoeX5E3MGBwf2j+AOV9hl
         /OUQAAgkxrkNm3VSICWljXNQ9V6HPztMSxqfAVTX+NJohy3rzL58NS2PBHWPCaloKA
         qgfsCniLg5PePeegbPMBhUSM/OX5hR/UkHJdSaGktK8SJrthAjUknqcw5nFGtLXfB1
         BN1vwSp7HgDlg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] Can only do S3 once after "tpm: take TPM chip power
 gating out of tpm_transmit()"
Message-ID: <20201211105100.GE12091@kernel.org>
References: <7E60C7F0-85C6-4A9A-B905-904D37A5E67B@canonical.com>
 <20201208101746.GA45313@kernel.org>
 <C9737DC9-6484-4497-83F4-494DBFD90D9C@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9737DC9-6484-4497-83F4-494DBFD90D9C@canonical.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 10, 2020 at 12:23:57PM +0800, Kai-Heng Feng wrote:
> 
> 
> > On Dec 8, 2020, at 18:17, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > On Mon, Dec 07, 2020 at 12:42:53PM +0800, Kai-Heng Feng wrote:
> >> Hi Jarkko,
> >> 
> >> A user report that the system can only do S3 once. Subsequent S3 fails after commit a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()").
> >> 
> >> Dmesg with the issue, collected under 5.10-rc2:
> >> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891502/comments/14
> >> 
> >> Dmesg without the issue, collected under 5.0.0-rc8:
> >> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891502/comments/16
> >> 
> >> Full bug report here:
> >> https://bugs.launchpad.net/bugs/1891502
> >> 
> >> Kai-Heng
> > 
> > Relevant part:
> > 
> > 
> > [80601.620149] tpm tpm0: Error (28) sending savestate before suspend
> > [80601.620165] PM: __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x90 returns 28
> > [80601.620172] PM: dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns 28
> > [80601.620178] PM: Device 00:01 failed to suspend: error 28
> > 
> > Looking at this there are two issues:
> > 
> > A. TPM_ORD_SAVESTATE command failing, this a new regression.
> > B. When tpm_pm_suspend() fails, it should not fail the whole suspend
> >   procedure. And it returns the TPM error code back to the upper
> >   layers when it does so, which makes no sense. This is an old
> >   issue revealed by A.
> > 
> > Let's look at tpm_pm_suspend():
> > 
> > /*
> > * We are about to suspend. Save the TPM state
> > * so that it can be restored.
> > */
> > int tpm_pm_suspend(struct device *dev)
> > {
> > 	struct tpm_chip *chip = dev_get_drvdata(dev);
> > 	int rc = 0;
> > 
> > 	if (!chip)
> > 		return -ENODEV;
> > 
> > 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > 		goto suspended;
> > 
> > 	if ((chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED) &&
> > 	    !pm_suspend_via_firmware())
> > 		goto suspended;
> > 
> > 	if (!tpm_chip_start(chip)) {
> > 		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > 			tpm2_shutdown(chip, TPM2_SU_STATE);
> > 		else
> > 			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > 
> > 		tpm_chip_stop(chip);
> > 	}
> > 
> > suspended:
> > 	return rc;
> > }
> > EXPORT_SYMBOL_GPL(tpm_pm_suspend);
> > 
> > I would modify this into:
> > 
> > /*
> > * We are about to suspend. Save the TPM state
> > * so that it can be restored.
> > */
> > int tpm_pm_suspend(struct device *dev)
> > {
> > 	struct tpm_chip *chip = dev_get_drvdata(dev);
> > 	int rc = 0;
> > 
> > 	if (!chip)
> > 		return -ENODEV;
> > 
> > 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > 		goto suspended;
> > 
> > 	if ((chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED) &&
> > 	    !pm_suspend_via_firmware())
> > 		goto suspended;
> > 
> > 	if (!tpm_chip_start(chip)) {
> > 		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > 			tpm2_shutdown(chip, TPM2_SU_STATE);
> > 		else
> > 			tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > 
> > 		tpm_chip_stop(chip);
> > 	}
> > 
> > suspended:
> > 	return rc;
> > }
> > EXPORT_SYMBOL_GPL(tpm_pm_suspend);
> > 
> > I.e. it's a good idea to put something into klog but that should not
> > fail the whole suspend procedure. TPM is essentially opt-in feature.
> > 
> > Of course issue A needs to be also sorted out but would this work as
> > a quick initial fix? I can queue a patch for this. Is it possible to
> > try out this fix for if I drop a patch?
> 
> Yes, possible test result from affected user.
> 
> I had to cut those code and do a diff side by side to find what changed.
> Hopefully next time I can get one from `git diff`...
> 
> Kai-Heng

Yes you can. Sorry about that.

/Jarkko
