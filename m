Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9592FB429C
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 23:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfIPVDh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 17:03:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38960 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730662AbfIPVDh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 17:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568667815;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yoztt8L8+kYQRxMPtC85ya3BagHgDeduD2h1ZIAKqTc=;
        b=UTxOf/esJ41QUQUjQGHwxgZQ8eMYyw3fKEaelXUT86wFr8S4bbbowdVZIRWa4DZs/Wnfrh
        H5gaiJiNjYp+vX3koY1q+mt4iA6T1eFrN21fPaE7QB+x//myMFTtS8YgNaycnQ9nXICt9I
        U4LdJIRpctLeJyIw+S8+jUeYx1KAgtY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-9x3hEOuqOPewtZ3yT-hvww-1; Mon, 16 Sep 2019 17:03:34 -0400
Received: by mail-qk1-f200.google.com with SMTP id d25so1536343qkk.17
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 14:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BKNnujlsu7uye1NQvdtsoIEI5OprfE1Gweft1aGgxzQ=;
        b=AtM+yRo42RCFaehuEnyCzxaj8461tS3KgYN/f6ixwfebxi2eVbWDouazqMuCO3Fvd8
         pzrV8XdC43tZYLmP3ctSZGmnkD9/9aVRO6SelVSksOZ6oPGtDXQGUyhJX6lX+N80hbQj
         ryHYRqTMkei4Johuo0lg4OH4ETP2AbSFZ5I2M6miP3V9qKmKo7lQXVVfcIRNlys13lWX
         DaL5KcK6q2B4jk89a4B+LEbNrC9gmgYrQRbuV1IgaJc8BzPQ8BLmn9xgui63/4INu/j8
         xER+9PEKh6mIB/95YCWUwY5x7n6v6UTFp5V+IQw/TMND89VW8Nha7iHHznpZPyGolSir
         5ZQg==
X-Gm-Message-State: APjAAAVbXLUyO/YvrzPqEtAZ7ptRlCV2wKGVvGE31OYOfST86VDLen1F
        kCQ4IsRXqxBUqfY1msXbo3VhjLYe+d8cdPtBfVTDzICyrS8PEvCHXvuNpjjiB8GdYO0wTSmDqPr
        qc5k8FAVxiJeSUZ68qBiCVpsVo8aT
X-Received: by 2002:ac8:33c3:: with SMTP id d3mr393357qtb.41.1568667813947;
        Mon, 16 Sep 2019 14:03:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpQBB0hj2oaAzIGQjzBEgm3XQZHAPhewba41ewLeoppALXlTPdv580wJU2vy2IMPPQEnjBkg==
X-Received: by 2002:ac8:33c3:: with SMTP id d3mr393327qtb.41.1568667813686;
        Mon, 16 Sep 2019 14:03:33 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id k17sm176571qtk.7.2019.09.16.14.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:03:32 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:03:31 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Wrap the buffer from the caller to tpm_buf in
 tpm_send()
Message-ID: <20190916210331.l6enypnafk2cwako@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190916085008.22239-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20190916085008.22239-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: 9x3hEOuqOPewtZ3yT-hvww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Sep 16 19, Jarkko Sakkinen wrote:
>tpm_send() does not give anymore the result back to the caller. This
>would require another memcpy(), which kind of tells that the whole
>approach is somewhat broken. Instead, as Mimi suggested, this commit
>just wraps the data to the tpm_buf, and thus the result will not go to
>the garbage.
>
>Obviously this assumes from the caller that it passes large enough
>buffer, which makes the whole API somewhat broken because it could be
>different size than @buflen but since trusted keys is the only module
>using this API right now I think that this fix is sufficient for the
>moment.
>
>In the near future the plan is to replace the parameters with a tpm_buf
>created by the caller.
>
>Reported-by: Mimi Zohar <zohar@linux.ibm.com>
>Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>Cc: stable@vger.kernel.org
>Fixes: 412eb585587a ("use tpm_buf in tpm_transmit_cmd() as the IO paramete=
r")
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>---
> drivers/char/tpm/tpm-interface.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-inter=
face.c
>index d9ace5480665..2459d36dd8cc 100644
>--- a/drivers/char/tpm/tpm-interface.c
>+++ b/drivers/char/tpm/tpm-interface.c
>@@ -358,13 +358,9 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t=
 buflen)
> =09if (!chip)
> =09=09return -ENODEV;
>
>-=09rc =3D tpm_buf_init(&buf, 0, 0);
>-=09if (rc)
>-=09=09goto out;
>-
>-=09memcpy(buf.data, cmd, buflen);
>+=09buf.data =3D cmd;
> =09rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting to a send a command=
");
>-=09tpm_buf_destroy(&buf);
>+
> out:
> =09tpm_put_ops(chip);
> =09return rc;
>--=20
>2.20.1
>

Nothing uses the out label any longer so it should be dropped as well, but =
other than that...

Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>

