Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04024319CD2
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 11:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBLKrO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 05:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhBLKrO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 05:47:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3336764DD7;
        Fri, 12 Feb 2021 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613126793;
        bh=44LlrjvrvotmTizwD9FXjppFmR0WxmRfKrO4ALzDjfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=goRcNdHKhsO3sQA9lofdxkph3jOfEqPWXhiXzQ0zBhE1KbBPjzP+euownqMyrwWEE
         TzDjFTZAecjCOgMI1JZ6JXYRsTnOjPqcCU1Snf5ff/FsXsdimEDdOQPU7yOVyR/tmd
         9ETgLFq78Yl68VTjxbN6XmbWijYAALGxmnbXLrWyBdKjOHExJ1939BS79UWYpPD8Go
         m8BPe6fl+TDfY245kZLEHlSD5n9lQEGf2jsusPxMYhn6JKgsWpRm7rjMxyu4Yhq3v+
         lxw4zp24b2q90AM6f27NyKLvc6NciqjKNBpRwrLPRBdUrl0pnvIa1/FaBKblXt8F7m
         1mutUtgFEcA2w==
Date:   Fri, 12 Feb 2021 12:46:24 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Laurent Bigonville <bigon@debian.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org
Subject: Re: TPM returned invalid status
Message-ID: <YCZcgF6ofubvKsFB@kernel.org>
References: <ee9c30b0-aff6-b1bd-2830-84b55a53b95e@debian.org>
 <8581ad17cb536c807d8ce781e955de07643aa1f4.camel@HansenPartnership.com>
 <22b860c1-c494-7a4d-73f3-7c9e90ab1ae8@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22b860c1-c494-7a4d-73f3-7c9e90ab1ae8@debian.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 08, 2021 at 03:47:57PM +0100, Laurent Bigonville wrote:
> Le 8/02/21 à 04:33, James Bottomley a écrit :
> > On Sat, 2021-02-06 at 00:31 +0100, Laurent Bigonville wrote:
> > > Hello,
> > > 
> > > I already posted that beginning of January in reply to "tpm_tis:
> > > Clean
> > > up locality release", but I didn't really got a reply
> > > 
> > > With debian unstable (Linux fornost 5.10.0-3-amd64 #1 SMP Debian
> > > 5.10.12-1 (2021-01-30) x86_64 GNU/Linux), I get the following error:
> > Sorry, forgot to cc you.  We're iterating to this as the fix:
> > 
> > https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/
> > 
> > If you want to test it out.
> 
> I recompiled 5.11.0-rc7+ with the patch and I still get the same trace

Yeah, still pending the fix for probe.

The whole thread is here:

https://lore.kernel.org/linux-integrity/20210123014247.989368-1-lma@semihalf.com/

/Jarkko
