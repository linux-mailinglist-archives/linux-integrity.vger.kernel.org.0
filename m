Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2199327ED10
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 17:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgI3PfK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 11:35:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:23144 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgI3PfK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 11:35:10 -0400
IronPort-SDR: qt8xh47IZ9NkKGe5Otp4NdV9oxrgRUOeyX4NlqIQRuWoBq+/YBL6ymwCLk0b94yXRm3QBo4mWz
 Oswdg/U9K8kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="141882915"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="141882915"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 08:35:09 -0700
IronPort-SDR: GbobdLkV0SHFx35Sp0jbW8ZoGtMmkFcn4Lhlm8oV0FXk5ueJnFQewS38yT3ONHdk+INPlvq3ta
 eWQBamRpfX1w==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="498043210"
Received: from geigerri-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 08:35:06 -0700
Date:   Wed, 30 Sep 2020 18:35:04 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v13 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
Message-ID: <20200930153504.GB52739@linux.intel.com>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
 <20200922022809.7105-5-James.Bottomley@HansenPartnership.com>
 <20200930111102.GB5145@linux.intel.com>
 <b8de8923e026525589c97b3cb7691a557c0a292f.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8de8923e026525589c97b3cb7691a557c0a292f.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 30, 2020 at 07:49:51AM -0700, James Bottomley wrote:
> On Wed, 2020-09-30 at 14:11 +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 21, 2020 at 07:28:08PM -0700, James Bottomley wrote:
> > > Modify the TPM2 key format blob output to export and import in the
> > > ASN.1 form for TPM2 sealed object keys.  For compatibility with
> > > prior trusted keys, the importer will also accept two TPM2B
> > > quantities representing the public and private parts of the
> > > key.  However, the export via keyctl pipe will only output the
> > > ASN.1 format.
> > > 
> > > The benefit of the ASN.1 format is that it's a standard and thus
> > > the exported key can be used by userspace tools
> > > (openssl_tpm2_engine, openconnect and tpm2-tss-engine).  The format
> > > includes policy specifications, thus it gets us out of having to
> > > construct policy handles in userspace and the format includes the
> > > parent meaning you don't have to keep passing it in each time.
> > > 
> > > This patch only implements basic handling for the ASN.1 format, so
> > > keys with passwords but no policy.
> > > 
> > > Signed-off-by: James Bottomley <
> > > James.Bottomley@HansenPartnership.com>
> > 
> > I did the test for 3/5 with this patch applied (actually all patches
> > in this series) so I can safely
> > 
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > I have one wish though before giving reviewed-by.
> > 
> > In my recent trusted keys fixes I took the convention trusted_tpm_*
> > for TPM trusted keys functions. I think we should start doing that
> > for all functions:
> > 
> > 1. For interface functions trusted_tpm_*
> > 2. TPM1: trusted_tpm1_*
> > 2. TPM2: trusted_tpm2_*
> 
> I'm not such a fan of this: we've discussed moving some of the
> functions around because we expect to grow consumers.  We really don't
> want to be having to rename everything as we move it, so I'd far prefer
> the name were related to the function rather than the location in the
> kernel tree.

OK, I see you point here. The trusted_tpm_* functions that I added are
directly bound to the specifict trusted keys implementation,  so it is
a different situation.

> > This is to manage chaos with TEE Trusted Keys in future and make the
> > distinction with TPM subsystem functions, and make it easier to grep
> > and trace this stuff with the various tracing tools.
> > 
> > This anyway needs one more rebase on top of the fixes that I did.
> > 
> > BTW, what is the situation with the ARM compilation issue?
> 
> It was fixed in this incarnation.

OK, great.

/Jarkko
