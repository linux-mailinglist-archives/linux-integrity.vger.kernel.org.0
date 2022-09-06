Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B505AE900
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 15:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiIFNDy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 09:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiIFNDx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 09:03:53 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EC8402F9;
        Tue,  6 Sep 2022 06:03:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 66B4E5C015C;
        Tue,  6 Sep 2022 09:03:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Sep 2022 09:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1662469432; x=1662555832; bh=Lz
        rKfTcjNa2gAYtG7mObzCcMkmt+e+ZeVr16IOXkI9Q=; b=FB8R49WvUzxUAY/QLO
        0B9zWhxqPOcOOARwGkDoP+AV2rxDIvbksXX2HQ1MxlhDGOhAux7gNLeO3trSzct9
        5eKepMsdR9areu1huPQnDzP+NlU3kSYTffVIjle2HNL7UFe3KGxtCwcwDGYWYpKu
        UA7DHyfluQWS0ZWm7oyFKt3Em9cOegvepxi5D5Omw9qxMHKQPcGeRxe/Cs5KMnXp
        xmA3xAz3SgmA9hlfxp5ALpUFmqkTYkyarKaJREMxAaJjEBvL1QSbRBdDVOguRwiI
        FwF8Gu0uK5BfwHx0M+01quZZV2IHxNO/m3jh7BUqbounFvtRvlZNg/dqm4E0zRuW
        alnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662469432; x=1662555832; bh=LzrKfTcjNa2gAYtG7mObzCcMkmt+
        e+ZeVr16IOXkI9Q=; b=DkC18CJJBQMHbol50NFvQme1LFVGP4hVY/zkbPRqkZBs
        vDfLjOs/da6LoN/vFc0ZIxSjLidBprjIRhy9u//YxpAMAg2asob+CfpnPLeF+72f
        5cRguktNnuRsDKqlBA8EL4UVofEboXA8Ekbnen02OEUsJI4r7mDgOXPaVpnk30lg
        HyCxNJBxwTKmYvwjVHkHzJmhSinzLF+XJrDIaeuz4m3VIeYsZbUU/sI56ckoyNJZ
        TsROQy5GU/41Jh4q8p4tOcI35jHWq12giheZa+V+zK85pxCEXDGTIhXNyv5TZsBL
        TGqJelhOm9207irqMoyJxKrBJ5JRMCOvNS0mj95euQ==
X-ME-Sender: <xms:NkUXYyAp1P7aigflXTgkJmCI6fhYOtu_uK8ueNr9a0GmtdLn1kLZjA>
    <xme:NkUXY8hevg6TLba2niZSV4APsBU0KlcVK3lRsUh505kEjtiHE98kK4joVgmeJ3FOi
    NKqOIMwKTN1cHuyyGI>
X-ME-Received: <xmr:NkUXY1lj9heGLCHl3_QB1xuVBmqB2tEYLORXu-XJkzrv45_ebAotMoBAnt2etD8uRQdXCxBgAKfmJlwZwlZr4Oy2tET8l5GHMq5H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelkedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnhepffelgeffveelkeffkeehiefgtdeluedvtdfghfdtvdefgfejheffudeuveek
    vddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    gvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:NkUXYwyvGZrad7T064RRoQ1OLHM5awoNeUvRS4HgNBUPN68MoT5RFQ>
    <xmx:NkUXY3QUiLPv4Y0m-uWgx8S_KBnq6chwfoU_TmTU5NjEls7o6JXxyA>
    <xmx:NkUXY7aJJ6e1n25wwg3yB9KwZKABSwsKKBcz63Pz-c9kK55rRKGzxw>
    <xmx:OEUXY_qqGV1JoBS2ZntZv3x-SeYrR6BEioLbT5zviEaPBp9kjzWf1Q>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Sep 2022 09:03:50 -0400 (EDT)
Date:   Tue, 6 Sep 2022 09:03:48 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     jarkko@kernel.org, a.fatoum@pengutronix.de, Jason@zx2c4.com,
        jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        sumit.garg@linaro.org, david@sigma-star.at, michael@walle.cc,
        john.ernberg@actia.se, jmorris@namei.org, serge@hallyn.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        j.luebbe@pengutronix.de, ebiggers@kernel.org, richard@nod.at,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Subject: Re: [RFC PATCH HBK: 6/8] KEYS: trusted: caam based black key
Message-ID: <YxdFNIYcD1QO7mtC@farprobe>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <20220906065157.10662-7-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220906065157.10662-7-pankaj.gupta@nxp.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 06, 2022 at 12:21:55 +0530, Pankaj Gupta wrote:
> - CAAM supports two types of black keys:

What is a "black key"?

>   -- Plain key encrypted with ECB
>   -- Plain key encrypted with CCM
>   Note: Due to robustness, default encytption used for black key is CCM.
                                     ^^^^^^^^^^

"encryption"

> - A black key blob is generated, and added to trusted key payload.

Missing "the" before "trusted".

--Ben
