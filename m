Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E66493ACF
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jan 2022 14:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354523AbiASNEB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jan 2022 08:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354077AbiASNEA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jan 2022 08:04:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6113C061574;
        Wed, 19 Jan 2022 05:04:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4836161472;
        Wed, 19 Jan 2022 13:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FDAC004E1;
        Wed, 19 Jan 2022 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642597439;
        bh=Lonhk8FqgowFMZcLwH8PUOtrhO/x4T7psKE6RNUkLVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4/CIqSeBQ0KxYtXJAGP6wLuBNozhE5tihrZmI6FE0x6wu9xulmTXiPeiUSXAnIkg
         mGxWQ6IbmGA49mh18dK6nlv7y8YZ/s9IrPRaVs6EQUDfiTJOLFWc9KCT9YDhdFtxsq
         aS5FTi+D/ZN7H/CqO7qhEH+a5Iwo4lAtQAArl2j5gZIwPVeWfa29AsoQ8DUiVKITyQ
         /nPPzAhwpVonHAsZLIwSMugnapOkE5JFw/rXO4CwY14lCZyfk5x5jXnTFxywcMU5z9
         Ano8FwSoDsp95xFClhT07NB9zDpX7MtZkXfjoQS8St94HTv1Nka3zTWdvdg0hOt7U0
         Z7eyXyJJkKYyA==
Date:   Wed, 19 Jan 2022 14:03:52 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v8 19/19] ima: Enable IMA namespaces
Message-ID: <20220119130352.wwpkieyjxzdku5mq@wittgenstein>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-20-stefanb@linux.vnet.ibm.com>
 <20220114144515.vbler7ae3jqebhec@wittgenstein>
 <8f7e0bcc-cd7c-723d-c544-300b5e8f3873@linux.ibm.com>
 <20220119094613.cxxxmz5qbuehd7c3@wittgenstein>
 <e3604476-5255-109e-994f-01e09b5340c0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3604476-5255-109e-994f-01e09b5340c0@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 19, 2022 at 07:45:22AM -0500, Stefan Berger wrote:
