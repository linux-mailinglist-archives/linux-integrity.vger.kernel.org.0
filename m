Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF75432F1DC
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 18:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCERxK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 12:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhCERwv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 12:52:51 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F5C06175F
        for <linux-integrity@vger.kernel.org>; Fri,  5 Mar 2021 09:52:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id p1so3796763edy.2
        for <linux-integrity@vger.kernel.org>; Fri, 05 Mar 2021 09:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9cy6NY2NneFUb+ai21Mer/bJAl+1fOEOH5Xn9JUNG4w=;
        b=M9iU8Hx8FsBg3SEJvJ/21kHhWBt5rp2CgMqle7NuC5OBFVe2oGQ9SQasL3gILMCMA2
         uD3OxosJLHMAEeYUlK2woG20Ck5JkBv1jdv2LNDWyOJJEp9NAgKajeSjXQnIGur7zrPI
         DHFKH+DwiTEZOtzsA2WF0yW4HKrGiGXqAevdSlryAMyuQyb45w7H6W8ZD+hjqAITLJrq
         tgNhi21v+U2FbLu4WMDpHXXLnaijE1rBsR2W1SwPWFmuMLd34ZH6GdrEK9ltgtqrqu4y
         u1xBnTnWTM3879W8b7j6MLhih0uRFIg2StKV+DwicGMnw7wSqm+dcs8AV9qsLKSZSqT/
         ZkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9cy6NY2NneFUb+ai21Mer/bJAl+1fOEOH5Xn9JUNG4w=;
        b=cXAN0yEh4PKEnp2GixIY2XLgMZGdTKWX+P4LcfyBMxeuJhvuXsOJmI3yi2oijN68Jd
         oIBrIu5Fjj2c2PV8z8+HLVGoNZFTwLmtlWytqYyLBaR41cha6IliGtJBCd7oaJXOcKHn
         QjiRqroJsE+yBvZYSnRJYpb4nZHDU7WAYnmEQljxTaUEIvtmckmKh6C9gtclqURh/p/C
         V/72h7FKyc/4hWo4hoLSCtbm8bCYiX1SKWkOWSWYL780OiGn0nh+4/2V63Z4CnRYqmwB
         tgPviCVIDxfAaut8q9wwys9ByjUA+/zdyiCrojSiRD7eWf7TrsFfEi3I5qdKQEvZTh+Y
         OCPw==
X-Gm-Message-State: AOAM532LNHtwmp2bTA6rv6Am6l0j1M2MI8UuN1oAN/XlJ7KQtVM7EiEh
        Ho6F0cEdrqNFosOFAzX2c4uyLchPFgsiF5kkAAsW
X-Google-Smtp-Source: ABdhPJwOI0lS36GAS0Qm3uPRAj87oRmnPCRoE0yZWekW+QEZ0i+1DFUufde+BDoBg2RYBnPYm4uJRenmSYQP12YxeUE=
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr10224074edt.12.1614966769368;
 Fri, 05 Mar 2021 09:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20210212163709.3139-1-nramas@linux.microsoft.com>
In-Reply-To: <20210212163709.3139-1-nramas@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 5 Mar 2021 12:52:38 -0500
Message-ID: <CAHC9VhSMz8FtK5HMPA1+FMeU0cs4vfCCaimxb-J+VDj_Dyk-nA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: measure state and policy capabilities
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 12, 2021 at 11:37 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> SELinux stores the configuration state and the policy capabilities
> in kernel memory.  Changes to this data at runtime would have an impact
> on the security guarantees provided by SELinux.  Measuring this data
> through IMA subsystem provides a tamper-resistant way for
> an attestation service to remotely validate it at runtime.
>
> Measure the configuration state and policy capabilities by calling
> the IMA hook ima_measure_critical_data().
>
> To enable SELinux data measurement, the following steps are required:
>
>  1, Add "ima_policy=critical_data" to the kernel command line arguments
>     to enable measuring SELinux data at boot time.
>     For example,
>       BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc3+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
>
>  2, Add the following rule to /etc/ima/ima-policy
>        measure func=CRITICAL_DATA label=selinux
>
> Sample measurement of SELinux state and policy capabilities:
>
> 10 2122...65d8 ima-buf sha256:13c2...1292 selinux-state 696e...303b
>
> Execute the following command to extract the measured data
> from the IMA's runtime measurements list:
>
>   grep "selinux-state" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6 | xxd -r -p
>
> The output should be a list of key-value pairs. For example,
>  initialized=1;enforcing=0;checkreqprot=1;network_peer_controls=1;open_perms=1;extended_socket_class=1;always_check_network=0;cgroup_seclabel=1;nnp_nosuid_transition=1;genfs_seclabel_symlinks=0;
>
> To verify the measurement is consistent with the current SELinux state
> reported on the system, compare the integer values in the following
> files with those set in the IMA measurement (using the following commands):
>
>  - cat /sys/fs/selinux/enforce
>  - cat /sys/fs/selinux/checkreqprot
>  - cat /sys/fs/selinux/policy_capabilities/[capability_file]
>
> Note that the actual verification would be against an expected state
> and done on a separate system (likely an attestation server) requiring
> "initialized=1;enforcing=1;checkreqprot=0;"
> for a secure state and then whatever policy capabilities are actually
> set in the expected policy (which can be extracted from the policy
> itself via seinfo, for example).
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ima.c         | 87 ++++++++++++++++++++++++++++++++--
>  security/selinux/include/ima.h |  6 +++
>  security/selinux/selinuxfs.c   |  6 +++
>  security/selinux/ss/services.c |  2 +-
>  4 files changed, 96 insertions(+), 5 deletions(-)

This draft seems fine to me, but there is a small logistical blocker
at the moment which means I can't merge this until -rc2 is released,
which likely means this coming Monday.  The problem is that this patch
relies on code that went upstream via in the last merge window via the
IMA tree, not the SELinux tree; normally that wouldn't be a problem as
I typically rebase the selinux/next to Linus' -rc1 tag once the merge
window is closed, but in this particular case the -rc1 tag is
dangerously broken for some system configurations (the tag has since
been renamed) so I'm not rebasing onto -rc1 this time around.

Assuming that -rc2 fixes the swapfile/fs-corruption problem, early
next week I'll rebase selinux/next to -rc2 and merge this patch.
However, if the swapfile bug continues past -rc2 we can consider
merging this via the IMA tree, but I'd assume not do that if possible
due to merge conflict and testing reasons.

-- 
paul moore
www.paul-moore.com
