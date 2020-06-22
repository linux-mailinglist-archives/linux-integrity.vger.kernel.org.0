Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7C20433F
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 00:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgFVWEu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 18:04:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:22921 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730839AbgFVWEu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 18:04:50 -0400
IronPort-SDR: uitBj6KVdvrNaXYZzA24a+vwSqZ+ZPdN1izDUpxf3pfvSrolM0M5a7a8V44LI1+htUlh5qfgzQ
 2nDYfzrr4Dlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="205379023"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="205379023"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 15:04:49 -0700
IronPort-SDR: WZl7TvUmNt2ctFzfFrmyq5v+cw50VKBmzSNhzXiSQlqXUCeXvMMtLlwmqb+iIGRyKFY4+80epB
 xQOprMD/FYaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="353606616"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2020 15:04:46 -0700
Date:   Tue, 23 Jun 2020 01:04:44 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 2/8] oid_registry: Add TCG defined OIDS for TPM keys
Message-ID: <20200622220444.GG22727@linux.intel.com>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
 <20200616160229.8018-3-James.Bottomley@HansenPartnership.com>
 <20200617214237.dlvfnx2s7aw4sfng@cantor>
 <1592439940.3515.40.camel@HansenPartnership.com>
 <20200618071451.GC6560@linux.intel.com>
 <1592508122.15159.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592508122.15159.7.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 18, 2020 at 12:22:02PM -0700, James Bottomley wrote:
> On Thu, 2020-06-18 at 10:14 +0300, Jarkko Sakkinen wrote:
> > On Wed, Jun 17, 2020 at 05:25:40PM -0700, James Bottomley wrote:
> > > On Wed, 2020-06-17 at 14:42 -0700, Jerry Snitselaar wrote:
> > > > On Tue Jun 16 20, James Bottomley wrote:
> > > > > The TCG has defined an OID prefix "2.23.133.10.1" for the
> > > > > various
> > > > > TPM
> > > > > key uses.  We've defined three of the available numbers:
> > > > > 
> > > > > 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key
> > > > > (Usually
> > > > > 		RSA2048 or Elliptic Curve) which can be
> > > > > imported by a
> > > > > 		TPM2_Load() operation.
> > > > > 
> > > > > 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key
> > > > > (Usually
> > > > > 		RSA2048 or Elliptic Curve) which can be
> > > > > imported by a
> > > > > 		TPM2_Import() operation.
> > > > > 
> > > > > Both loadable and importable keys are specific to a given TPM,
> > > > > the
> > > > > difference is that a loadable key is wrapped with the symmetric
> > > > > secret, so must have been created by the TPM itself.  An
> > > > > importable
> > > > > key is wrapped with a DH shared secret, and may be created
> > > > > without
> > > > > access to the TPM provided you know the public part of the
> > > > > parent
> > > > > key.
> > > > > 
> > > > > 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to
> > > > > 128
> > > > > 		bytes) which is sealed by the TPM.  It usually
> > > > > 		represents a symmetric key and must be unsealed
> > > > > before
> > > > > 		use.
> > > > > 
> > > > 
> > > > James, which document are these defined in? I was searching last
> > > > night, and couldn't find it.
> > > 
> > > It isn't.  It's defined in a TCG spreadsheet that Monty Wiseman
> > > keeps, but that seems to be as "official" as it gets with the TCG
> > > OID registry.
> > > 
> > > James
> > 
> > "The TCG has defined an OID prefix "2.23.133.10.1" for the various
> > TPM key uses."
> > 
> > Should this sentence start just as "TCG ...", not sure if "the" is
> > required?
> 
> I've always referred to it as The Trusted Computing Group (so the TCG)
> partly to show they're not just any old trusted computing group.  But I
> think they mostly do refer to themselves in literature as TCG.

... not that this highly important, just asking for pure interest :-)

/Jarkko
