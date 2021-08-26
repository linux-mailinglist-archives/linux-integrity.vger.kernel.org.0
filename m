Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B1C3F8B6C
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbhHZQAv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242973AbhHZQAv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 12:00:51 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2868DC061757;
        Thu, 26 Aug 2021 09:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References
        :In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LpWe8J+b+uwWxCuoccwBvHIGks/k1YWntvyIrq3a2Tc=; b=Cace3Qbeqty+2BdUpatncS9aBg
        1Aa3C01OKXwzib7g/eViO0tXzFwuBL8DwkBejG/QrgnRJu0fajb/aHIIr2/+DtyWLkf3EUy1Gqo+a
        ufo/CK1FJEst3q/vIdrE9ElNueKUD+kQOJ0jns2K1ILtVH3S9o3zPfSA7D54WV1g1QsOMW9ie7yMX
        Tm8m/dpDZ4yGq3DAuHo9b/MJ+venKI1qB7emCg5JZqUlY67aZSIHcl4DFD0zRi8B8vBRL5TIuKArw
        of3ZCYAnPXR092+1Z6VMlWY0Egkqy5IE/89kwGSZ3lN1IGxw+w5CZCNxALyC0UIxxJ1Qiic8JS4QT
        eDsB9JKQ==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1mJHnE-0007aH-8p; Thu, 26 Aug 2021 18:59:52 +0300
Message-ID: <160cb027ef423eab95b8883f053208f3bdabe41f.camel@iki.fi>
Subject: Re: [PATCH v13 2/7] tpm: tpm_tis: Fix expected bit handling and
 send all  bytes in one shot without last byte in exception
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
Date:   Thu, 26 Aug 2021 18:59:52 +0300
In-Reply-To: <20210826111908.117278-3-amirmizi6@gmail.com>
References: <20210826111908.117278-1-amirmizi6@gmail.com>
         <20210826111908.117278-3-amirmizi6@gmail.com>
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
> Detected the following incorrect implementation of the send command:
> polling on the TPM_STS.stsValid field followed by checking the
> TPM_STS.expect field only once.

Umh, what?

Can you be a bit more verbose what is the incorrect behaviour?
I'm sorry but I simply cannot decipher that sentence.

/Jarkko
