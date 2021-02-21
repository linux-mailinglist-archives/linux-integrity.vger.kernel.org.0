Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689A0320D4C
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Feb 2021 20:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBUTpo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 14:45:44 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:54133 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230401AbhBUTpi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 14:45:38 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 17C6E58024F;
        Sun, 21 Feb 2021 14:44:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 21 Feb 2021 14:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=KK7U3PtBaDBEZQddjEEuQxaWjx0
        rOhXM1pRTOxjzCQ4=; b=QhEAa3a0K46bSjQTH6GKygCzlEvzxjwWPdriVPwLeDj
        CKwWlpU/pChFf26OIIu/C6C3VS89XiijU8lJaProgZi5XdSrsBvpQcyWQ+BERJeF
        JUGjZZIiIMb0oxeltg/xPZtgOCHdsOiv52h72eAdV0YmXA7qWSgsa5zE17WPun5Z
        gr8B/HPtHI+fuRYRiB3fIxzlM0xzVt1ztadCgF5r4s2L+tZxMK18MGqeNsodFI5T
        msiGzegsmXh/dxvDUKyF/ypH7BxUGNV7Biu8GiWkuR+TzGuMuaWHnE7oTQ7P78Ah
        xAUgTvD5dCaPIcGaYDSYsPYZi3uYzNFxULzhfADQfZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KK7U3P
        tBaDBEZQddjEEuQxaWjx0rOhXM1pRTOxjzCQ4=; b=DizqxHw0MABc+iOWp01mCF
        /OgT2nN9Cg6gAVUoS0L9YTEXweK1TBAMJEDJLJLXW44TywJrVcZE8ZK/JzlzWy0x
        7G175BK9mIk4FCA6sNIwOzIvTfoPB5heq/2yPMoKeGfzRyswMgeY/yOtUAdEyBJs
        UOQzvRuXw3nTtmJmX83lsdd/CBxSC5jn3TkNWJr7RLm9drjhvMJfghJ34tQcfUUH
        MbwIkcrHZkSqJCln4bAulOv/AtvkeL7/++GMWZmOkHd8L9fi7d+0Np5LYbx9FQvY
        AAUHaeldqDJVAMzazTEba3vEYCrwbLg2kCg0IzsbRrUxC7GttxKDkwiMk/RsLHTw
        ==
X-ME-Sender: <xms:H7gyYMldXQ6DGPWP5EWDuTS-IyBlqvrK_JwMlFcUDWHvGRPvdR-TxQ>
    <xme:H7gyYL2gRQvb0OcMgNVezevKdRrv2EGY0ZEBZdR1U9hGFKuFLRfTaXEPGKnlPLDHE
    LFlHbu5PaEjtB3VoJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkedugdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttderjeenucfhrhhomhepuegvnhcu
    uehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrghtth
    gvrhhnpeevffdtteetgfdttdekueefgedttddtueeugeekgeetffeuteffjeduieehhfek
    tdenucfkphepvdegrdduieelrddvtddrvdehheenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:H7gyYKqWq2bEioLxV_3YlbkV63Y470jUh42eAX3Py6iJ6LuS0bfC4Q>
    <xmx:H7gyYIlOB3Z6WGliVPjPs9VJQZok_BGYHwBWDUCzQwYccUKvJ-jVjA>
    <xmx:H7gyYK1KO0JXYJgS2ViHqxdwGA78kH4i1xiP-uvJSwEXoll7x6WkXA>
    <xmx:ILgyYLJ9daWXOZ4vap6fCZc64eFD44wSh_bNpRST-bmsx5Ndt4mYbQ>
Received: from localhost (unknown [24.169.20.255])
        by mail.messagingengine.com (Postfix) with ESMTPA id 62DBA1080063;
        Sun, 21 Feb 2021 14:44:31 -0500 (EST)
Date:   Sun, 21 Feb 2021 14:44:29 -0500
From:   Ben Boeckel <me@benboeckel.net>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net,
        rjw@rjwysocki.net, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 5/9] security: keys: trusted: Allow storage of PCR values
 in creation data
Message-ID: <YDK4HYZjHUdZ3GkL@erythro>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-6-matthewgarrett@google.com>
 <YDB9U2oyt0fmvLDF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDB9U2oyt0fmvLDF@kernel.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 20, 2021 at 05:09:07 +0200, Jarkko Sakkinen wrote:
> Something popped into mind: could we make PCR 23 reservation dynamic
> instead of a config option.
> 
> E.g. if the user space uses it, then it's dirty and hibernate will
> fail. I really dislike the static compilation time firewall on it.

I don't know the threat model here, but couldn't hibernation then be
blocked by userspace using PCR 23 in some way (thus becoming a Denial of
Service)? Are elevated permissions required to use PCR values?

--Ben
