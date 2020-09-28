Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE727B464
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1SWg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 14:22:36 -0400
Received: from l2mail1.panix.com ([166.84.1.75]:56017 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgI1SWf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 14:22:35 -0400
X-Greylist: delayed 1012 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 14:22:35 EDT
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4C0Vn40HcfzDS8;
        Mon, 28 Sep 2020 14:05:43 -0400 (EDT)
Received: from xps-7390 (cpe-23-242-39-94.socal.res.rr.com [23.242.39.94])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4C0Vn164GYzmWW;
        Mon, 28 Sep 2020 14:05:41 -0400 (EDT)
Date:   Mon, 28 Sep 2020 11:05:39 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>, tweek@google.com
Subject: Re: [Regression] "tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures" causes null pointer dereference
In-Reply-To: <20200928171238.GB119268@linux.intel.com>
Message-ID: <alpine.DEB.2.23.453.2009281104310.3261@xps-7390>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com> <20200928140623.GA69515@linux.intel.com> <BB63B86E-CA44-4EB7-A5D1-21B0E9EB2850@canonical.com> <20200928155215.GA92669@linux.intel.com> <CAMj1kXF-hOTZ62_Tf_GAN9_w7ztngdVp_atNrowH5Y0SwSjCAw@mail.gmail.com>
 <20200928171238.GB119268@linux.intel.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On Mon, 28 Sep 2020, Jarkko Sakkinen wrote:

> That's a good guess. Just a bit confused how that particular patch can
> have the effect: it has two deferences to efispecid instead of one in
> the same statement. Would be interesting to hear if the bug is triggered
> in Kenneth's environment by the exact same commit.

I can confirm that reverting 7f3d176f5f stops my kernel from panic()ing:

$ sudo fwupdtpmevlog
[sudo] password for kenny:
Failed to parse file: attempted to read 0x10 bytes from buffer of 0x00
$

It would normally OOPS at that point.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
