Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0762330CE31
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 22:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhBBVuk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 16:50:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231860AbhBBVui (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 16:50:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3499064F84;
        Tue,  2 Feb 2021 21:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612302597;
        bh=gthtiNOLBtbazSEYCkP7aYkQY117x3/WDHZK8yVZtYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ab8h2GsuCnh8bjO5sUPlkGseNfLS7qZMFeCq3eXh/NlyP5WWVJB110UW4rAnd26v8
         5DnVwf/SxpnEcDfp6/Lj1SBuWQRb18tTIsG6lJs2MkLKMJYkLFc6ffgABSVhQ4j/eX
         WjfcPf28Sut0+C/YkAp5h8ZRGgYXjJ8DNwRSLMcJA4iWm2nUvs2Zz+ht1SwO1r466e
         Abfmi6uasEhFikKN+LnsYBpdrE144m26k9i8np9G+GnPa2D7qB3LhEY8yoBbpypiSl
         n6OLUQa5SufDbgMkKWCNqczwRbr+6p+mqd1WWn/0qr+sqVP1n3idkUvkMIpTjn90BB
         IeDtYsch45YHg==
Date:   Tue, 2 Feb 2021 23:49:50 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dirk Gouders <dirk@gouders.net>, Tj <ml.linux@elloe.vision>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: Re: [PATCH v4] tpm_tis: Add missing tpm_request/relinquish_locality
 calls
Message-ID: <YBnI/huAaaDVpEtO@kernel.org>
References: <20210202155139.521421-1-lma@semihalf.com>
 <20210202195724.628468-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202195724.628468-1-lma@semihalf.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 02, 2021 at 08:57:24PM +0100, Lukasz Majczak wrote:
> There are missing calls to tpm_request_locality before the calls to
> the tpm_get_timeouts() and tpm_tis_probe_irq_single() - both functions
> internally send commands to the tpm. As the current
> approach might work for tpm2, it fails for tpm1.x - in that case
> call to tpm_get_timeouts() or tpm_tis_probe_irq_single()
> without acquired locality fails and in turn causes tpm_tis_core_init()
> to fail, it can be observed in the log with the following warning
> trace:

Ignoring this version.

/Jarkko
