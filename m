Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FC7E3BAA
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 21:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504369AbfJXTCl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 15:02:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:7222 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504337AbfJXTCk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 15:02:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 12:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="399868603"
Received: from nesterov-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.8.153])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2019 12:02:35 -0700
Date:   Thu, 24 Oct 2019 22:02:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20191024190217.GA7002@linux.intel.com>
References: <20191016182814.18350-1-ivan.lazeev@gmail.com>
 <20191021155735.GA7387@linux.intel.com>
 <20191023115151.GF21973@linux.intel.com>
 <20191023232035.ir7hmed4m3emovyx@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023232035.ir7hmed4m3emovyx@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 23, 2019 at 04:20:35PM -0700, Jerry Snitselaar wrote:
> On Wed Oct 23 19, Jarkko Sakkinen wrote:
> > On Mon, Oct 21, 2019 at 06:57:35PM +0300, Jarkko Sakkinen wrote:
> > > Almost tested this today. Unfortunately the USB stick at hand was
> > > broken.  I'll retry tomorrow or Wed depending on which day I visit at
> > > the office and which day I WFH.
> > > 
> > > At least the AMI BIOS had all the TPM stuff in it. The hardware I'll be
> > > using is Udoo Bolt V8 (thanks Jerry for pointing me out this device)
> > > with AMD Ryzen Embedded V1605B [1]
> > > 
> > > Thanks for the patience with your patch.
> > > 
> > > [1] https://en.wikichip.org/wiki/amd/ryzen_embedded/v1605b
> > 
> > Jerry, are you confident to give this tested-by?
> > 
> > I'm still in process of finding what I should put to .config in order
> > to get USB keyboard working with UDOO BOLT.
> > 
> > /Jarkko
> 
> I ran it through the tpm2 kselftests and it passed:
> 
> TAP version 13
> 1..2
> # selftests: tpm2: test_smoke.sh
> # test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
> # test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
> # test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
> # test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
> # test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
> # test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
> # test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
> # test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
> # test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ok
> #
> # ----------------------------------------------------------------------
> # Ran 9 tests in 12.305s
> #
> # OK
> ok 1 selftests: tpm2: test_smoke.sh
> # selftests: tpm2: test_space.sh
> # test_flush_context (tpm2_tests.SpaceTest) ... ok
> # test_get_handles (tpm2_tests.SpaceTest) ... ok
> # test_invalid_cc (tpm2_tests.SpaceTest) ... ok
> # test_make_two_spaces (tpm2_tests.SpaceTest) ... ok
> #
> # ----------------------------------------------------------------------
> # Ran 4 tests in 11.355s
> #
> # OK
> ok 2 selftests: tpm2: test_space.sh
> 
> 
> I also did some other testing of tpm2-tools commands, creating a
> trusted key and encrypted key, and running rngtest against /dev/random
> with the current hwrng being tpm-rng-0.
> 
> I ran the selftests on an intel nuc as well:
> 
> TAP version 13
> 1..2
> # selftests: tpm2: test_smoke.sh
> # test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
> # test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
> # test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
> # test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
> # test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
> # test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
> # test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
> # test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
> # test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ok
> # # ----------------------------------------------------------------------
> # Ran 9 tests in 29.620s
> # # OK
> ok 1 selftests: tpm2: test_smoke.sh
> # selftests: tpm2: test_space.sh
> # test_flush_context (tpm2_tests.SpaceTest) ... ok
> # test_get_handles (tpm2_tests.SpaceTest) ... ok
> # test_invalid_cc (tpm2_tests.SpaceTest) ... ok
> # test_make_two_spaces (tpm2_tests.SpaceTest) ... ok
> # # ----------------------------------------------------------------------
> # Ran 4 tests in 26.337s
> # # OK
> ok 2 selftests: tpm2: test_space.sh
> 
> 
> So,
> 
> Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> 
> 
> One thing I've noticed on the bolt and the nuc:
> 
> [    0.808935] tpm_tis MSFT0101:00: IRQ index 0 not found
> 
> I'm guessing this is Stefan's patches causing this?
> 
> 1ea32c83c699 | 2019-09-02 | tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts (Stefan Berger)
> 5b359c7c4372 | 2019-09-02 | tpm_tis_core: Turn on the TPM before probing IRQ's (Stefan Berger)
> 
> I've never noticed tpm_tis messages before on a tpm_crb system, and doublechecked that I don't see it with 5.3.

I'd guess it is related to:

https://patchwork.kernel.org/patch/11200049/

Thank you for the tested-by. I pushed this now. I'll try to get also
my tested-by before sending the PR (still fighting to find correct
kernel config to enable USB keyboard with UDOO BOLT).

/Jarkko
