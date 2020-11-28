Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29E82C7681
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Nov 2020 23:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbgK1Wzd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 28 Nov 2020 17:55:33 -0500
Received: from mail.hallyn.com ([178.63.66.53]:60772 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgK1Wzd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 28 Nov 2020 17:55:33 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 65BD38AB; Sat, 28 Nov 2020 16:54:50 -0600 (CST)
Date:   Sat, 28 Nov 2020 16:54:50 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org, fstests@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH v3 00/38] idmapped mounts
Message-ID: <20201128225450.GC22812@mail.hallyn.com>
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Nov 28, 2020 at 10:34:49PM +0100, Christian Brauner wrote:
> Hey everyone,

Hey Christian,

a general request.  Argue with me if it seems misguided.

When looking at a patch or a small hunk of code, these days, if a variable
called 'ns' or 'user_ns' is seen passed to a function, it can be easy to
assume which user_ns it is based on what you think would make sense, but if
your assumption is wrong, your patch review will be wrong.

Can we stick to a convention where we have maybe

subj_userns - the userns of the task seeking some action
obj_userns - the userns of the thing being acted on - task, superblock,...
mnt_userns - the userns of a mountpoint through which an object is seen

You're replacing a lot of such callers and callsites in this patchset, so
this would be a great time to start doing that.

-serge
