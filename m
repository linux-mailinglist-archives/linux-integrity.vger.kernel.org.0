Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169B8642A90
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Dec 2022 15:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLEOov (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Dec 2022 09:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiLEOot (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Dec 2022 09:44:49 -0500
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEB0012A96
        for <linux-integrity@vger.kernel.org>; Mon,  5 Dec 2022 06:44:48 -0800 (PST)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 71F4172C989;
        Mon,  5 Dec 2022 17:44:47 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 58F624A5058;
        Mon,  5 Dec 2022 17:44:47 +0300 (MSK)
Date:   Mon, 5 Dec 2022 17:44:47 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils] Experimental fsverity.test related GA CI
 improvements
Message-ID: <20221205144447.4mtmteolbvcabzzp@altlinux.org>
References: <20221201002654.2238906-1-vt@altlinux.org>
 <7db27896916a944d8e4a212cad23865166ceb9f4.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <7db27896916a944d8e4a212cad23865166ceb9f4.camel@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Dec 05, 2022 at 08:39:32AM -0500, Mimi Zohar wrote:
> 
> On Thu, 2022-12-01 at 03:26 +0300, Vitaly Chikunov wrote:
> > From: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > This does not make fsverity.test working on GA CI, though.
> > 
> > - `--device /dev/loop-control' is required for losetup(8) to work.
> > - `--privileged' is required foo mount(8) to work, and this makes
> >   `--security-opt seccomp=unconfined' redundant.
> > - GA container does not have `/sys/kernel/security' mounted which is
> >   needed for `/sys/kernel/security/integrity/ima/policy'.
> > - Enable `set -x` in CI as the logs is everything we have to analyze on
> >   failures.
> > 
> 
> Agreed, even with these changes the fsverity test will not be executed,
> but skipped.
> 
> However, the reason for them being skipped is totally different than
> prior to this patch.   Once the distros have enabled both fsverity
> support and are running a recent enough kernel with IMA support for
> fsverity, the fsverity test should succeed.
> 
> So the problem isn't the GitHub actions architecture or the fsverity
> test itself, but the lack of IMA kernel support for it.  In addition to
> the ima-evm-utils distro tests, there needs to be a way for testing new
> kernel integrity features.  Roberto's proposed ima-evm-utils UML patch
> set downloads and uses a UML kernel for this purpose.
> 
> Unless someone can recommend a better alternative, a single UML
> "distro" test could be defined and would be executed if a UML kernel is
> supplied.   Additional UML tests could be specified.

Just as an idea. I did some CI testing for LKRG on GA,
  https://github.com/lkrg-org/lkrg/blob/main/.github/workflows/docker-boot.yml
  https://github.com/lkrg-org/lkrg/blob/main/.github/workflows/docker-boot.sh

It's possible to boot in QEMU system created in Docker (alas without
KVM as GA does not support it). But this will install distribution's kernel.
So it would need to find distribution with the appropriate kernel.

Also, GA have cache functionality, so there could be dependent job
to build the kernel with required options and then save it into a cache
(to save time, bandwidth, and CPU resources).

And another possibility is, instead of using Docker it's possible to use
cloud images that many distributions have, and then same as with docker
(install or build kernel, save into cache and use in next CI runs).
Never tried this method myself. AFAIK this will require to use cloud-init
to set up system on first boot.

Thanks,


> 
> thanks,
> 
> Mimi
