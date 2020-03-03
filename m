Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C24211784D1
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 22:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbgCCVU6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Mar 2020 16:20:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:36035 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732413AbgCCVU6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Mar 2020 16:20:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 13:20:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="243730156"
Received: from fkuchars-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.4.236])
  by orsmga006.jf.intel.com with ESMTP; 03 Mar 2020 13:20:55 -0800
Date:   Tue, 3 Mar 2020 23:20:53 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v6 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
Message-ID: <20200303212053.GB110353@linux.intel.com>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
 <20200302122759.5204-5-James.Bottomley@HansenPartnership.com>
 <20200303200614.GD5775@linux.intel.com>
 <1583268141.3638.10.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583268141.3638.10.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 03, 2020 at 03:42:21PM -0500, James Bottomley wrote:
> On Tue, 2020-03-03 at 22:06 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 02, 2020 at 07:27:57AM -0500, James Bottomley wrote:
> > > Modify the TPM2 key format blob output to export and import in the
> > > ASN.1 form for TPM2 sealed object keys.  For compatibility with
> > > prior
> > > trusted keys, the importer will also accept two TPM2B quantities
> > > representing the public and private parts of the key.  However, the
> > > export via keyctl pipe will only output the ASN.1 format.
> > > 
> > > The benefit of the ASN.1 format is that it's a standard and thus
> > > the
> > > exported key can be used by userspace tools (openssl_tpm2_engine,
> > > openconnect and tpm2-tss-engine).  The format includes policy
> > > specifications, thus it gets us out of having to construct policy
> > > handles in userspace and the format includes the parent meaning you
> > > don't have to keep passing it in each time.
> > > 
> > > This patch only implements basic handling for the ASN.1 format, so
> > > keys with passwords but no policy.
> > > 
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > > om>
> > 
> > tpm_key (like you have tpm2_key prefix).
> 
> OK, I should probably do tpm2_key as the prefix since TPM 1.2 cannot do
>  policy, that's a TPM 2 only thing.

Agreed that would be even better.

/Jarkko
