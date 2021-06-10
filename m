Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD353A27AA
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 11:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFJJFX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 05:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhFJJFX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 05:05:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB34360FD8;
        Thu, 10 Jun 2021 09:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623315807;
        bh=qGY0QZc6tRdG5jSPQ1whVRHSm4J+Iy/w7u4SlqbvRaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmGXI17K4+Ve2TeAZVAOf2YiXh4Yov1SyAtMZtCh/BP/ZGR/m8aSz1EvwAVNuyFBd
         coBHql1i/eDZVrv3cInf3A2mYkQ4NCz72OCZ/h9QBBEsqpWZpEwSRzGVJUx3ia+CUJ
         l0ne9Z9g0YfvkzWQgpBgqbh13WcENxO8hCqqoz9V8JvQ8zPzEal66SonDZxGz1tjcQ
         n1nIzIEwUKacfEftegcCioPXqPvGSE07lxPAujLSjZ9kQBy1KxMFd8vRCFLCDj6hdE
         Wlm1aZesClr9emvqe4gxV/+UvDpeDd+q0HnOxwvg9JpJbJIgWwMOyntO+FpxxOXMk4
         /9jaVkwK8Mh6g==
Date:   Thu, 10 Jun 2021 12:03:23 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Add support for ECDSA-signed kernel modules
Message-ID: <20210610090323.f7b47xqxbkwnm5cx@kernel.org>
References: <20210602143537.545132-1-stefanb@linux.ibm.com>
 <20210603064738.pwfq3n7erzmncdmw@kernel.org>
 <8b79651b-1fe4-48c0-3498-529344ac6243@linux.ibm.com>
 <20210609124412.engcrbo3fezuzyoq@kernel.org>
 <f22e7ae1-8779-e995-091c-8a899fd7fd76@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f22e7ae1-8779-e995-091c-8a899fd7fd76@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 09, 2021 at 09:58:29AM -0400, Stefan Berger wrote:
> 
> On 6/9/21 8:44 AM, Jarkko Sakkinen wrote:
> > On Thu, Jun 03, 2021 at 08:32:59AM -0400, Stefan Berger wrote:
> > > On 6/3/21 2:47 AM, Jarkko Sakkinen wrote:
> > > > > -- 
> > > > > 2.29.2
> > > > > 
> > > > > 
> > > > Please instead send a fix.
> > > We have a Fixes tag in 1/2, so we want this to propagate to older kernels
> > > and need the fix in 1/2 for that reason.
> > > 
> > >     Stefan
> > So please do an additional fix and send it.
> 
> 1/2 is supposed to propagate to older kernels and needs to change as posted
> here in v5 (assuming that this does indeed fix what the build bot was
> complaining about). 2/2 also changes. A fix on top of v4 would fix 2/2 but
> won't apply cleanly to 1/2 as cannot easily propagate to older kernels. Is
> that what we want? Why can you not remove v4 from your queue and replace it
> with v5?
> 
>    Stefan

What you can do is to send fix or fixes with appropriate fixes tags and
I can then squash them for appropriate patches. That's less work for me.

/Jarkko
