Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C90F46737
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 20:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfFNSNP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 14:13:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42938 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFNSNP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 14:13:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id l19so1972550pgh.9
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jun 2019 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:subject:cc:user-agent:date;
        bh=ZLVDWUWwWY4MpQ/fxABhQErt5/T/sQKzxrLl0+83gd0=;
        b=F/ZB6ORavFWyfK9TSla7/HqOfq2c2l0pz5qJuy3jEPcr17gJLZgyiFcEiReWczZ4bi
         f9ONz8SUO9N76h1XRciw/qHw+mWnSHHTiG9dg/RyWE2MMARvWcv+Dn6aEfA+HuZpomSK
         p3L4+/pudF2hA5CGZXA3FcqShuGYAY3jI5KKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:subject:cc
         :user-agent:date;
        bh=ZLVDWUWwWY4MpQ/fxABhQErt5/T/sQKzxrLl0+83gd0=;
        b=hKBRgVWa9XrDlXgXgUvjUKyS+vsSHFhdp+Svb/vlNT+8BNcsW58WHVt0sKT/M6XXOg
         sO3i9FI+ZyampZk3SyVI94RetQMZwek9TFNN+b2iJBhCfTqZ+blfjpNKQWJZYGq457TE
         yOOIEaG/DtkJjdPA6AwJffUKzs28OEPhQOC710+1FViggForYgf7MLwpdpZFnUwdtid1
         YNS8yKqA+wgHXdRQzb88mtrvrkURdj0bi4EHzmhWgUcf3OhD/BZmUrjdKS0z2QZrJnse
         wNV5C2ItzTAmT16LHLmKp0hnqdF39KCzNDK0Z08THcdHa71eP6TG1U6rrC+nxnEdsBel
         ZhgA==
X-Gm-Message-State: APjAAAVgX5GVQ9JPRk91Cn/5uGkW1pVbZEVmbLdhEcWvKquXksL2uz44
        kZmR2viHX0lI+TFHH+iVv7FuZA==
X-Google-Smtp-Source: APXvYqwhGwL7yshptV+gRwCd63XpWKvE0KUQQrTCSKiIt6r0u4yc69kfnzZn5k0V6NZrfaFRfW4W1Q==
X-Received: by 2002:a63:e44c:: with SMTP id i12mr11731959pgk.297.1560535994544;
        Fri, 14 Jun 2019 11:13:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e22sm3590678pgb.9.2019.06.14.11.13.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 11:13:14 -0700 (PDT)
Message-ID: <5d03e3ba.1c69fb81.9c2c8.aa89@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190614152700.GE11241@linux.intel.com>
References: <20190613180931.65445-1-swboyd@chromium.org> <20190613180931.65445-2-swboyd@chromium.org> <20190614152700.GE11241@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/8] tpm: block messages while suspended
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 14 Jun 2019 11:13:13 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2019-06-14 08:27:00)
> On Thu, Jun 13, 2019 at 11:09:24AM -0700, Stephen Boyd wrote:
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 1b5436b213a2..48df005228d0 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -132,6 +132,8 @@ struct tpm_chip {
> >       int dev_num;            /* /dev/tpm# */
> >       unsigned long is_open;  /* only one allowed */
> > =20
> > +     unsigned long is_suspended;
> > +
> >       char hwrng_name[64];
> >       struct hwrng hwrng;
>=20
> I think it would better idea to have a bitmask of some sort that
> would have bits for 'open' and 'suspended'.
>=20

Sure. I can combine is_open and is_suspended into some sort of 'unsigned
long flags' member and then have #define TPM_IS_OPEN 0 and #define
TPM_IS_SUSPENDED 1 defines?

