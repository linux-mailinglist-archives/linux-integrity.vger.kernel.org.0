Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA546477234
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 13:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhLPMuk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 07:50:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44688 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhLPMuk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 07:50:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36222B8240E;
        Thu, 16 Dec 2021 12:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3E8C36AEB;
        Thu, 16 Dec 2021 12:50:31 +0000 (UTC)
Date:   Thu, 16 Dec 2021 13:50:27 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v7 00/14] ima: Namespace IMA with audit support in IMA-ns
Message-ID: <20211216125027.fte6625wu5vxkjpi@wittgenstein>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 16, 2021 at 12:43:09AM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> The goal of this series of patches is to start with the namespacing of
> IMA and support auditing within an IMA namespace (IMA-ns) as the first
> step.
> 
> In this series the IMA namespace is piggy backing on the user namespace
> and therefore an IMA namespace gets created when a user namespace is
> created. The advantage of this is that the user namespace can provide
> the keys infrastructure that IMA appraisal support will need later on.
> 
> We chose the goal of supporting auditing within an IMA namespace since it
> requires the least changes to IMA. Following this series, auditing within
> an IMA namespace can be activated by a user running the following lines
> that rely on a statically linked busybox to be installed on the host for
> execution within the minimal container environment:
> 
> mkdir -p rootfs/{bin,mnt,proc}
> cp /sbin/busybox rootfs/bin
> cp /sbin/busybox rootfs/bin/busybox2
> echo >> rootfs/bin/busybox2
> PATH=/bin unshare --user --map-root-user --mount-proc --pid --fork \
>   --root rootfs busybox sh -c \
>  "busybox mount -t securityfs /mnt /mnt; \
>   busybox echo 'audit func=BPRM_CHECK mask=MAY_EXEC' > /mnt/ima/policy; \
>   busybox2 cat /mnt/ima/policy"
> 
> [busybox2 is used to demonstrate 2 measurements; see below]
> 
> Following the audit log on the host the last line cat'ing the IMA policy
> inside the namespace would have been audited. Unfortunately the auditing
> line is not distinguishable from one stemming from actions on the host.
> The hope here is that Richard Brigg's container id support for auditing
> would help resolve the problem.
> 
> The following lines added to a suitable IMA policy on the host would
> cause the execution of the commands inside the container (by uid 1000)
> to be measured and audited as well on the host, thus leading to two
> auditing messages for the 'busybox2 cat' above and log entries in IMA's
> system log.
> 
> echo -e "measure func=BPRM_CHECK mask=MAY_EXEC uid=1000\n" \
>         "audit func=BPRM_CHECK mask=MAY_EXEC uid=1000\n" \
>     > /sys/kernel/security/ima/policy
> 
> The goal of supporting measurement and auditing by the host, of actions
> occurring within IMA namespaces, is that users, particularly root,
> should not be able to evade the host's IMA policy just by spawning
> new IMA namespaces, running programs there, and discarding the namespaces
> again. This is achieved through 'hierarchical processing' of file
> accesses that are evaluated against the policy of the namespace where
> the action occurred and against all namespaces' and their policies leading
> back to the root IMA namespace (init_ima_ns).

Note that your worst-case is 32 levels (maximum supported userns
nesting) where each ima namespace defines a separate policy.

So make sure you don't run into locking issues when hierarchically
processing rules. So far I think it's fine since the locks aren't held
across the hierarchial walk but are dropped and reaqcuired for each
level.

But that could still mean a lot of contention on iint->mutex since this
lock is global, i.e. in this context: for all ima namespaces. You might
want to consider coming up with some rough ideas for how to solve this
_if_ this becomes a problem in the future.

> 
> The patch series adds support for a virtualized SecurityFS with a few
> new API calls that are used by IMA namespacing. Only the data relevant
> to the IMA namespace are shown. The files and directories of other
> security subsystems (TPM, evm, Tomoyo, safesetid) are not showing
> up when secruityfs is mounted inside a user namespace.
> 
> Much of the code leading up to the virtualization of SecurityFS deals
> with moving IMA's variables from various files into the IMA namespace
> structure called 'ima_namespace'. When it comes to determining the
> current IMA namespace I took the approach to get the current IMA
> namespace (get_current_ns()) on the top level and pass the pointer all
> the way down to those functions that now need access to the ima_namespace
> to get to their variables. This later on comes in handy once hierarchical
> processing is implemented in this series where we walk the list of
> namespaces backwards and again need to pass the pointer into functions.

Just to repeat the point from earlier reviews, all those functions need
to be guaranteed to call from syscall context. Functions that operate on
files have different semantics.

> 
> This patch also introduces usage of CAP_MAC_ADMIN to allow access to the
> IMA policy via reduced capabilities. We would again later on use this
> capability to allow users to set file extended attributes for IMA appraisal
> support.
> 
> My tree with these patches is here:
> 
> git fetch https://github.com/stefanberger/linux-ima-namespaces v5.15+imans.v7.posted 
> 
> Regards,
>    Stefan
> 
> v7:
>  - Dropped 2 patches related to key queues; using &init_ima_ns for all calls
>    from functions related to key queues where calls need ima_namespace
>  - Moved ima_namespace to security/integrity/ima/ima.h
>  - Extended API descriptions with ns parameter where needed
>  - Using init_ima_ns in functions related to appraisal and xattrs
>  - SecurityFS: Using ima_ns_from_file() to get ns pointer 
>  - Reformatted to 80 columns per line

Since we're starting to be fairly along I would ask you to please write
detailed commit messages for the next revision.

I would also like to see all links for prior versions of this patchset
in the commit message since the discussion has been fairly extensive so
for this series it makes a lot of sense. So something like:

Link: https://lore.kernel.org/r/$MSGID (v1)
Link: https://lore.kernel.org/r/$MSGID (v2)
Link: https://lore.kernel.org/r/$MSGID (v3)
Link: https://lore.kernel.org/r/$MSGID (v4)
Link: https://lore.kernel.org/r/$MSGID (v5)
Link: https://lore.kernel.org/r/$MSGID (v6)
Link: https://lore.kernel.org/r/$MSGID (v7)
Signed-off-by: meh
Signed-off-by: mih
Signed-off-by: muh

I find that extremely pleasant in case we need to revisit things later.
(Technically you can get the same by searching lore via the final link
but I find it be pretty pleasing to just copy+paste directly from the
commit message to the discussion for the earlier patch.)
