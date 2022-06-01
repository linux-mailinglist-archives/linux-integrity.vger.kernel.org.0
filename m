Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27761539B1A
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jun 2022 04:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349102AbiFACHB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 May 2022 22:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiFACHA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 May 2022 22:07:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C579A1B7
        for <linux-integrity@vger.kernel.org>; Tue, 31 May 2022 19:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1AC160AC6
        for <linux-integrity@vger.kernel.org>; Wed,  1 Jun 2022 02:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02551C385A9;
        Wed,  1 Jun 2022 02:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654049218;
        bh=zdGqzFAIQFqFeWUzjSIkJN2FvybnwxjvGvhGhYQj5Ng=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AnNjxj5ld0s+wPrRTmmS8qcFk98eMQyQNWBtTwad1ZbbQrawL4BQsWZun/JyV7zA8
         7/ACFtYZA9OVm6GkOtukbNHFKk3XcYXnj5rZ6MgbYsqIO4oiH0MYi4epUNd2ABIwKt
         iMEl22k3BnjFxk+uaiHWTOEL0FXffsRSmyPM3oLZngYZF76pp0NRxS+4FFl+BwtkF1
         tLbHjbSqP1oK2x0WHJS+ExMlP4t9ArEmHCmCla9vxcnozmjedr+yH8bWO+pUx5L4Ce
         1RbTD6sWgd5lYzzzaLnafAZQIjgOTHmLDIa7XB3DbGbEmzUi9v8/Zs3a6bPum+XaFb
         o36Vxd4eFUPrw==
Message-ID: <faf0156e6f735b2d7d793fbf48ae4c6a108e8eb1.camel@kernel.org>
Subject: Re: [PATCH] tpm: Add check for Failure mode for TPM2 modules
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Marten Lindahl <martenli@axis.com>
Cc:     =?ISO-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        kernel <kernel@axis.com>
Date:   Wed, 01 Jun 2022 05:05:08 +0300
In-Reply-To: <YpTiOdC2W6PaoI2R@axis.com>
References: <20220425102552.663069-1-marten.lindahl@axis.com>
         <3991049ce6859f51e5b61e94de269f4672a568cb.camel@kernel.org>
         <YmbDpMUtUK/NrXIY@axis.com> <YpTiOdC2W6PaoI2R@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-05-30 at 17:26 +0200, Marten Lindahl wrote:
> On Mon, Apr 25, 2022 at 05:52:04PM +0200, M=C3=A5rten Lindahl wrote:
> > On Mon, Apr 25, 2022 at 04:03:33PM +0200, Jarkko Sakkinen wrote:
> > > On Mon, 2022-04-25 at 12:25 +0200, M=C3=A5rten Lindahl wrote:
> > > > In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
> > > > TPM2 modules") it was said that:
> > > >=20
> > > > "If the TPM is in Failure mode, it will successfully respond to bot=
h
> > > > tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> > > > answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that T=
PM
> > > > is in Failure mode."
> > > >=20
> > > > But a check was never added in the commit when calling
> > > > tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode=
.
> > > > This commit corrects this by adding a check.
> > > >=20
> > > > Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> > >=20
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > >=20
> > > I think this should actually have the fixes tag. It's a regression,
> > > right? I can add it.
>=20
> Hi Jarkko!
>=20
> Just curious. I can't see this patch was added to linux-next. Was I
> expected to do something more to it?

No it's just me failing to do my job properly. I'll pick this and
make a 2nd pull request v5.19. Apologies.

BR, Jarkko
