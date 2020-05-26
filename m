Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE681E3362
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2020 01:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbgEZXGO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 19:06:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42266 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389802AbgEZXGN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 19:06:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E73BC8EE181;
        Tue, 26 May 2020 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590534372;
        bh=UIJxxdcolMNBV1F2tHlacd/GA5Gqhl4Il9Tm33AYAaQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DiLoaq8fmnx68F+zW+NvPjpBkda+KC3ETTX4xGdOxk06zVmgscgPQCibtLWnUO0fI
         TrgPDUtYdszzo7Jzqvc1MyVusz629oB29QWSpsnIlVu6BiWsBV2g5ZFbOs16Q3qcQc
         +KFR+4/dX92dbBoqbQBi6OxEQQFaLODVUR4cB9N4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KLmpmuVFYzlj; Tue, 26 May 2020 16:06:12 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8D8B18EE0D4;
        Tue, 26 May 2020 16:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590534372;
        bh=UIJxxdcolMNBV1F2tHlacd/GA5Gqhl4Il9Tm33AYAaQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DiLoaq8fmnx68F+zW+NvPjpBkda+KC3ETTX4xGdOxk06zVmgscgPQCibtLWnUO0fI
         TrgPDUtYdszzo7Jzqvc1MyVusz629oB29QWSpsnIlVu6BiWsBV2g5ZFbOs16Q3qcQc
         +KFR+4/dX92dbBoqbQBi6OxEQQFaLODVUR4cB9N4=
Message-ID: <1590534370.15108.17.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Alex Guzman <alex@guzman.io>, Mario.Limonciello@dell.com,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Date:   Tue, 26 May 2020 16:06:10 -0700
In-Reply-To: <da3027a2aa9d1b7110a65de919e88f42ef2e13bb.camel@guzman.io>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
         <1590520454.11810.40.camel@HansenPartnership.com>
         <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
         <1590521924.15108.1.camel@HansenPartnership.com>
         <da3027a2aa9d1b7110a65de919e88f42ef2e13bb.camel@guzman.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-05-26 at 15:19 -0700, Alex Guzman wrote:
[...]
> When using your patch, I get a hang when trying to use tpm2_getcap,
> and dmesg shows some info.

Are you sure it's all applied?  This

> [  570.913803]  tpm_tcg_write_bytes+0x2f/0x40
> [  570.913805]  release_locality+0x49/0x220
> [  570.913807]  tpm_relinquish_locality+0x1f/0x40
> [  570.913808]  tpm_chip_stop+0x21/0x40
> [  570.913810]  tpm_put_ops+0x9/0x30
> [  570.913811]  tpm_common_write+0x179/0x190
> [  570.913813]  vfs_write+0xb1/0x1a0

Implies an unmatched tpm_put_ops() in the async write path, as though
this hunk:

> @@ -211,11 +202,19 @@ ssize_t tpm_common_write(struct file *file,
> const char __user *buf,
>         if (file->f_flags & O_NONBLOCK) {
>                 priv->command_enqueued = true;
>                 queue_work(tpm_dev_wq, &priv->async_work);
> -               tpm_put_ops(priv->chip);
>                 mutex_unlock(&priv->buffer_mutex);
>                 return size;
>         }

Is missing.  I actually booted the patch in my TPM based VM and it all
seems to work OK when I execute tpm2_getcap (I verified it's using
O_NONBLOCK) and tssgetcapability in sync mode.

James

