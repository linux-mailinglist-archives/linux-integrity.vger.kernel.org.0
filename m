Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB993F8B60
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 17:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbhHZP6V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 11:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbhHZP6V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 11:58:21 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8159C061757;
        Thu, 26 Aug 2021 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References
        :In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZnGe1nVJ1CjSDZDcZI0kLv7JieGOOXz8IXiGfM2vWOg=; b=vCwqW1gApWpdGNv1xOnZEngggZ
        tapUoSvNGbDkeiGebQoMw5auiTyvm1Bf+8L2tTnwQUrcU9hKH9zEpThL0jphg8B4cCVg1zRpn3zsK
        e5RriResuYJf+iIpnb5blFK2vNvMK/WGSq9P0ANhriDGHHVS+92EV54qoDWipGXG7oj4VMmV6L0j0
        3Srwy3i36F8r1cam65UIgDSl3AoNAl0XSs8bwCENdQMYq6+oRVl5NpDz8AKgqlt1r6DrlqXhbGHK9
        r/p/K5srrlj0pNAQ6iQGKjMhirW7YXhDGurLKyyUk2JT1qOVWEMr2HteoAnKECnf8dOdltGtSPx+p
        y6tQ1MDQ==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1mJHkX-0006ux-Oe; Thu, 26 Aug 2021 18:57:05 +0300
Message-ID: <284e47260b22b8f308a1efa6754845329f6c89a5.camel@iki.fi>
Subject: Re: [PATCH v13 1/7] tpm: Make read{16, 32}() and write32() in 
 tpm_tis_phy_ops optional
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     amirmizi6@gmail.com, Eyal.Cohen@nuvoton.com,
        jarkko.sakkinen@linux.intel.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Date:   Thu, 26 Aug 2021 18:57:04 +0300
In-Reply-To: <20210826111908.117278-2-amirmizi6@gmail.com>
References: <20210826111908.117278-1-amirmizi6@gmail.com>
         <20210826111908.117278-2-amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jarkko.sakkinen@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-26 at 14:19 +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
>=20
> Only tpm_tis can use memory-mapped I/O, which is truly mapped into
> the kernel's memory space. Therefore, using ioread16/ioread32/iowrite32
> turns into a straightforward pointer dereference.
> Every other driver requires more complicated operations to read more than
> one byte at a time and will just fall back to read_bytes/write_bytes.

s/Every other driver/Some drivers, such as tpm_tis_spi,/g.

> Therefore, move this common code out of tpm_tis_spi and into tpm_tis_core
> so that it is used automatically when low-level drivers do not implement
> the specialized methods.

This does not really explain why you are moving the code.

You are moving it so that you don't have to reimplement things both in
SPI and I2C drivers?

Perhaps:

"Re-implement tpm_tis_{read, write}_{16, 32}, so that they check
 if implementations for {read, write}_{16, 32} in tpm_tis_phys_ops
 exist, and if not, fallback to {read, write}_bytes()."

> Co-developed-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Since there's been a while, it'd be better if you dropped my tags.
I consider them as expired by now. Please do this for all patches.

/Jarkko

