Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3178222C62F
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgGXNSv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 09:18:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:39474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXNSv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 09:18:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33ABCAC66;
        Fri, 24 Jul 2020 13:18:57 +0000 (UTC)
Date:   Fri, 24 Jul 2020 15:18:45 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 2/2] IMA: Add test for kexec cmdline measurement
Message-ID: <20200724131845.GB24626@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200724070038.29491-1-pvorel@suse.cz>
 <20200724070038.29491-2-pvorel@suse.cz>
 <1595592111.5211.246.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595592111.5211.246.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

> On Fri, 2020-07-24 at 09:00 +0200, Petr Vorel wrote:
> > From: Lachlan Sneff <t-josne@linux.microsoft.com>

> > IMA policy can be set to measure the command line passed in the kexec
> > system call. Add a testcase that verifies that the IMA subsystem
> > correctly measure the cmdline specified during a kexec.

> > Note that this test does not actually reboot.

> > Ideally, test shouldn't even require an image, since it doesn't actually
> > reboot, but the IMA cmdline measurement occurs after the image is parsed
> > and verified, so we must pass a valid kernel image.

> > There is a possibility of putting together a dummy kernel image that has
> > the right headers and appears to be signed correctly, but doesn't
> > actually contain any code, but, after investigating that possibility, it
> > appears to be quite difficult (and would require a dummy kernel for each
> > arch).
Maybe I'll omit these 2 paragraphs from commit message.

> This test attempts to kexec the existing running kernel image.  To
> kexec a different kernel image export IMA_KEXEC_IMAGE=<pathname>.
+1, that's a correct description for all test description, commit message and
README.md. Thanks!

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,
> > sent version with few my fixes.
> > @Mimi: could you please have a quick look? (I know you reviewed previous
> > version.)

> Thanks, Petr.  Just a couple of comments ...


> <snip>

> > +# Test that the kexec cmdline is measured correctly.
> > +# NOTE: This does *not* actually reboot.
> > +test1() {
> > +	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
> > +		tst_brk TCONF "Kernel image not found ('$IMA_KEXEC_IMAGE'), specify it in \$IMA_KEXEC_IMAGE"
> > +	fi
> > +
> > +	# Strip the `BOOT_IMAGE=...` part from the cmdline.
> > +	local cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
> > +
> > +	if ! kexec -sl $IMA_KEXEC_IMAGE --reuse-cmdline; then
> > +		tst_res TCONF "kexec failed: $?"
I overlooked that TCONF is bad, I guess it should be TFAIL (failure of something
what we test).

Meaning of TCONF/TBROK/TFAIL is described in
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#222-basic-test-interface
IMHO only missing kernel image ($IMA_KEXEC_IMAGE) and checking
func=KEXEC_CMDLINE in loaded policy should be marked as TCONF, the rest should
be TFAIL. TBROK is used for unexpected errors in preparation phase (often this
code is in setup).

Thus here should be:
tst_res TFAIL "kexec failed: $?"

> > +
> > +		local sb_status="$(bootctl status 2>/dev/null | grep 'Secure Boot' \
> > +			| tr -d ' ' | sed 's/SecureBoot:*//')"
> > +
> > +		if [ "$sb_status" = "enabled" ]; then
> > +			tst_res TINFO "secure boot is enabled, the specified kernel image may not be signed"
> > +		fi

> Independently of the secure boot status, the IMA policy itself could require a signature.

> For example, a recent software update is preventing one of my test
> laptops from booting with secure boot enabled, but the custom IMA
> policy still requires the kexec kernel image to be signed.

> Search the IMA policy for an appraise "func=KEXEC_KERNEL_CHECK" policy
> rule.
I guess you mean keep to keep current bootctl status based search

That also mean, that check_policy_readable needs to be searched earlier.
Probably just to set:
TST_SETUP="check_policy_readable"

> > +
> > +		return
> > +	fi
> > +
> > +	kexec -su
> > +
> > +	if ! measure "$cmdline"; then
> > +		tst_res TFAIL "unable to find a correct entry in the IMA log"
> > +
> > +		check_policy_readable
> > +
> > +		if ! grep "measure func=KEXEC_CMDLINE" $IMA_POLICY >/dev/null; then
> > +			tst_brk TCONF "The IMA policy does not specify 'measure func=KEXEC_CMDLINE', see IMA test README"
> > +		fi
> > +

> Other than the policy "action" - measure/dont_measure,
> audit/dont_audit, appraise/dont_appraise - being the first keyword,
> the ordering of the policy options and flags is flexible.  Most
> policies do provide the "func" option immediately following the
> "action".  This would normally work.
OK, is this correct?
if ! grep '^measure.*func=KEXEC_CMDLINE' $IMA_POLICY >/dev/null; then

> > +		return
> > +	fi
> > +
> > +	cmdline="foo"
> > +	if ! kexec -sl $IMA_KEXEC_IMAGE --append=$cmdline; then
> > +		tst_brk TCONF "kexec failed: $?"
> > +	fi
> > +

Instead of whole block please use:
EXPECT_PASS_BRK kexec -sl $IMA_KEXEC_IMAGE --append=$cmdline


> The error messages are exactly the same here and below.  Should a hint
> be provided as to which one failed?
+1, thanks for spotting this. Using EXPECT_PASS_BRK will solve this (commands
are different).

> Mimi

> > +	kexec -su
Maybe, if we expect kexec to exit 0, we could run it with ROD (that exit test
with tst_brk TBROK if non-zero exit code)
ROD kexec -su

FYI we don't use ROD everywhere, but where hidden failure of some command
complicates debugging failing test or even lead to wrong test result (false
positive or negative).

> > +
> > +	if ! measure "$cmdline"; then
> > +		tst_brk TFAIL "unable to find a correct entry in the IMA log"
> > +	fi
> > +
> > +	cmdline="bar"
> > +	if ! kexec -sl $IMA_KEXEC_IMAGE --command-line=$cmdline; then
EXPECT_PASS_BRK kexec -sl $IMA_KEXEC_IMAGE --command-line=$cmdline
> > +		tst_brk TCONF "kexec failed: $?"
> > +	fi
> > +
> > +	kexec -su
And here as well.

> > +
> > +	if ! measure "$cmdline"; then
> > +		tst_brk TFAIL "unable to find a correct entry in the IMA log"
> > +	fi
> > +
> > +	tst_res TPASS "kexec cmdline was measured correctly"
> > +}
> > +
> > +tst_run

@Mimi, @Lachlan: if you both ack my changes, I can fix the code before merging.
If there are more changes needed and thus Lachlan plan new version, please use
my patches from https://patchwork.ozlabs.org/project/ltp/list/?series=191990&state=*
(download https://patchwork.ozlabs.org/series/191990/mbox/ and import it with "git am")
or clone my github fork and use kexec.v3.fixes branch:
https://github.com/pevik/ltp/tree/ima/kexec.v3.fixes).

Kind regards,
Petr
