Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188C93F8B7B
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhHZQFX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 12:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231732AbhHZQFX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 12:05:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28FCC61040;
        Thu, 26 Aug 2021 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629993875;
        bh=Amn2JvtODUmFxZEOkQ4cWSK3BbCpMN9r7gy44Qlrb4A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cXN4w02b6+QJVyGhgCxymVLKfI36Lh9F5OX2bYxoyzvq+jXDAvGhzh24oMGNEUPIs
         9HH3WaTdERfDoLk2DCkq0WcupjamrDgJeS1jvMaDuKhIdtwZQQM4aai/aFDO55Bv6p
         zt7JI0TH54496Ko6xVBtngqk/LWA3tS+vQEEHgwQe7GKreHOG19zqOCWHdLMXLIQmy
         S+lmOaiEaSoaZF7pnRLmZUrLbVmHLPx3m9vUS22bhPaHPZ0KoIJX6vypv3MhxmBhnM
         jHpbhxYhH0KxGtNGL20y1AJfGLW/OKYTVymK8h6Wfme5ryzPl7IOWOqNHNHyb2ijb8
         7rd942txTvvgw==
Message-ID: <74d983731b3fe639a2cc073f5c616dfc97939ea9.camel@kernel.org>
Subject: Re: [PATCH v13 6/7] tpm: tpm_tis: add tpm_tis_i2c driver
From:   Jarkko Sakkinen <jarkko@kernel.org>
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
Date:   Thu, 26 Aug 2021 19:04:33 +0300
In-Reply-To: <20210826111908.117278-7-amirmizi6@gmail.com>
References: <20210826111908.117278-1-amirmizi6@gmail.com>
         <20210826111908.117278-7-amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-26 at 14:19 +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
>=20
> I2c support for TPM devices is currently available as a vendor-specific T=
PM
  ~~~
  I2C

What is "vendor-specific TPM driver"? If you coin up term, please just go
ahead and explain what it means in practice.

/Jarkko

