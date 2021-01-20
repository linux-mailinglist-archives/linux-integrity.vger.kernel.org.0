Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FCC2FE122
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 05:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbhAUDxF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jan 2021 22:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388702AbhATXt0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jan 2021 18:49:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0B69221FE;
        Wed, 20 Jan 2021 23:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611186522;
        bh=2BgVV18n0FiTAx3Ktk2+qq/+MuryRP60T+o5yjWBck4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyAPTm4TVc8RBvCmozjOhaqCARYGaelqOnoxhCn1FdCSw3nMaWzQnnJgzAxfpJdL0
         dNc+PfScLbvgqk7iYIEyRL62sY+wPjr3sKcz+h+iDR/XvyRiQTNOcBM6hRJgjmqsqb
         sTo7XfeBp57TftPu0R7AvFoQb9+qXgdPmQJXfcrknC2Us2s4aK+5cHLTYFdzpLpfdp
         OsZP2xBSMEh6M+K/28nNnQPOqfiD0UHTo0LtejjLE5jgGgiswwd6lOxQb3IuL6aAov
         vJBJlI0N8oUAqe5BYZRr0ixWXSpaC4PcDH7azCxLw/tEztgTAagQoyGO2e2HaDSN2/
         1cvhhoB9t5TAw==
Date:   Thu, 21 Jan 2021 01:48:36 +0200
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
Subject: Re: [PATCH v3 05/10] certs: Replace K{U,G}IDT_INIT() with
 GLOBAL_ROOT_{U,G}ID
Message-ID: <YAjBVNxsZ7Zn2Ksi@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-6-mic@digikod.net>
 <YAe8cr7bS2Dn0RRn@kernel.org>
 <96550031-5183-e60f-f279-3475ab3851bc@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96550031-5183-e60f-f279-3475ab3851bc@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 20, 2021 at 12:17:28PM +0100, Mickaël Salaün wrote:
> 
> On 20/01/2021 06:15, Jarkko Sakkinen wrote:
> > On Thu, Jan 14, 2021 at 04:19:04PM +0100, Mickaël Salaün wrote:
> >> From: Mickaël Salaün <mic@linux.microsoft.com>
> >>
> >> Align with the new macros and add appropriate include files.
> >>
> >> Cc: David Woodhouse <dwmw2@infradead.org>
> >> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> >> Signed-off-by: David Howells <dhowells@redhat.com>
> > 
> > The commit message makes no sense. What you new macros?
> 
> What about "Use the new GLOBAL_ROOT_UID and GLOBAL_ROOT_GID definitions,
> and add appropriate include files."?

They were added in 2011 so you could just remove "the new". Otherwise,
WFM.

/Jarkko
