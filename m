Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA382FC9E0
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 05:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbhATES3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Jan 2021 23:18:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbhATERL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Jan 2021 23:17:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C8E623131;
        Wed, 20 Jan 2021 04:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611116190;
        bh=xyjnizKJKYbTRv0UN0+Gwt4VTaFiAxMHtX+9p9eYe1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ah7CzMikRzj9W9tCn1AXbZZE8R1ZZweT7ziyrwOtDpZNF2g4cVOr6PlWh5KRAFxsC
         AsbyuxEJ7GBuwoXPbRq9GiQePaNVne4UT+gu7x4YV6Ov8TvIZ0Z/FAHEm6WoCE8U/o
         x3tNJU7WNAdOBS6eYKCR3szPJBlq0AI3sjlazIcwBrqsJWGeK4ORLPxH3rMihm1ykE
         Lr0r4acf4K5C7MoADs+SRSfn/OeKJ4tTs7cNgaqo330SvD6nYRKcsjP8u3Vf0m2zqy
         Rs0SpKX5xSvb/Rg6JYz14DF23Yy5LF9BUa8F30nt64fgx+JITef2DSwaq5iXNc6OAk
         XDQUGoZNZjTsA==
Date:   Wed, 20 Jan 2021 06:16:23 +0200
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
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 06/10] certs: Make blacklist_vet_description() more
 strict
Message-ID: <YAeul+B2x6QK0NVq@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-7-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114151909.2344974-7-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 04:19:05PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Before exposing this new key type to user space, make sure that only
> meaningful blacklisted hashes are accepted.  This is also checked for
> builtin blacklisted hashes, but a following commit make sure that the
> user will notice (at built time) and will fix the configuration if it
> already included errors.
> 
> Check that a blacklist key description starts with a valid prefix and
> then a valid hexadecimal string.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

In this I'm not as worried about ABI, i.e. you don't have any reason
supply any other data, which doesn't follow these ruels, whereas there
could very well be a script that does format hex "incorrectly".

/Jarkko
