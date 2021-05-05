Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEF63733DF
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 05:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhEEDTL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 23:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhEEDTK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 23:19:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD894610D2;
        Wed,  5 May 2021 03:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620184695;
        bh=Yghl4ypXK+j7lyqNCoh5WbRJtmqgHJ2laHlMxQtz0s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVjAfnF/WXpH1TPEIGy/i/G3JAKA17KbBCzozV5KollxF0cZAfRdi7MMFXvx65yf0
         dmEsRfgoaT1Q1UdQnzYqZT9eH8Y76PO90pXDfYx9xnIw+qRBKUL/Xp7ll9z15ug1QF
         p0hxJX7KvDCxkbEhbPsEHr8tl9zSPg+rn40tANFVydFCK6AkLRC3A9dp8MS+iwG2ZJ
         J15PDApPhfGgR6VXttCZe0zyWpORADkE+uizBc1IlpHk1LGlX+4dFsKdVJnt5kukNt
         U8AAq63Bjd5znz3fQO38BqA+SoIM5Pd/ky8dSZLL43W1cJhbhcglSmb0ZESkfZJeHF
         gG0vKfsKzXE6w==
Date:   Wed, 5 May 2021 06:18:12 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net
Subject: Re: [PATCH 0/9] Enable hibernation when Lockdown is enabled
Message-ID: <YJIOdNdWTClIXYZz@kernel.org>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <CAE=gft4HnQKP3RK1hOGpThccLPanQzWpssCsEyUQGLbTMpzrFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft4HnQKP3RK1hOGpThccLPanQzWpssCsEyUQGLbTMpzrFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 04, 2021 at 02:56:35PM -0700, Evan Green wrote:
> Does anyone know if this series is abandoned, or is Matthew planning
> to do another spin? Email to matthewgarrett@google.com bounces.
> 
> -Evan

Good question.

It could be that because James' patches did not end up to 5.12, but 5.13
instead, Matthew has just put this into hold for a while.

I mean the review comments I gave, were relatively cosmetic.

If I was the author, that's at least I might have done...

/Jarkko

