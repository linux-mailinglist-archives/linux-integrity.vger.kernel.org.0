Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2E3309859
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 21:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhA3Us3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 15:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhA3Us2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 15:48:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE19464E0E;
        Sat, 30 Jan 2021 20:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612039668;
        bh=bLI+ZNwZ/Px1wCi6hAgk4/4culKMpmswS9uXcxraxYg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CLiYs4yeKmz/ahstkrgtQsBiQkWseA6roT+zDTfPndAuKeoJRdfdF7/edA1Xtb2Qx
         Rn5U5twSSATBFNMN4vtcJKtYewLbabTYWv30YnQlMDZuZ8bZHtyIhM7rqPFeiRJaPG
         YKSHpNAHMhcZ2JeoRfNV4EkHZxLv500f4QSBbheqvShnmOc8TReBm2MvjPJoGusQxx
         GhwI2jAx5mhBR+tJw5oqzxh5mhJdZo6ZJiDvAHhZ4eWM9sNglWHERrgLZOCxdrjzVp
         xRn+DhNwduxNUp2e2uJU+EI01mvU1PrD7byhVpsPuC0pG7R7WZJugxdSyzYloLP13u
         mulDXXspf9PNg==
Message-ID: <ad016e07e5d8c8584981dfbc920eda9c80e3459a.camel@kernel.org>
Subject: Re: [PATCH v2] tpm_tis: Add missing tpm_request/relinquish_locality
 calls
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Tj <ml.linux@elloe.vision>, Dirk Gouders <dirk@gouders.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Date:   Sat, 30 Jan 2021 22:47:43 +0200
In-Reply-To: <464454f440df67d3470e67ff0386bbc306d07dac.camel@kernel.org>
References: <20210123014247.989368-1-lma@semihalf.com>
         <20210128130753.1283534-1-lma@semihalf.com>
         <464454f440df67d3470e67ff0386bbc306d07dac.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-01-30 at 22:40 +0200, Jarkko Sakkinen wrote:
> On Thu, 2021-01-28 at 14:07 +0100, Lukasz Majczak wrote:
> > There is a missing call to tpm_request_locality before the call to
> > the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
> > approach might work for tpm2, it fails for tpm1.x - in that case
> > call to tpm_get_timeouts() or tpm_tis_probe_irq_single()
> > without locality fails and in turn causes tpm_tis_core_init() to fail.
> > Tested on Samsung Chromebook Pro (Caroline).
> >=20
> > Signed-off-by: Lukasz Majczak <lma@semihalf.com>
>=20
> Is it possible that you test against linux-next and see if any
> problems still arise? I've applied the locality fixes from James.

Also one nit: if any problems still persist, please add a snippet
from klog to your commit message.

/Jarkko
