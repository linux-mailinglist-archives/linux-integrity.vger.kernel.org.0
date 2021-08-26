Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867D53F8B80
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbhHZQGU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 12:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232555AbhHZQGU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 12:06:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72E1C61073;
        Thu, 26 Aug 2021 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629993932;
        bh=6EOvxsS40DWi4+3S3XPVsGwCcBBe7Jps2Wzxpeei4kU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=toXdmH43h5RNaLiKqEu9/Yqv/CeUG47J37KFiSCSg9OUODgfAdMFkNQhpUw0QlKJk
         pLas5wY+devMxG3fIRxW/X4vvbv3b9UV6v8WuraGtCabsyMecdEtKWvyAxe4M16vGh
         KG9VLNxsEQXUBg76srBRPusxtxzldhwhpyWgGCgqWr84/UyIBcQk9MG72u84b+kG80
         40HPlCn3VZ9n3knaFQMr5JsQWi4IukZHlnLIdNPVV14mwRcbFNb6uRXvtz7MQCc6kW
         TQ4fulAm7aop4gjiCqMo6OsuHkuX1nOG2G5ksLXXpnhZYSQvkLT/qgUG9fQlShO8+c
         3THEKBphym0Ww==
Message-ID: <2073010e89045054c2d9a6451e7056f257082d15.camel@kernel.org>
Subject: Re: [PATCH v13 7/7] tpm: Add YAML schema for TPM TIS I2C options
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
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Rob Herring <robh@kernel.org>
Date:   Thu, 26 Aug 2021 19:05:30 +0300
In-Reply-To: <20210826111908.117278-8-amirmizi6@gmail.com>
References: <20210826111908.117278-1-amirmizi6@gmail.com>
         <20210826111908.117278-8-amirmizi6@gmail.com>
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
> Added a YAML schema to support tpm tis i2c related dt-bindings for the I2=
c
  ~~~
  Add

Using imperative form in the current time is better than describing the
past.

/Jarkko

