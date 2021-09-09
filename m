Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C602405858
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 15:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353866AbhIIN6W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 09:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352996AbhIIN5I (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 09:57:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBCCC611CB;
        Thu,  9 Sep 2021 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631195758;
        bh=c5iA0xZnsS2ihax/Ol/20Gbo0ppGT5VXT99jFlcp6Eo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J3pyVybmGebub+vWfza4U/0mTJQdRcORir91+E7ho+y5uBjHaaNKNonmTQP5TrgoA
         3rv1D4vHwSFQ7xz9CzyMyXiLf7KSqvSEctg75KBU3RehbwJ5LmIYAC13G2eDYtR42J
         EYfIzNQ60PP5U6//Uo9tVQgE9POw9aPENNVrk/6wD+mt8DMtDmHZdyDGoZpo4Q6OFu
         JgL0krJYUMXvIgXOXml9ul//2pORyn0suOo9H1rJ/xs0UGTXzCBK6cm9HCg0+ins7x
         SWGEaAMzTx/OCabfUjXYjq8ruxfO0JTfo1g8SIUvi1P52ZBXaqimW9PdfPjnzsICbX
         nN8w53MAJ4QXA==
Message-ID: <1d6fa8c32123e3e3708214540a45a940fab01ee1.camel@kernel.org>
Subject: Re: [PATCH v5 01/12] integrity: Introduce a Linux keyring called
 machine
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Thu, 09 Sep 2021 16:55:56 +0300
In-Reply-To: <20210907160110.2699645-2-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <20210907160110.2699645-2-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-09-07 at 12:00 -0400, Eric Snowberg wrote:
> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
> Boot DB and MOK keys to validate the next step in the boot chain.  The
> MOK facility can be used to import user generated keys.  These keys can
> be used to sign an end-users development kernel build.  When Linux
> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
> .platform keyring.
>=20
> Add a new Linux keyring called machine.  This keyring shall contain just
> MOK CA keys and not the remaining keys in the platform keyring. This new
> machine keyring will be used in follow on patches.  Unlike keys in the
> platform keyring, keys contained in the machine keyring will be trusted
> within the kernel if the end-user has chosen to do so.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

I guess this is somewhat sealed so

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

