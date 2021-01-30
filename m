Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBE030980F
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 20:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhA3Tka (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 14:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhA3Tka (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 14:40:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6790B64E11;
        Sat, 30 Jan 2021 19:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612035589;
        bh=91F3pwpWtvwlrWPZcvxDLPs0JprKkknEj+GyG6Zwi3g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WAJQWQC1YohDLev3N+ZAZpani7zaeB4j3kjw/QQP9QmduzY+hNksoi4xukOUfjwRY
         F1Pk7X1oS633SgChRPHbKjQ0DZdsGapevVWS2dRmOsTjloILrqxfgyv1593mpiiBDd
         lk8/sg5H9VK/THvYQp82p9T4tdZw81SYnJ07pGCE+ZYhqp+pKbvfMC/b57gxYx17nF
         veKRdruLImXAOTWQwPg5aqWQKnlNEiCi1hYv2wtTOBtIfXxF6mu4xMDgtnsnm8ESEC
         gu6M0/NgDcG7sBrwBsLCjLhLHHKV0PmH4DMIe0ORRYfhXQe+YKnmRiQfk7tjiAn2O/
         xU3glqwUu3xlg==
Message-ID: <9d4bebb993a62cdac9b385094ccc55ccbe79a4fc.camel@kernel.org>
Subject: Re: [PATCH v4 00/10] Enable root to update the blacklist keyring
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Sat, 30 Jan 2021 21:39:45 +0200
In-Reply-To: <3613306.1611852751@warthog.procyon.org.uk>
References: <20210121155513.539519-1-mic@digikod.net>
         <3613306.1611852751@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-28 at 16:52 +0000, David Howells wrote:
>=20
> Hi Micka=C3=ABl,
>=20
> I could pull your patches (unless Jarkko wants to), but can you please dr=
op
> the patches that are also in my keys-misc branch lest one or other (or bo=
th)
> of our branches get dropped in the next merge window due to conflicts?
>=20
> Ideally, can you base your branch on my keys-misc branch?

David, please pull :-)

If possible add to all:

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Was a chaotic week. My test environment was broken until Wed because
of issues with BuildRoot (that I reported and BR devs were able to
reproduce related to LINUX_OVERRIDE_SRCDIR).

> Thanks,
> David

/Jarkko
