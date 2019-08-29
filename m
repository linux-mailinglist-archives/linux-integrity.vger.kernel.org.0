Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75618A2142
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 18:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfH2Qsw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 12:48:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34275 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfH2Qsw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 12:48:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so1900810pgc.1
        for <linux-integrity@vger.kernel.org>; Thu, 29 Aug 2019 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=1h84VsdEIk/RJ4GEMoCJoDXJxxyf4qCt79WxpGG3KGE=;
        b=L6iutWMqf94DI+IpjCYzaKO+6zBr6FJPyp8I7ReRPPz9Bwz1C06r0jvcl9g9UTKzL8
         La34RPLh1cDgQsTv9Dde+LHjRqv6t/s/NH2+alpReu9/fFX+0415PKw/c69n9P4bx6tc
         eYZAwI4nVcPTmI9qCrfnAkgWxN6xmN7DFxDfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=1h84VsdEIk/RJ4GEMoCJoDXJxxyf4qCt79WxpGG3KGE=;
        b=EVcUPN7d07VRXv1vu4aKx3mP7wreZ6tkkPrR3vqkdrGEwFdsm767e4R7KyIZgKfFSG
         dJGva3sSSj3g1HhaQLJ5ekq6v2uvdipzuCH0xOjB/Y0Yb7pQWUawXP0Cj29wODWgYBN3
         M85sEl0Yfck8Q6CAdvw1bZGqYkyE8qPgwUEHyGj+GPsLgOcUWLDKY4Waye/RblB/OYo3
         lUBqVYoZbggfBf5atNaSIK8XAkgWGgIfSjJiITZa7vKuKZyI/FrTJuXQHv/2cMYTQnUg
         EZep+dwfwqItY5iOXJFPEZS06aNG4ZL/VyCnGHQMZyoXnO3RZgB1xcqpFIbQNQWLy4te
         /0GA==
X-Gm-Message-State: APjAAAUdZ8del8zSt7HCgZC63oUS1mLRrFavzaPc5+isjVk+5edrKBwE
        EZCZOlslOoTYvtdNHpFUfyFoig==
X-Google-Smtp-Source: APXvYqxOzI6wuGgea5pIs/8SlJlLegZwhC0dTBl5d3h0cyYkFR86wEuwXhJEzQmABuYhe7Awu6XWlg==
X-Received: by 2002:a17:90a:a4c5:: with SMTP id l5mr10863298pjw.49.1567097331984;
        Thu, 29 Aug 2019 09:48:51 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m19sm8863124pff.108.2019.08.29.09.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:48:51 -0700 (PDT)
Message-ID: <5d6801f3.1c69fb81.58389.32c9@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190829163221.72njmrixakywqi5z@linux.intel.com>
References: <20190828082150.42194-1-swboyd@chromium.org> <20190828082150.42194-5-swboyd@chromium.org> <20190829163221.72njmrixakywqi5z@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v5 4/4] tpm: tpm_tis_spi: Support cr50 devices
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 29 Aug 2019 09:48:50 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-29 09:32:21)
> On Wed, Aug 28, 2019 at 01:21:50AM -0700, Stephen Boyd wrote:
> > diff --git a/drivers/char/tpm/cr50_spi.c b/drivers/char/tpm/cr50_spi.c
> > new file mode 100644
> > index 000000000000..535674f4b02a
> > --- /dev/null
> > +++ b/drivers/char/tpm/cr50_spi.c
> > @@ -0,0 +1,327 @@
[...]
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +int tpm_tis_spi_resume(struct device *dev)
> > +{
> > +     struct tpm_chip *chip =3D dev_get_drvdata(dev);
> > +     struct tpm_tis_data *data =3D dev_get_drvdata(&chip->dev);
> > +     struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> > +     struct cr50_spi_phy *cr50_phy;
> > +
> > +     if (phy->is_cr50) {
> > +             cr50_phy =3D to_cr50_spi_phy(phy);
> > +             /*
> > +              * Jiffies not increased during suspend, so we need to re=
set
> > +              * the time to wake Cr50 after resume.
> > +              */
> > +             cr50_phy->wake_after =3D jiffies;
> > +     }
>=20
> To simplify the code I would just put also wake_after to
> tpm_tis_spi_phy.

Ok. But keep the other members in cr50_spi_phy as they are?

>=20
> > +
> > +     return tpm_tis_resume(dev);
> > +}
> > +#endif
> > diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_=
spi.c
> > index b3ed85671dd8..fdac842a61ed 100644
> > --- a/drivers/char/tpm/tpm_tis_spi.c
> > +++ b/drivers/char/tpm/tpm_tis_spi.c
> > @@ -215,17 +219,18 @@ static int tpm_tis_spi_probe(struct spi_device *d=
ev)
> >  {
> >       struct tpm_tis_spi_phy *phy;
> >       int irq;
> > +     struct device_node *np =3D dev->dev.of_node;
> > +     const struct spi_device_id *spi_dev_id =3D spi_get_device_id(dev);
> > +
> > +     if (of_device_is_compatible(np, "google,cr50") ||
> > +         (spi_dev_id && spi_dev_id->driver_data =3D=3D TPM_IS_CR50))
> > +             return cr50_spi_probe(dev);
>=20
> You could keep pointers to probes directly in driver_data.

Ok. Will do.

