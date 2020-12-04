Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7912CE711
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 05:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgLDEo5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Dec 2020 23:44:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:25401 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgLDEo5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Dec 2020 23:44:57 -0500
IronPort-SDR: JjPwbhfR5CN7Mv55E0DYbQBXE2uU3QZ2FNCSz+0yvbnsVgbR/jGTuC8UDS3T8YFU37RLqlGZqj
 aVArcosGyiFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="258040361"
X-IronPort-AV: E=Sophos;i="5.78,391,1599548400"; 
   d="scan'208";a="258040361"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 20:43:14 -0800
IronPort-SDR: ILfJr7B+C6Ud9vErCXT73j4pD9S8VIJrV0DlMT/y3p1M7mJ90cDFPpF0EwVWFTUluPXshYQXuu
 HJhcXoIHndWA==
X-IronPort-AV: E=Sophos;i="5.78,391,1599548400"; 
   d="scan'208";a="315975966"
Received: from kramerha-mobl.ger.corp.intel.com (HELO linux.intel.com) ([10.252.53.177])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 20:43:12 -0800
Date:   Fri, 4 Dec 2020 06:43:07 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 1/5] lib: add ASN.1 encoder
Message-ID: <20201204044307.GB84413@linux.intel.com>
References: <20201129222004.4428-1-James.Bottomley@HansenPartnership.com>
 <20201129222004.4428-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129222004.4428-2-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 29, 2020 at 02:20:00PM -0800, James Bottomley wrote:
> We have a need in the TPM2 trusted keys to return the ASN.1 form of
> the TPM key blob so it can be operated on by tools outside of the
> kernel.  The specific tools are the openssl_tpm2_engine, openconnect
> and the Intel tpm2-tss-engine.  To do that, we have to be able to read
> and write the same binary key format the tools use.  The current ASN.1
> decoder does fine for reading, but we need pieces of an ASN.1 encoder
> to write the key blob in binary compatible form.
> 
> For backwards compatibility, the trusted key reader code will still
> accept the two TPM2B quantities that it uses today, but the writer
> will only output the ASN.1 form.
> 
> The current implementation only encodes the ASN.1 bits we actually need.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Also:

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I've successfully used this multiple times already.

/Jarkko
