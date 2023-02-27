Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A00E6A4497
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 15:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjB0Ogi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 09:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjB0Ogh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 09:36:37 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9194520062;
        Mon, 27 Feb 2023 06:36:35 -0800 (PST)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B6BC42022A;
        Mon, 27 Feb 2023 22:36:29 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1677508591;
        bh=Dq2wTOEVHR/EtxLny++w+r/h2DyPA2HYeK440pfq4dY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Om9XQoDl4gpBz57iortqzD0YVwqkBCAYstx2EkAzAonoFovrXSG9y8yTLvpPbgC/E
         O6q8MvF9fngviij+ZJZoGnpRHFuCFYKON8nVcy+ZsGoGusW5oqFUkv5mTQHPSJwxQa
         7zcxuluO8LQQxZCqksBzvX/4cdrWTJVjTeGmJ/KOCSvTRAWyVjSqAzuKgxM81FARgZ
         WS1WKFJ76Tu2WC0W+qWS/fkbuWILOqFni1NOqaNQD/zKNTRl48/PcPaIabvMcVod1S
         W1FMLaOrMgyHUGQ3skq1s1Ss/uRHMUWshOUP4RdCx5pkqv8PHF3b+Mr1ZNrCfdYtmz
         5PDSF/Pknpw1A==
Message-ID: <c5d674bd67735de460b19fd955f718bf8b604c1d.camel@codeconstruct.com.au>
Subject: Re: [External] Re: [BUG] blacklist: Problem blacklisting hash (-13)
 during boot
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Mark Pearson <markpearson@lenovo.com>,
        Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Mon, 27 Feb 2023 22:36:29 +0800
In-Reply-To: <2a215e4d-bf55-b063-3f1f-a63f51cbdbfb@lenovo.com>
References: <c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de>
         <af0d6881-76c0-f570-0c5b-f664e261c4cf@digikod.net>
         <632d2180-02f8-4a5f-803a-57a6443a60f4@t-8ch.de>
         <12ceffb8-4e90-4eb5-2110-a0e69b412cea@lenovo.com>
         <fec5e8eb3803068a11267f386ddda389a1211736.camel@codeconstruct.com.au>
         <2a215e4d-bf55-b063-3f1f-a63f51cbdbfb@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mark,


> I've been looking at this and the FW team are claiming that it's not=20
> caused by duplicate entries in the dbx table, which is honestly a bit
> confusing.
>=20
> We've been doing some more digging - but is there a possibility this
> is caused by something else?

I can't quite trace where the EACCES is coming from, I can't see any
obvious causes there - the blacklist key type doesn't have an ->update
operation, and the assoc_array insert doesn't look like it would fail.

However: if I delete one of the duplicate keys using the bios UI, then
the number of errors logged decreases by one.

Cheers,


Jeremy

