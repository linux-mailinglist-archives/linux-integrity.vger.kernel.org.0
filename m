Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA023F8B70
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbhHZQCK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 12:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243019AbhHZQCJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 12:02:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9887F608FE;
        Thu, 26 Aug 2021 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629993682;
        bh=khh3k5Ma+p78zMJRvhYYQQ4ZRKQOvsle6iLbvUWss0Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iYUmzx8Z4kv5tmEV6JV6+bP8Fk+EazFZVIALi4BBniSP6Pcqw+FDG8c13wk96B4v9
         26qSakGn+gZBnx7m/8YPZMpr/Xbmd8ZPrN3g5x2TkgMWML4OOAhk2AU8iLn1/o9YKK
         VRXDtMqoh4fpu5r/mtc2jnS+QcrV/kR9otooCydODOZPmGkwnEF1CeF+DEMD3ypqnH
         QJhsBi/NB2ZxOiL0cuuNgffkZsWt+lqZuvQykR471AlsfiUqSaJ9fwadXmDH8Ldw+K
         M5DnJn08BNGPQVX8vam6mZ5njxixGAVg03Z/ffR9BTaqdqeUrTfKZgqEFvfrZzyyXV
         YqWrr7ideqrAw==
Message-ID: <a333b92f4c1645a9e2f3eb6887026e67036f86a0.camel@kernel.org>
Subject: Re: [PATCH v13 3/7] tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()"
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
Date:   Thu, 26 Aug 2021 19:01:19 +0300
In-Reply-To: <20210826111908.117278-4-amirmizi6@gmail.com>
References: <20210826111908.117278-1-amirmizi6@gmail.com>
         <20210826111908.117278-4-amirmizi6@gmail.com>
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
> Using this function while reading/writing data resulted in an aborted
> operation.

"Using <the function name>...". Also what is "aborted operation"?

Please say the exact thing instead of absractions.

/Jarkko

