Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D394A72CC
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Feb 2022 15:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344663AbiBBONi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 09:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiBBONh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 09:13:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B2EC061714;
        Wed,  2 Feb 2022 06:13:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56CC96187D;
        Wed,  2 Feb 2022 14:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19754C340ED;
        Wed,  2 Feb 2022 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643811216;
        bh=CVz6X3byuWMkZSr5srBVeCEK4RTVy53e99LhmWCQdYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lj8q7kfBofqO8GGn86wA2xIE+YR9ur17SRyhKD1jqMs79MZBNZ3HcWgvBIeb/lYxR
         EOKfimVGQke3TZSfrbJmHO/u5piHUfhKQ2vqbFuHDdQnHcIxIB+2GF8dwgDr/nZG06
         eKn1I34IjSqIGASIo9Y7QQ7BXcF2OQUmNIkuyFmcAh1DcpIcUguurfR0eT9kT8LiB1
         T2fAvZvkyBeaULOPrIzZlJ8nE0egJpW5lZTHEfULOZ3BpmbXBVZDgNRwENuIdOQwE+
         gyUqlcfN9sew9Uwy0uN54LI8e/sZaqzJ+Ax5OsrltcF2/rSYphJeJ0FW99EnDCv40Q
         kXrl+5WBSlzQA==
Date:   Wed, 2 Feb 2022 15:13:29 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v10 00/27] ima: Namespace IMA with audit support in IMA-ns
Message-ID: <20220202141329.k5jcsbutpmzv53c3@wittgenstein>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 01, 2022 at 03:37:08PM -0500, Stefan Berger wrote:
> The goal of this series of patches is to start with the namespacing of
> IMA and support auditing within an IMA namespace (IMA-ns) as the first
> step.
> 
> In this series the IMA namespace is piggy backing on the user namespace
> and therefore an IMA namespace is created when a user namespace is
> created, although this is done late when SecurityFS is mounted inside
> a user namespace. The advantage of piggy backing on the user namespace
> is that the user namespace can provide the keys infrastructure that IMA
> appraisal support will need later on.
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
>   busybox echo 1 > /mnt/ima/active; \
>   busybox echo 'audit func=BPRM_CHECK mask=MAY_EXEC' > /mnt/ima/policy; \
>   busybox2 cat /mnt/ima/policy"
> 
> [busybox2 is used to demonstrate 2 audit messages; see below]
> 
> Following the audit log on the host the last line cat'ing the IMA policy
> inside the namespace would have been audited. Unfortunately the auditing
> line is not distinguishable from one stemming from actions on the host.
> The hope here is that Richard Brigg's container id support for auditing
> would help resolve the problem.
> 
> In the above the writing of '1' to the 'active' file is used to activate
> the IMA namespace. Future extensions to IMA namespaces will make use of
> the configuration stage after the mounting of securityfs and before the
> activation to for example choose the measurement log template.
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
> capability to allow users to set file extended attributes for IMA
> appraisal support.
> 
> My tree with these patches is here:
> 
> git fetch https://github.com/stefanberger/linux-ima-namespaces v5.16+imans.v10.posted
> 
> Regards,
>    Stefan
> 
> Links to previous postings:
> v1: https://lore.kernel.org/linux-integrity/20211130160654.1418231-1-stefanb@linux.ibm.com/T/#t
> v2: https://lore.kernel.org/linux-integrity/20211203023118.1447229-1-stefanb@linux.ibm.com/T/#t
> v3: https://lore.kernel.org/linux-integrity/6240b686-89cf-2e31-1c1b-ebdcf1e972c1@linux.ibm.com/T/#t
> v4: https://lore.kernel.org/linux-integrity/20211207202127.1508689-1-stefanb@linux.ibm.com/T/#t
> v5: https://lore.kernel.org/linux-integrity/20211208221818.1519628-1-stefanb@linux.ibm.com/T/#t
> v6: https://lore.kernel.org/linux-integrity/20211210194736.1538863-1-stefanb@linux.ibm.com/T/#t
> v7: https://lore.kernel.org/linux-integrity/20211217100659.2iah5prshavjk6v6@wittgenstein/T/#t
> v8: https://lore.kernel.org/all/20220104170416.1923685-1-stefanb@linux.vnet.ibm.com/#r
> v9: https://lore.kernel.org/linux-integrity/?t=20220131234353
> 
> v10:
>  - Added A-b's; addressed issues from v9
>  - Added 2 patches to support freeing of iint after namespace deletion
>  - Added patch to return error code from securityfs functions
>  - Added patch to limit number of policy rules in IMA-ns to 1024

I'm going to go take a lighter touch with this round of reviews.
First, because I have February off. :)
Second, because I think that someone who is more familiar with IMA and
its requirements should take another look to provide input and ask more
questions. Last time I spoke to Serge he did want to give this a longer
look and maybe also has additional questions.
