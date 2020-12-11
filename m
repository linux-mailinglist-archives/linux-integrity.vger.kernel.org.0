Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960F22D7D84
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 19:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391580AbgLKR6e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 12:58:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393130AbgLKR6b (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 12:58:31 -0500
Date:   Fri, 11 Dec 2020 19:57:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607709471;
        bh=tkO1EluQu5ZWiVhEjAj2vhHocMYZbvDc67cBYRuuMFA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ct5CIflkJzrGJpsVozYnkSv813UO7KDvlEXbHpWuhofWaxVMh3xnV65d7Sp+KvmXc
         w63e24MSp2UN5ytwT0Oh7u3HxUeBjgj3cJoKJ5aK14jKsdYVxn1W7szpL2BSWf2zwV
         KNIvGciBtqSCrDUQN47ulVuaq37iYXXDEi3bDYkWNT9aPkLedO71zEL5f/6KCYVp8y
         Ot0aAUwdoX18J9jIZ4zXF+99rkubWuacqq9efy+Sh1/tBv9j7QQ3UIqgLB6ReM0MFW
         32LzNiA5j5Fpgi77H71ztJX+TRizcDEB1jFSNcfon8YsjHpWALBXTEWYc1wROhDFrd
         8//GlOfXUaxBg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        enric.balletbo@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, Andrey Pronin <apronin@chromium.org>
Subject: Re: [PATCH v2] tpm: ignore failed selftest in probe
Message-ID: <20201211175745.GA34718@kernel.org>
References: <20201207135710.17321-1-dafna.hirschfeld@collabora.com>
 <20201208173451.GA57585@kapsi.fi>
 <ca37d350-d79c-41ad-f221-55d8851437bc@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca37d350-d79c-41ad-f221-55d8851437bc@collabora.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 11, 2020 at 05:56:24PM +0100, Dafna Hirschfeld wrote:
> Hi,
> 
> 
> Am 08.12.20 um 18:34 schrieb Jarkko Sakkinen:
> > On Mon, Dec 07, 2020 at 02:57:10PM +0100, Dafna Hirschfeld wrote:
> > > From: Andrey Pronin <apronin@chromium.org>
> > > 
> > > If a TPM firmware update is interrupted, e.g due to loss of power or a
> > > reset while installing the update, you end with the TPM chip in failure
> > > mode. TPM_ContinueSelfTest command is called when the device is probed.
> > > It results in TPM_FAILEDSELFTEST error, and probe fails. The TPM device
> > > is not created, and that prevents the OS from attempting any further
> > > recover operations with the TPM. Instead, ignore the error code of the
> > > TPM_ContinueSelfTest command, and create the device - the chip is out
> > > there, it's just in failure mode.
> > > 
> > > Testing:
> > > Tested with the swtpm as TPM simulator and a patch in 'libtpms'
> > > to enter failure mode
> > > 
> > > With this settings, the '/dev/tpm0' is created but the tcsd daemon fails
> > > to run.  In addition, the commands TPM_GetTestResult, TPM_GetCapability
> > > and TPM_GetRandom were tested.
> > > 
> > > A normal operation was tested with an Acer Chromebook R13 device
> > > (also called Elm) running Debian.
> > 
> > Move testing part to the stuff before diffstat.
> > 
> > > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > > [change the code to still fail in case of fatal error]
> > 
> > What is this?
> 
> In the original patch, any return value from 'tpm1_do_selftest'
> is ignored. I change the original patch so that in case of system
>  error (rc < 0) the error is not ignored since this error did not
> come from the TPM but from the system.
> 
> > 
> > > Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > > 
> > > ---
> > > changes since v1:
> > > - rewriting the commit message
> > > 
> > > This commit comes from chromeos:
> > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/1065c2fe54d6%5E%21/
> > > 
> > > In Chromeos, the selftest fails if the TPM firmware is updated during EC
> > > reset. In that case the userspace wants to access the TPM for recovery.
> > > 
> > > This patch is for TPM 1.2 only, I can also send a patch for TPM 2 if it
> > > is required that the behaviour stays consistent among the versions.
> > > 
> > > libtpms patch:
> > > https://gitlab.collabora.com/dafna/libtpms/-/commit/42848f4a838636d01ddb5ed353b3990dad3f601d
> > > 
> > > TPM tests:
> > > https://gitlab.collabora.com/dafna/test-tpm1.git
> > > 
> > >   drivers/char/tpm/tpm1-cmd.c | 17 ++++++++---------
> > >   1 file changed, 8 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > > index ca7158fa6e6c..8b7997ef8d1c 100644
> > > --- a/drivers/char/tpm/tpm1-cmd.c
> > > +++ b/drivers/char/tpm/tpm1-cmd.c
> > > @@ -697,6 +697,8 @@ EXPORT_SYMBOL_GPL(tpm1_do_selftest);
> > >   /**
> > >    * tpm1_auto_startup - Perform the standard automatic TPM initialization
> > >    *                     sequence
> > > + * NOTE: if tpm1_do_selftest returns with a TPM error code, we return 0 (success)
> > > + *	 to allow userspace interaction with the TPM when it is on failure mode.
> > >    * @chip: TPM chip to use
> > 
> > 
> > Please do not use "we ...". Use imperative form.
> > 
> > Also that is wrong place for the description:
> > 
> > https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt
> > 
> > >    *
> > >    * Returns 0 on success, < 0 in case of fatal error.
> > > @@ -707,18 +709,15 @@ int tpm1_auto_startup(struct tpm_chip *chip)
> > >   	rc = tpm1_get_timeouts(chip);
> > >   	if (rc)
> > > -		goto out;
> > > +		return rc < 0 ? rc : -ENODEV;
> > 
> > Do not use ternary operators. Also we are interested on
> > TPM_SELFTESTFAILED only (according to the commit message).
> > 
> > I.e. afaik should be
> > 
> > 	if (rc) {
> > 		if (rc == TPM_SELFTESTFAILED)
> > 			return -ENODEV;
> > 		else
> > 			return rc;
> > 	}
> 
> I read the description of TPM_ContinueSelfTest
> in the spec file
> https://trustedcomputinggroup.org/wp-content/uploads/TPM-Main-Part-3-Commands_v1.2_rev116_01032011.pdf
> 
> It is stated there that when running a command C1 before running TPM_ContinueSelfTest
> then the command might return error codes TPM_NEEDS_SELFTEST/TPM_DOING_SELFTEST.
> In those cases the command tpm1_get_timeouts should be called again after  calling
> 'tpm1_continue_selftest'.
> So it seems that we can just move the the call to 'tpm1_get_timeouts' to
> after the call to 'tpm1_continue_selftest'.
> 
> I guess that the ChromeOS's TPM can support TPM_GetCapability for TPM_CAP_PROP_TIS_TIMEOUT, also
> when it is on failure mode and this is why their patch ignores only the
> result of 'tpm1_do_selftest' and not the result of 'tpm1_get_timeouts'.
> 
> The idea of the patch is opposite than what you suggest.
> If 'tpm1_get_timeouts' returns 'TPM_SELFTESTFAILED' then the code should not return '-ENODEV'
> since we do want to have '/dev/tpm*' in that case.
> 
> Thanks,
> Dafna
 
My mistake.

You only need to add two lines of code:

out:
	if (rc == TPM_SELFTESTFAILED)
		rc = 0;
	if (rc > 0)
		rc = -ENODEV;
	return rc;
}

But how does this patch deal with TPM2?

This should be opt-in feature or restricted to a narrow subset of TPM
commands. Please rephrase this for next iteration:

"The TPM device is not created, and that prevents the OS from attempting
any further recover operations with the TPM."

What you've sent works only as a PoC.
	
/Jarkko
