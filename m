Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035DB6EC0D7
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 17:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDWPlH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 11:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWPlG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 11:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC5E51;
        Sun, 23 Apr 2023 08:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E18260F89;
        Sun, 23 Apr 2023 15:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A86C433D2;
        Sun, 23 Apr 2023 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682264463;
        bh=IhRUqd5X1Jj8by8pHQK9aPW4atIXcC1FX7AD4IwJxa4=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=i3BvtYHn2x3W5KZ0PmomtZWNK21rk22hm/VXqYV3o3FQdr3QF5AgAZiUrVD2dhoEE
         XZPmgBhFTMQMbxaH4yIR210NntvzvFXmOwFmuJNu1wMV3L6uG8+jecsPlqPSRpUNQ1
         INDCIgEYUN9ou/eym2nd3vt0zGc5p0y8fDP/AeypPPdLV/g0s6j/l9L/89JYby7+zP
         L9KXq1dfO2YeCYclDv0L4XTafu0+h59VDNkx9mPsqiOT0vl8fnJUGqVxOMGFkxmDa/
         bw83evunnOYVp+wqQ0D/a/iX04kw+5LcrmMo+AdGFCO0NKZlmZDj0ejmXIcDRCBZ7O
         jHk/GAqoPN2Dw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 23 Apr 2023 18:40:59 +0300
Message-Id: <CS48ZBNWI6T9.1CU08I6KDVM65@suppilovahvero>
To:     =?utf-8?q?Michael_Niew=C3=B6hner?= <linux@mniewoehner.de>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>
Cc:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <stefanb@linux.vnet.ibm.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jandryuk@gmail.com>, <pmenzel@molgen.mpg.de>,
        <l.sanfilippo@kunbus.com>, <lukas@wunner.de>,
        <p.rosenberger@kunbus.com>
Subject: Re: [PATCH v11 00/14] TPM IRQ fixes
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
 <4c094418-7725-b815-f1f9-8b12f1ac4d72@gmx.de>
 <c02493fac223707de39e44d51b0a0ce512565250.camel@mniewoehner.de>
 <20230319135338.c7k6r3ws6lby5qgv@kernel.org> <ZEK+w3Q++vu4Kl5x@kernel.org>
 <a93b6222-edda-d43c-f010-a59701f2aeef@gmx.de>
 <CS4767IVV0V2.2E9IH70NE7FGQ@suppilovahvero>
 <87d022be08cf911178cfb8182598a1689b050845.camel@mniewoehner.de>
In-Reply-To: <87d022be08cf911178cfb8182598a1689b050845.camel@mniewoehner.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun Apr 23, 2023 at 6:36 PM EEST, Michael Niew=C3=B6hner wrote:
> On Sun, 2023-04-23 at 17:15 +0300, Jarkko Sakkinen wrote:
> > On Sat Apr 22, 2023 at 3:59 AM EEST, Lino Sanfilippo wrote:
> > > Hi,
> > >=20
> > > On 21.04.23 18:50, Jarkko Sakkinen wrote:
> > >=20
> > > >=20
> > > > I tested this with libvirt/QEMU/swtpm and did the following tests:
> > > >=20
> > > > 1. TPM 1.2 suspend/resume.
> > > > 2. TPM 2.0 kselftest.
> > > > 3. TPM 2.0 suspend/resume + kselftest.
> > > >=20
> > > > I see no issues so I can pick this for my pull request.
> > > >=20
> > > > Tests were performed on top of v6.3-rc7.
> > > >=20
> > > > For all:
> > > >=20
> > > > Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > >=20
> > > > BR, Jarkko
> > >=20
> > > Thats great, thanks a lot for testing this!
> >=20
> > Thanks for the patience! I'm sorry it took so long but at least all the
> > steps in v11 make perfect sense and I see nothing that would rise red
> > flags. So we can land this with good confidence I think.
> >=20
> > BR, Jarkko
>
> I wonder, if it makes sense to submit this patch series to longterm and/o=
r at
> least stable?

it's a feature, so I don't think so.

BR, Jarkko
