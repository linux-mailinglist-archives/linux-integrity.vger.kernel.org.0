Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B339910DBDA
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Nov 2019 00:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfK2Xvi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Nov 2019 18:51:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:16353 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfK2Xvh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Nov 2019 18:51:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 15:51:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,259,1571727600"; 
   d="scan'208";a="241184315"
Received: from gamanzi-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.3.126])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2019 15:51:32 -0800
Date:   Sat, 30 Nov 2019 01:51:31 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Add tpm_version_major sysfs file
Message-ID: <20191129235131.GA21546@linux.intel.com>
References: <20191030225843.23366-1-jsnitsel@redhat.com>
 <20191128010826.w4ixlix3s3ovta3m@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128010826.w4ixlix3s3ovta3m@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Nov 27, 2019 at 06:08:26PM -0700, Jerry Snitselaar wrote:
> On Wed Oct 30 19, Jerry Snitselaar wrote:
> > Easily determining what TCG version a tpm device implements
> > has been a pain point for userspace for a long time, so
> > add a sysfs file to report the TCG major version of a tpm device.
> > 
> > Also add an entry to Documentation/ABI/stable/sysfs-class-tpm
> > describing the new file.
> > 
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: linux-integrity@vger.kernel.org
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > ---
> > v4: - Change file name to tpm_version_major
> >    - Actually display just the major version.
> >    - change structs to tpm1_* & tpm2_*
> >      instead of tpm12_* tpm20_*.
> > v3: - Change file name to version_major.
> > v2: - Fix TCG usage in commit message.
> >    - Add entry to sysfs-class-tpm in Documentation/ABI/stable
> > 
> > Documentation/ABI/stable/sysfs-class-tpm | 11 ++++++++
> > drivers/char/tpm/tpm-sysfs.c             | 34 +++++++++++++++++++-----
> > 2 files changed, 38 insertions(+), 7 deletions(-)
> > 
> 
> Anyone else have feedback?

I can apply this after the issues on hand have been sorted out.

/Jarkko
