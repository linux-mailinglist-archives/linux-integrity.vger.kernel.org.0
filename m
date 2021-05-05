Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532883733E4
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 05:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhEEDUU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 23:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhEEDUT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 23:20:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BAD661159;
        Wed,  5 May 2021 03:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620184763;
        bh=oBLF1gXuqnSZm6Yx7wief5m9hr7D9c4QcsHF4OKDZVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlD8fO9uZqD7SrP4yxUHRoSqwH+qrkX2/5vj4ky7M8CJLdYyTQ+s0OLAMB5BVm0Ho
         VziFLZSIgsVQvVogIqz2fNItRsLLJ8SljO2PcYTJ1EKGjPb+EdBGZ+sTERyZ+h8MMc
         m/tW7ru19CMo6viOBk8hI/X5Je+xcKlPrmoJuoc8xC4oPAaLI2WH6+kKHXCnFTmOoa
         wincLI1QBHgCFuFg43b5ZdtNatt8XcOuFTwTT+weTA592ojU52J+1JN5s7Kfq9+DNI
         C0kM4HuAOngxvSAu6oO9xGHaUpxE1U0bSv9WPbqREsdczJrWlFc9Flqq2vUBbIJqxP
         ojuTSkFxhMZCw==
Date:   Wed, 5 May 2021 06:19:21 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net
Subject: Re: [PATCH 0/9] Enable hibernation when Lockdown is enabled
Message-ID: <YJIOuTbf91DCEkDe@kernel.org>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <CAE=gft4HnQKP3RK1hOGpThccLPanQzWpssCsEyUQGLbTMpzrFw@mail.gmail.com>
 <YJIOdNdWTClIXYZz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJIOdNdWTClIXYZz@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 05, 2021 at 06:18:15AM +0300, Jarkko Sakkinen wrote:
> On Tue, May 04, 2021 at 02:56:35PM -0700, Evan Green wrote:
> > Does anyone know if this series is abandoned, or is Matthew planning
> > to do another spin? Email to matthewgarrett@google.com bounces.
> > 
> > -Evan
> 
> Good question.
> 
> It could be that because James' patches did not end up to 5.12, but 5.13
> instead, Matthew has just put this into hold for a while.
> 
> I mean the review comments I gave, were relatively cosmetic.
> 
> If I was the author, that's at least I might have done...

Few months can pass surprisingly fast if you have all sorts of stuff going
on :-)

/Jarkko
