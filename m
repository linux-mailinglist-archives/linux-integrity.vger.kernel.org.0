Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943122A0A2D
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Oct 2020 16:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgJ3Prc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Oct 2020 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgJ3Prb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Oct 2020 11:47:31 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1FC0613CF
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2020 08:47:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4B1981280331;
        Fri, 30 Oct 2020 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604072851;
        bh=TbT0fb1EVTMQR6caAxGBZcOAwiRA3iwi9mStz3NPXLE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=IBJm0aNVAeZLCrZSrKwoHL2AYtEYV436uw+P6ABiynn+VfMxHGIyF5MCp1aG74vvV
         Z/8s2Ugh3ZHaOUkPJlo61m7AkAi+9TVnMSziOUO0PuoG8ynBcX9tTJlGmI6ML8WRZO
         2iwAjRkEWBf3r7kzReABsT0EGHe1y8J1Hw3Z/xRY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9LCaR7GmvM8Q; Fri, 30 Oct 2020 08:47:31 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DBDC7128032B;
        Fri, 30 Oct 2020 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604072851;
        bh=TbT0fb1EVTMQR6caAxGBZcOAwiRA3iwi9mStz3NPXLE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=IBJm0aNVAeZLCrZSrKwoHL2AYtEYV436uw+P6ABiynn+VfMxHGIyF5MCp1aG74vvV
         Z/8s2Ugh3ZHaOUkPJlo61m7AkAi+9TVnMSziOUO0PuoG8ynBcX9tTJlGmI6ML8WRZO
         2iwAjRkEWBf3r7kzReABsT0EGHe1y8J1Hw3Z/xRY=
Message-ID: <6ebaaa03669cbc92037b6f1ac8d8649744c01146.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/5] tpm_tis: Clean up locality release
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Fri, 30 Oct 2020 08:47:30 -0700
In-Reply-To: <20201030121756.GB522355@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
         <20201001180925.13808-3-James.Bottomley@HansenPartnership.com>
         <875z75hkk8.fsf@redhat.com> <20201024121007.GA32960@kernel.org>
         <20201030121756.GB522355@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-10-30 at 14:17 +0200, Jarkko Sakkinen wrote:
[...]
> Just noticed that the short summary is wrong: a fix is not a clean
> up.

I don't really think this is a fix.  What we currently have is working,
just suboptimally.  This makes it work optimally, which is better, but
it's not fixing anything because apart from a speed up in operations
there will be no user visible change.  If we use the word "fix" it will
excite all the automatic patch selectors for stable.

> Maybe "tpm_tis: Invoke locality release without wait" ? I'm also open
> for other suggestions but the current is short summary does not
> describe the patch.

That sounds fine, not having fix in the subject works for me.

James


