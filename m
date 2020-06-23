Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A756204699
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 03:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbgFWBR7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 21:17:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:12656 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731466AbgFWBR7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 21:17:59 -0400
IronPort-SDR: Y/T2L06UzLKA3kBPMWrA/HdtXv3lgAEghEkPdoH8ulmkFPqtGUjPQV6Ysa6TdZIgqhS1uZYJ52
 S7uwZZuTPreg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="141426685"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="141426685"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 18:17:57 -0700
IronPort-SDR: Ka/xdDBzglgnZ7q+EfCYiUripKChDcLPndCKKvApNz8S5a4XbyWXKCtrIvrOUrOezwgBkgF0a8
 fV0ak7TOAZww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="319012568"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2020 18:17:54 -0700
Date:   Tue, 23 Jun 2020 04:17:53 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Wiseman, Monty (GE Research, US)" <monty.wiseman@ge.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 3/8] oid_registry: Add TCG defined OIDS for TPM keys
Message-ID: <20200623011753.GH28795@linux.intel.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
 <1575781746.14069.11.camel@HansenPartnership.com>
 <194d8ba601b9ecb43e812445729c6270e9f32162.camel@infradead.org>
 <26ED11907FC0F446BB0296B5357EEF0E316CDBB0@CINMBCNA02.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ED11907FC0F446BB0296B5357EEF0E316CDBB0@CINMBCNA02.e2k.ad.ge.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 19, 2020 at 08:45:24PM +0000, Wiseman, Monty (GE Research, US) wrote:
> James,
> 
> > -----Original Message-----
> > From: David Woodhouse <dwmw2@infradead.org>
> > Sent: December 9, 2019 03:56 AM
> > To: James Bottomley <James.Bottomley@HansenPartnership.com>; linux-
> > integrity@vger.kernel.org; Wiseman, Monty (GE Global Research, US)
> > <monty.wiseman@ge.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>; Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com>
> > Subject: EXT: Re: [PATCH 3/8] oid_registry: Add TCG defined OIDS for TPM
> > keys
> >
> > On Sat, 2019-12-07 at 21:09 -0800, James Bottomley wrote:
> > > The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
> > > key uses.  We've defined three of the available numbers:
> > >
> > > 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key (Usually
> > > 		RSA2048 or Elliptic Curve) which can be imported by a
> > > 		TPM2_Load() operation.
> > >
> > > 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key (Usually
> > > 		RSA2048 or Elliptic Curve) which can be imported by a
> > > 		TPM2_Import() operation.
> > >
> > > Both loadable and importable keys are specific to a given TPM, the
> > > difference is that a loadable key is wrapped with the symmetric
> > > secret, so must have been created by the TPM itself.  An importable
> > > key is wrapped with a DH shared secret, and may be created without
> > > access to the TPM provided you know the public part of the parent key.
> > >
> > > 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
> > > 		bytes) which is sealed by the TPM.  It usually
> > > 		represents a symmetric key and must be unsealed before
> > > 		use.
> >
> > Do we still not have an official reference for these that you can
> > provide in the commit or the file itself?
> >
> > It would be very nice to have something more than a verbal assurance
> > that they're in Monty's spreadsheet.
> >
> >
> > > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > > ---
> > >  include/linux/oid_registry.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> > > index 657d6bf2c064..a4cee888f9b0 100644
> > > --- a/include/linux/oid_registry.h
> > > +++ b/include/linux/oid_registry.h
> > > @@ -107,6 +107,11 @@ enum OID {
> > >  	OID_gostTC26Sign512B,		/* 1.2.643.7.1.2.1.2.2 */
> > >  	OID_gostTC26Sign512C,		/* 1.2.643.7.1.2.1.2.3 */
> > >
> > > +	/* TCG defined OIDS for TPM based keys */

Would be nice to have a link to the TCG OID specification instead of
this text.

> > > +	OID_TPMLoadableKey,		/* 2.23.133.10.1.3 */
> > > +	OID_TPMImporableKey,		/* 2.23.133.10.1.4 */
> > > +	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
> > > +
> > >  	OID__NR
> > >  };
> > >
> Bring back an old thread.  We are finally getting the TCG OID registry ready
> to publish and wanted to verifier the OIDs you requested and we assigned
> above.
> 
> I can find 2.23.133.10.1.3 TPM Loadable key in the tpm2-tss-engine project.
> 
> I do not see this one, nor the others list above in the kernel source. Did 
> these ever
> get used? If so, where and can you provide a use case for a relying party?
> 
> Also, I have in my local spreadsheet the following which I believe were just
> drafts and never assigned. Please confirm.
> 2.23.133.10.1.1.2
> Secondary Identifier: tcg-wellKnownAuthValue
> 
> This in intended to be bitmap of well-known authValues. This is not intended
> to contain an actual authValue. For example. Bit 1 means and authValue of
> hashsize all zeros, Bit 2 means an authValue of hashsize all NULLs, etc.
> [Note: Bit 1 is lsb in this notation]
> 
> 2.23.133.10.1.1.3
> No secondary identifier or description
> 
> 2.23.133.10.1.1.4
> No secondary identifier or description
> 
> 
> Monty Wiseman
> Principal Engineer, Security Architecture
> Controls & Optimization

/Jarkko
