Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1199D166831
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2020 21:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgBTURK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Feb 2020 15:17:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:5376 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgBTURJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Feb 2020 15:17:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 12:17:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="408901241"
Received: from moriol-mobl.ger.corp.intel.com (HELO localhost) ([10.252.25.78])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2020 12:17:05 -0800
Date:   Thu, 20 Feb 2020 22:17:03 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v5 0/6] TPM 2.0 trusted keys with attached policy
Message-ID: <20200220201703.GA24990@linux.intel.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 30, 2020 at 11:18:06AM +0100, James Bottomley wrote:
> This is mainly a respin to add more spacing as Jarkko requested.
> However, I also added the seal/unseal operations to the
> openssl_tpm2_engine (next branch):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/
> 
> With the result that the kernel code completely failed the
> interoperability checks because the ASN.1 format requires the TPM2B
> length prepended to the public and private blobs.  I corrected this in
> patch 4 and now all the interoperability tests are passing.
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
> James
> 
> ---
> 
> James Bottomley (6):
>   lib: add ASN.1 encoder
>   oid_registry: Add TCG defined OIDS for TPM keys
>   security: keys: trusted fix tpm2 authorizations
>   security: keys: trusted: use ASN.1 TPM2 key format for the blobs
>   security: keys: trusted: add ability to specify arbitrary policy
>   security: keys: trusted: implement counter/timer policy
> 
>  Documentation/security/keys/trusted-encrypted.rst |  64 ++-
>  include/keys/trusted-type.h                       |   7 +-
>  include/linux/asn1_encoder.h                      |  32 ++
>  include/linux/oid_registry.h                      |   5 +
>  include/linux/tpm.h                               |   8 +
>  lib/Makefile                                      |   2 +-
>  lib/asn1_encoder.c                                | 431 ++++++++++++++++++++
>  security/keys/Kconfig                             |   2 +
>  security/keys/trusted-keys/Makefile               |   2 +-
>  security/keys/trusted-keys/tpm2-policy.c          | 463 ++++++++++++++++++++++
>  security/keys/trusted-keys/tpm2-policy.h          |  31 ++
>  security/keys/trusted-keys/tpm2key.asn1           |  23 ++
>  security/keys/trusted-keys/trusted_tpm1.c         |  50 ++-
>  security/keys/trusted-keys/trusted_tpm2.c         | 370 +++++++++++++++--
>  14 files changed, 1454 insertions(+), 36 deletions(-)
>  create mode 100644 include/linux/asn1_encoder.h
>  create mode 100644 lib/asn1_encoder.c
>  create mode 100644 security/keys/trusted-keys/tpm2-policy.c
>  create mode 100644 security/keys/trusted-keys/tpm2-policy.h
>  create mode 100644 security/keys/trusted-keys/tpm2key.asn1
> 
> -- 
> 2.16.4

Somehow managed to drown this to my emails. Looking into next week.

/Jarkko
> 
