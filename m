Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F646EC04E
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDWORn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDWORf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 10:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E461D9;
        Sun, 23 Apr 2023 07:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FBC661207;
        Sun, 23 Apr 2023 14:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C63C433EF;
        Sun, 23 Apr 2023 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682259360;
        bh=kQEraV2IoNz+cpAy+V4YEyMCX+50s5aHdtSWErZBi44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QX4gcmYxzR/ltkDAk5inIIH45ra6iqMsJIzSLzYoaELfiKgmejbJm5gBsu971DDFu
         vPvsxixEwZEZN0FCRyQVwDmOt6x7QOKeHB7KciiI6BVyo20SGLcekPLQ3VKrhZZv/5
         wAL4MBK9hJ0M2OX33VO5vU5fYPqsY6TVcaYoqqBX5mvr1tqr/CHL/hlACkO2nllpCC
         jCQ+MV8aI2FPSkqNkArR4WlRuY6yjiybKKQ6q34rEYsftB7F+IlA+lMIkoxT2gySxu
         aDDBjdL4IjxAfi8zg5XFV924V4JfHa4D72yDSx0k/vKOpJ3fnxU4MO2P7cxy5brtEB
         SNtWyQiEoYoIw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 23 Apr 2023 17:15:56 +0300
Message-Id: <CS4767IVV0V2.2E9IH70NE7FGQ@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lino Sanfilippo" <LinoSanfilippo@gmx.de>,
        =?utf-8?q?Michael_Niew=C3=B6hner?= <linux@mniewoehner.de>
Cc:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <stefanb@linux.vnet.ibm.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jandryuk@gmail.com>, <pmenzel@molgen.mpg.de>,
        <l.sanfilippo@kunbus.com>, <lukas@wunner.de>,
        <p.rosenberger@kunbus.com>
Subject: Re: [PATCH v11 00/14] TPM IRQ fixes
X-Mailer: aerc 0.14.0
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
 <4c094418-7725-b815-f1f9-8b12f1ac4d72@gmx.de>
 <c02493fac223707de39e44d51b0a0ce512565250.camel@mniewoehner.de>
 <20230319135338.c7k6r3ws6lby5qgv@kernel.org> <ZEK+w3Q++vu4Kl5x@kernel.org>
 <a93b6222-edda-d43c-f010-a59701f2aeef@gmx.de>
In-Reply-To: <a93b6222-edda-d43c-f010-a59701f2aeef@gmx.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat Apr 22, 2023 at 3:59 AM EEST, Lino Sanfilippo wrote:
> Hi,
>
> On 21.04.23 18:50, Jarkko Sakkinen wrote:
>
> >
> > I tested this with libvirt/QEMU/swtpm and did the following tests:
> >
> > 1. TPM 1.2 suspend/resume.
> > 2. TPM 2.0 kselftest.
> > 3. TPM 2.0 suspend/resume + kselftest.
> >
> > I see no issues so I can pick this for my pull request.
> >
> > Tests were performed on top of v6.3-rc7.
> >
> > For all:
> >
> > Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > BR, Jarkko
>
> Thats great, thanks a lot for testing this!

Thanks for the patience! I'm sorry it took so long but at least all the
steps in v11 make perfect sense and I see nothing that would rise red
flags. So we can land this with good confidence I think.

BR, Jarkko
