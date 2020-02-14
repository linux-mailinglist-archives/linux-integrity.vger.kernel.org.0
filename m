Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0337E15F86C
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2020 22:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgBNVEg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Feb 2020 16:04:36 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39666 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbgBNVEg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Feb 2020 16:04:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3C5958EE2DB;
        Fri, 14 Feb 2020 13:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581714275;
        bh=2QiRVPopb1I6FiNmvB97Hyx5ngYBmW1djpl05jvCR+I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KgacME6wnU46aGpmkZdzekl2N3E2ih4ooy/cGWTXfDVrI1DmyFZ2My+/ldrY9S6hd
         rUbNg27owHzDOGZVtqGHJj0JBy30RO+18iTjv0qPMaXoGIBdu4T8+kHz79RSoDmqmE
         Zc5GhK7/UD+7hud26apUTpdN+W97VUrAiiXXnmX8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pp5-gCdXgipx; Fri, 14 Feb 2020 13:04:35 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B09F28EE0DF;
        Fri, 14 Feb 2020 13:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581714275;
        bh=2QiRVPopb1I6FiNmvB97Hyx5ngYBmW1djpl05jvCR+I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KgacME6wnU46aGpmkZdzekl2N3E2ih4ooy/cGWTXfDVrI1DmyFZ2My+/ldrY9S6hd
         rUbNg27owHzDOGZVtqGHJj0JBy30RO+18iTjv0qPMaXoGIBdu4T8+kHz79RSoDmqmE
         Zc5GhK7/UD+7hud26apUTpdN+W97VUrAiiXXnmX8=
Message-ID: <1581714273.16860.18.camel@HansenPartnership.com>
Subject: Re: Debugging errors with Dell XPS 9560 TPM
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Alex Guzman <alex@guzman.io>, linux-integrity@vger.kernel.org
Date:   Fri, 14 Feb 2020 16:04:33 -0500
In-Reply-To: <20200214210203.dgzhkrvagiozezfi@cantor>
References: <CAJ7-PMaLw_H8Fc1tyoT95f5EWpS3nvJt1Wx9=xpuiSotJ2h9VA@mail.gmail.com>
         <CAJ7-PMbJ5fiQAj-5QAzAcFW0eMNkxpQSs=r_wUEfED33XZAPDg@mail.gmail.com>
         <1581712162.16860.8.camel@HansenPartnership.com>
         <20200214210203.dgzhkrvagiozezfi@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-02-14 at 14:02 -0700, Jerry Snitselaar wrote:
> On Fri Feb 14 20, James Bottomley wrote:
> > On Fri, 2020-02-14 at 10:32 -0800, Alex Guzman wrote:
> > > Looks like someone had a look on the bug tracker
> > > (https://bugzilla.kernel.org/show_bug.cgi?id=206275#c6)
> > > and they figure it's definitely a regression in the kernel and
> > > should
> > > be reverted or rectified. They advised me to come ping here once
> > > more.
> > 
> > Reading the bugzilla, I don't get *what* needs to be reverted.  The
> > commit 4d6ebc4c4950595414722dfadd0b361f5a05d37e isn't present in
> > upstream, so what kernel is it present in, or what is the full
> > commit message so we can find the upstream commit?
> > 
> > James
> > 
> > 
> > > - Alex
> > > 
> > > On Sat, Feb 1, 2020 at 4:19 PM Alex Guzman <alex@guzman.io>
> > > wrote:
> > > > 
> > > > Hey there! I reported a bug on the bug tracker a bit ago but
> > > > haven't seen any movement, so I figured I'd drop in here. My
> > > > XPS 9560 has been having issues with its TPM, and all commands
> > > > will fail with error 1 when operating on the TPM device. I
> > > > managed to bisect it back to commit
> > > > 4d6ebc4c4950595414722dfadd0b361f5a05d37e (tpm: fix
> > > > invalid locking in NONBLOCKING mode) though it began failing
> > > > with error 14 (bad address) at that point.
> > > > 
> > > > I reported the bug at
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=206275 and attached
> > > > some dmesg logs from boot there. Does anyone have any
> > > > suggestions for additional debugging or such to figure out
> > > > what's happening here?
> > > > 
> > > > - Alex
> > > 
> > > 
> 
> d23d12484307 | 2019-12-17 | tpm: fix invalid locking in NONBLOCKING
> mode (Tadeusz Struk)
> 
> There is a commit that is a fix to this commit:
> 
> a430e67d9a2c | 2020-01-08 | tpm: Handle negative priv->response_len
> in tpm_common_read() (Tadeusz Struk)

Yes, I suspected it might be that ... in which case upstream should
have the fix, can we verify that 5.6-rc1 works just fine?

James

