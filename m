Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0823846735
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 20:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfFNSMi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 14:12:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33479 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNSMi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 14:12:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so1340295plo.0
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jun 2019 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:subject:cc:user-agent:date;
        bh=ScI87c0IlyAE4jve6HhJl87g8VW2jGMqM1x+hPj+aK4=;
        b=QWAqqTMajs/XZNhqs6M7SHMK0Vph4q8kiNiYzc74G7ZO/RNh4key5pn13WMRBtEX1X
         AAQX0gnsntNJzdMwktj7O8ph/WnIPp1JEOab3RHbCzN3Qd9OBSBOBdU524+ULyLfVB0/
         ofIM0+OkjC5qOQAiggLyxuXOR3JXrI1aDZnS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:subject:cc
         :user-agent:date;
        bh=ScI87c0IlyAE4jve6HhJl87g8VW2jGMqM1x+hPj+aK4=;
        b=UQk5lw6gddPsOGD97zANbBMY8dAtFVYLbU4GQ14aYrd3Hixl0cb6GdOYi3Z95CDxus
         tPEdJBtvW1VsEohBHzMfSlGXCSLyrapiQbB5nDD4tA8y//GIeGBzC3GH3r8/Kb9ij0uP
         VgL76HtqUBwWQgBTUoWPF3plAWgzFiQbMOZ7AAMtICYebRxLbP427SPQxs1SNDENqmYW
         fuzhG5JAEvFnfydpQ2DcyRfO/qyl1O/FK1HzTTzctLr6hLF7xKYTTZbBXP2Oq8UYuzuQ
         sH1utlPN+HUkKFdFCtuODRqUubRTyOPWbOcbrzjKDVVkn6k2my9NoHXjg0XbZfUUC3XU
         mbNA==
X-Gm-Message-State: APjAAAX+lgupS2vHh7WQ+bal9qk7JGNk6hnUubxeqRsHdxv7rOqJg7GN
        c66XFUYw8l6V0tQPWdt+63Izdw==
X-Google-Smtp-Source: APXvYqxHj8VADlpF2bda26NGYbtU+zSPrYY7vRhzkruDiV7jwCROz0D4JYe3qNdSl1UeO/wmCq5KMg==
X-Received: by 2002:a17:902:15c5:: with SMTP id a5mr96105932plh.39.1560535957521;
        Fri, 14 Jun 2019 11:12:37 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a3sm4154500pje.3.2019.06.14.11.12.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 11:12:36 -0700 (PDT)
Message-ID: <5d03e394.1c69fb81.f028c.bffb@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190613232613.GH22901@ziepe.ca>
References: <20190613180931.65445-1-swboyd@chromium.org> <20190613180931.65445-2-swboyd@chromium.org> <20190613232613.GH22901@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/8] tpm: block messages while suspended
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 14 Jun 2019 11:12:36 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jason Gunthorpe (2019-06-13 16:26:13)
> On Thu, Jun 13, 2019 at 11:09:24AM -0700, Stephen Boyd wrote:
> > From: Andrey Pronin <apronin@chromium.org>
> >=20
> > Other drivers or userspace may initiate sending a message to the tpm
> > while the device itself and the controller of the bus it is on are
> > suspended. That may break the bus driver logic.
> > Block sending messages while the device is suspended.
> >=20
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >=20
> > I don't think this was ever posted before.
>=20
> Use a real lock.
>=20

To make sure the bit is tested under a lock so that suspend/resume can't
update the bit in parallel?

