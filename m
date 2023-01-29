Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0A867FF4E
	for <lists+linux-integrity@lfdr.de>; Sun, 29 Jan 2023 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjA2NGg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 29 Jan 2023 08:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjA2NGg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 Jan 2023 08:06:36 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8231821972;
        Sun, 29 Jan 2023 05:06:24 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B32E73200A1B;
        Sun, 29 Jan 2023 08:06:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 29 Jan 2023 08:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1674997581; x=1675083981; bh=WI
        iGLgM5lUUCvnAd3EHS+Z21BQAFwL9/K1vm6nT+YhA=; b=PW8eXYcheY6Y9fo3Yu
        mUYKMIxsk32kgz57TyqPAfKAdxjn+LjeM2VqQZo69N1PYrrHfrYB0Y4nnfUtG0/7
        CHfajPws6cFE6pIsYh1ywmsiCxnNvF0cZTczSN7mitunjjqT0FjIPxFLQNCGUXx+
        EvMKIS/fRBRqVoWfOE1YN6PH2g8Nfj0aPpSDu8r4+o3GhElOlmRgzTBlgV3mS8k3
        UHaredj6sp00CFf4nQymEB5HpWs1IGWub1NGqewvRQLnscesf2h1Idon7kH3vOPh
        yMPCQ5X3iGT561CJT5xyDJDodMmzxdubkWkqG403p7zapbmC8IwbV79F/RzY8fln
        1joQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674997581; x=1675083981; bh=WIiGLgM5lUUCvnAd3EHS+Z21BQAF
        wL9/K1vm6nT+YhA=; b=Eno7DSIRShLpNPQ4vKqL1cLFsWPhgf16E7fdeSLbbYEL
        CH3raKl7+0DxzOjudi2t3W8Th0KbYqgQOY0YpwIYIGvTkUPpq71c/Q1SBwbsuiMj
        nyNVaWRMCC5kB7tKiaFg6N5Ij9jJdQ3UkAgZw7hEQ9v2CmUdiWvDpsilhOSMa4fW
        0UneFY4GaYZVKQdwGfA7dmHSWKdaiBQmvJZb6uA5u7CxoivGGJEcyq7d5NMazuIN
        WmOGj2dlL+gOPXq6VXFDM2cIbEWHiaVT3hAHUEXRaTungIlWiHTUEuAsmV8kIgxg
        tmIiSbDt8YBoMkQA0joEqZGFN/JiM5mkcQyZKeX5hA==
X-ME-Sender: <xms:TG_WY3Mdd7DJGS1v6XPW9TWsCrARL5n0xr5bL7aUIU7nBKBFzezTHw>
    <xme:TG_WYx_4Jk-oo-dQVzDBJIfP0i47wRloYeId_5HnTlEV7EyT9WrnUP2Td1dqP2GSK
    MCaz8hHyJQD_K0El4o>
X-ME-Received: <xmr:TG_WY2TXd0wROLw3w98VQ-f97d-Bzo1EwI3D-Nf5zHih2-QiJ-vUMhagFrO4viKjOSvqjNVy36R1ozRn5WSAdrpSTxl5Zpo_3sv_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeftddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnhepffelgeffveelkeffkeehiefgtdeluedvtdfghfdtvdefgfejheffudeuveek
    vddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    gvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:TG_WY7v5nceOQDLuJ0Y7k-9at4kINlkm2iT0nnRuH4U_3LMDn6eU0A>
    <xmx:TG_WY_caSYviY8yajfVUUBRoblnsUzMWq-_eySNIbWcxOe-Qo_SChQ>
    <xmx:TG_WY30B9Yq7Hu1f-5KrN2P3UqGEzVAFKLgZ68mMtEjL_3aGgoZBhA>
    <xmx:TW_WY745O9WeSaElaNcnl48Fo8aLOu-z1FBD4BvGDT-2TEDHqyAbZQ>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jan 2023 08:06:20 -0500 (EST)
Date:   Sun, 29 Jan 2023 08:06:19 -0500
From:   Ben Boeckel <me@benboeckel.net>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 09/11] KEYS: trusted: Add session encryption
 protection to the seal/unseal path
Message-ID: <Y9ZvS9PozyX5AxpZ@farprobe>
References: <20230124175516.5984-1-James.Bottomley@HansenPartnership.com>
 <20230124175516.5984-10-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124175516.5984-10-James.Bottomley@HansenPartnership.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 24, 2023 at 12:55:14 -0500, James Bottomley wrote:
> If some entity is snooping the TPM bus, the can see the data going in
                                          ^^^ they
> to be sealed and the data coming out as it is unsealed.  Add parameter
> and response encryption to these cases to ensure that no secrets are
> leaked even if the bus is snooped.
> 
> As part of doing this conversion it was discovered that policy
> sessions can't work with HMAC protected authority because of missing
> pieces (the tpm Nonce).  I've added code to work the same way as
> before, which will result in potential authority exposure (while still
> adding security for the command and the returned blob), and a fixme to
> redo the API to get rid of this security hole.

--Ben
