Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1031296A
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 04:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBHDek (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Feb 2021 22:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBHDei (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Feb 2021 22:34:38 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAFAC061756
        for <linux-integrity@vger.kernel.org>; Sun,  7 Feb 2021 19:33:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E694C128042A;
        Sun,  7 Feb 2021 19:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612755235;
        bh=oSlh1Fb2w/TVr+tT8LlPpamG6QfSSAxcTb6S4xc7wJs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=K/DSYo+l0kB7agxymK5DCO6YsKST79dgntfNQLxKnOnfKtAPiWO9+QfpXDRrdlLEY
         bq8xW0pGmvOvusR5JSODMi1nzCzTl7Cb6qL+6FBN4nLPzH1Pi5n2oQ4gcwEXQAB+hH
         4kpUJglDQnselh9mEYZzZDNSw6edZoN2jPk9Agbg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qh4i9UzO8lmv; Sun,  7 Feb 2021 19:33:55 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 96AEB1280413;
        Sun,  7 Feb 2021 19:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612755235;
        bh=oSlh1Fb2w/TVr+tT8LlPpamG6QfSSAxcTb6S4xc7wJs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=K/DSYo+l0kB7agxymK5DCO6YsKST79dgntfNQLxKnOnfKtAPiWO9+QfpXDRrdlLEY
         bq8xW0pGmvOvusR5JSODMi1nzCzTl7Cb6qL+6FBN4nLPzH1Pi5n2oQ4gcwEXQAB+hH
         4kpUJglDQnselh9mEYZzZDNSw6edZoN2jPk9Agbg=
Message-ID: <8581ad17cb536c807d8ce781e955de07643aa1f4.camel@HansenPartnership.com>
Subject: Re: TPM returned invalid status
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Laurent Bigonville <bigon@debian.org>,
        linux-integrity@vger.kernel.org
Date:   Sun, 07 Feb 2021 19:33:54 -0800
In-Reply-To: <ee9c30b0-aff6-b1bd-2830-84b55a53b95e@debian.org>
References: <ee9c30b0-aff6-b1bd-2830-84b55a53b95e@debian.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-02-06 at 00:31 +0100, Laurent Bigonville wrote:
> Hello,
> 
> I already posted that beginning of January in reply to "tpm_tis:
> Clean 
> up locality release", but I didn't really got a reply
> 
> With debian unstable (Linux fornost 5.10.0-3-amd64 #1 SMP Debian 
> 5.10.12-1 (2021-01-30) x86_64 GNU/Linux), I get the following error:

Sorry, forgot to cc you.  We're iterating to this as the fix:

https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/

If you want to test it out.

Thanks,

James


