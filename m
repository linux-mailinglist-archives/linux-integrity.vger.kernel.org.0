Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1D461811
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 15:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbhK2O2B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 09:28:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33926 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhK2O0A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 09:26:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE6A961536
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 14:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E9BC004E1;
        Mon, 29 Nov 2021 14:22:38 +0000 (UTC)
Date:   Mon, 29 Nov 2021 15:22:35 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
Message-ID: <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
 <20211129045834.GB20606@mail.hallyn.com>
 <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
 <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
 <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 29, 2021 at 09:10:29AM -0500, James Bottomley wrote:
> On Mon, 2021-11-29 at 08:53 -0500, Stefan Berger wrote:
> > On 11/29/21 07:50, James Bottomley wrote:
> > > On Sun, 2021-11-28 at 22:58 -0600, Serge E. Hallyn wrote:
> > > > On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley wrote:
> > > > > Currently we get one entry in the IMA log per unique file
> > > > > event.  So, if you have a measurement policy and it measures a
> > > > > particular binary it will not get measured again if it is
> > > > > subsequently executed. For Namespaced IMA, the correct
> > > > > behaviour
> > > > > seems to be to log once per inode per namespace (so every
> > > > > unique
> > > > > execution in a namespace gets a separate log entry).  Since
> > > > > logging
> > > > > once per inode per namespace is
> > > > I suspect I'll need to do a more in depth reading of the existing
> > > > code, but I'll ask the lazy question anyway (since you say "the
> > > > correct behavior seems to be") - is it actually important that
> > > > files which were appraised under a parent namespace's policy
> > > > already
> > > > should be logged again?
> > > I think so.  For a couple of reasons, assuming the namespace
> > > eventually
> > > gets its own log entries, which the next incremental patch proposed
> > > to
> > > do by virtualizing the securityfs entries.  If you don't do this:
> > 
> > To avoid duplicate efforts, an implementation of a virtualized 
> > securityfs is in this series here:
> > 
> > https://github.com/stefanberger/linux-ima-namespaces/commits/v5.15%2Bimans.20211119.v3
> > 
> > It starts with 'securityfs: Prefix global variables with secruityfs_'
> 
> That's quite a big patch series.  I already actually implemented this
> as part of the RFC for getting the per namespace measurement log.  The
> attached is basically what I did.
> 
> Most of the time we don't require namespacing the actual virtualfs
> file, because it's world readable.  IMA has a special requirement in
> this regard because the IMA files should be readable (and writeable
> when we get around to policy updates) by the admin of the namespace but
> their protection is 0640 or 0440.  I thought the simplest solution
> would be to make an additional flag that coped with the permissions and
> a per-inode flag way of making the file as "accessible by userns
> admin".  Doing something simple like this gives a much smaller
> diffstat:

That's a NAK from me. Stefan's series might be bigger but it does things
correctly. I appreciate the keep it simple attitude but no. I won't
speciale-case securityfs or similar stuff in core vfs helpers.

Christian
