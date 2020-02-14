Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8250715F7B6
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2020 21:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgBNU3Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Feb 2020 15:29:25 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39028 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbgBNU3Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Feb 2020 15:29:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 664368EE2DB;
        Fri, 14 Feb 2020 12:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581712164;
        bh=lOE3wVreuNeXiij7KseiFkeOnrhhicYXNeSi/8YWziQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Ya7e3Lp+MoPmdvCwHRH8/j+imra8eeJyHL/+JVSKabucZMSOV+kNS4bHPDVK48Wd6
         X2GwZ9VoDzwtpxokFqFI3pr6Y8V+Ay94XUPsYSO/Nt3ZSV9DQMnZascUYHlBpwfxpk
         VdR47rfQRHTQsSinLNzgjggIqd/LQLgbEjKvdJVk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PeI_93u4FqEs; Fri, 14 Feb 2020 12:29:24 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BBCEE8EE0DF;
        Fri, 14 Feb 2020 12:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581712164;
        bh=lOE3wVreuNeXiij7KseiFkeOnrhhicYXNeSi/8YWziQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Ya7e3Lp+MoPmdvCwHRH8/j+imra8eeJyHL/+JVSKabucZMSOV+kNS4bHPDVK48Wd6
         X2GwZ9VoDzwtpxokFqFI3pr6Y8V+Ay94XUPsYSO/Nt3ZSV9DQMnZascUYHlBpwfxpk
         VdR47rfQRHTQsSinLNzgjggIqd/LQLgbEjKvdJVk=
Message-ID: <1581712162.16860.8.camel@HansenPartnership.com>
Subject: Re: Debugging errors with Dell XPS 9560 TPM
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Alex Guzman <alex@guzman.io>, linux-integrity@vger.kernel.org
Date:   Fri, 14 Feb 2020 15:29:22 -0500
In-Reply-To: <CAJ7-PMbJ5fiQAj-5QAzAcFW0eMNkxpQSs=r_wUEfED33XZAPDg@mail.gmail.com>
References: <CAJ7-PMaLw_H8Fc1tyoT95f5EWpS3nvJt1Wx9=xpuiSotJ2h9VA@mail.gmail.com>
         <CAJ7-PMbJ5fiQAj-5QAzAcFW0eMNkxpQSs=r_wUEfED33XZAPDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-02-14 at 10:32 -0800, Alex Guzman wrote:
> Looks like someone had a look on the bug tracker
> (https://bugzilla.kernel.org/show_bug.cgi?id=206275#c6)
> and they figure it's definitely a regression in the kernel and should
> be reverted or rectified. They advised me to come ping here once
> more.

Reading the bugzilla, I don't get *what* needs to be reverted.  The
commit 4d6ebc4c4950595414722dfadd0b361f5a05d37e isn't present in
upstream, so what kernel is it present in, or what is the full commit
message so we can find the upstream commit?

James


> - Alex
> 
> On Sat, Feb 1, 2020 at 4:19 PM Alex Guzman <alex@guzman.io> wrote:
> > 
> > Hey there! I reported a bug on the bug tracker a bit ago but
> > haven't
> > seen any movement, so I figured I'd drop in here. My XPS 9560 has
> > been
> > having issues with its TPM, and all commands will fail with error 1
> > when operating on the TPM device. I managed to bisect it back to
> > commit 4d6ebc4c4950595414722dfadd0b361f5a05d37e (tpm: fix invalid
> > locking in NONBLOCKING mode) though it began failing with error 14
> > (bad address) at that point.
> > 
> > I reported the bug at
> > https://bugzilla.kernel.org/show_bug.cgi?id=206275 and attached
> > some
> > dmesg logs from boot there. Does anyone have any suggestions for
> > additional debugging or such to figure out what's happening here?
> > 
> > - Alex
> 
> 

