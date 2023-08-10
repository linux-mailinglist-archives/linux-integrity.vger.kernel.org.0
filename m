Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4582777C4E
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjHJPh0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 11:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjHJPh0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 11:37:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1429C26B7
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 08:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A07E366030
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 15:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976B0C433C8;
        Thu, 10 Aug 2023 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691681845;
        bh=C8643SQYATJXOCK+gy5a21oMOmCfCm4rca7AbvzXS2M=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=NLyHjLHV7uFJEVeE/oGNx2RtVo1ZZQvAi2WfJFRUQiUm+KetFOH7AHHb5LkDHwxwy
         YaX68BKCXuVXk0fhyB0Pg1F3AfY7CZ18n1eB9un1yWZUA9oh7nGBgqlGQdKfyUL6NT
         bfd1LKX1FYwaq+3i71pQcIGPrAYl7ECBgXxSvEXTvggktDxnKN5CQ+y5Cnr05qiHZX
         QG2nQ2pzS8iSl6V0okAgS1/KL3s8KORk7LcgofJ99q5/Yj1XOEX09c6oXZfiB2SmA9
         WFclunoYU3j27tNRSn46RzcXyrULcjtIWduZzDWK5WMJBh6n41zKnIqrdvVOjti6U5
         KXDYbkZ/YTK2Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 18:37:17 +0300
Message-Id: <CUOZ5VOB1ECG.1KFQVQZES6ITA@wks-101042-mac.ad.tuni.fi>
Cc:     "Mario Limonciello" <mario.limonciello@amd.com>, <jgg@ziepe.ca>,
        <linux@dominikbrodowski.net>, <linux-integrity@vger.kernel.org>,
        <daniil.stas@posteo.net>, <peterhuewe@gmx.de>
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Mailer: aerc 0.15.2
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
 <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
 <ZNFv8f3r86zq3JSh@zx2c4.com> <f7f9be14-b5f6-4c2c-a4e3-8d44bfa4b36c@amd.com>
 <ZNGOpFbH43qQ/v5T@zx2c4.com>
 <CAHk-=whT2hf5f6SwK32J4cF2Yu+q9SZaO6JZVzBOsLz63uPW1w@mail.gmail.com>
 <ZNJ5IZjpOdOBFFja@zx2c4.com>
 <CAHk-=whQFZ=KqUWiFUP7s=t4tKs8Aga=Gq5LvS5Ugyk-nMTF1w@mail.gmail.com>
In-Reply-To: <CAHk-=whQFZ=KqUWiFUP7s=t4tKs8Aga=Gq5LvS5Ugyk-nMTF1w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Aug 9, 2023 at 8:06 PM EEST, Linus Torvalds wrote:
> On Tue, 8 Aug 2023 at 10:19, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Alright, looks like Mario took care of that:
>
> Ok, I just took that patch directly, so that we can close this issue.
>
> It's
>
>     cacc6e22932f ("tpm: Add a helper for checking hwrng enabled")
>
> in my tree, and I'll push out shortly after it's gone through my trivial =
tests.
>
>                   Linus

Thank you.

I'm still sending a small PR with fixup to disable tpm_tis irq usage
across the board tonight or tomorrow morning (GMT+3).

BR, Jarkko
