Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709F238D7AF
	for <lists+linux-integrity@lfdr.de>; Sun, 23 May 2021 00:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhEVWqc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 22 May 2021 18:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhEVWqb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 22 May 2021 18:46:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C22C61205;
        Sat, 22 May 2021 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621723506;
        bh=imGF+WkXvcRwpXlQp31iSlqfUP5grxM50aEF9bcM9uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtqhEl4hAB20vhGv/9LehV+/cJjGF3aizEYqUqYp+6SF7+jiPdeho7JkQvYT3GrtR
         TykE5m2LQsGdwh6imlf66+ydmG7twdTUFqyXFkPzCItA0wPAtkZyzhmcUkL1Vz4XPd
         SQV74X3eSd0tpy1jtgPi3rseQcyqIID46XLvxPUaNL67Zo9Mluet8ug0CVXmpEPofA
         WNCwZXTEb/659zYxY+o+bWtJ0TyIDloWamAENaMLALiSWlMVT9uqdvFc3wB7lixmtT
         j2pmWfCtq/HqfeccnECdOnt1EQskUJIClI+k8D4vlaq6DlEqMyA83wEycE2+LQvC3l
         hgppF2Pbka5QQ==
Date:   Sun, 23 May 2021 01:45:04 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/4] Trusted Key policy for TPM 2.0
Message-ID: <YKmJcJWHZj7sLidd@kernel.org>
References: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
 <49bf69d011373f339a21bb61183b135babb6edc8.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bf69d011373f339a21bb61183b135babb6edc8.camel@infradead.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 21, 2021 at 02:48:55PM +0100, David Woodhouse wrote:
> On Thu, 2021-05-20 at 17:43 -0700, James Bottomley wrote:
> > Now that the ASN.1 representation of trusted keys is upstream we can
> > add policy to the keys as a sequence of policy statements meaning the
> > kernel can now construct and use the policy session rather than the
> > user having to do it and pass the session down to the kernel.  This
> > makes TPM 2.0 keys with policy much easier.
> > 
> > The format of the policy statements is compatible with the
> > openssl_tpm2_engine policy implementation:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/
> > 
> > And the seal_tpm2_data command in the above can be used to create
> > sealed keys (including with policy statements) for the kernel.
> 
> I'd love to see that format properly defined and documented instead of
> just a reference to another implementation.

A valid point. How can we know that this is good for "everyone"?

Also, one major thing that this patch set is kselftest's. It's too
obnoxious to copy-paste examples from commit messages, and also
does not really create a good platform to discuss any possible
issues that these patches might have.

/Jarkko
