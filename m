Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6CD309478
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 11:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhA3KZ2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 05:25:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232199AbhA3KZ0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 05:25:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0488964E05;
        Sat, 30 Jan 2021 10:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612002285;
        bh=JnBJ9yEVn7P1tBZKCOw6J2eaiEK2+XU3s7XI7eKmziI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVQ6JqkYHMUPHoFe/qjI3k5FhKYLINAdkkZru1LeotSaLIitfKzlBcCYlcbSe3u03
         jUnGlWulA31u9bfPAwef9yCP8w6sEJg+vdpTfibNqYG6c4Y1t3uQsni/Dqt8XFcn4h
         Dp5Q+4ub3EDyBo/ReZArE3N6q7ejXCdHxOT36anGLM/jAQ/gluLR88BbGqua8NxAgR
         6iGdWCGljP3YaKFBlnQkg6c+VcoPGsJOH/OQo4tSBRajxAgbIc7DNX7d62crk2Qrq5
         +ObWQZLLPtiZzJAa/6CaqUly0AehC+ti4B070xMhezW7pQV3nHMI1A6Iax/09AjFmO
         Mfo6jR9t++dMA==
Date:   Sat, 30 Jan 2021 12:24:40 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jmorris@namei.org, serge@hallyn.com,
        nayna@linux.ibm.com, erichte@linux.ibm.com, mpe@ellerman.id.au,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v4] certs: Add EFI_CERT_X509_GUID support for dbx entries
Message-ID: <YBUz6Cbx/ckG8Zjj@kernel.org>
References: <2442460.1610463459@warthog.procyon.org.uk>
 <X/9a8naM8p4tT5sO@linux.intel.com>
 <A05E3573-B1AF-474B-94A5-779E69E5880A@oracle.com>
 <YAFdNiYZSWpB9vOw@kernel.org>
 <CFBF6AEC-2832-44F7-9D7F-F20489498C33@oracle.com>
 <YAgTawk3EENF/P6j@kernel.org>
 <D9F5E0BD-E2FC-428F-91B3-35D2750493A0@oracle.com>
 <3063834.1611747971@warthog.procyon.org.uk>
 <61a0420790250807837b5a701bb52f3d63ff0c84.camel@linux.ibm.com>
 <86CE3924-E36F-44FD-A259-3CC7E69D3EAC@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86CE3924-E36F-44FD-A259-3CC7E69D3EAC@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 27, 2021 at 08:41:29AM -0700, Eric Snowberg wrote:
> 
> > On Jan 27, 2021, at 7:03 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > [Cc'ing linux-integrity]
> > 
> > On Wed, 2021-01-27 at 11:46 +0000, David Howells wrote:
> >> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >> 
> >>>> I suppose a user space tool could be created. But wouldn’t what is
> >>>> currently done in the kernel in this area need to be removed?
> >>> 
> >>> Right. I don't think this was a great idea in the first place to
> >>> do to the kernel but since it exists, I guess the patch does make
> >>> sense.
> >> 
> >> This information needs to be loaded from the UEFI tables before the system
> >> starts loading any kernel modules or running any programs (if we do
> >> verification of such, which I think IMA can do).
> > 
> > There needs to a clear distinction between the pre-boot and post-boot
> > keys.  UEFI has its own trust model, which should be limited to UEFI. 
> > The .platform keyring was upstreamed and limited to verifying the kexec
> > kernel image.   Any other usage of the .platform keyring keys is
> > abusing its intended purpose.
> > 
> > The cover letter says,   "Anytime the .platform keyring is used, the
> > keys in the .blacklist keyring are referenced, if a matching key is
> > found, the key will be rejected."   I don't have a problem with loading
> > the UEFI X509 dbx entries as long as its usage is limited to verifying
> > the kexec kernel image.
> 
> Correct, with my patch, when EFI_CERT_X509_GUID entries are found in the
> dbx, they will only be used during kexec.  I believe the latest dbx file on 
> uefi.org contains three of these entires.
> 
> Based on my understanding of why the platform keyring was introduced, 
> I intentionally only used these for kexec.  I do question the current 
> upstream mainline code though.  Currently, when EFI_CERT_X509_SHA256_GUID
> or EFI_CERT_SHA256_GUID entries are found in the dbx, they are applied 
> everywhere.  It seems like there should be a dbx revocation keyring 
> equivalent to the current platform keyring that is only used for pre-boot. 
> 
> If that is a direction you would like to see this go in the future, let
> me know, I’d be happy to work on it.

I would tend to agree with this.

/Jarkko
