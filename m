Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FFD74E03B
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 23:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjGJV3T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 17:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGJV3T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 17:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3B7DE;
        Mon, 10 Jul 2023 14:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B99BF6113E;
        Mon, 10 Jul 2023 21:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB6C433C8;
        Mon, 10 Jul 2023 21:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689024557;
        bh=dtD3GyK11fAqYBP+J3dFc7pAiI6iNRFdGJzYuCQgyOE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fxPYvTaZ8ymVbYXdUNz8785prZugYpJAUTGuwVx40ES+aYl+/1l7NxKK+A5Rbz1bo
         w3vSFVCUp/jHJP/LpZ8o8t6DLczEY5m8sionoS9wwAXB2xkOQFNJLBkYW2n2CP7cCv
         wHBzfZYjcIE8py83utUHMrhyh4mMNnrFE4/MLTAagnkWCJdOVPv6S7mG2tnWaj2rlV
         alD7UpSWWh9vGuY6BSYF3xfxa6aOhMxOy/Ko4m0TwKktcqu9Ds7/T+Ja7v903mktOF
         ld2iQ17pcPY1IPF4iWRTafquXiD/rdZB9n4xaRAr38blf9J56yNF+5fEAErbjdSIC4
         1lJjozq9CePwg==
Message-ID: <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Christian Hesse <list@eworm.de>, linux-integrity@vger.kernel.org
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jul 2023 00:29:12 +0300
In-Reply-To: <20230710231315.4ef54679@leda.eworm.net>
References: <20230710133836.4367-1-mail@eworm.de>
         <20230710142916.18162-1-mail@eworm.de>
         <20230710231315.4ef54679@leda.eworm.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-07-10 at 23:13 +0200, Christian Hesse wrote:
> Christian Hesse <mail@eworm.de> on Mon, 2023/07/10 16:28:
> > This device suffer an irq storm, so add it in tpm_tis_dmi_table to
> > force polling.
>=20
> Uh, looks like this is not quite right. The product version specifies the=
 CPU
> "level" across generations (for example "i5-1240P" vs. "i7-1260P" vs.
> "i7-1280P"). So I guess we should match on the product name instead...
>=20
> I will send an updated set of patches. Would be nice if anybody could ver=
ify
> this...

OK, this good to hear! I've been late with my pull request (past rc1)
because of kind of conflicting timing with Finnish holiday season and
relocating my home office.

I'll replace v2 patches with v3 and send the PR for rc2 after that.
So unluck turned into luck this time :-)

Thank you for spotting this!

BR, Jarkko