> 
> On 1/19/22 04:46, Christian Brauner wrote:
> > On Tue, Jan 18, 2022 at 01:09:12PM -0500, Stefan Berger wrote:
> > > On 1/14/22 09:45, Christian Brauner wrote:
> > > > On Tue, Jan 04, 2022 at 12:04:16PM -0500, Stefan Berger wrote:
> > > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > > 
> > > > > Introduce the IMA_NS in Kconfig for IMA namespace enablement.
> > > > > 
> > > > > Enable the lazy initialization of an IMA namespace when a user mounts
> > > > > SecurityFS. Now a user_namespace will get a pointer to an ima_namespace
> > > > > and therefore add an implementation of get_current_ns() that returns this
> > > > > pointer.
> > > > > 
> > > > > get_current_ns() may now return a NULL pointer for as long as the IMA
> > > > > namespace hasn't been created, yet. Therefore, return early from those
> > > > > functions that may now get a NULL pointer from this call. The NULL
> > > > > pointer can typically be treated similar to not having an IMA policy set
> > > > > and simply return early from a function.
> > > > > 
> > > > > Implement ima_ns_from_file() for SecurityFS-related files where we can
> > > > > now get the IMA namespace via the user namespace pointer associated
> > > > > with the superblock of the SecurityFS filesystem instance. Since
> > > > > the functions using ima_ns_from_file() will only be called after an
> > > > > ima_namesapce has been allocated they will never get a NULL pointer
> > > > > for the ima_namespace.
> > > > > 
> > > > > Switch access to userns->ima_ns to use acquire/release semantics to ensure
> > > > > that a newly created ima_namespace structure is fully visible upon access.
> > > > > 
> > > > > Replace usage of current_user_ns() with ima_ns_from_user_ns() that
> > > > > implements a method to derive the user_namespace from the given
> > > > > ima_namespace. It leads to the same result.
> > > > > 
> > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > ---
> > > [...]
> > > > > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > > > > index b7dbc687b6ff..5a9b511ebbae 100644
> > > > > --- a/security/integrity/ima/ima_policy.c
> > > > > +++ b/security/integrity/ima/ima_policy.c
> > > > > @@ -1333,6 +1333,7 @@ static unsigned int ima_parse_appraise_algos(char *arg)
> > > > >    static int ima_parse_rule(struct ima_namespace *ns,
> > > > >    			  char *rule, struct ima_rule_entry *entry)
> > > > >    {
> > > > > +	struct user_namespace *user_ns = ima_ns_to_user_ns(ns);
> > > > So I think ima_policy_write() and therefore ima_parse_rule() can
> > > > legitimately be reached at least from an ancestor userns but also from a
> > > > completely unrelated userns via securityfs. Sorry, I didn't see this
> > > > earlier. Think of the following two scenarios:
> > > > 
> > > > * userns1: unshare -U --map-root --mount
> > > > -----------------------------------------
> > > >      mount -t securityfs securityfs /userns1_securityfs
> > > >      fd_in_userns1 = open("/userns1_securityfs/ima_file, O_RDWR);
> > > > 
> > > >      /* I _think_ that sending of fds here should work but I haven't
> > > >       * bothered to recheck the scm code as I need to do some driving in a
> > > >       * little bit so I'm running out of time...
> > > >       */
> > > >      send_fd_scm_rights(fd_in_userns1, task_in_userns2);
> > > > 
> > > > * userns2: unshare -U --map-root --mount
> > > > -----------------------------------------
> > > >      fd_from_userns1 = receive_fd_scm_rights();
> > > >      write_policy(fd_from_userns1, "my fancy policy");
> > > Passing an fd around like this presumably indicates that you intend to let
> > > the recipient read/write to it.
> > Yes.
> > 
> > > 
> > > > It also means that if you inherit an fd from a more privileged imans
> > > > instance you can write to it:
> > > Now in this example we have to assume that root is making a mistake passing
> > > the file descriptor around?
> > > 
> > > # ls -l /sys/kernel/security/ima/
> > > total 0
> > > -r--r-----. 1 root root 0 Jan 18 12:48 ascii_runtime_measurements
> > > -r--r-----. 1 root root 0 Jan 18 12:48 binary_runtime_measurements
> > > -rw-------. 1 root root 0 Jan 18 12:48 policy
> > > -r--r-----. 1 root root 0 Jan 18 12:48 runtime_measurements_count
> > > -r--r-----. 1 root root 0 Jan 18 12:48 violations
> > > 
> > > > * initial_userns:
> > > 
> > > So that's the host, right? And this is a 2nd independent example from the
> > > first.
> > Yes, these are just two examples to give a more complete idea of the
> > semantics by specifying two cases and how ima would behave.
> > 
> > > > ------------------
> > > >      mount -t securityfs securityfs /initial_securityfs
> > > > 
> > > >      fd_in_initial_securityfs = open("/initial_securityfs/ima_file, O_RDWR);
> > > > 
> > > >      pid = fork():
> > > >      if (pid == 0) {
> > > > 	unshare(CLONE_NEWUSER);
> > > > 	/* write idmapping for yourself */
> > > > 
> > > > 	write_policy(fd_in_initial_securityfs, "my fancy policy");
> > > >      }
> > > > 
> > > > would allow an unprivileged caller to alter the host's ima policy (as
> > > > you can see the example requires cooperation).
> > > Sorry, not currently following. Root is the only one being able to open that
> > > IMA files on the host, right? Is this a mistake here where root passed the
> > Yes.
> > 
> > > fd onto the child and that child is not trusted to mess with the fd
> > > including passing it on further?
> > This is just an example what the current semantics mean in practice.
> > The above code snippet is neither good nor bad by itself as that depends
> > on context:
> > 
> > 1) Let's say for whatever reason you would like to let unprivileged
> >     containers add policy rules (sorry in case I'm using the wrong ima
> >     vernacular) for themselves to the initial ima namespace during
> >     startup. That can be a rather valid and important use-case. Then this
> >     code snipped above where root opens a policy fd in the host
> >     securityfs instance and then let's the container access it across
> >     fork() + post namespace creation is "good" as it will allow the
> >     container to write the rules during setup while e.g. letting the
> >     container manager process (the code prior to fork) continue doing
> >     other stuff.
> 
> I would agree to supporting passing the fd to other containers to have them
> add rules to the policy, if that's what is intended.
> 
> 
> > 
> > 2) If you only want to ever allow container manager on the host write
> >     rules for the container in the initial ima ns but never the container
> >     setup process itself then the above code is "bad". The policy fd
> >     should've been closed before the fork() and definitely be opened
> >     o-cloexec.
> 
> I would treat the IMA files' file descriptors like those of fd =
> open("/top/secret/file", O_RDWR) assuming the programmer knows the
> implications of passing the fd around, including knowing that open fds are
> inherited by child processes... I don't see that there's anything wrong with
> that.

Agreed. And we do already have these semantics for a range of fds
including splitting open and write between callers and namespaces.
