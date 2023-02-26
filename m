Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC8F6A2E2F
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Feb 2023 05:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBZE3V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 25 Feb 2023 23:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZE3T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 25 Feb 2023 23:29:19 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD1B2739;
        Sat, 25 Feb 2023 20:29:17 -0800 (PST)
Date:   Sat, 25 Feb 2023 22:28:56 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1677385754; bh=yl/hlBinxDM5IGBWq7H2QzpdT6RFq3YQQHzeNxTBwhs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=RvzQgNqjnaN+g4plpsbTMU5pBDfx0cdS1dMN0hYUB2DMwOuyZmr8wteJx6amX6jdZ
         VVrr1q5qCEvTYWzAH4lZWKGkFSdY2xqggR9AxzpE/WrtegXagd6D2VC6PRS9M5ym6j
         2rdVnEQWxOp7bjjmHjL9Zt4+/9L7+gTUwuDTY0q0=
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity@vger.kernel.org
Message-ID: <860048ca-d827-4319-9755-9b44ba3c4157@t-8ch.de>
In-Reply-To: <fec5e8eb3803068a11267f386ddda389a1211736.camel@codeconstruct.com.au>
References: <c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de> <af0d6881-76c0-f570-0c5b-f664e261c4cf@digikod.net> <632d2180-02f8-4a5f-803a-57a6443a60f4@t-8ch.de> <12ceffb8-4e90-4eb5-2110-a0e69b412cea@lenovo.com> <fec5e8eb3803068a11267f386ddda389a1211736.camel@codeconstruct.com.au>
Subject: Re: [External] Re: [BUG] blacklist: Problem blacklisting hash (-13)
 during boot
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <860048ca-d827-4319-9755-9b44ba3c4157@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Feb 25, 2023 21:42:54 Jeremy Kerr <jk@codeconstruct.com.au>:

> Hi Mark,
>
>> I have flagged this to the FW team (LO-2105) to get their feedback
>> and see if we can get it addressed on our platforms.
>
> Any progress from the FW team about this? I have a fresh-out-of-the-box
> T14s with this issue, there's 33 duplicated hashes in dbx:
>
> $ mokutil --dbx | grep -E '[[:xdigit:]]{64}' | sort | uniq -cd
> [...]
>
> - and so generating 33 KERN_ERR messages on boot.
>
> Given there's (at least) a few months' worth of GA machines with this
> issue, can we suppress the warning?

In 6.3 this message will be downgraded to a warning.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c95e8f6fd157b45ef0685c221931561e943e82da

A fixed firmware is still desirable, though.

Thomas
