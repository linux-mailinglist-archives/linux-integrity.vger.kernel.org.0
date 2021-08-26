Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CC73F8B77
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhHZQEC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 12:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242968AbhHZQEB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 12:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CC5460ED3;
        Thu, 26 Aug 2021 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629993793;
        bh=46VQnXe0S/Xq9TFQRoWCZJdbzW1Ri9/3zb6hlDzYOU8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aQ6bQelntSG4ZWXlBZ9qoa2W2JJ15WJQrWl2+VRXeqTMZaOtpL1/fjvg2uX50Ukws
         8ASa/vNGkXTKHKiDK5qIizUDXJi6mjGNrei/3qA36L87XQJoNEOr46Utgjhs49ybGD
         XBhVLwic78YXVx/BIYGf8yTwo6prt+/CNMkHkHqnPyRZG+UPc7JFUUG8AccUO+W74S
         BzRWw+PydHcp4NXZHZBxapVVeUDMTSOuSEU/13cKxHuV9YByWETYz47xZoCufQIVK2
         iSxGFyhYIy2fSL26NS8kxBPATZVN1qospDvawhC97IXLgpIkXrw1pSRGnO6PvAyzqo
         TQ64838UUc3lA==
Message-ID: <a87af58e77bee938c85f9edef8a2fcdf1266256e.camel@kernel.org>
Subject: Re: [PATCH v13 5/7] tpm: tpm_tis: verify TPM_STS register is valid
 after  locality request
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
Date:   Thu, 26 Aug 2021 19:03:11 +0300
In-Reply-To: <20210826111908.117278-6-amirmizi6@gmail.com>
References: <20210826111908.117278-1-amirmizi6@gmail.com>
         <20210826111908.117278-6-amirmizi6@gmail.com>
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
> Issue could result when the TPM does not update TPM_STS register after
> a locality request (TPM_STS Initial value =3D 0xFF) and a TPM_STS registe=
r
> read occurs (tpm_tis_status(chip)).

What does it mean when "issue results"?

I don't understand that part.

/Jarkko
