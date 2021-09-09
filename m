Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9906540586D
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 16:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346884AbhIIOBn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 10:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242617AbhIIOAD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 10:00:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5D2261215;
        Thu,  9 Sep 2021 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631195934;
        bh=acTHeao9RjaRL1S6gkxS59/c+bTOkCkbYw9NK+UEdnc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YXEmzI1UCVVIkAXley/ZNUB3XxcPAy3Lbz6434G6KkaE+e6+IqJXWmdJX7fS3v6GI
         yB9mb47cw7Ceek1NdN2IVA9rDkyQeYf8NtNuj2aZOvEAs//ipywVAzpUiVESIQM4dp
         u/39krzglWywVDVg7TEb3hK1snYlC+N1BuLLJOz+NYUPqWA0wbt49XMnJpAJXVQ2+G
         R4d6O3hYXZPlxr35XWWsvICRsmOIwx1fn4Y/mZwHftQxrkfbqjTv9ban9vrXAkMw6R
         7DnH8e2TBcijtG+F7Aluvs4gG8M1+/NnH2c5SZoj+H/tPEbZyWYW/M7KhBYnnXppZr
         uk2YyztODXiSA==
Message-ID: <e56b14a494ec35989372f505264cc68e9352c8b9.camel@kernel.org>
Subject: Re: [PATCH v5 12/12] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
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
Date:   Thu, 09 Sep 2021 16:58:52 +0300
In-Reply-To: <20210907160110.2699645-13-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <20210907160110.2699645-13-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-09-07 at 12:01 -0400, Eric Snowberg wrote:
> With the introduction of uefi_check_trust_mok_keys, it signifies the end-
> user wants to trust the machine keyring as trusted keys.  If they have
> chosen to trust the machine keyring, load the qualifying keys into it
> during boot, then link it to the secondary keyring .  If the user has not
> chosen to trust the machine keyring, it will be empty and not linked to
> the secondary keyring.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

I would not worry too much applying the code changes if the story
part made sense (to *almost anyone*) in the cover letter.

/Jarkko
