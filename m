Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EB670EB8D
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 04:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbjEXCwf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 22:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjEXCwe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 22:52:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E22139;
        Tue, 23 May 2023 19:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 307E263822;
        Wed, 24 May 2023 02:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63644C433EF;
        Wed, 24 May 2023 02:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684896752;
        bh=8pknsu26G/MZFoo3umZIWDOGFjEyKKgnX58CS1U2u8I=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=D3j2XYr4Ab1zXbSEdoRyP1mDfCVJuxB/8L1S1td0JKTtFMXSmSZkdQc+GQbWRTitX
         rOHdNoP7G/QBnHzhnCtDe0GSLS/C9BUZAJUUgG+0s0Eb2cWNXH1Vjg8+k3EMv41TeP
         qSGP7tygfPalJxvMHbXBloV2eAobnU+4iHRCvZMncebVYkj0Mk5sI0PIhTsoKYEjXb
         Cn02s5kV0rKtaYLjiCoU+saMFnjkzul/+PH+gP6tLGkl1PVYIO6VpG8b1uYl0W34gS
         l4VsmfQTT+CXJJ/4o7nJszplPI+I9sp98dnlAAvgElvAGu+sft3sWsQagiXkwHCiNn
         NHzKpwqDpftJw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 05:52:29 +0300
Message-Id: <CSU61T6XP2L8.3RHK45A4J0C2C@suppilovahvero>
Subject: Re: [PATCH v2] tpm_tis_spi: fix:release chip select when flow
 control fails
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Paul Menzel" <pmenzel@molgen.mpg.de>,
        "Peijie Shao" <shaopeijie@cestc.cn>
Cc:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230522070140.33719-1-shaopeijie@cestc.cn>
 <7840f8c2-a903-7d80-c4bd-8568ad1c8682@molgen.mpg.de>
In-Reply-To: <7840f8c2-a903-7d80-c4bd-8568ad1c8682@molgen.mpg.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon May 22, 2023 at 11:17 AM EEST, Paul Menzel wrote:
> Dear Peijie,
>
>
> Thank you for your patch.
>
> The fix: tag in your commit message summary is uncommon. I suggest:
>
> > tpm_tis_spi: Release chip select when flow control fails
>
>
> Am 22.05.23 um 09:01 schrieb shaopeijie@cestc.cn:
> > From: Peijie Shao <shaopeijie@cestc.cn>
> >=20
> > The failure paths in tpm_tis_spi_transfer() do not deactivate
> > chip select. Send an empty message (cs_select =3D=3D 0) to overcome
> > this.
>
> Does the standard require to deactivate it?
>
> A note on your test setup would be nice to have in the commit message.

I think it is "good enough", not to say it couldn't be improved.

I can accept as it is, or substitute with one with an updated commit
message. This is going earliest to v6.5.

BR, Jarkko
