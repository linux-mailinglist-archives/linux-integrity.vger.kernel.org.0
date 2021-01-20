Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554442FCABB
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 06:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbhATFan (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jan 2021 00:30:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbhATFUl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jan 2021 00:20:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C65012311C;
        Wed, 20 Jan 2021 05:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611120000;
        bh=MwrYgBA8FbFaypjtHU5QfT972J023QiIOLjTwZnRH+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oVbS8bVtuLjj4mm5CMYKndqzU5xTOF9cnmQhWdJqY1a7Ht0cLPzWH0z6KmIVAnK6Q
         gEPqclIqa50Qn36dT4/l8JDeqLNkMGNP6lzSJpVUaSc91H4qtdyg7Q683lJpCtcWcT
         msqDrEgDNlhwS3XwB+fj0IkVVynS8jA0wI1q4iOPwyst3ycLme521TSx6oUhC2Yt0B
         a7KwaqXMdsbZUpWpyr112JQrjuPu23BIpVeYIdWm39o5YiEMR3HyZoIOvdwzFscUMZ
         427nfb6PbgVhu3pz/dLnfg9Ie3od3VQs9R0s3vG/SRvuUpTCb5SPzwOor+KvUGxYeU
         kocr/nXetJOtA==
Date:   Wed, 20 Jan 2021 07:19:54 +0200
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
Subject: Re: [PATCH v3 08/10] certs: Check that builtin blacklist hashes are
 valid
Message-ID: <YAe9egzT5D7B0swR@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-9-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114151909.2344974-9-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 04:19:07PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Add and use a check-blacklist-hashes.awk script to make sure that the
> builtin blacklist hashes will be approved by the run time blacklist
> description checks.  This is useful to debug invalid hash formats, and
> it make sure that previous hashes which could have been loaded in the
> kernel (but ignored) are now noticed and deal with by the user.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

I get this with a self-signed cert:

certs/Makefile:18: *** target pattern contains no '%'.  Stop.

CONFIG_SYSTEM_BLACKLIST_HASH_LIST="tbs:8eed1340eef37c1dc84d996406ad05c7dbb3eade19132d688408ca2f63904869"

I used the script in 10/10 to test this, which is another
reamark: the patches are in invalid order, as you need to
apply 10/10 before you can test  8/10.

/Jarkko
