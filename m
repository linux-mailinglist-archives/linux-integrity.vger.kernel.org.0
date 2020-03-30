Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3621982A9
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 19:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgC3RrI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 13:47:08 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42112 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727905AbgC3RrI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 13:47:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7B0C18EE423;
        Mon, 30 Mar 2020 10:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1585590427;
        bh=pxAp1CiWV1gJzCg9Xe1pSaL5cSuIn1U4/TbV8gjeAmE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=FAYpbI7CtdIXzUMoyoW/aVlfWkC6V3S79tPmg+pUZF2w98bZfYEGxeMWkPXhYAWsM
         O1vH6oyLmgb1uOCNAx0hT6lnJ0UUcA07WB0HCZ/OZB0AQFs/ET6CGLpr7cno+H7Kqo
         i/NA0kLg7xWLYdlq+jLBgWdcBMnO8ySotsLy0UEo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9y28tf3442dC; Mon, 30 Mar 2020 10:47:07 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B63398EE112;
        Mon, 30 Mar 2020 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1585590427;
        bh=pxAp1CiWV1gJzCg9Xe1pSaL5cSuIn1U4/TbV8gjeAmE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=FAYpbI7CtdIXzUMoyoW/aVlfWkC6V3S79tPmg+pUZF2w98bZfYEGxeMWkPXhYAWsM
         O1vH6oyLmgb1uOCNAx0hT6lnJ0UUcA07WB0HCZ/OZB0AQFs/ET6CGLpr7cno+H7Kqo
         i/NA0kLg7xWLYdlq+jLBgWdcBMnO8ySotsLy0UEo=
Message-ID: <1585590425.3295.2.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 0/2] ima-evm-utils: Add some tests for evmctl
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 30 Mar 2020 10:47:05 -0700
In-Reply-To: <0432e72c-4f55-60bd-94c0-13eac1f244d0@linux.microsoft.com>
References: <20200327042515.22315-1-vt@altlinux.org>
         <d39b433e-4504-d0a4-116f-dd33ca238f7f@linux.microsoft.com>
         <0432e72c-4f55-60bd-94c0-13eac1f244d0@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-03-30 at 09:28 -0700, Lakshmi Ramasubramanian wrote:
> On 3/30/20 9:16 AM, Lakshmi Ramasubramanian wrote:
> 
> > On 3/26/20 9:25 PM, Vitaly Chikunov wrote:
> > > This series adds simple evmctl tests for hash, sign, and verify 
> > > operations.
> > 
> > Could you please add the steps to initialize, configure, and run
> > the tests in cover letter?
> > 
> > thanks,
> >   -lakshmi
> 
> Sorry - forgot to reply-all.

It looks like it's the standard autoreconf -fiv; ./configure; make;
make check?

That's basically the universal autoconf way of running tests ... I'm
not really sure documenting how to do this is a necessary requirement
for the series.

James

