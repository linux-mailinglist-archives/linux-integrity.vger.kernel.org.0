Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CE52A3AE0
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 04:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgKCDLe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Nov 2020 22:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgKCDLd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Nov 2020 22:11:33 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D72C061A47
        for <linux-integrity@vger.kernel.org>; Mon,  2 Nov 2020 19:11:33 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p5so22118922ejj.2
        for <linux-integrity@vger.kernel.org>; Mon, 02 Nov 2020 19:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCNp5uuCotCMVQFPmFQkl/qugp5FXzzai3j5BPPHGqk=;
        b=uXdqhUkwc6vJl5oSsp9M9v55Y0oVU7Z+urxwdLpZIfp5raj2vtZ4Gl4YofA+4/Dcg7
         1Ssiy9WmKy2/khawAjHvRLeihftKOb2MVympxzoHp6777XVNzMA5t6DaSLk59hn98vOX
         KgN9lGNzQXJwMvXEiGecRNP4VT+BIG5XwaDNvvQcaK3zFu6ljHxx5jkOcp4lQ8AOAvZi
         kQgmNV40EPyzSOO7+xWurBf691zrs0eK/B1rJD5xwwVx1f/pwQv+uLaU49kzauJ96oxC
         veEzukdM+QC3GvygLEMSAOmA7lTHr2c9i9y1XzXU5XhKgrfhCFFX2DPE2G4avI+fufdG
         inOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCNp5uuCotCMVQFPmFQkl/qugp5FXzzai3j5BPPHGqk=;
        b=k50pRR71Q/v46zJV90ubHkwXB+7TraupZumYKjj6+exCy/HWNSc1JtioFRic/76xs+
         T+jpQsnqb76rrqYjNEvV8RO/iIhVxW3To7N55tj7nXw8QxE/ZZWC6+lMumERBdtdNJWX
         UakfDd6ZJ7bBtKlB9/QAGXVQVLiyml+wYnjaL7PhPJMwlGWW1YPoy5ZN9romJ1AfCZnl
         BmaeH4oyP5Z6e3pmvm+W70TBVnc6Oh3WJDWKjl6RGHFf0hZYy89quuHcO1cZBPKdil2d
         GhwnJYE1f0BesiYInETHC/ILeyZPiR+/4qvTEJw30Hq9I2VZjZgC0Is7LwLqBgk9y6bT
         3ppw==
X-Gm-Message-State: AOAM5319nFdUgDbKIV8roAJw7ctN9zz5C/O14VfNtwOsQd0NUoWKCtCd
        hLFBj6ZJAMFxtzr/2nMfY28cQH8S/edm3IvGr6BBntEruQ==
X-Google-Smtp-Source: ABdhPJyJiRoGvU6qVRGAo6lFX2GXqnIjtisl1RWvwxejNfHaVph8xZTc7VB+Gt+3oyMVHt/DmhvE2q9M/D85a7BDMps=
X-Received: by 2002:a17:906:cb0f:: with SMTP id lk15mr9735825ejb.431.1604373091593;
 Mon, 02 Nov 2020 19:11:31 -0800 (PST)
MIME-Version: 1.0
References: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
 <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com>
 <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
 <CAHC9VhR8mbqZS3TVgG7MxQywe9uqDRCN+c59PozLTpOoQ-mK7Q@mail.gmail.com> <9195fd7a-a5c5-8588-d33c-772d2f530032@linux.microsoft.com>
In-Reply-To: <9195fd7a-a5c5-8588-d33c-772d2f530032@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Nov 2020 22:11:20 -0500
Message-ID: <CAHC9VhT36qSJvhH5CFwixdT8tzH2bqfvaDa6nPZt1rmOKOr_kQ@mail.gmail.com>
Subject: Re: [RFC] Finding the right target branch for patches that span IMA
 and SeLinux
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Oct 31, 2020 at 11:08 PM Tushar Sugandhi
<tusharsu@linux.microsoft.com> wrote:
> On 2020-10-30 1:37 p.m., Paul Moore wrote:

...

> > If the patch(set) introduces new functionality I will ask you to add
> > or update an existing test in the selinux-testsuite.
> > * https://github.com/SELinuxProject/selinux-testsuite
>
> Lakshmi has written an SeLinux test for this feature, and it is
> currently being targeted for LTP repo.
> https://github.com/linux-test-project/ltp
>
> We can work with you to also get it incorporated in selinux-testsuite.
> But the concern here is we may have to pull additional dependent scripts
> from LTP to selinux-testsuite to support our test.
>
> Could you please take a look at Lakshmi's SeLinux test, and guide us
> further on this? Here is the patch.
> https://patchwork.kernel.org/patch/11804587/

As I'm looking at the test(s) above, I'm thinking that this may not be
something that needs to be in the selinux-testsuite.  While SELinux is
obviously an important part of the test, the test is more IMA focused
(which is probably the way it should be).

As a bit of background, the selinux-testsuite is intended to serve as
a relatively easy and quick to run test that can be used by developers
to quickly test their patches; while it aims for good coverage, it
does not try to be a comprehensive regression test suite.  Not only
would that be duplicating other efforts such as the LTP, it would go
against the goal of making the test suite quick and easy to use.

> > If the patch(set) introduces new, or changed, functionality I may ask
> > you to update The SELinux Notebook.
> > * https://github.com/SELinuxProject/selinux-notebook
>
> Will do. Thanks.
>
> > Beyond the above, the general SELinux kernel tree process is
> > documented in the README.md found in selinux/main:
> > * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/tree/README.md
> >
> Thanks for the pointer.
> We'll go through the documentation.

Can you and Lakshmi help me better understand the state of the
SELinux/IMA patches?  I see that you included Lakshmi's SELinux/IMA
patch in your last patchset, and it appears to have included feedback
from Stephen's last review.  Is it your intent to continue to submit
the SELinux/IMA patch as part of a larger patchset, or do you plan to
split that back out into a standalone patch?

-- 
paul moore
www.paul-moore.com
