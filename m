Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6C37010B
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Apr 2021 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhD3TO6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Apr 2021 15:14:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:47688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhD3TO5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Apr 2021 15:14:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CCEFB13B;
        Fri, 30 Apr 2021 19:14:08 +0000 (UTC)
Date:   Fri, 30 Apr 2021 21:14:06 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@us.ibm.com>
Subject: Re: [PATCH 1/1] travis: Fix Fedora
Message-ID: <YIxW/h41HTozljSo@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210429053918.10240-1-pvorel@suse.cz>
 <07d6895b02ea3818b0687d79f66575fc08ff6c97.camel@linux.ibm.com>
 <YIwFFwf80Hj178zK@pevik>
 <a3db607d43565699e3d08c941161d1cfa69f28ac.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3db607d43565699e3d08c941161d1cfa69f28ac.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> [Cc'ing Stefan]

> Hi Petr,

> On Fri, 2021-04-30 at 15:24 +0200, Petr Vorel wrote:
> > > On Thu, 2021-04-29 at 07:39 +0200, Petr Vorel wrote:
> > > > Fedora recently got 2.33, which requires on Travis CI to use podman.

> > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > ---
> > > > Hi Mimi,

> > > > Tested [1].

> > > > Previously Fedora fails on autoconf issue [2], which is caused by
> > > > faccessat2 incompatibility on glibc 2.33:

> > > > /usr/bin/autoconf: This script requires a shell more modern than all
> > > > /usr/bin/autoconf: the shells that I found on your system.
> > > > /usr/bin/autoconf: Please tell bug-autoconf@gnu.org about your system,
> > > > /usr/bin/autoconf: including any error possibly output before this
> > > > /usr/bin/autoconf: message. Then install a modern shell, or manually run
> > > > /usr/bin/autoconf: the script under such a shell if you do have one.
> > > > autoreconf: /usr/bin/autoconf failed with exit status: 1

> > > > [1] https://travis-ci.org/github/pevik/ima-evm-utils/builds/768789641
> > > > [2] https://travis-ci.org/github/pevik/ima-evm-utils/jobs/767259578

> > > The "boot_aggregate" test should succeed, but for some reason is now
> > > being skipped.

> > > PASS: ima_hash.test
> > > PASS: sign_verify.test
> > > SKIP: boot_aggregate.test
> > Not sure why, I'll try to have look. Maybe missing dependencies?
> > I suppose this is not related to the patch at all.

> The boot_aggregate test has a dependency on a software TPM.  From the
> end of the log, there's problems communicating with the swtpm.

> which: no tpm_server in (../src:/root/ima-evm-utils-install/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin)
> INFO: Starting software TPM: /usr/bin/swtpm
> INFO: Sending software TPM startup
> TSS_Socket_Open: Error on connect to localhost:2321
> TSS_Socket_Open: client connect: error 111 Connection refused
> startup: failed, rc 000b0008
> TSS_RC_NO_CONNECTION - Failure connecting to lower layer
> INFO: Retry sending software TPM startup
> TSS_Socket_Open: Error on connect to localhost:2321
> TSS_Socket_Open: client connect: error 111 Connection refused
> startup: failed, rc 000b0008
> TSS_RC_NO_CONNECTION - Failure connecting to lower layer
> INFO: Software TPM startup failed
Hm, testing if sudo is needed for podman to be able to the container run swtpm.

> > > I tested with/without this patch on our internal travis.   I was seeing
> > > the Tumbleweed problem, but am not seeing this problem with Fedora
> > > latest yet.  Both with/without the patch, Fedora latest works properly
> > "not yet" => if you check glibc package update for the version. I bet it's still
> > 2.32. Thanks for testing it.

> From the local raw log:
>   glibc-devel-2.33-
> 5.fc34.x86_64
>   glibc-headers-x86-2.33-5.fc34.noarch

OK, if your internal travis is working with 2.33 maybe the rest of the setup is
different (different docker and/or runc), because this patch is really needed on
public Travis.

Kind regards,
Petr

> thanks,

> Mimi

> > > on our internal travis.

