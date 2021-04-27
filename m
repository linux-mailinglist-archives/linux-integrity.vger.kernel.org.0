Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9267C36CF9D
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Apr 2021 01:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhD0XoI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Apr 2021 19:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236547AbhD0XoH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 19:44:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0AED613F8;
        Tue, 27 Apr 2021 23:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619567003;
        bh=PgKrq2v+c6YN5sorlwdjsf5RumADE22V7LpZdmH6xg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcZgT7ueV32crK/B+5CXCZAHQQ3IZgyXEM6n3aQtI0CFu2oVMM2gxiAU4arMqFP5N
         pghQY+By3+9dQuBEaPkOXjBF5mz4yMe94ULCjfBfjAjUSto8mWhwo+uszlCE8hpWJE
         JV5vrK5dMfmeQK9mymDYVf28v+wNX0vJXv96WefJiLmkdqPsSKAWZpIztoKCbp3Ead
         N5bsklqc8nemMwmZLqiWl0HzydF2D5KlqxFi2M/dVZT0k8VDm019xjBhEAwwtrAFHf
         JY1hLguOsTrPeYr4de6ne9O6Ss9QgrKFAhh4hFjHRw/ew5Fi3F/NW0NnoP4NVQA+O8
         mQAgbNhkzu6Bw==
Date:   Wed, 28 Apr 2021 02:43:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     pr-tracker-bot@kernel.org
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        dhowells@redhat.com, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for v5.13 (updated)
Message-ID: <YIihl5jTTwu1Vz9n@kernel.org>
References: <52f4810fbcdb3a118b7126e2497ae384016c9004.camel@HansenPartnership.com>
 <161945276076.5751.10749914749968096050.pr-tracker-bot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161945276076.5751.10749914749968096050.pr-tracker-bot@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 26, 2021 at 03:59:20PM +0000, pr-tracker-bot@kernel.org wrote:
> The pull request you sent on Fri, 23 Apr 2021 16:04:26 -0700:
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/tpmdd.git queue
> 
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/87f27e7b189f54a9e928efb4ea98bf375708ff1f
> 
> Thank you!

Thanks James for taking care of this (just came back from 2 week vacation)!

/Jarkko
