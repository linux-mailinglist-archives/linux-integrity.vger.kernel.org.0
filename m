Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E8B3E28ED
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Aug 2021 12:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245122AbhHFKyO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Aug 2021 06:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239854AbhHFKyG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Aug 2021 06:54:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DC0C061798
        for <linux-integrity@vger.kernel.org>; Fri,  6 Aug 2021 03:53:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mBxU5-0002nV-4I; Fri, 06 Aug 2021 12:53:49 +0200
Subject: Re: [RFC PATCH v1 0/4] keys: introduce key_extract_material helper
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, Richard Weinberger <richard@nod.at>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        linux-integrity@vger.kernel.org
References: <cover.b2fdd70b830d12853b12a12e32ceb0c8162c1346.1626945419.git-series.a.fatoum@pengutronix.de>
Message-ID: <7bc58825-c6d8-5e6d-4e1c-c4375e19c10e@pengutronix.de>
Date:   Fri, 6 Aug 2021 12:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <cover.b2fdd70b830d12853b12a12e32ceb0c8162c1346.1626945419.git-series.a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello everyone,

On 22.07.21 11:17, Ahmad Fatoum wrote:
> While keys of differing type have a common struct key definition, there is
> no common scheme to the payload and key material extraction differs.
> 
> For kernel functionality that supports different key types,
> this means duplicated code for key material extraction and because key type
> is discriminated by a pointer to a global, users need to replicate
> reachability checks as well, so builtin code doesn't depend on a key
> type symbol offered by a module.
> 
> Make this easier by adding a common helper with initial support for
> user, logon, encrypted and trusted keys.
> 
> This series contains two example of its use: dm-crypt uses it to reduce
> boilerplate and ubifs authentication uses it to gain support for trusted
> and encrypted keys alongside the already supported logon keys.
> 
> Looking forward to your feedback,

@Mike, Aliasdair: Do you think of key_extract_material as an improvement?

Does someone share the opinion that the helper is useful or should I drop
it and just send out the ubifs auth patch seperately?

Cheers,
Ahmad

> Ahmad
> 
> ---
> To: David Howells <dhowells@redhat.com>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: James Morris <jmorris@namei.org>
> To: "Serge E. Hallyn" <serge@hallyn.com>
> To: Alasdair Kergon <agk@redhat.com>
> To: Mike Snitzer <snitzer@redhat.com>
> To: dm-devel@redhat.com
> To: Song Liu <song@kernel.org>
> To: Richard Weinberger <richard@nod.at>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-raid@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-security-module@vger.kernel.org
> 
> Ahmad Fatoum (4):
>   keys: introduce key_extract_material helper
>   dm: crypt: use new key_extract_material helper
>   ubifs: auth: remove never hit key type error check
>   ubifs: auth: consult encrypted and trusted keys if no logon key was found
> 
>  Documentation/filesystems/ubifs.rst |  2 +-
>  drivers/md/dm-crypt.c               | 65 ++++--------------------------
>  fs/ubifs/auth.c                     | 25 +++++-------
>  include/linux/key.h                 | 45 +++++++++++++++++++++-
>  security/keys/key.c                 | 40 ++++++++++++++++++-
>  5 files changed, 107 insertions(+), 70 deletions(-)
> 
> base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
