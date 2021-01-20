Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8772FE2E9
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 07:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbhAUGcf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 01:32:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387805AbhATXqq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jan 2021 18:46:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EBC2223DB;
        Wed, 20 Jan 2021 23:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611186361;
        bh=Y7yPimnwlZiWOVF8artsqTLZ2o9NMklqcf3t/32s7vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIbgduiy7h6RXVcu3vanpKkTOj/w3EtR8hRdz+oqt+FzACvklqlu0yNsWr8lgmqHq
         pPuDIB17c1IK97pn+bAMDMdrypJNHZkMR9l4aZfeI4Hxjn3iNS6GJ5y/z/56TwTP4k
         0mzi0q16u+FOYIbrECeKSVuTQrcF3X3Sb9bIypRiXlIfZ6vtgAq/ZV+MqYiiEkJwhi
         dBHS9k4KS3J6p+pnPl3bUrJV/j8BB6d2PxYX84thKc485+2f1NeSlcVU/XNT2zvy1J
         G6VEBM+gEo0jGxBnd6P80heNA4t1lO5f1QJIbmxgZv5sskDoPp0UXRbT7uS93Oib2B
         TEoSqLoShlM6A==
Date:   Thu, 21 Jan 2021 01:45:55 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 04/10] certs: Fix blacklist flag type confusion
Message-ID: <YAjAswPAr3tcuDhd@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-5-mic@digikod.net>
 <YAepvxOBcEU0paqA@kernel.org>
 <fc4d5812-238c-baf7-d7f6-cc123bdb855d@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc4d5812-238c-baf7-d7f6-cc123bdb855d@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 20, 2021 at 12:15:10PM +0100, Mickaël Salaün wrote:
> 
> On 20/01/2021 04:55, Jarkko Sakkinen wrote:
> > On Thu, Jan 14, 2021 at 04:19:03PM +0100, Mickaël Salaün wrote:
> >> From: David Howells <dhowells@redhat.com>
> >>
> >> KEY_FLAG_KEEP is not meant to be passed to keyring_alloc() or key_alloc(),
> >> as these only take KEY_ALLOC_* flags.  KEY_FLAG_KEEP has the same value as
> >> KEY_ALLOC_BYPASS_RESTRICTION, but fortunately only key_create_or_update()
> >> uses it.  LSMs using the key_alloc hook don't check that flag.
> >>
> >> KEY_FLAG_KEEP is then ignored but fortunately (again) the root user cannot
> >> write to the blacklist keyring, so it is not possible to remove a key/hash
> >> from it.
> >>
> >> Fix this by adding a KEY_ALLOC_SET_KEEP flag that tells key_alloc() to set
> >> KEY_FLAG_KEEP on the new key.  blacklist_init() can then, correctly, pass
> >> this to keyring_alloc().
> > 
> > OK, so thing work by luck now, but given the new patches which allow
> > to append new keys they would break, right?
> 
> Without this fix, patch 9/10 would allow to remove and modify keys from
> the blacklist keyring.
> 
> > 
> >> We can also use this in ima_mok_init() rather than setting the flag
> >> manually.
> > 
> > What does ima_mok_init() do?
> 
> This was initially an addition from David Howells, I only fixed the
> argument bit-ORing. ima_mok_init() allocates a blacklist keyring (with
> different properties) dedicated to IMA.
 
Please add this to the commit message.

/Jarkko
