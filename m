Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC67C1E33FC
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2020 02:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgE0ASZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 20:18:25 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42866 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbgE0ASZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 20:18:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3E16E8EE181;
        Tue, 26 May 2020 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590538704;
        bh=qID++NqcCImhZsa5jpMl2xI3bNrObdcyNtPXj6J7vTA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nn+hxfT7PV/m8JO5KlzADc5duM37fIGlQITTf2WsHd2ZlK9ywTrkidZpOegr4aovL
         f5DQCl2MH4e3UrZjKbQ3Ho5T83bGFI0meV/QpToT0SKIcpnV+aCpjLTa19QPw88r/b
         uYRAXGTNlGfSWP1kvUOH2xt6e5PpCqDi8xHlHUG4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nz4t2lLbttbW; Tue, 26 May 2020 17:18:24 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7C57E8EE0D4;
        Tue, 26 May 2020 17:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590538703;
        bh=qID++NqcCImhZsa5jpMl2xI3bNrObdcyNtPXj6J7vTA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T1Y/cKeWxtbmbBUOm78QeCdLFUqn+xmpk6E3IRjgulQEmYpeh4x2z39psGk5tKD57
         7KFJXTEEZ85zCawULY6iCjn4ZYT/RLCVybG9psE5iOdT6OKB2bZmmf3BqSDrwjr1U/
         I8kAPCXNq7e9nWqSSgenBsf+5vP/vKzwqfUp3vs0=
Message-ID: <1590538702.3576.2.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Alex Guzman <alex@guzman.io>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Date:   Tue, 26 May 2020 17:18:22 -0700
In-Reply-To: <CAJ7-PMaoFyi89OFgYsNknc2d0Fr4RHLmmHo-puNiKchM=0mU6w@mail.gmail.com>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
         <1590520454.11810.40.camel@HansenPartnership.com>
         <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
         <1590521924.15108.1.camel@HansenPartnership.com>
         <da3027a2aa9d1b7110a65de919e88f42ef2e13bb.camel@guzman.io>
         <1590534370.15108.17.camel@HansenPartnership.com>
         <CAJ7-PMaoFyi89OFgYsNknc2d0Fr4RHLmmHo-puNiKchM=0mU6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-05-26 at 16:31 -0700, Alex Guzman wrote:
> On Tue, May 26, 2020 at 4:06 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Tue, 2020-05-26 at 15:19 -0700, Alex Guzman wrote:
> > [...]
> > > When using your patch, I get a hang when trying to use
> > > tpm2_getcap, and dmesg shows some info.
> > 
> > Are you sure it's all applied?  This
> > 
> > > [  570.913803]  tpm_tcg_write_bytes+0x2f/0x40
> > > [  570.913805]  release_locality+0x49/0x220
> > > [  570.913807]  tpm_relinquish_locality+0x1f/0x40
> > > [  570.913808]  tpm_chip_stop+0x21/0x40
> > > [  570.913810]  tpm_put_ops+0x9/0x30
> > > [  570.913811]  tpm_common_write+0x179/0x190
> > > [  570.913813]  vfs_write+0xb1/0x1a0
> > 
> > Implies an unmatched tpm_put_ops() in the async write path, as
> > though this hunk:
> > 
> > > @@ -211,11 +202,19 @@ ssize_t tpm_common_write(struct file *file,
> > > const char __user *buf,
> > >         if (file->f_flags & O_NONBLOCK) {
> > >                 priv->command_enqueued = true;
> > >                 queue_work(tpm_dev_wq, &priv->async_work);
> > > -               tpm_put_ops(priv->chip);
> > >                 mutex_unlock(&priv->buffer_mutex);
> > >                 return size;
> > >         }
> > 
> > Is missing.  I actually booted the patch in my TPM based VM and it
> > all seems to work OK when I execute tpm2_getcap (I verified it's
> > using O_NONBLOCK) and tssgetcapability in sync mode.
> > 
> > James
> > 
> 
> Oh, I did miss that bit. The patch had issues applying for some
> reason and I missed the single-line removal when I was looking at the
> diff.

Sorry, that's likely my fault: I did it on top of my current TPM tree.
I'll prepare a version against the vanilla kernel with a real
changelog.

> I gave it a spin on my machine again. getcap seems to work correctly
> with and without having the async config flag set for tpm2-tss. The
> pkcs11 plugin seems to work correctly again too. :)

Great, thanks!  I'll add your tested-by to the above.

James

