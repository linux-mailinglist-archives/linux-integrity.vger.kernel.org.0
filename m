Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E2532F1FF
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 18:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCER57 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 12:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCER5p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 12:57:45 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26E9C061574;
        Fri,  5 Mar 2021 09:57:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C8D791280557;
        Fri,  5 Mar 2021 09:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1614967064;
        bh=I12qLg9Cwserkp5Y2dm2OSRdMTJvsQsUwHpn6DZphVo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HOVc499lijkDdTOqaUgES5NwYDqdRrMroJVLkIwh9RbwMbWm7DAkgJA47Zd2pPboR
         1/MiiB5ca3cUAN48bPkaR1QtDnEVeHVxk6Qy2ZwiSCFQSj1+zHqtIqXvmVJJOOo1pY
         6N0yglQoKMJdbxcZ8RSwQEnilHoli6AJJHCB8t9A=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FpH8EscH_1PE; Fri,  5 Mar 2021 09:57:44 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B0F2A1280555;
        Fri,  5 Mar 2021 09:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1614967064;
        bh=I12qLg9Cwserkp5Y2dm2OSRdMTJvsQsUwHpn6DZphVo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HOVc499lijkDdTOqaUgES5NwYDqdRrMroJVLkIwh9RbwMbWm7DAkgJA47Zd2pPboR
         1/MiiB5ca3cUAN48bPkaR1QtDnEVeHVxk6Qy2ZwiSCFQSj1+zHqtIqXvmVJJOOo1pY
         6N0yglQoKMJdbxcZ8RSwQEnilHoli6AJJHCB8t9A=
Message-ID: <af0f2d60c6584b613172b08e4fcea4119e231e93.camel@HansenPartnership.com>
Subject: Re: [PATCH v3] selinux: measure state and policy capabilities
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Paul Moore <paul@paul-moore.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 05 Mar 2021 09:57:42 -0800
In-Reply-To: <CAHC9VhSMz8FtK5HMPA1+FMeU0cs4vfCCaimxb-J+VDj_Dyk-nA@mail.gmail.com>
References: <20210212163709.3139-1-nramas@linux.microsoft.com>
         <CAHC9VhSMz8FtK5HMPA1+FMeU0cs4vfCCaimxb-J+VDj_Dyk-nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-03-05 at 12:52 -0500, Paul Moore wrote:
[...]
> This draft seems fine to me, but there is a small logistical blocker
> at the moment which means I can't merge this until -rc2 is released,
> which likely means this coming Monday.  The problem is that this
> patch relies on code that went upstream via in the last merge window
> via the IMA tree, not the SELinux tree; normally that wouldn't be a
> problem as I typically rebase the selinux/next to Linus' -rc1 tag
> once the merge window is closed, but in this particular case the -rc1
> tag is dangerously broken for some system configurations (the tag has
> since been renamed) so I'm not rebasing onto -rc1 this time around.
> 
> Assuming that -rc2 fixes the swapfile/fs-corruption problem, early
> next week I'll rebase selinux/next to -rc2 and merge this patch.
> However, if the swapfile bug continues past -rc2 we can consider
> merging this via the IMA tree, but I'd assume not do that if possible
> due to merge conflict and testing reasons.

If it helps, we rebased the SCSI tree on top of the merge for the
swapfile fix which is this one, without waiting for -rc2:

commit f69d02e37a85645aa90d18cacfff36dba370f797
Merge: 7a7fd0de4a98 caf6912f3f4a
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Mar 2 18:18:17 2021 -0800

    Merge tag 'misc-5.12-2021-03-02' of git://git.kernel.dk/linux-block
 
James


