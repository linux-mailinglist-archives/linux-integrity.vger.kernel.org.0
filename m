Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F6C27B2D2
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 19:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgI1RMo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 13:12:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:55534 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgI1RMo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 13:12:44 -0400
IronPort-SDR: JUnFEodwvNCy7ZFra21yOVKRiitIY4P1oQTinpPOtM2Nhad+V7N6noysL79bBs4Ub5SU2avYGt
 /u5/HJLdt5fA==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="141437254"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="141437254"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:12:43 -0700
IronPort-SDR: Uv+n6jt9GG5EmsFF1YJGbGEn9CtZ6b4LPpBZJTgN2GGWI16laY2+QfTpfxZXK4hQjjhYOyL1m1
 sAG+uge1/LJw==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="488667581"
Received: from evinhugx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.44.118])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:12:40 -0700
Date:   Mon, 28 Sep 2020 20:12:39 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>, tweek@google.com
Subject: Re: [Regression] "tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures" causes null pointer dereference
Message-ID: <20200928171238.GB119268@linux.intel.com>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
 <20200928140623.GA69515@linux.intel.com>
 <BB63B86E-CA44-4EB7-A5D1-21B0E9EB2850@canonical.com>
 <20200928155215.GA92669@linux.intel.com>
 <CAMj1kXF-hOTZ62_Tf_GAN9_w7ztngdVp_atNrowH5Y0SwSjCAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF-hOTZ62_Tf_GAN9_w7ztngdVp_atNrowH5Y0SwSjCAw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 28, 2020 at 06:15:00PM +0200, Ard Biesheuvel wrote:
> > > > It is possible but initially feels a bit weird:
> > > >
> > > > -                  sizeof(TCG_SPECID_SIG)) || count > efispecid->num_algs) {
> > > > +                  sizeof(TCG_SPECID_SIG)) ||
> > > > +           !efispecid->num_algs || count != efispecid->num_algs) {

^^^

> In tpm2_bios_measurements_start(), we dereference tpm_bios_log to
> access bios_event_log and bios_event_log_end without checking tpm_bios
> for NULL. This is where the crash seems to occur.

That's a good guess. Just a bit confused how that particular patch can
have the effect: it has two deferences to efispecid instead of one in
the same statement. Would be interesting to hear if the bug is triggered
in Kenneth's environment by the exact same commit.

/Jarkko
