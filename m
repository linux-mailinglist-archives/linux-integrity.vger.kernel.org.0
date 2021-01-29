Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0893630909B
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 00:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhA2X2J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Jan 2021 18:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhA2X2H (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 18:28:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C0D564DDB;
        Fri, 29 Jan 2021 23:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611962846;
        bh=nRY2roERXFxon206XTayNLdW3D0tWgBoL27kAm2mJ38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sObX8n19jS4j1u0y1AoPSVGaWBIc3KYPHKTq3lUMz/O9E0eQb/l6Fzw3cBi9ZSMLP
         s0R19sYoGde/nkB5AzKCWtpWoIebqObVKtDG6qD7cLIEA1WIdWFp+Xze8jdn+IOnRr
         eZU/FGbRRjELdFfNuKq5yms5WWvaAfC1lm0aVjVadLMuyP/dOBR8iI5MlcF6+KcVYh
         MEtTCQloA0foZnXbE0xh5+Yp5f+YHjm8tqzn1tGyw+sLKzgsJnouXrFxTRStCOxJpp
         V/lgAkI1HJSRIVoUNPbp1oGrFqA5dVFWp/SmqyayLBAcKW227ub/8Ka13THoAZJQhU
         xvvsEEbBh2Xig==
Date:   Sat, 30 Jan 2021 01:27:21 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jmorris@namei.org, serge@hallyn.com,
        nayna@linux.ibm.com, erichte@linux.ibm.com, mpe@ellerman.id.au,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v4] certs: Add EFI_CERT_X509_GUID support for dbx entries
Message-ID: <YBSZ2bfYsUo2Y28i@kernel.org>
References: <1360578.1607593748@warthog.procyon.org.uk>
 <2442460.1610463459@warthog.procyon.org.uk>
 <X/9a8naM8p4tT5sO@linux.intel.com>
 <A05E3573-B1AF-474B-94A5-779E69E5880A@oracle.com>
 <YAFdNiYZSWpB9vOw@kernel.org>
 <CFBF6AEC-2832-44F7-9D7F-F20489498C33@oracle.com>
 <YAgTawk3EENF/P6j@kernel.org>
 <D9F5E0BD-E2FC-428F-91B3-35D2750493A0@oracle.com>
 <3063834.1611747971@warthog.procyon.org.uk>
 <61a0420790250807837b5a701bb52f3d63ff0c84.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61a0420790250807837b5a701bb52f3d63ff0c84.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 27, 2021 at 09:03:59AM -0500, Mimi Zohar wrote:
> [Cc'ing linux-integrity]
> 
> On Wed, 2021-01-27 at 11:46 +0000, David Howells wrote:
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > > > I suppose a user space tool could be created. But wouldn’t what is
> > > > currently done in the kernel in this area need to be removed?
> > > 
> > > Right. I don't think this was a great idea in the first place to
> > > do to the kernel but since it exists, I guess the patch does make
> > > sense.
> > 
> > This information needs to be loaded from the UEFI tables before the system
> > starts loading any kernel modules or running any programs (if we do
> > verification of such, which I think IMA can do).
> 
> There needs to a clear distinction between the pre-boot and post-boot
> keys.  UEFI has its own trust model, which should be limited to UEFI. 
> The .platform keyring was upstreamed and limited to verifying the kexec
> kernel image.   Any other usage of the .platform keyring keys is
> abusing its intended purpose.
> 
> The cover letter says,   "Anytime the .platform keyring is used, the
> keys in the .blacklist keyring are referenced, if a matching key is
> found, the key will be rejected."   I don't have a problem with loading
> the UEFI X509 dbx entries as long as its usage is limited to verifying
> the kexec kernel image.
> 
> Mimi

Thanks Mimi, this is a valid argument. I agree.

/Jarkko
