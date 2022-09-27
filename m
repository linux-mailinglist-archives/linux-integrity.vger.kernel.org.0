Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C4B5ECA3B
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Sep 2022 18:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiI0Q6S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 12:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiI0Q6C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 12:58:02 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559ECADCEA;
        Tue, 27 Sep 2022 09:57:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 967875809C1;
        Tue, 27 Sep 2022 12:57:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Sep 2022 12:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1664297870; x=1664305070; bh=gk
        fETQGOUkN/p+KkeVW4lZaExlmLKRZn8wJCWXZOXRI=; b=sl/KntKinPRXzDDFxY
        luTWeO/SAjzn6ocbPDU+4KC12/bVB6ccIpBzxeskfUvDq2NgfLfP3ltMZX4+xa6X
        BhM0uzytzQN2YmEsxfOPgepG40v0MKaXtnPL3fujQWOK7fsXRv+lLYXEfTf8Ex6y
        LW+YRy64iVE2l+jp4KNKtXCxHGQRYUkmhkb6+tZrgjVrLfa5UlTvyQ8GWbNDMBSe
        iTpYp2NbuxpA4SC0WuhpORxMR7exRrXmD1CI+rCPyDCT5v0Bd4UykGSrpEdbDlTN
        pW6LoTYLKUq9Y057QwyPJdKta6TKAwUs+8WTuIuIPki55EHVRFtUq3rZF1mUWqF2
        sSMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664297870; x=1664305070; bh=gkfETQGOUkN/p+KkeVW4lZaExlmL
        KRZn8wJCWXZOXRI=; b=q6PBxVsB6TAiVJKjj7grNbonKK2ajkzvu/Dzd2TH3CFA
        hnLfkasV7cvf9QZxfOLarnnYK4fGDO+k/0vjt3ORJi3AYKxeDF2cHfdTtzgkZOA/
        bVWzsJkB/rtVBcG17iWEeLE/B16IzohQIu4UGywnXvxCXy0G3oVEs2Tu8U6fYPGt
        2F1d6esauHi1hMziOUxsKaOKag/bzfMP3IqBrCogwrG73VGlF+jc9EB9QKkBZVCo
        E6s8ewS0UBSQvkPpmfsqmmIFjuX2ddnMMMQXsV0J2jiUexlrYdBAiq0dfWhQ4D7V
        5X1QklITrS/WgLhZpKhKtd8fejhParaszKfQhyWxvA==
X-ME-Sender: <xms:jCszY4DySiXJMko8aH6ARcnYUKhk1nQi75b_4TxTydAkX-i5tBjsHQ>
    <xme:jCszY6hcvgxD2NlospONkVCWUqCc3PiXfrpm_LanOFkBoMSm7flrlvr4SDlb21x_l
    JQy-Yf_ouczQM4S9pQ>
X-ME-Received: <xmr:jCszY7m7jIY0Xy2HazcDIdh3ZA0Eo72olKfXUhzEFnmyCVMfBpkYLWaYlbg900Ic2HboBLBaREjLPih9_uSZNXwAkw9grUotXmJC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegiedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnheptefgvefgfffhveeltefhfeettdefgfelteefheetgfejfefgfeeigfeutedv
    ffefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:jCszY-yPA3xV8oQtg5ZtGJXt4TmA6x6rX1ngeAi_022fFsS3t8EEsg>
    <xmx:jCszY9QTppKQQ1N4lpPLZeDhBloVWFiXZ7EFUFrSGLpGxl6ntHpOvg>
    <xmx:jCszY5aF3UZCKkuN0OUZuydwsb0cgRuNUjIFsfCqkoEmX372jSuqmw>
    <xmx:jiszY6DAdqedfCLj4PUBmMx1pjlY_6_JFeLFpGgiurvmFr5Us6WkyA>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Sep 2022 12:57:48 -0400 (EDT)
Date:   Tue, 27 Sep 2022 12:58:43 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        apronin@chromium.org, dlunev@google.com, jarkko@kernel.org,
        Pavel Machek <pavel@ucw.cz>, rjw@rjwysocki.net, corbet@lwn.net,
        linux-pm@vger.kernel.org, zohar@linux.ibm.com,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>, jejb@linux.ibm.com,
        gwendal@chromium.org, Matthew Garrett <mgarrett@aurora.tech>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 05/11] security: keys: trusted: Allow storage of PCR
 values in creation data
Message-ID: <YzMrw3TASWemgRTh@megas.dev.benboeckel.internal>
References: <20220927164922.3383711-1-evgreen@chromium.org>
 <20220927094559.v3.5.I32591db064b6cdc91850d777f363c9d05c985b39@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220927094559.v3.5.I32591db064b6cdc91850d777f363c9d05c985b39@changeid>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 27, 2022 at 09:49:16 -0700, Evan Green wrote:
> From: Matthew Garrett <matthewgarrett@google.com>
> 
> When TPMs generate keys, they can also generate some information
> describing the state of the PCRs at creation time. This data can then
> later be certified by the TPM, allowing verification of the PCR values.
> This allows us to determine the state of the system at the time a key
> was generated. Add an additional argument to the trusted key creation
> options, allowing the user to provide the set of PCRs that should have
> their values incorporated into the creation data.
> 
> Link: https://lore.kernel.org/lkml/20210220013255.1083202-6-matthewgarrett@google.com/
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Reviewed-by: Ben Boeckel <linux@me.benboeckel.net>

Thanks!

--Ben
