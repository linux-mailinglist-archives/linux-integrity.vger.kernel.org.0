Return-Path: <linux-integrity+bounces-7070-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA7CB56AB5
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Sep 2025 19:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9620B189CAA8
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Sep 2025 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5632275B12;
	Sun, 14 Sep 2025 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEoij5ZZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53919C560
	for <linux-integrity@vger.kernel.org>; Sun, 14 Sep 2025 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757869391; cv=none; b=bjsQGIppqDxVYvGYqO+fLSmw/o/lbm2v7m+S4Z60NQC4GkfD1rNZAkC3+AfIjCsu1Iv1efwoWcZqfyd8cSgxCeOh331ODueBaUE2WU0IzWBmBRvH/zdrYILVt5+w4iu5K0z502ToIMXLFCCIN2HBCuKZfED9k8g8Nsijb1XqQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757869391; c=relaxed/simple;
	bh=s+pgR2tUCOJYYjYVkJV1xL91HfmseE42bgTl3RdZ+qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1R0OsxvRTpeCMOAlmLs41WQEObWjR+IecZwv/DayUE5dDKIrdwGj7WoNztUmUsiYsBSZxM8jgDx0CAzaizkUeNP1Y/lCBke/1qkdo31M5rBp9X3syxH7tfCB5PtlPxuRr/TEYxHDqe1xOW0B2B8BJptcjRAtmJlnB+MwlRMxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEoij5ZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5FCC4CEF0;
	Sun, 14 Sep 2025 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757869391;
	bh=s+pgR2tUCOJYYjYVkJV1xL91HfmseE42bgTl3RdZ+qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEoij5ZZSd62GDZE/gzLhHD/aP/FdMS7bokWSbWwCMO6uNyw4fCWgzz6DARymc0IQ
	 V9V0xY/4paO17VOsdp4cPbgFzV3vtDqBrH/2fl+PlB87oEYfKuYGxf/g5KosQeFpuZ
	 2W87j7MlsQgRpNpVL7G81IW3QVqP9RJ1PTPdlJGIC68SRBqVz4L0uoD4u76rwxkGPU
	 qQZ08D2CaoIZ6hnvgmxxa268SzEP64I8gPyuJXQA+7cIOLImqG3myDO5oAU2j5hz0x
	 MCI2Kh+JJ+Hf8XGLsFweAnRTrIzin6mLIM25PwWn/4DfzoPWwgLq4zXFiDDt6/UAT+
	 S7jTTluvl5VTA==
Date: Sun, 14 Sep 2025 20:03:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v4] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aMb1S-FtrB9wUzM0@kernel.org>
References: <20250902142429.14041-2-daleksan@redhat.com>
 <aLcl2SzTc_nTX56u@kernel.org>
 <CAG+gbFeYuxVbo+RY9Ux-zysO76Q9yiD5DfD4e4cwNxX-VgfKWQ@mail.gmail.com>
 <aMGwoYlvBSPLpp3z@kernel.org>
 <CAG+gbFfed3fFZYnLHNMFGWaO-pEM2RTUJktZ0AuQLSC_zY1g5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG+gbFfed3fFZYnLHNMFGWaO-pEM2RTUJktZ0AuQLSC_zY1g5Q@mail.gmail.com>

On Wed, Sep 10, 2025 at 01:28:19PM -0400, Denis Aleksandrov wrote:
> On Wed, Sep 10, 2025 at 1:09 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Tue, Sep 02, 2025 at 03:12:45PM -0400, Denis Aleksandrov wrote:
> > > Great, thank you Jarkko!
> > >
> > > Could you please take a look at the most recent reply from Paul in the
> > > v2 thread for this patch?
> > > Should I move forward with the advised changes and send a v5?
> >
> > Mind passing me the lore link? At least quick search could not find
> > (sorry).
> >
> 
> Here is the link:
> https://lore.kernel.org/linux-integrity/20250827022102.17731-1-daleksan@redhat.com/t/#u
> My apologies for not including it earlier.

Here's what I have in my tree right now:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=18aada46edf7f79dba1ab89a100d0fc350d4a5c8

Let's take this is in simpler terms: is there something wrong in the
commit?

BR, Jarkko

