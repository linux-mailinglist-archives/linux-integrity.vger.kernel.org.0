Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75BB0F6AA3
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Nov 2019 19:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfKJSAS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Nov 2019 13:00:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36634 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfKJSAS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Nov 2019 13:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573408817;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hixz/IzNhB0JpEt6Ya+nzMEp0JX0n9HHRljmP2H+u7k=;
        b=D0LpdoVmmNrPKpfZoR/SlXNnE1+S9dMHjULcfWQ96A+BwAirOWXABHgDyDVUmyqZ/UnhFz
        LOQndWPDiwTZsnycNdkpEYdcZjZnfEv5tuZ24kDoaaKP6iaL2KrWEQomQouXUO/ZKXsfmX
        fGCLF6jODld2OeBHgYGT/e4y+vIcwZ0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-lI3PfA1_NX2DhMv2mJ3ViA-1; Sun, 10 Nov 2019 13:00:13 -0500
Received: by mail-pf1-f200.google.com with SMTP id g186so10567775pfb.15
        for <linux-integrity@vger.kernel.org>; Sun, 10 Nov 2019 10:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Um2+4ViHEGLtX+G0u5WhQV8LmjxfVLK7h3RGaAChVEk=;
        b=NeV3fTOMjbO20oU5TrAX9PgvGGZxMrPADHAjqoYR3lChcjiURMRB6wNlbnOt76d2di
         vAbbBuGDCjF8OqSlrKzxtOghH0IKOcXQq1ZlL3eLXRzWSmfhOz+5i5SruNhvWoEfMpUV
         6ZNELcN9gruK2L7tnDfIDGG5FpYFF1B2xAZa9GA+4BKvFBd8Qy8NTTpTZ6CaQLCOmgnW
         y4RUKhUF4ZizxC8roP79uMqD/1PVhX117yFhS9vhNtFcnbq1aO/OvYdDn5+zn3hHgkD1
         auNTqtEGLhzM40czRIZYjCW9ARyRR1TcbaOZ/CLiDiR7NOKZm3eTGixHhOKiPOnNoq9k
         rCZw==
X-Gm-Message-State: APjAAAUDq6axaww1DYj/31Sww6pDE9i3FPM/TOKPAZ/UAYfhyoEBdccj
        MpOXHdlaaVze8nrOL8e5aJbDPwXSjb4V8yb7/oKv4r35o5izljxFs99jfniEGb7KSQIFA6BDPB+
        yqdaPucYSYASbAlLrTS+DBkm/jE2W
X-Received: by 2002:a17:902:b20b:: with SMTP id t11mr22199282plr.211.1573408812854;
        Sun, 10 Nov 2019 10:00:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyfWm4OglYklA+A7wQRUWJBtP0mHnD6YYVjbFQFg9Q6GxMN0YxEL0MKIhZn8HxYbk8Q0luQ3A==
X-Received: by 2002:a17:902:b20b:: with SMTP id t11mr22199248plr.211.1573408812514;
        Sun, 10 Nov 2019 10:00:12 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 27sm12289493pgx.23.2019.11.10.10.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 10:00:11 -0800 (PST)
Date:   Sun, 10 Nov 2019 11:00:10 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     amirmizi6@gmail.comg, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hagar@nuvoton.com,
        amir.mizinski@nuvoton.com
Subject: Re: [PATCH v1 3/5] char: tpm: rewrite "tpm_tis_req_canceled()"
Message-ID: <20191110180010.xyvv4gf6jiqyrac3@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: amirmizi6@gmail.comg,
        Stefan Berger <stefanb@linux.vnet.ibm.com>, Eyal.Cohen@nuvoton.com,
        jarkko.sakkinen@linux.intel.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hagar@nuvoton.com,
        amir.mizinski@nuvoton.com
References: <20191110162137.230913-1-amirmizi6@gmail.com>
 <20191110162137.230913-4-amirmizi6@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191110162137.230913-4-amirmizi6@gmail.com>
X-MC-Unique: lI3PfA1_NX2DhMv2mJ3ViA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun Nov 10 19, amirmizi6@gmail.com wrote:
>From: Amir Mizinski <amirmizi6@gmail.com>
>
>using this function while read/write data resulted in aborted operation.
>after investigating according to TCG TPM Profile (PTP) Specifications,
>i found cancel should happen only if TPM_STS.commandReady bit is lit
>and couldn't find a case when the current condition is valid.
>also only cmdReady bit need to be compared instead of the full lower statu=
s register byte.
>
>Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
>---
> drivers/char/tpm/tpm_tis_core.c | 12 +-----------
> 1 file changed, 1 insertion(+), 11 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_co=
re.c
>index ce7f8a1..9016f06 100644
>--- a/drivers/char/tpm/tpm_tis_core.c
>+++ b/drivers/char/tpm/tpm_tis_core.c
>@@ -627,17 +627,7 @@ static int probe_itpm(struct tpm_chip *chip)
>
> static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
> {
>-=09struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>-
>-=09switch (priv->manufacturer_id) {
>-=09case TPM_VID_WINBOND:
>-=09=09return ((status =3D=3D TPM_STS_VALID) ||
>-=09=09=09(status =3D=3D (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
>-=09case TPM_VID_STM:
>-=09=09return (status =3D=3D (TPM_STS_VALID | TPM_STS_COMMAND_READY));

Stefan were these cases you found that were deviating from the spec? Wonder=
ing
if dropping these will cause issues for these devices.

>-=09default:
>-=09=09return (status =3D=3D TPM_STS_COMMAND_READY);
>-=09}
>+=09return ((status & TPM_STS_COMMAND_READY) =3D=3D TPM_STS_COMMAND_READY)=
;
> }
>
> static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>--=20
>2.7.4
>

