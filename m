Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38B846BF1C
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 16:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhLGPVT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 10:21:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40094 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhLGPVT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 10:21:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE0CCB817F8;
        Tue,  7 Dec 2021 15:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24679C341C1;
        Tue,  7 Dec 2021 15:17:40 +0000 (UTC)
Date:   Tue, 7 Dec 2021 16:17:37 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v3 00/16] ima: Namespace IMA with audit support in IMA-ns
Message-ID: <20211207151737.vlzfwfrba4n6uxpx@wittgenstein>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211206172600.1495968-1-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 06, 2021 at 12:25:44PM -0500, Stefan Berger wrote:
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
> PATH=/bin unshare --user --map-root-user --mount-proc --pid --fork \
>   --root rootfs busybox sh -c \
>  "busybox mount -t securityfs /mnt /mnt; \
>   busybox echo 'audit func=BPRM_CHECK mask=MAY_EXEC' > /mnt/ima/policy; \
>   busybox cat /mnt/ima/policy"
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
> auditing messages for the 'busybox cat' above and log entries in IMA's
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
> 
> This patch also introduces usage of CAP_MAC_ADMIN to allow access to the
> IMA policy via reduced capabilities. We would again later on use this
> capability to allow users to set file extended attributes for IMA appraisal
> support.
> 
> The basis for this series of patches is Linux v5.15.
> My tree with these patches is here:
> https://github.com/stefanberger/linux-ima-namespaces/tree/v5.15%2Bimans.v3.public

I have one small procedural favor to ask. :)

I couldn't apply your patch series directly. It if isn't too
inconvenient for you could you pass --base with a proper upstream tag,
e.g. --base=v5.15.

The branch you posted here doesn't exist afaict and I had to peruse your
github repo and figured the correct branch might be v5.15+imans.v3.posted.

In any case, --base with a proper upstream tag would make this all a bit
easier or - if it really is necessary to pull from your tree it would be
nice if you could post it in a form directly consumable by git and note
url-escaped. So something like

git clone https://github.com/stefanberger/linux-ima-namespaces v5.15+imans.v3.posted

would already help.

Christian
