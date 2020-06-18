Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B981FEC0E
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgFRHO5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 03:14:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:13982 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgFRHO4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 03:14:56 -0400
IronPort-SDR: WLTCpuJ1UseivhoTRFRODLy2Hj4QDFe+Afe1/qVrOwUAzIt2RnNmqCnIBsPFvwlnMWYHYwR6TW
 kx38BgfigzWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="140824140"
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="140824140"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 00:14:56 -0700
IronPort-SDR: 38e8kL0h5wRnOg19M0CkaBZOGWJxhGrA42/EBZwgrX7P3x3/a1yAjRtobGgXcGtGjt6IbDE3wJ
 C78Y0AXSSYEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="263515951"
Received: from jkalinox-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.49.234])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2020 00:14:53 -0700
Date:   Thu, 18 Jun 2020 10:14:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 2/8] oid_registry: Add TCG defined OIDS for TPM keys
Message-ID: <20200618071451.GC6560@linux.intel.com>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
 <20200616160229.8018-3-James.Bottomley@HansenPartnership.com>
 <20200617214237.dlvfnx2s7aw4sfng@cantor>
 <1592439940.3515.40.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592439940.3515.40.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 17, 2020 at 05:25:40PM -0700, James Bottomley wrote:
> On Wed, 2020-06-17 at 14:42 -0700, Jerry Snitselaar wrote:
> > On Tue Jun 16 20, James Bottomley wrote:
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
> > > Both loadable and importable keys are specific to a given TPM, the
> > > difference is that a loadable key is wrapped with the symmetric
> > > secret, so must have been created by the TPM itself.  An importable
> > > key is wrapped with a DH shared secret, and may be created without
> > > access to the TPM provided you know the public part of the parent
> > > key.
> > > 
> > > 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
> > > 		bytes) which is sealed by the TPM.  It usually
> > > 		represents a symmetric key and must be unsealed before
> > > 		use.
> > > 
> > 
> > James, which document are these defined in? I was searching last
> > night, and couldn't find it.
> 
> It isn't.  It's defined in a TCG spreadsheet that Monty Wiseman keeps,
> but that seems to be as "official" as it gets with the TCG OID
> registry.
> 
> James

"The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
key uses."

Should this sentence start just as "TCG ...", not sure if "the" is
required?

/Jarkko
