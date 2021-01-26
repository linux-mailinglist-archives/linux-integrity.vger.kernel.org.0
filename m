Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA1304EE8
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 02:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391854AbhA0BWc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Jan 2021 20:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbhAZS4u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jan 2021 13:56:50 -0500
Received: from iam.tj (unknown [IPv6:2a01:7e00:e000:151::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4021CC0617AA
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jan 2021 10:56:05 -0800 (PST)
Received: from [IPv6:2a02:8011:2007:0:37a2:855e:7ada:e97f] (unknown [IPv6:2a02:8011:2007:0:37a2:855e:7ada:e97f])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by iam.tj (Postfix) with ESMTPSA id 93A01340F6;
        Tue, 26 Jan 2021 18:56:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=elloe.vision; s=2019;
        t=1611687361; bh=pW5BRli1GLGipBIINvB0TPU8uc9pLCA7uO+KzYIjKp0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QLqnp4U75FOJmxWaBj47zhyMtwv3z5qUoxEt5iy32Ze+uuN88tnXz0r1iCIZ7WIty
         6mRj29gYHxQjrtcJPbgRYD1DPb0GLMryd4SMtro3kaMNV9DqQri6LRSK8QNrmONmZi
         LJlRxWa0Up0K/csa1kOPlL7iPM6Lxka35SVEP07pdF7C+cEDqaaSNmEFchORoB4/Yg
         ACjc2fYPdB2azFATIu/EKw7W9Cu+xsF7wgxyqxA2H8vRQeIco1+oOKWrFg9FFOeX3c
         WMHTLnP7ttgzlspCye1Gw/Q9QPvWJ/pBVwhKdKu72Y4S5bZ+JCyk9EFO8vGVlUZ5Wv
         13uxMcGjh+1GA==
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        =?UTF-8?Q?=c5=81ukasz_Majczak?= <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dirk Gouders <dirk@gouders.net>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
References: <20210123014247.989368-1-lma@semihalf.com>
 <20210125171846.GA31929@roeck-us.net>
 <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
 <a0249ad7b498e6f1cc065814350e145a07e92d37.camel@HansenPartnership.com>
From:   "Tj (Elloe Linux)" <ml.linux@elloe.vision>
Organization: Elloe CIC
Message-ID: <31c50c4f-487f-1977-2962-4a138b0d0ecc@elloe.vision>
Date:   Tue, 26 Jan 2021 18:55:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a0249ad7b498e6f1cc065814350e145a07e92d37.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 26/01/2021 16:46, James Bottomley wrote:
> On Tue, 2021-01-26 at 16:46 +0100, Łukasz Majczak wrote:
>> Hi Jarkko, Guenter
>>
>> Yes, here are the logs when failure occurs -
>> https://gist.github.com/semihalf-majczak-lukasz/1575461f585f1e7fb1e9366b8eceaab9
>> Look for a phrase "TPM returned invalid status"
> 
> We've had other reports of this:
> 
> https://lore.kernel.org/linux-integrity/ghsgagsnag.fsf@gouders.net/
> https://lore.kernel.org/linux-integrity/374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision/
> 
> The problem is some TIS TPMs don't begin in the correct locality so we
> have to set it.  When I proposed the check, I also proposed a fix for
> this problem:
> 
> https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/
> 
This patch solves the error messages on top of -rc5

> But it's part of a series that never went upstream.  Part of the reason
> was Jarkko proposed the get/put patch to fix this instead, but that
> never went upstream either.  We need to decide an approach and apply
> one or other fixes.
> 
> James
> 
> 

