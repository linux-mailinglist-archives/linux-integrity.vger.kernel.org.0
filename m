Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF384937A6
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jan 2022 10:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348366AbiASJq0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jan 2022 04:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346503AbiASJqY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jan 2022 04:46:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACBCC061574;
        Wed, 19 Jan 2022 01:46:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2357B81907;
        Wed, 19 Jan 2022 09:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAE7C004E1;
        Wed, 19 Jan 2022 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642585581;
        bh=+qQOh1PurSXvzxoWo6Z89b7E5FjgIwjP+Cb6PNVs2EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAGRGfQoAcOgl/Mq4niJaTi8+9CD/hjHAaly1vihDB6OnII6oVI23i2bxHkEtN9we
         vhT91/iZV9ltw/vLMjlU08EyHnfRL+CG/dOJf4qTGMQZf4kXwipfQL0g63v4drTsig
         nlV91Uno3swlWGVxSfX4bF8PyffofyATNJx/UVpoFfjxtVqmtMPzJdhvtnJaek00hS
         dbYUIF+z/22uAQz8+vsv8krkyhu8dMibTJoWRUWRaw5UY06tOf/RG/ueU3oLILu8X4
         DP6jwyjtHsa5upVb/EzddT7vQGm0s04oVVe4bIDveB7p3O2N4canBoxMjYxYMOb4zz
         mqEmBu52oofkA==
Date:   Wed, 19 Jan 2022 10:46:13 +0100
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
Message-ID: <20220119094613.cxxxmz5qbuehd7c3@wittgenstein>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-20-stefanb@linux.vnet.ibm.com>
 <20220114144515.vbler7ae3jqebhec@wittgenstein>
 <8f7e0bcc-cd7c-723d-c544-300b5e8f3873@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f7e0bcc-cd7c-723d-c544-300b5e8f3873@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 18, 2022 at 01:09:12PM -0500, Stefan Berger wrote:
> 
> On 1/14/22 09:45, Christian Brauner wrote:
> > On Tue, Jan 04, 2022 at 12:04:16PM -0500, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Introduce the IMA_NS in Kconfig for IMA namespace enablement.
> > > 
> > > Enable the lazy initialization of an IMA namespace when a user mounts
> > > SecurityFS. Now a user_namespace will get a pointer to an ima_namespace
> > > and therefore add an implementation of get_current_ns() that returns this
> > > pointer.
> > > 
> > > get_current_ns() may now return a NULL pointer for as long as the IMA
> > > namespace hasn't been created, yet. Therefore, return early from those
> > > functions that may now get a NULL pointer from this call. The NULL
> > > pointer can typically be treated similar to not having an IMA policy set
> > > and simply return early from a function.
> > > 
> > > Implement ima_ns_from_file() for SecurityFS-related files where we can
> > > now get the IMA namespace via the user namespace pointer associated
> > > with the superblock of the SecurityFS filesystem instance. Since
> > > the functions using ima_ns_from_file() will only be called after an
> > > ima_namesapce has been allocated they will never get a NULL pointer
> > > for the ima_namespace.
> > > 
> > > Switch access to userns->ima_ns to use acquire/release semantics to ensure
> > > that a newly created ima_namespace structure is fully visible upon access.
> > > 
> > > Replace usage of current_user_ns() with ima_ns_from_user_ns() that
> > > implements a method to derive the user_namespace from the given
> > > ima_namespace. It leads to the same result.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> [...]
> > > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > > index b7dbc687b6ff..5a9b511ebbae 100644
> > > --- a/security/integrity/ima/ima_policy.c
> > > +++ b/security/integrity/ima/ima_policy.c
> > > @@ -1333,6 +1333,7 @@ static unsigned int ima_parse_appraise_algos(char *arg)
> > >   static int ima_parse_rule(struct ima_namespace *ns,
> > >   			  char *rule, struct ima_rule_entry *entry)
> > >   {
> > > +	struct user_namespace *user_ns = ima_ns_to_user_ns(ns);
> > So I think ima_policy_write() and therefore ima_parse_rule() can
> > legitimately be reached at least from an ancestor userns but also from a
> > completely unrelated userns via securityfs. Sorry, I didn't see this
> > earlier. Think of the following two scenarios:
> > 
> > * userns1: unshare -U --map-root --mount
> > -----------------------------------------
> >     mount -t securityfs securityfs /userns1_securityfs
> >     fd_in_userns1 = open("/userns1_securityfs/ima_file, O_RDWR);
> > 
> >     /* I _think_ that sending of fds here should work but I haven't
> >      * bothered to recheck the scm code as I need to do some driving in a
> >      * little bit so I'm running out of time...
> >      */
> >     send_fd_scm_rights(fd_in_userns1, task_in_userns2);
> > 
> > * userns2: unshare -U --map-root --mount
> > -----------------------------------------
> >     fd_from_userns1 = receive_fd_scm_rights();
> >     write_policy(fd_from_userns1, "my fancy policy");
> 
> Passing an fd around like this presumably indicates that you intend to let
> the recipient read/write to it.

Yes.

> 
> 
> > It also means that if you inherit an fd from a more privileged imans
> > instance you can write to it:
> 
> Now in this example we have to assume that root is making a mistake passing
> the file descriptor around?
> 
> # ls -l /sys/kernel/security/ima/
> total 0
> -r--r-----. 1 root root 0 Jan 18 12:48 ascii_runtime_measurements
> -r--r-----. 1 root root 0 Jan 18 12:48 binary_runtime_measurements
> -rw-------. 1 root root 0 Jan 18 12:48 policy
> -r--r-----. 1 root root 0 Jan 18 12:48 runtime_measurements_count
> -r--r-----. 1 root root 0 Jan 18 12:48 violations
> 
> > 
> > * initial_userns:
> 
> 
> So that's the host, right? And this is a 2nd independent example from the
> first.

Yes, these are just two examples to give a more complete idea of the
semantics by specifying two cases and how ima would behave.

> 
> > ------------------
> 
> >     mount -t securityfs securityfs /initial_securityfs
> > 
> >     fd_in_initial_securityfs = open("/initial_securityfs/ima_file, O_RDWR);
> > 
> >     pid = fork():
> >     if (pid == 0) {
> > 	unshare(CLONE_NEWUSER);
> > 	/* write idmapping for yourself */
> > 
> > 	write_policy(fd_in_initial_securityfs, "my fancy policy");
> >     }
> > 
> > would allow an unprivileged caller to alter the host's ima policy (as
> > you can see the example requires cooperation).
> 
> Sorry, not currently following. Root is the only one being able to open that
> IMA files on the host, right? Is this a mistake here where root passed the

Yes.

> fd onto the child and that child is not trusted to mess with the fd
> including passing it on further?

This is just an example what the current semantics mean in practice.
The above code snippet is neither good nor bad by itself as that depends
on context:

1) Let's say for whatever reason you would like to let unprivileged
   containers add policy rules (sorry in case I'm using the wrong ima
   vernacular) for themselves to the initial ima namespace during
   startup. That can be a rather valid and important use-case. Then this
   code snipped above where root opens a policy fd in the host
   securityfs instance and then let's the container access it across
   fork() + post namespace creation is "good" as it will allow the
   container to write the rules during setup while e.g. letting the
   container manager process (the code prior to fork) continue doing
   other stuff.

2) If you only want to ever allow container manager on the host write
   rules for the container in the initial ima ns but never the container
   setup process itself then the above code is "bad". The policy fd
   should've been closed before the fork() and definitely be opened
   o-cloexec.

The examples really were just trying to make obvious what the semantics
are that you're buying.
