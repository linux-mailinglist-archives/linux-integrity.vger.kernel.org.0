Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F070C31FEC3
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 19:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBSSZz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 13:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhBSSZx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 13:25:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D7AC64DA8;
        Fri, 19 Feb 2021 18:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613759113;
        bh=3SOsL63I1e4HLF82yT5C2pj5BfH4Zygn+ix2rcnwZWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGtuOuvbBjfWA+3K1ByolXIL9TmcuAVl4Iw3OKYhvRnHYZ+Bx3zV+MnF0VD2FrkcK
         mnfkNMMWEVf7eer8x0GjQXHZqLnh2DbCYXULREdnEfwQZIXLvfJFZWxovOYngkXwbc
         6Y+a0KzsuJFrJjmeqYGq5a1HHJd8xGtRfWMWrJnrkO1s2HLxRazSUEPVOMp40hIOjM
         /ygNVL2PLcIyGj2AW7zVjZfTMM5LwiRO70m6yAUPB+/GW2aG9bPj/y4/reQB/V6k1N
         4MaKpX0DtmKwP5y/CZqPfQGX7/mYlEzXlos2NRh3yOZgZl+HTuD5n2r/LN/6X1EnvV
         JTw3ixqyZwEBg==
Date:   Fri, 19 Feb 2021 20:24:58 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v15 0/5] TPM 2.0 trusted key rework
Message-ID: <YDACehLCy4f2sDzo@kernel.org>
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

This is online again in the master branch. 

I've mangled the commits as follows:

1. Fixed my emails to jarkko@kernel.org.
2. Adjusted the Makefile, i.e. separate lines for each entry.
3. Fixed the checkpatch issues.

I guess we could potentially re-consider this to rc2 pull? With all the
mangling required, did not make sense to include this to the first pull.

/Jarkko
