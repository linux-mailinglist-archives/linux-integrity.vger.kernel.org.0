Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0621770C39
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Aug 2023 01:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjHDXI6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Aug 2023 19:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHDXI5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Aug 2023 19:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197C4C2D;
        Fri,  4 Aug 2023 16:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D2AC6215E;
        Fri,  4 Aug 2023 23:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B705BC433C8;
        Fri,  4 Aug 2023 23:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691190535;
        bh=kBeQRrMgrEtvZCzBKnTEH/D5NSJwd5w8LEJQ2UzOxiI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=lGzI1lBTrtG3N66S2MX3IvN+Afq2ksM2OiwAbW/fnG+PG6/ZZXSD62anoE3xpqcDK
         ArbI0nPUsiqYbKNfQfF5QPux+9ihNyh4Keoag1rXLtH5myCt1OhHo2FBRMvIpEsRCc
         eXTdekgg6CjarpqP9bl7//XwL1kxAIXnB9n3WdY6IKSncGKTfR/e8MkpQ/J40BVcgy
         +uAA57K866bP3Jtk042zyNx5ljLXDWQsucc5q4l8338yj6pRti3VzPzk8vejhDAtZp
         LtD/saLCvU8uVVoWZitq2i74Ccc7dyKlcCFFls+Co2mXjbQCx+cdM//JfbRzWYaFQW
         Ochmw840ioSew==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 05 Aug 2023 02:08:51 +0300
Message-Id: <CUK50CNOK83S.3BRAZR7NV5T5I@wks-101042-mac.ad.tuni.fi>
Subject: Re: [PATCH v2] tpm: Disable RNG for all AMD fTPMs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Mario Limonciello" <mario.limonciello@amd.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        <linux-integrity@vger.kernel.org>,
        "Daniil Stas" <daniil.stas@posteo.net>, <bitlord0xff@gmail.com>,
        "stable" <stable@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20230802122533.19508-1-mario.limonciello@amd.com>
 <ZMuvhEwN41qEhY9r@zx2c4.com>
 <CUK1R4XYQYE0.H9RI2VM350XF@wks-101042-mac.ad.tuni.fi>
 <CAHmME9oSrnGYpHsZQYFqVmy1mojAdKhxEQUQLf2+91f34jZezQ@mail.gmail.com>
In-Reply-To: <CAHmME9oSrnGYpHsZQYFqVmy1mojAdKhxEQUQLf2+91f34jZezQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Aug 4, 2023 at 11:41 PM EEST, Jason A. Donenfeld wrote:
> Please don't. Instead take Mario's v3:
> https://lore.kernel.org/all/20230803182428.25753-1-mario.limonciello@amd.=
com/

Sure! I noticed it.

BR, Jarkko
