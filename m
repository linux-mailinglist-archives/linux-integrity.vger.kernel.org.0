Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C128A6A3636
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 02:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjB0Bmo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Feb 2023 20:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB0Bmn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Feb 2023 20:42:43 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B93A11644;
        Sun, 26 Feb 2023 17:42:42 -0800 (PST)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 117952003E;
        Mon, 27 Feb 2023 09:42:40 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1677462160;
        bh=t8Y/0oReh9Y8o+O3hMl5s2yRIWqSmv7FKI4yv0RdW+k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=cM8HqswmGuQ17SQ3m6NCv9PX1IPiZh4lVUH91a8jesK3i7Zr/1Kt/cz+dDJl+IiVE
         ieAmiqE5Ei4/1pyBs8xa2WaAnCTvqua8nPFDH8MRX4NDHosgGnQ16QMKwKu/IgU22/
         NmrlhTZqdem51FcNMm5tXpYzolpkLmoRBwdQaQjNgFGwJpReH3mdUg9XGE1YDKBXal
         SrzLqf8iPsl4hxYXiLtxfwOWu7bhb72ucaJvcKj2X/bljhmLCRIL/TVI+MJMRpoawy
         ft0jDd8vZ69HqCrnBvOkRx061AsGFIw+9RQOpNClHosWgqu+Rb0C5vr4GUNuruDOm6
         HajOXRXDFhfmg==
Message-ID: <e8190083513e08b2d237ee428ee6606de2c29b91.camel@codeconstruct.com.au>
Subject: Re: [External] Re: [BUG] blacklist: Problem blacklisting hash (-13)
 during boot
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity@vger.kernel.org
Date:   Mon, 27 Feb 2023 09:42:39 +0800
In-Reply-To: <860048ca-d827-4319-9755-9b44ba3c4157@t-8ch.de>
References: <c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de>
         <af0d6881-76c0-f570-0c5b-f664e261c4cf@digikod.net>
         <632d2180-02f8-4a5f-803a-57a6443a60f4@t-8ch.de>
         <12ceffb8-4e90-4eb5-2110-a0e69b412cea@lenovo.com>
         <fec5e8eb3803068a11267f386ddda389a1211736.camel@codeconstruct.com.au>
         <860048ca-d827-4319-9755-9b44ba3c4157@t-8ch.de>
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

Hi Thomas,

> > Given there's (at least) a few months' worth of GA machines with
> > this issue, can we suppress the warning?
>=20
> In 6.3 this message will be downgraded to a warning.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc95e8f6fd157b45ef0685c221931561e943e82da

Nice, thanks for that.

> A fixed firmware is still desirable, though.

Yep, definitely.

Not to discourage a firmware fix, but I could look at adding support to
one of the utils (mokutil?) to delete duplicate kek/db/dbx entries...

Cheers,


Jeremy
