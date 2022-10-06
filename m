Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8EE5F6629
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiJFMgW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJFMgU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:36:20 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4CF85A8E;
        Thu,  6 Oct 2022 05:36:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A3BA73200805;
        Thu,  6 Oct 2022 08:36:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 06 Oct 2022 08:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1665059773; x=
        1665146173; bh=x/5eQeyF8wgxc3lBlMlLCE+D3SClhrVS+22aVr9TqjU=; b=q
        +sgP3Tc/y297yW5XXTzhrO4+Qo6cxIjnmKI3zcvscNQwafBSie53iKn3KCSwJfSu
        LC0WbgPyKW5Xc1UsQeJw3PwnECIjH8emzV0abYkXYxgCyh4Gif+antZgx7LNbqW/
        9ddmEF/4b1GoW4FR/glvrutlElogDrL8gehTfKvuFoMmfdaH8IUKwgLo3V5fqDhp
        32qlfia1GOqZZHrvoJbZln9rdSqlXgXoBI6QVb49px5nZOCs9Qkgp6CQQr3eLstx
        5n9t028e3VkD6mHwgaCLAwsPE3fQyy2exQFRWiILShrXZJPMQ54fDVu5LnvuXa1o
        tdXfQNwPw4cYE1X5fJARw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1665059773; x=1665146173; bh=x/5eQeyF8wgxc
        3lBlMlLCE+D3SClhrVS+22aVr9TqjU=; b=raTmo2i386qfqhru2VjLPvoZMtJmv
        nQQUiMPj6BWtWemO+UGjVXK8d9R+RQmHOFFWPV+rNcHEJY9k3pi2O7t4j3FPMCbE
        +KOHy9DafDsRDnMY62SGvTRuRIi+orJuaksZxtHJfDQfx91niWX1tZ/Ol1RqVVB7
        E9v9n7DveTFJTfHzGasj+FOQcQXoP+VhYB8lL95tZ1/DU3PWNghTYIxCUQSQYlAL
        FUrSyHDLa+0TIMVMpvWm9DTnTn887/j+xiXEBrCRIeY3IX6vcD39kiT/i2bkYFdO
        8SJYRtMINHRPKkewjt6UTPVgbti/V1PGgKReavF0D4ZQhQVulCmPhei3w==
X-ME-Sender: <xms:uss-Y1vYy2Vqs8hF-ULSkI7VRJTg5ui-mHr7WbUC_8PfV6Q0F4lqlw>
    <xme:uss-Y-f8BiJcJaRYQThmkup6rV_TuuP7O6V5dMhJpqiHDTSybh6J3nXc3I-bN9mPM
    4OA5ryUbinLOfVRNws>
X-ME-Received: <xmr:uss-Y4yQhTLgH2hwlyfhykGdjoe0LOt5x-YQ0KRx0v1n-odCTikP1z3yc3cK7_hZ1zRHEQXD_XIHNgX9J_GLvQeFXiSRLd3o903R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkrhhfgggtuggjfgesthdtredttderjeenucfhrhhomhepuegv
    nhcuuehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeduteehgfefudfffeelfffhheejgfdvfffhledvueekudeuieegueejieff
    vdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:uss-Y8O_r3BBxeFMpfHX33weeXb5KKr6skLM9dBoKh0TLy3GXSsvRQ>
    <xmx:uss-Y1-cJf9I8_HXk2-JQg_xeoQ4dFfS7l1r1V-Dl8O4Merzz4bJmA>
    <xmx:uss-Y8WK-3erQvyA7yRtCKK6hrIVzT3Fo7WJjEmsrGHY3cMikx92rw>
    <xmx:vcs-Y5Sbjc3jYNXO0uaAfqH0Nh35mLLSQDxdAnpMI3L5oTp3d7IyrQ>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Oct 2022 08:36:10 -0400 (EDT)
Date:   Thu, 6 Oct 2022 08:37:00 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     jarkko@kernel.org, a.fatoum@pengutronix.de, gilad@benyossef.com,
        Jason@zx2c4.com, jejb@linux.ibm.com, zohar@linux.ibm.com,
        dhowells@redhat.com, sumit.garg@linaro.org, david@sigma-star.at,
        michael@walle.cc, john.ernberg@actia.se, jmorris@namei.org,
        serge@hallyn.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        j.luebbe@pengutronix.de, ebiggers@kernel.org, richard@nod.at,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Subject: Re: [PATCH v0 2/8] keys-trusted: new cmd line option added
Message-ID: <Yz7L7KZ4WVW6XBmx@megas.dev.benboeckel.internal>
Reply-To: list.lkml.keyrings@me.benboeckel.net
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-3-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221006130837.17587-3-pankaj.gupta@nxp.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 06, 2022 at 18:38:31 +0530, Pankaj Gupta wrote:
> Changes done:
> - new cmd line option "hw" needs to be suffix, to generate the
>   hw bound key.

`Documentation/` is silent on this. Can you please add this there?

Other than that, is `hw` really a good name for this? Are there virtual
devices for these things that can make them not hardware in some way?
Is there a better name in such a case? Maybe something "device"
oriented?

--Ben
