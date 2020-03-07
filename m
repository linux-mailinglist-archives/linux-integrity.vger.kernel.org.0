Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF517D063
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Mar 2020 23:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgCGWA3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 Mar 2020 17:00:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:23789 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgCGWA3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 Mar 2020 17:00:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 14:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,527,1574150400"; 
   d="scan'208";a="276010277"
Received: from speryt-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.14.154])
  by fmsmga002.fm.intel.com with ESMTP; 07 Mar 2020 14:00:27 -0800
Date:   Sun, 8 Mar 2020 00:00:26 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v7 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
Message-ID: <20200307220026.GA122868@linux.intel.com>
References: <20200305022744.12492-1-James.Bottomley@HansenPartnership.com>
 <20200305022744.12492-5-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305022744.12492-5-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 04, 2020 at 06:27:42PM -0800, James Bottomley wrote:
> Modify the TPM2 key format blob output to export and import in the
> ASN.1 form for TPM2 sealed object keys.  For compatibility with prior
> trusted keys, the importer will also accept two TPM2B quantities
> representing the public and private parts of the key.  However, the
> export via keyctl pipe will only output the ASN.1 format.
> 
> The benefit of the ASN.1 format is that it's a standard and thus the
> exported key can be used by userspace tools (openssl_tpm2_engine,
> openconnect and tpm2-tss-engine).  The format includes policy
> specifications, thus it gets us out of having to construct policy
> handles in userspace and the format includes the parent meaning you
> don't have to keep passing it in each time.
> 
> This patch only implements basic handling for the ASN.1 format, so
> keys with passwords but no policy.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Not yet sure but I get

keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1 pcrinfo=03000001 6768033e216468247bd031a0a2d9876d79818f8f" @u
add_key: No such device

After applying 1/6-4/6.

At this point I'm assuming that I've made mistake somewhere, which is
entirely possible.

/Jarkko
