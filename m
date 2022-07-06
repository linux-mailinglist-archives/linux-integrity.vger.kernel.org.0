Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2629F56873C
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jul 2022 13:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiGFLsP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jul 2022 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiGFLsO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jul 2022 07:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0765C27FD6
        for <linux-integrity@vger.kernel.org>; Wed,  6 Jul 2022 04:48:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9623561EA0
        for <linux-integrity@vger.kernel.org>; Wed,  6 Jul 2022 11:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9A3C341C0;
        Wed,  6 Jul 2022 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657108093;
        bh=48bioGnGY1JJCCO13fIsPNCPQ93GS2y3jjmFl/TadSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tain4dCIXeFWGWV9v7Ak8geP3KCn+yU9JP6xkUakSFNcSlYji8Y32xtZyVJnXgJH+
         mPWA0M28GBAztHM7tE2fU2Ben/T6vIXGi1iUcs2pj83iPzmW3phcTmtR4DiLt/Bcmc
         mYpSym7JuhoD9M3nRBxAEX75DlSMcIukY4WgtmNe7yjJgeRX5KCLg1zUElsIhV57mB
         jIzPjFCPzSbo5zeoTYa4xe6JbVnUYBoPdFUQH0kQoamrF6Un22v6HR9xSA4i/72Spu
         LjVkbKFvr+aj1qO14xLQAcz/yGhJasL7xRR/35yGLt7JUwlVI0m67ouJ0DB3cTdcQF
         SH/OHaXabz6aw==
Date:   Wed, 6 Jul 2022 12:48:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to
 verify kexec'ed kernel signature
Message-ID: <20220706114806.GB2403@willie-the-truck>
References: <20220704015201.59744-1-coxu@redhat.com>
 <711440de6340ef6ad73e4db5edd36fc391b8a11d.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711440de6340ef6ad73e4db5edd36fc391b8a11d.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 06, 2022 at 07:35:36AM -0400, Mimi Zohar wrote:
> On Mon, 2022-07-04 at 09:51 +0800, Coiby Xu wrote:
> > Currently when loading a kernel image via the kexec_file_load() system
> > call, x86 can make use of three keyrings i.e. the .builtin_trusted_keys,
> > .secondary_trusted_keys and .platform keyrings to verify a signature.
> > However, arm64 and s390 can only use the .builtin_trusted_keys and
> > .platform keyring respectively. For example, one resulting problem is
> > kexec'ing a kernel image  would be rejected with the error "Lockdown:
> > kexec: kexec of unsigned images is restricted; see man
> > kernel_lockdown.7".
> > 
> > This patch set enables arm64 and s390 to make use of the same keyrings
> > as x86 to verify the signature kexec'ed kernel image.

[...]

> > For arm64, the tests were done as follows,
> >   1. build 5.19.0-rc2
> >   2. generate keys and add them to .secondary_trusted_keys, MOK, UEFI
> >      db;
> >   3. sign different kernel images with different keys including keys
> >      from .builtin_trusted_key, .secondary_trusted_keys keyring, a UEFI db
> >      key and MOK key
> >   4. Without lockdown, all kernel images can be kexec'ed; with lockdown
> >      enabled, only the kernel image signed by the key from the
> >      .builtin_trusted_key keyring can be kexec'ed
> 
> Just confirming, for arm64, this patch set allows verifying the
> kexec'ed kernel image signature using keys on either the .platform or
> .secondary_trusted_keys keyrings.

It looks like this series is ready to go, but it's not clear who should
pick it up. Eric -- would you be the best person? Otherwise, I'm happy to
take it via the arm64 tree (on its own branch) if that would be helpful.

Thanks,

Will
