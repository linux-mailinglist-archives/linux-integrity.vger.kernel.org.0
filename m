Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB7444430
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Nov 2021 16:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhKCPFv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Nov 2021 11:05:51 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41124 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhKCPFu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Nov 2021 11:05:50 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 30A7C72C8B8;
        Wed,  3 Nov 2021 18:03:11 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 11DDA4A46EC;
        Wed,  3 Nov 2021 18:03:11 +0300 (MSK)
Date:   Wed, 3 Nov 2021 18:03:10 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH ima-evm-utils] travis: use alt:sisyphus from docker.io
Message-ID: <20211103150310.6wzmbk4kfvuxe6qe@altlinux.org>
References: <20211102231742.191215-1-zohar@linux.ibm.com>
 <20211102232354.a7y64ogsjs23beja@altlinux.org>
 <50ed73cbfd1def4ee94b810f6194a633bbdebb31.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50ed73cbfd1def4ee94b810f6194a633bbdebb31.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Nov 02, 2021 at 08:32:30PM -0400, Mimi Zohar wrote:
> On Wed, 2021-11-03 at 02:23 +0300, Vitaly Chikunov wrote:
> > On Tue, Nov 02, 2021 at 07:17:42PM -0400, Mimi Zohar wrote:
> > > Instead of returning an image, it prompts for a response.  Hardcode
> > > to use docker.io.
> > > 
> > >  Please select an image:
> > >   ▸ docker.io/library/alt:sisyphus
> > >     quay.io/alt:sisyphus
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  .travis.yml | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/.travis.yml b/.travis.yml
> > > index 42853e16bfee..3836befe0bae 100644
> > > --- a/.travis.yml
> > > +++ b/.travis.yml
> > > @@ -68,7 +68,7 @@ matrix:
> > >            compiler: gcc
> > >  
> > >          - os: linux
> > > -          env: DISTRO=alt:sisyphus TSS=libtpm2-tss-devel CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
> > > +          env: REPO="docker.io/library" DISTRO=${REPO}/alt:sisyphus TSS=libtpm2-tss-devel CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
> > 
> > I wonder why podman is used in this case.
> 
> We were seeing issues on Alpine, Fedora, and Alt. Changing to podman
> fixed them.  For example on Alt, we started seeing the following, but
> openssl-gost was installed. [1] 
> 
> + control openssl-gost
> control: No such facility: openssl-gost 

Now I realize that podman is used to workaround incorrect seccomp
filtering of faccessat2 syscall in old Docker (with EPERM instead of
ENOSYS). This problem is still not fixed in bionic Travis instances,
causing "control: No such facility" errors.

Thanks,

> 
> I've reverted the commit, but I don't have access to the public travis.
> I've asked Stefan to trigger travis and am waiting for the results.
> 
> Mimi
> 
> [1] 
> https://app.travis-ci.com/github/stefanberger/ima-evm-utils/jobs/545999661
