Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C359F8E1
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 13:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiHXL4y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Aug 2022 07:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiHXL4x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Aug 2022 07:56:53 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9102889906;
        Wed, 24 Aug 2022 04:56:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EE9B2580E11;
        Wed, 24 Aug 2022 07:56:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Aug 2022 07:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661342208; x=
        1661349408; bh=kuW/qG4JUmJmu4VzPx61uemjjFalqwyag3kx6XOqPOE=; b=o
        pzymONiwjq65ETafTTr380XapsmSk8TEgFCze/PUAxebjOab59cPNdRbW5I2P5Gc
        nPQKG4YPRvE++LJQ7/t27UluedPOuvs7txqtYryRE+szjSSAdEz19GlMLM1fa1p6
        Lg/mfnoslm76AnTcRYz7PmDQ5au0tb4YrubBbqIOCcVqACJIEF1WwW2wzdBGfYTH
        BXkh+6ZCAdLIsKeQVByEzhFgw3NWWTIOIlCMIEHIQH1MV5kOQRubdSY99Qj/x+wX
        a6Z931m4w51+xL+9hCbzbx9OFA/lOBTWB6kJ5BgCfd1Y/F2Y8xHr7Dw72Drfi2s2
        wPa7i8fGjQDU2jFbAkIUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1661342208; x=1661349408; bh=kuW/qG4JUmJmu
        4VzPx61uemjjFalqwyag3kx6XOqPOE=; b=BKd1EmuvOpNnAIpXPJJFjSIkFigeG
        5WPP3Ibfqgn6f+nabolef24CZ62iA40nUXTpU69mHIajgRUJeaPdZKqeeRby1+7R
        OImR1Cgp49wc6MKbmxueF2Z4rhcVmtBgvDlP/buckg88nSZoV8AGAqyo74MWqQWf
        cL1vExQMPfwMqwL+3Wstn11DI/v16iRCvmxGkFPGKdv8aY0nVGLRVfm80jl6tV9K
        qPyRmPnvGD414awHxysN3ma/36/3b0er2sKgT8h0nmLSufblmsK3v4OnfSTC95+6
        BcUAijw6ggfn3y6AtnoNC1NJ9cKi4J9GoNmGp1ALRk7N50KuUdDpNfyuA==
X-ME-Sender: <xms:_xEGY0_3uaGI0slJdDTlozWfU31KwX4m5ySru_WAamPhEnUYzqSV-A>
    <xme:_xEGY8tiKbf9JBRjzog0znkRGzDefHS3WnHdFVEBCMKmsLdH9SQJ6b2uc62_Qe1xZ
    cV2XmWuz87kQXoF2PE>
X-ME-Received: <xmr:_xEGY6DK5T_2PH1z13eyzdjJ9YNA8GuZGlXSmB5eqnWH6GQ4xp9GjLffVaerb7T17LbiNi7_s13F35Zf7pRmNE5f4cKJTeCsrgM7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkrhhfgggtuggjfgesthdtredttderjeenucfhrhhomhepuegv
    nhcuuehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeduteehgfefudfffeelfffhheejgfdvfffhledvueekudeuieegueejieff
    vdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:_xEGY0dyRnm6I5p5ONdvswQuoH911Qcv4k4ImGelq3Uch2wdQt5f_w>
    <xmx:_xEGY5M2YhW9IUMVZJ6XQ-y_7KCZgHrFbMNy0dM51kOr9oKnXhoY0w>
    <xmx:_xEGY-nqQ6Kt_ul1NcmJNFISyhWSNz1xNbbNexnw5rJRg1E6x27NzA>
    <xmx:ABIGYw_lH9x1hUhEBWjBASxkZJlyL74M8KEWiyffntejBaufUpUfTA>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Aug 2022 07:56:47 -0400 (EDT)
Date:   Wed, 24 Aug 2022 07:56:46 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 04/10] security: keys: trusted: Allow storage of PCR
 values in creation data
Message-ID: <YwYR/rzvrkvgZzBm@farprobe>
Reply-To: list.lkml.keyrings@me.benboeckel.net
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.4.I32591db064b6cdc91850d777f363c9d05c985b39@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220823152108.v2.4.I32591db064b6cdc91850d777f363c9d05c985b39@changeid>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 23, 2022 at 15:25:20 -0700, Evan Green wrote:
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 0bfb4c33974890..dc9e11bb4824da 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -199,6 +199,10 @@ Usage::
>         policyhandle= handle to an authorization policy session that defines the
>                       same policy and with the same hash algorithm as was used to
>                       seal the key.
> +       creationpcrs= hex integer representing the set of PCR values to be
> +                     included in the PCR creation data. The bit corresponding
> +		     to each PCR should be 1 to be included, 0 to be ignored.
> +		     TPM2 only.

There's inconsistent whitespace here. Given the context, I suspect the
tabs should be expanded to spaces.

As for the docs themselves, this might preferrably mention how large
this is supposed to be. It seems to be limited to 32bits by the code.
What happens if fewer are provided? More? Will there always be at most
32 PCR values? Also, how are the bits interpreted? I presume bit 0 is
for PCR value 0?

Thanks for including docs.

Thanks,

--Ben
