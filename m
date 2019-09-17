Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE6B4649
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2019 06:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfIQEXh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Sep 2019 00:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfIQEXh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Sep 2019 00:23:37 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2449B21670;
        Tue, 17 Sep 2019 04:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568694216;
        bh=n6FYeZsdtZqdYPBfiuj7zkiWZJbqq5vut9hKGoQNdiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRxiM1DvlUlUAkis4iWI5cYUQ+WzRB08OyX9VOH33zckqzx3rhKGGklpiUdrPgORN
         n2oKPG3gWmsgtVTkNTjvbCpzQ+YQkGxVRYbTr9qn3LhaycE6bbcs/toSxgh6ZHPnsF
         CPWQBQYozwOvFAaPKvvhAr3Yc5MGnPZuYewe9FxA=
Date:   Mon, 16 Sep 2019 21:23:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: Re: [PATCH 1/3] ima: keep the integrity state of open files up to
 date
Message-ID: <20190917042334.GA1436@sol.localdomain>
Mail-Followup-To: Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk,
        Konsta Karsisto <konsta.karsisto@gmail.com>
References: <20190902094540.12786-1-janne.karhunen@gmail.com>
 <20190909213938.GA105935@gmail.com>
 <CAE=NcraXOhGcPHh3cPxfaNjFXtPyDdSFa9hSrUSPfpFUmsxyMA@mail.gmail.com>
 <20190915202433.GC1704@sol.localdomain>
 <CAE=NcrbaJD4CaUvg1tmNSSKjkG-EizNM7GUaztA0=fiUCo03Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=NcrbaJD4CaUvg1tmNSSKjkG-EizNM7GUaztA0=fiUCo03Cg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 16, 2019 at 02:45:56PM +0300, Janne Karhunen wrote:
> On Sun, Sep 15, 2019 at 11:24 PM Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > > > This still doesn't make it crash-safe.  So why is it okay?
> > >
> > > If Android is the load, this makes it crash safe 99% of the time and
> > > that is considerably better than 0% of the time.
> > >
> >
> > Who will use it if it isn't 100% safe?
> 
> I suppose anyone using mutable data with IMA appraise should, unless
> they have a redundant power supply and a kernel that never crashes. In
> a way this is like asking if the ima-appraise should be there for
> mutable data at all. All this is doing is that it improves the crash
> recovery reliability without taking anything away.

Okay, so why would anyone use mutable data with IMA appraise if it corrupts your
files by design, both with and without this patchset?

> 
> Anyway, I think I'm getting along with my understanding of the page
> writeback slowly and the journal support will eventually be there at
> least as an add-on patch for those that want to use it and really need
> the last 0.n% reliability. Note that even without that patch you can
> build ima-appraise based systems that are 99.999% reliable just by

On what storage devices, workloads, and filesystems is this number for?

> having the patch we're discussing here. Without it you would be orders
> of magnitude worse off. All we are doing is that we give it a fairly
> good chance to recover instead of giving up without even trying.
> 
> That said, I'm not sure the 100% crash recovery is ever guaranteed in
> any Linux system. We just have to do what we can, no?
> 

Filesystems implement consistency mechanisms, e.g. journalling or copy-on-write,
to recover from crashes by design.  This patchset doesn't implement or use any
such mechanism, so it's not crash-safe.  It's not clear that it's even a step in
the right direction, as no patches have been proposed for a correct solution so
we can see what it actually involves.

- Eric
