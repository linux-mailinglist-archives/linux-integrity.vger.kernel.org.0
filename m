Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46434306D30
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jan 2021 07:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhA1GBb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jan 2021 01:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhA1GBb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jan 2021 01:01:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B061961492;
        Thu, 28 Jan 2021 06:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611813650;
        bh=teUHGyAjCjPfkBxZ3i0lEJwRQIyDMft5Td689zeTnzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+/FLBEnsy7zi/vb4OhUiq4SOtifApjlFwsxXY3tb0Qi5Kzui/CjiZsDSUPffQP8z
         nHv9wXtmRo7prHCPC/rnunZvGW0r9WuCMIr13YIYDT+ZvHCo6h1oHIgfIB8aQMXwvY
         ARG3t4c45hdCwcYtSxVqFeOC2Y0H9+1eBP8rhn6vxmysoDYe8lv9xtoo6rIzOf/Xz0
         c8Q2TLhtOG/mzUEfCJ4eehT+WNPEf5nj3Tv1LnSYty1J2+6ma5DqgiMs3IE34bBoyd
         Bw0nn55UPe6/LYjaoLCTdiVJs6YXI1aN3GccA2Cj1R0ucbnTZCdA4Of71/OJKhCZNd
         mZLXzyqyVO+8Q==
Date:   Thu, 28 Jan 2021 08:00:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v15 0/5] TPM 2.0 trusted key rework
Message-ID: <YBJTDfUCItiuzr08@kernel.org>
References: <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 27, 2021 at 11:06:12AM -0800, James Bottomley wrote:
> v15: fix 0day sign issue and add reviews and testeds
> 
> General cover letter minus policy bit:
> 
> This patch updates the trusted key code to export keys in the ASN.1
> format used by current TPM key tools (openssl_tpm2_engine and
> openconnect).  The current code will try to load keys containing
> policy, but being unable to formulate the policy commands necessary to
> load them, the unseal will always fail unless the policy is executed
> in user space and a pre-formed policy session passed in.
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
> 
> ---
> 
> James Bottomley (5):
>   lib: add ASN.1 encoder
>   oid_registry: Add TCG defined OIDS for TPM keys
>   security: keys: trusted: fix TPM2 authorizations
>   security: keys: trusted: use ASN.1 TPM2 key format for the blobs
>   security: keys: trusted: Make sealed key properly interoperable

AFAIK, bug fixes should merged before functional changes and migratable
flag has a regression:

https://marc.info/?l=linux-integrity&m=160255753405345

I'll send an update to this series.

/Jarkko

> 
>  .../security/keys/trusted-encrypted.rst       |  58 +++
>  include/keys/trusted-type.h                   |   2 +
>  include/linux/asn1_encoder.h                  |  32 ++
>  include/linux/oid_registry.h                  |   5 +
>  include/linux/tpm.h                           |   2 +
>  lib/Kconfig                                   |   3 +
>  lib/Makefile                                  |   1 +
>  lib/asn1_encoder.c                            | 454 ++++++++++++++++++
>  security/keys/Kconfig                         |   3 +
>  security/keys/trusted-keys/Makefile           |   4 +-
>  security/keys/trusted-keys/tpm2key.asn1       |  11 +
>  security/keys/trusted-keys/trusted_tpm1.c     |  34 +-
>  security/keys/trusted-keys/trusted_tpm2.c     | 269 ++++++++++-
>  13 files changed, 846 insertions(+), 32 deletions(-)
>  create mode 100644 include/linux/asn1_encoder.h
>  create mode 100644 lib/asn1_encoder.c
>  create mode 100644 security/keys/trusted-keys/tpm2key.asn1
> 
> -- 
> 2.26.2
> 
> 
