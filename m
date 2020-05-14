Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62D81D32E8
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgENObn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 10:31:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:18374 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbgENObm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 10:31:42 -0400
IronPort-SDR: jj8voQk5VLhnTkkM9aoIBJRs5/rcSvHkqz7reVj8HvQtxKPIZL0M76JqCANSQrun5v17Or3HAl
 5szkFkEueHuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 07:31:15 -0700
IronPort-SDR: +VvltwEvuS2M9X6uOWottj/pxT9v+2KilD2hs56nTZRohxBvw60dpE8pz/Y12KfQmz7IDBMYxs
 AR+ELk90LHmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="298726823"
Received: from ashadrin-mobl1.ccr.corp.intel.com ([10.249.38.112])
  by orsmga008.jf.intel.com with ESMTP; 14 May 2020 07:31:13 -0700
Message-ID: <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
In-Reply-To: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 14 May 2020 17:31:02 +0300
User-Agent: Evolution 3.36.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-07 at 16:11 -0700, James Bottomley wrote:
> This is a respin on v8 to make the encoder selectable and address
> David's comments.  The trusted key part hasn't changed except to add a
> now necessary select for ASN1_ENCODER to patch 4 and the changelog of
> patch 6 has been updated to correct the cut and paste error in the
> keyctl statement.
> 
> General cover letter:
> 
> This patch updates the trusted key code to export keys in the ASN.1
> format used by current TPM key tools (openssl_tpm2_engine and
> openconnect).  It also simplifies the use of policy with keys because
> the ASN.1 format is designed to carry a description of how to
> construct the policy, with the result that simple policies (like
> authorization and PCR locking) can now be constructed and used in the
> kernel, bringing the TPM 2.0 policy use into line with how TPM 1.2
> works.
> 
> The key format is designed to be compatible with our two openssl
> engine implementations as well as with the format used by openconnect.
> I've added seal/unseal to my engine so I can use it for
> interoperability testing and I'll later use this for sealed symmetric
> keys via engine:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/
> 
> James

I'm compiling now kernel with all series included.

Kind of checking if I could just take the whole series. Let see.

In all cases I want the style errors in 3/8 to be fixes with a helper
but maybe better to hold before sending anything. Possibly that is all
needed I'll just carve that patch myself.

Please don't do anything for the moment.

/Jarkko

