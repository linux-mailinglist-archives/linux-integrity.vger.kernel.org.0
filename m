Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7638B429E
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 23:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfIPVFB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 17:05:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42078 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730662AbfIPVFB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 17:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568667900;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xTIXm4K2D6Qs2K7CtMCu5t3JJce0LvphVa9t+F5TPc=;
        b=XEOmU6bBvAb2dgT7J5TxtLcF85qESbzRLBkYLQLWrfSXY76peNNYVh1xXFR+Kp2uHBy1yj
        9G2NAFK5QQ6JXEyy8sBRoeuQXsPZlhXbEoqiDjuwuzmejqKW1ZVy8AdPNMTakB2sA9oYP8
        uP4K9V3idhW6G1TaOo/qBPHIauKkJ7k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-382jUfepMdqgq_8Q1dth0w-1; Mon, 16 Sep 2019 17:04:58 -0400
Received: by mail-qt1-f198.google.com with SMTP id g16so1703966qtq.15
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 14:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=4ERiCmOZ8H3sPNSQthd2g+0oVPuH4YPtd+sm2yhsBE0=;
        b=OZ8R0z+cBTxMge7fRdIh6q+l5xEbyWFJeqTz5Xn4Zb+PrSSarenrpgOfIwZGnz4lKX
         09CRUDgx5P6Ga0C15Eoe76bHWUzURF9eSupp+eTpG1ZPCRHE+WR2/Ah1W6GY8cQNelry
         zJaAETtid8oTCas9fkzIWjZIr7OPaVQ28jb7FLXpMaXtMJ2gK0vYLySRJo79Ku6yaPCy
         c3TelBsRlL5PH26QD4xAYmf84DqmKBlOrPU0tB/OViCKtiUjzMfsXkpbQ3ywQrEuTAJa
         /yS62aN2OXaH8n/MEL1dSARdC4uAAm8pYpPZgTAU+Axz3GeihGx9cZH8jPwDzJ2emuPZ
         tDBw==
X-Gm-Message-State: APjAAAXkWUv0cf90WsOSDfoore8aYiZZ8RXw2Rz/cla0Td/4mrj63Nd1
        IWEDTQfinOZ4rvkhznr99RMYfscd8rUmc1rIY+LmoMXIVbHnoXbWBrK1stKvPU5Kj8N02adFDBw
        02rcYfHg3SckXDHSRhMCFnb+xh6X6
X-Received: by 2002:a05:6214:1549:: with SMTP id t9mr177782qvw.68.1568667896459;
        Mon, 16 Sep 2019 14:04:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw7QP6IN4If6IqdEiE7mlgnayhIJAjkoYIwxiFRX5sPKLM4tlcXgm2XeZ5ZkcZWqN/t9OIXUQ==
X-Received: by 2002:a05:6214:1549:: with SMTP id t9mr177751qvw.68.1568667896220;
        Mon, 16 Sep 2019 14:04:56 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 60sm99677qta.77.2019.09.16.14.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:04:55 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:04:54 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Wrap the buffer from the caller to tpm_buf in
 tpm_send()
Message-ID: <20190916210454.mq3g2m6s5a2syaxp@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190916085008.22239-1-jarkko.sakkinen@linux.intel.com>
 <20190916210331.l6enypnafk2cwako@cantor>
MIME-Version: 1.0
In-Reply-To: <20190916210331.l6enypnafk2cwako@cantor>
User-Agent: NeoMutt/20180716
X-MC-Unique: 382jUfepMdqgq_8Q1dth0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Sep 16 19, Jerry Snitselaar wrote:
>On Mon Sep 16 19, Jarkko Sakkinen wrote:
>>tpm_send() does not give anymore the result back to the caller. This
>>would require another memcpy(), which kind of tells that the whole
>>approach is somewhat broken. Instead, as Mimi suggested, this commit
>>just wraps the data to the tpm_buf, and thus the result will not go to
>>the garbage.
>>
>>Obviously this assumes from the caller that it passes large enough
>>buffer, which makes the whole API somewhat broken because it could be
>>different size than @buflen but since trusted keys is the only module
>>using this API right now I think that this fix is sufficient for the
>>moment.
>>
>>In the near future the plan is to replace the parameters with a tpm_buf
>>created by the caller.
>>
>>Reported-by: Mimi Zohar <zohar@linux.ibm.com>
>>Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>>Cc: stable@vger.kernel.org
>>Fixes: 412eb585587a ("use tpm_buf in tpm_transmit_cmd() as the IO paramet=
er")
>>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>---
>>drivers/char/tpm/tpm-interface.c | 8 ++------
>>1 file changed, 2 insertions(+), 6 deletions(-)
>>
>>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-inte=
rface.c
>>index d9ace5480665..2459d36dd8cc 100644
>>--- a/drivers/char/tpm/tpm-interface.c
>>+++ b/drivers/char/tpm/tpm-interface.c
>>@@ -358,13 +358,9 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_=
t buflen)
>>=09if (!chip)
>>=09=09return -ENODEV;
>>
>>-=09rc =3D tpm_buf_init(&buf, 0, 0);
>>-=09if (rc)
>>-=09=09goto out;
>>-
>>-=09memcpy(buf.data, cmd, buflen);
>>+=09buf.data =3D cmd;
>>=09rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting to a send a command=
");
>>-=09tpm_buf_destroy(&buf);
>>+
>>out:
>>=09tpm_put_ops(chip);
>>=09return rc;
>>--=20
>>2.20.1
>>
>
>Nothing uses the out label any longer so it should be dropped as well, but=
 other than that...
>
>Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>

sigh (wrong emacs macro hit), that should be:

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

