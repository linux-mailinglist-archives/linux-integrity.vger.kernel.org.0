Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5484C461F9B
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 19:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbhK2Sxw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 13:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379539AbhK2Svv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 13:51:51 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323D5C043CEF
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 07:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638198489;
        bh=C7rlmjvCJkDvUMEnxSS8/T7w+qb/IyjvaJpJfh4row4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=LmsgiC+1bRPS5m2wQ5DPIZGE/qUnXc6egz9a9XZT+zR3Bsn+/sFu9szQBXFlPu7A5
         51tb/QegwvJqnXhjoR3TngCK0uJnqf5GwA3OzmjgRmAsu952Npuwme8UKblPYtesPT
         pGk+3IXHZvaxiGzzvceW4/7Hp7mj4C6Qq1ZqXoN8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C63D91280970;
        Mon, 29 Nov 2021 10:08:09 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zMuDmpdvlhYg; Mon, 29 Nov 2021 10:08:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638198489;
        bh=C7rlmjvCJkDvUMEnxSS8/T7w+qb/IyjvaJpJfh4row4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=LmsgiC+1bRPS5m2wQ5DPIZGE/qUnXc6egz9a9XZT+zR3Bsn+/sFu9szQBXFlPu7A5
         51tb/QegwvJqnXhjoR3TngCK0uJnqf5GwA3OzmjgRmAsu952Npuwme8UKblPYtesPT
         pGk+3IXHZvaxiGzzvceW4/7Hp7mj4C6Qq1ZqXoN8=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 88357128096D;
        Mon, 29 Nov 2021 10:08:08 -0500 (EST)
Message-ID: <c4c975b8d382136d76db9a9ff9b6b182afd2487d.camel@HansenPartnership.com>
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, containers@lists.linux.dev,
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
Date:   Mon, 29 Nov 2021 10:08:06 -0500
In-Reply-To: <1402f334-8072-48d1-b30b-2c2cdd4869dd@linux.ibm.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
         <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
         <20211129045834.GB20606@mail.hallyn.com>
         <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
         <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
         <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
         <1402f334-8072-48d1-b30b-2c2cdd4869dd@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-11-29 at 09:30 -0500, Stefan Berger wrote:
> On 11/29/21 09:10, James Bottomley wrote:
> > On Mon, 2021-11-29 at 08:53 -0500, Stefan Berger wrote:
> > > On 11/29/21 07:50, James Bottomley wrote:
> > > > On Sun, 2021-11-28 at 22:58 -0600, Serge E. Hallyn wrote:
> > > > > On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley
> > > > > wrote:
> > > > > > Currently we get one entry in the IMA log per unique file
> > > > > > event.  So, if you have a measurement policy and it
> > > > > > measures a particular binary it will not get measured again
> > > > > > if it is subsequently executed. For Namespaced IMA, the
> > > > > > correct behaviour seems to be to log once per inode per
> > > > > > namespace (so every unique execution in a namespace gets a
> > > > > > separate log entry).  Since logging once per inode per
> > > > > > namespace is
> > > > > I suspect I'll need to do a more in depth reading of the
> > > > > existing code, but I'll ask the lazy question anyway (since
> > > > > you say "the correct behavior seems to be") - is it actually
> > > > > important that files which were appraised under a parent
> > > > > namespace's policy already should be logged again?
> > > > I think so.  For a couple of reasons, assuming the namespace
> > > > eventually gets its own log entries, which the next incremental
> > > > patch proposed to do by virtualizing the securityfs
> > > > entries.  If you don't do this:
> > > To avoid duplicate efforts, an implementation of a virtualized
> > > securityfs is in this series here:
> > > 
> > > https://github.com/stefanberger/linux-ima-namespaces/commits/v5.15%2Bimans.20211119.v3
> > > 
> > > It starts with 'securityfs: Prefix global variables with
> > > secruityfs_' 

> > That's quite a big patch series.  I already actually implemented
> > this as part of the RFC for getting the per namespace measurement
> > log.  The attached is basically what I did.
> 
> I know it's big. I tried to avoid having to bind-mount the system-
> wide single securityfs into the container and inherit all the other
> security subsystems' files and directories (evm, TPM, safesetid,
> apparmor, tomoyo  [ 
> https://elixir.bootlin.com/linux/latest/C/ident/securityfs_create_dir
>  
> ]) and instead have a  'view' that is a bit more restricted to those 
> subsystems that are namespaced. The securityfs_ns I created can be 
> mounted into each user namespace individually and only shows what
> you're supposed to see without other filesystem tricks to hide files
> or so. It should be future-extensible for other subsystem to register
> themselves there if they have something to show to the user.

Using F_USER_NS for this is certainly what it was designed for.  I
don't think size is a problem as long as it's right sized to perform
the required function.  I usually find it easier to oversimplify and
work up, but that's certainly not the only approach.

James


