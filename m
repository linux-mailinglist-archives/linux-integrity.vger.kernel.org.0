Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398CB2024CE
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Jun 2020 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgFTPgn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 20 Jun 2020 11:36:43 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33088 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgFTPgn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 20 Jun 2020 11:36:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ADE648EE0DF;
        Sat, 20 Jun 2020 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592667402;
        bh=IAzLA4Nw4byGvLCmmgYTlb4E4SvgBzctr+lJ/WQJsS8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GQGGDux8RfdyX0JucAoSdjaYW/j1jxROCP2xxLa7qJaNv/wkAf5eLbhxA9N+uRvVG
         RaybokTnHd0eZMMgYOfGnr43BLWsonTScqR73W+OqCbmaPZuVz5EOyu7JwkywlMYZM
         SnH0VGymEqbpUl6iBjO5mEeMrhsGEd6kDjB+8xrc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 57w7gC6kHhlY; Sat, 20 Jun 2020 08:36:42 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 421B48EE079;
        Sat, 20 Jun 2020 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592667402;
        bh=IAzLA4Nw4byGvLCmmgYTlb4E4SvgBzctr+lJ/WQJsS8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GQGGDux8RfdyX0JucAoSdjaYW/j1jxROCP2xxLa7qJaNv/wkAf5eLbhxA9N+uRvVG
         RaybokTnHd0eZMMgYOfGnr43BLWsonTScqR73W+OqCbmaPZuVz5EOyu7JwkywlMYZM
         SnH0VGymEqbpUl6iBjO5mEeMrhsGEd6kDjB+8xrc=
Message-ID: <1592667400.3583.10.camel@HansenPartnership.com>
Subject: Re: [PATCH 3/8] oid_registry: Add TCG defined OIDS for TPM keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Wiseman, Monty (GE Research, US)" <monty.wiseman@ge.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Sat, 20 Jun 2020 08:36:40 -0700
In-Reply-To: <26ED11907FC0F446BB0296B5357EEF0E316CDBB0@CINMBCNA02.e2k.ad.ge.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781746.14069.11.camel@HansenPartnership.com>
         <194d8ba601b9ecb43e812445729c6270e9f32162.camel@infradead.org>
         <26ED11907FC0F446BB0296B5357EEF0E316CDBB0@CINMBCNA02.e2k.ad.ge.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-06-19 at 20:45 +0000, Wiseman, Monty (GE Research, US)
wrote:
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
> > Subject: EXT: Re: [PATCH 3/8] oid_registry: Add TCG defined OIDS
> > for TPM
> > keys
> > 
> > On Sat, 2019-12-07 at 21:09 -0800, James Bottomley wrote:
> > > The TCG has defined an OID prefix "2.23.133.10.1" for the various
> > > TPM
> > > key uses.  We've defined three of the available numbers:
> > > 
> > > 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key
> > > (Usually
> > > 		RSA2048 or Elliptic Curve) which can be imported by a
> > > 		TPM2_Load() operation.
> > > 
> > > 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key
> > > (Usually
> > > 		RSA2048 or Elliptic Curve) which can be imported by a
> > > 		TPM2_Import() operation.
> > > 
> > > Both loadable and importable keys are specific to a given TPM,
> > > the
> > > difference is that a loadable key is wrapped with the symmetric
> > > secret, so must have been created by the TPM itself.  An
> > > importable
> > > key is wrapped with a DH shared secret, and may be created
> > > without
> > > access to the TPM provided you know the public part of the parent
> > > key.
> > > 
> > > 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to
> > > 128
> > > 		bytes) which is sealed by the TPM.  It usually
> > > 		represents a symmetric key and must be unsealed before
> > > 		use.
> > 
> > Do we still not have an official reference for these that you can
> > provide in the commit or the file itself?
> > 
> > It would be very nice to have something more than a verbal
> > assurance
> > that they're in Monty's spreadsheet.
> > 
> > 
> > > Signed-off-by: James Bottomley
> > 
> > <James.Bottomley@HansenPartnership.com>
> > > ---
> > >  include/linux/oid_registry.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/include/linux/oid_registry.h
> > > b/include/linux/oid_registry.h
> > > index 657d6bf2c064..a4cee888f9b0 100644
> > > --- a/include/linux/oid_registry.h
> > > +++ b/include/linux/oid_registry.h
> > > @@ -107,6 +107,11 @@ enum OID {
> > >  	OID_gostTC26Sign512B,		/*
> > > 1.2.643.7.1.2.1.2.2 */
> > >  	OID_gostTC26Sign512C,		/*
> > > 1.2.643.7.1.2.1.2.3 */
> > > 
> > > +	/* TCG defined OIDS for TPM based keys */
> > > +	OID_TPMLoadableKey,		/* 2.23.133.10.1.3 */
> > > +	OID_TPMImporableKey,		/* 2.23.133.10.1.4
> > > */
> > > +	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
> > > +
> > >  	OID__NR
> > >  };
> > > 
> 
> Bring back an old thread.  We are finally getting the TCG OID
> registry ready to publish and wanted to verifier the OIDs you
> requested and we assigned
> above.
> 
> I can find 2.23.133.10.1.3 TPM Loadable key in the tpm2-tss-engine
> project.
> 
> I do not see this one, nor the others list above in the kernel
> source. Did these ever get used? If so, where and can you provide a
> use case for a relying party?

Yes, the openssl_tpm2_engine project.  It's a more sophisticated
version of the above:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

The use case is that we can use the same ASN.1 format for data entities
that respond to different TPM2 commands, so:

2.23.133.10.1.3: Public and Private parts used as input to TPM2_Load
which produce a keyhandle for public key operations

2.23.133.10.1.4: Public and Private parts used as input to TPM2_Import
which produce a key handle for public key operations

2.23.133.10.1.5: Public and Private parts used as input to TPM2_Load
which produce a keyandle for TPM2_Unseal

I believe we discussed the fact that we'd need several OIDs for the
various key formats which are the same data structure but are used
differently.  However, the only other use I can think of for the ASN.1
structure would be importable unsealed data.  I don't think anyone's
yet implemented that, but I can see there might be a use case and it
would be convenient to have a published OID for it, say
2.23.133.10.1.6?

> Also, I have in my local spreadsheet the following which I believe
> were just drafts and never assigned. Please confirm.
> 2.23.133.10.1.1.2
> Secondary Identifier: tcg-wellKnownAuthValue
> 
> This in intended to be bitmap of well-known authValues. This is not
> intended to contain an actual authValue. For example. Bit 1 means and
> authValue of hashsize all zeros, Bit 2 means an authValue of hashsize
> all NULLs,
> etc.
> [Note: Bit 1 is lsb in this notation]
> 
> 2.23.133.10.1.1.3
> No secondary identifier or description
> 
> 2.23.133.10.1.1.4
> No secondary identifier or description

I don't think they were ever anything to do with the TPM engine
projects.  They were just something you already had in the spreadsheet
at the time, which is why you told me to start at ...10.1.3

James

