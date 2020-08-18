Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317CF247DEB
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 07:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgHRFiy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 01:38:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:42666 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgHRFiy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 01:38:54 -0400
IronPort-SDR: cn7kQt3qM/33iJhv1ZZJRisnL0ERwGfIBTGuXGHJJ+v8uy45sSOtp5uLvGiYtVN2Hpo3o1vciA
 ERmFSHdb595Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154103478"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="154103478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 22:38:54 -0700
IronPort-SDR: wvIW5wog2bJS4gOJXCOmQBofM5s8yJ2pctl29s58COQQInEtJ1TWI+Uy3PioiJPg67msNQI+qo
 1sewMzXrfI0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="400400039"
Received: from lcrossx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.46.217])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2020 22:38:53 -0700
Date:   Tue, 18 Aug 2020 08:38:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200818053852.GC119714@linux.intel.com>
References: <20200722155739.26957-1-James.Bottomley@HansenPartnership.com>
 <20200722155739.26957-2-James.Bottomley@HansenPartnership.com>
 <20200724065745.GB1871046@linux.intel.com>
 <1595820339.32688.26.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595820339.32688.26.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jul 26, 2020 at 08:25:39PM -0700, James Bottomley wrote:
> On Fri, 2020-07-24 at 09:57 +0300, Jarkko Sakkinen wrote:
> > On Wed, Jul 22, 2020 at 08:57:39AM -0700, James Bottomley wrote:
> > > use macro magic to create sysfs per hash groups with 24 PCR files
> > > in
> > 
> > 'Use'
> > 
> > Please, just say what the patch does in plain English and dust the
> > magic away.
> 
> The reason for the macro magic comment is that there are 3 checkpatch
> errors and one warning from this, all spurious, because checkpatch
> doesn't understand the syntax of macros that create macros.
> 
> > > them one for each possible agile hash of the TPM.  The files are
> >                                                    ~~
> > 
> > I'd prefer a single space.
> 
> It's still listed in the style guides as best practice for monospaced
> fonts, but at this point I've lost the will to care about it.
> 
> > > plugged in to a read function which is TPM version agnostic, so
> > > this works also for TPM 1.2 although the hash is only sha1 in that
> > > case. For every hash the TPM supports, a group named pcr-<hash> is
> > > created and each of the PCR read files placed under it.
> > 
> > Yeah, the commit message is missing the statement what it does and
> > goes straight away rationalizing "macro magic".
> 
> OK so how about
> 
> ---
> Create sysfs per hash groups with 24 PCR files in them one group, named
> pcr-<hash>, for each agile hash of the TPM.  The files are plugged in
> to a PCR read function which is TPM version agnostic, so this works
> also for TPM 1.2 although the hash is only sha1 in that case.
> 
> Note: the macros used to create the hashes emit spurious checkpatch
> warnings.  Do not try to "fix" them as checkpatch recommends otherwise
> they'll break.
> ---
> 
> James
> 

I'll check the latest version (saw it in patchwork). I just came back
from vacation - sorry for the delay.

/Jarkko
