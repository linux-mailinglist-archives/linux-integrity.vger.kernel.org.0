Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2977966C
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjHKRqj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 13:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjHKRqi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 13:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5D5EA;
        Fri, 11 Aug 2023 10:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 028F7660ED;
        Fri, 11 Aug 2023 17:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF924C433C7;
        Fri, 11 Aug 2023 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691775997;
        bh=XN8nt7rCjPkt81XRG6RpHmQBTg+fdjpZT4wKVdUETxY=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=Thpsz4WcFC/dToQwvNin+TcR6pHVkdz3vEH5keFi8J2R+nnI6HuoOe7jxwrfI3IOY
         sbjZekcSVe10HtLEirEuKBehS/TmbF3Af+XfBoEai0BSAEf0D/Q/55ojSjnWQISc5n
         6izRXa7GzWDP3vSwfM412XJ2cpbgYPsMEs4jFsGlUYKstf8vUsy8htJxaafBRZDPTP
         +DApiKNEJD3i4wtQVsgCA7lu5tQfpNL5dw+JJazZLwxioM6aFzrivdwmGdL08lhP63
         BvWKc6wxlEolsY3MM88j71UTW1GtqY7suidCfPAfs7NHWtGoT/m9ZgLQqM2r53IEW5
         NNci/KDEbmwbg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Aug 2023 20:46:32 +0300
Message-Id: <CUPWJDNTPO9V.1AVEKAAT1GQAO@suppilovahvero>
To:     "Grundik" <ggrundik@gmail.com>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>
Cc:     "Linux kernel regressions list" <regressions@lists.linux.dev>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Christian Hesse" <mail@eworm.de>, <stable@vger.kernel.org>,
        <roubro1991@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Christian Hesse" <list@eworm.de>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230710133836.4367-1-mail@eworm.de>
 <20230710142916.18162-1-mail@eworm.de>
 <20230710231315.4ef54679@leda.eworm.net>
 <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
 <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
 <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
 <fdd5fd9ece045ebd1888672a75f157e64ade98fb.camel@gmail.com>
 <a588d1d3-12e0-b078-b6cc-b0a63c54ab37@leemhuis.info>
 <fed7ec9d048c26e9526ccd909132c51e8e3e78cc.camel@gmail.com>
In-Reply-To: <fed7ec9d048c26e9526ccd909132c51e8e3e78cc.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Aug 11, 2023 at 1:44 PM EEST, Grundik wrote:
> On Fri, 2023-08-11 at 10:18 +0200, Thorsten Leemhuis wrote:
> > Jarkko & Lino, did you see this msg Grundik posted that about a week
> > ago? It looks like there is still something wrong there that need
> > attention. Or am I missing something?
> >=20
> > FWIW, two more users reported that they still see similar problems
> > with
> > recent 6.4.y kernels that contain the "tpm,tpm_tis: Disable
> > interrupts
> > after 1000 unhandled IRQs" patch. Both also with MSI laptops:
> >=20
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217631#c18
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217631#c20
> >=20
> > No reply either afaics.
>
> As I said before: it does not looks like blacklisting is a good
> solution at all.
>
> If there are general fix, then blacklisting only makes testing of that
> fix more difficult. If general fix works, why blacklist? If it does not
> work and its impossible to figure out why =E2=80=94 maybe there should be
> kernel boot option to select between polling/irq instead of/in addition
> to hard-coded blacklist.
>
> Unfortunately, its very hard to test this fixes on my side: since TPM
> is not a module, but compiled into kernel itself, it requires
> recompiling a whole kernel, which is quite a task for a laptop. But I
> will try my best, if needed.

I agree with this.

Can you check my response to Thorsten and share your opinions?

BR, Jarkko
