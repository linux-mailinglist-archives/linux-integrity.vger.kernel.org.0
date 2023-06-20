Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1005B737223
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 18:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjFTQzt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jun 2023 12:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjFTQzt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jun 2023 12:55:49 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281E5E42;
        Tue, 20 Jun 2023 09:55:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9816D5C00D1;
        Tue, 20 Jun 2023 12:55:47 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Tue, 20 Jun 2023 12:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687280147; x=1687366547; bh=Sl
        3DEUe4Hjvy6NiO+rNUzCTrgSgWHmOtA4exakhcD4A=; b=fOECUpP3LAEmLX40jz
        tBg8we8WlxUXXqUHzSTwcmKM4Dyf23NAEeoKboiF8HOiFOykO9nENQ/jRjYvON22
        q6eh3AIJvF9zSNCM8Bx9AyBcdxV3CIft9LO/NWC8znq9Q32bkZljbNkmEmXiSX+1
        Z1ycpeoC/qPt12lK7JQCVDUV9kOKTYjDx/3I8rdccN0Pg36RZxdtS0SgRS0Ype7p
        AMmkuT3+wQFLVKIlY+4a3wBP15wONuOiWdm45lndWkskHlkiIZ3StEz9m+s23X5R
        U+bp+ko9tSAgEmADecSu6Wg6EoFBMGPPe2JNFWoiRyfvD7nQrvO2xJDAzYmbK/II
        SMkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687280147; x=1687366547; bh=Sl3DEUe4Hjvy6
        NiO+rNUzCTrgSgWHmOtA4exakhcD4A=; b=RSlWPg0O6+7vhXKIwKNiJ25oZJoZf
        wVeqVHyyUzQL7cNDc9PCqG41u+lbjElfaGdnm7zOmvnIesBO9O0UgFMgViv1buZp
        ETXHPr5a4wZW62OVJH803GwBCSz8pYPhqHUzsjsdEH+lE1ep/hzooSD8j6KsoTiN
        nipTY91JWYoYE1zO0wsW+Bg2E+EhJ6/TGX+qvW9QmBnwJJlkoAvZxdVjsac2KEsb
        03qnRLOQtgTMp0fE4xDG/yp0a/cSWE4Og5OHOaM7I5S3wDWhQ/hKyzNMGxOFLXfd
        Emiu7vKfI8gDQbBG7b/WIEZjv+ybQPOvdi2L7sXA+5UXC8JS2tTiWSIOw==
X-ME-Sender: <xms:E9qRZDUILdZhwbWrWTjFObdWSG36C0QUNB75eJNTP5FI3ekeqPpn4A>
    <xme:E9qRZLk4XnXgtlh3pLwILEkrkMsCqHlOLPRKC43lcm21WTWXaysrKh7-q6RpG-wFW
    bGKqg5RyyEEnEbk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefhedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeljeeuveeiffeuvdefhfekgfeuffejgfeuhfektdeuvdffvdeg
    vedvgeetleelfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgs
    uhhmrdhorhhg
X-ME-Proxy: <xmx:E9qRZPa0AFC_EGglKgYdHmqNpQTAo9T72KfQY4pSFAAZfRM1QZ9Jfw>
    <xmx:E9qRZOV8jR5lPtdmB2Vre6gTerj9Wrht7a0AB6Vj8w-KGMGpHZ9kNw>
    <xmx:E9qRZNmv0xWQQZJVinPR4WnSIM2oLZsLYQWykMF3dnhur_7iN4Qb5g>
    <xmx:E9qRZGDy_CDPWyBFQadtljHXcLUG4UdfcVhpzMpDYsUs5d4Vhq8BCQ>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5515B2A20085; Tue, 20 Jun 2023 12:55:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <8cb2e0a2-864b-4cee-bc71-544bf02eaf34@betaapp.fastmail.com>
In-Reply-To: <20230619221048.10335-1-ebiggers@kernel.org>
References: <20230619221048.10335-1-ebiggers@kernel.org>
Date:   Tue, 20 Jun 2023 12:55:27 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Eric Biggers" <ebiggers@kernel.org>, fsverity@lists.linux.dev
Cc:     linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        "Alexander Larsson" <alexl@redhat.com>,
        "Luca Boccassi" <bluca@debian.org>,
        "Victor Hsieh" <victorhsieh@google.com>
Subject: Re: [PATCH v2] fsverity: improve documentation for builtin signature support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On Mon, Jun 19, 2023, at 6:10 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> fsverity builtin signatures (CONFIG_FS_VERITY_BUILTIN_SIGNATURES) aren't
> the only way to do signatures with fsverity, and they have some major
> limitations.  Yet, more users have tried to use them, e.g. recently by
> https://github.com/ostreedev/ostree/pull/2640.  In most cases this seems
> to be because users aren't sufficiently familiar with the limitations of
> this feature and what the alternatives are.
>
> Therefore, make some updates to the documentation to try to clarify the
> properties of this feature and nudge users in the right direction.

FWIW,
Reviewed-by: Colin Walters <walters@verbum.org>

And I agree with your points enough that our project using fsverity will switch to documenting userspace crypto first.

I did spend a few minutes reading through `git log -p crypto/asymmetric_keys` and beyond the links to the bugfixes you already sent, I think you're clearly within your rights to add this text to the fsverity docs.  

