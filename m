Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4515D27E1E7
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 08:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgI3G54 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 02:57:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:36456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgI3G54 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 02:57:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E31FABF4;
        Wed, 30 Sep 2020 06:57:55 +0000 (UTC)
Date:   Wed, 30 Sep 2020 08:57:53 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ima_tpm.sh: Fix calculating boot aggregate
Message-ID: <20200930065753.GC21664@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200925185034.24155-1-pvorel@suse.cz>
 <20200925185034.24155-4-pvorel@suse.cz>
 <20200929121735.GA11889@dell5510>
 <4ce0e22ef2812a9be66b45b5ce32902810f17efd.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ce0e22ef2812a9be66b45b5ce32902810f17efd.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Tue, 2020-09-29 at 14:17 +0200, Petr Vorel wrote:
> > Hi,

> > >  test1()
> > >  {
> > >  	tst_res TINFO "verify boot aggregate"

> > > -	local zero="0000000000000000000000000000000000000000"
> > >  	local tpm_bios="$SECURITYFS/tpm0/binary_bios_measurements"
> > > -	local ima_measurements="$ASCII_MEASUREMENTS"
> > > -	local boot_aggregate boot_hash line
> > > +	local cmd="evmctl ima_boot_aggregate"
> > > +	local boot_aggregate cmd zero

> > > -	# IMA boot aggregate
> > > -	read line < $ima_measurements
> > > -	boot_hash=$(echo $line | awk '{print $(NF-1)}' | cut -d':' -f2)
> > > +	if [ "$MISSING_EVMCTL" = 1 ]; then
> > > +		if [ -f "$tpm_bios" ]; then
> > I leaved this error during rebase:
> > if [ ! -f "$tpm_bios" ]; then

> > I'm still investigating corner case issue when
> > /sys/kernel/security/tpm0/binary_bios_measurements
> > is not presented (mostly when no TPM device, thus IMA "TPM-bypass" code being
> > used, but sometimes also for TPM 2.0 which does not export event log).

> There's another case as well.  On one of my test systems with a TPM 2.0
> chip, but without secure boot enabled, the binary_bios_measurements
> exists, but it can't be accessed.  dmesg contains a secure boot status
> line.
So you can view binary_bios_measurements with ls, but don't have permission to
read. Interesting.

> Mimi

Kind regards,
Petr
