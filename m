Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB750304EE3
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 02:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbhA0BVQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Jan 2021 20:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbhAZRIE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jan 2021 12:08:04 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041F5C061A2B;
        Tue, 26 Jan 2021 08:46:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 60BB6128025E;
        Tue, 26 Jan 2021 08:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1611679609;
        bh=YYXnRPkivoOQxj54PhIN26oV5DaWUkpUQrmfHkVSlNU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ppIoAxCFDVqtgUWlciU6HC4WacNGp4rGFFc9rJ3UYff+qWhXsPAw/7CxEwo8D9t9r
         VKEMzkyoULgQhSLHDJwwr45B4xgnnkkPSi4hT88o41fDDQA6YIDr9x4b3QJasMGjhq
         TWViLYPh6j/ibqwTHyBotM/JJqFZQjzabutH3ZjI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gPbahwszsqyx; Tue, 26 Jan 2021 08:46:49 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B80391280232;
        Tue, 26 Jan 2021 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1611679609;
        bh=YYXnRPkivoOQxj54PhIN26oV5DaWUkpUQrmfHkVSlNU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ppIoAxCFDVqtgUWlciU6HC4WacNGp4rGFFc9rJ3UYff+qWhXsPAw/7CxEwo8D9t9r
         VKEMzkyoULgQhSLHDJwwr45B4xgnnkkPSi4hT88o41fDDQA6YIDr9x4b3QJasMGjhq
         TWViLYPh6j/ibqwTHyBotM/JJqFZQjzabutH3ZjI=
Message-ID: <a0249ad7b498e6f1cc065814350e145a07e92d37.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     =?UTF-8?Q?=C5=81ukasz?= Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Tj (Elloe Linux)" <ml.linux@elloe.vision>,
        Dirk Gouders <dirk@gouders.net>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Date:   Tue, 26 Jan 2021 08:46:48 -0800
In-Reply-To: <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
References: <20210123014247.989368-1-lma@semihalf.com>
         <20210125171846.GA31929@roeck-us.net>
         <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-01-26 at 16:46 +0100, Łukasz Majczak wrote:
> Hi Jarkko, Guenter
> 
> Yes, here are the logs when failure occurs -
> https://gist.github.com/semihalf-majczak-lukasz/1575461f585f1e7fb1e9366b8eceaab9
> Look for a phrase "TPM returned invalid status"

We've had other reports of this:

https://lore.kernel.org/linux-integrity/ghsgagsnag.fsf@gouders.net/
https://lore.kernel.org/linux-integrity/374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision/

The problem is some TIS TPMs don't begin in the correct locality so we
have to set it.  When I proposed the check, I also proposed a fix for
this problem:

https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/

But it's part of a series that never went upstream.  Part of the reason
was Jarkko proposed the get/put patch to fix this instead, but that
never went upstream either.  We need to decide an approach and apply
one or other fixes.

James


