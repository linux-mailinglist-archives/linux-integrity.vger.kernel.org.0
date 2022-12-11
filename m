Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F9764960F
	for <lists+linux-integrity@lfdr.de>; Sun, 11 Dec 2022 21:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLKUCD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Dec 2022 15:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKUCC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Dec 2022 15:02:02 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACDABCA9;
        Sun, 11 Dec 2022 12:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670788919;
        bh=BObJ8X9xMcvldFZWCha1qp57q/IaizJ/YT5qHAyBxLQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=pwJeAeegTQZ7UbE+4Bhf81yLOEpej9zr1zEQIOK4IfthGPy6Gcr/BpmlopAQmmhPx
         g//2VnYIYyHL+bbagrdR+byenZeYDXXUuF3a1NAiso8HYiGJoDax7phmZa1I218nGd
         evaav/Roqrtj1Ej3PJv1s8xBgXRzmG1FrgjSSQRk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 93C7A1281B54;
        Sun, 11 Dec 2022 15:01:59 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lObUrYfBeijH; Sun, 11 Dec 2022 15:01:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670788919;
        bh=BObJ8X9xMcvldFZWCha1qp57q/IaizJ/YT5qHAyBxLQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=pwJeAeegTQZ7UbE+4Bhf81yLOEpej9zr1zEQIOK4IfthGPy6Gcr/BpmlopAQmmhPx
         g//2VnYIYyHL+bbagrdR+byenZeYDXXUuF3a1NAiso8HYiGJoDax7phmZa1I218nGd
         evaav/Roqrtj1Ej3PJv1s8xBgXRzmG1FrgjSSQRk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id F0C4E1281A47;
        Sun, 11 Dec 2022 15:01:58 -0500 (EST)
Message-ID: <704a88efc2a7cf5c2679af2ca37a682efd6ceaa2.camel@HansenPartnership.com>
Subject: Re: [PATCH 01/11] tpm: move buffer handling from static inlines to
 real functions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        keyrings@vger.kernel.org
Date:   Sun, 11 Dec 2022 15:01:57 -0500
In-Reply-To: <Y5PqRdlEdBjj72KM@kernel.org>
References: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
         <20221209160611.30207-2-James.Bottomley@HansenPartnership.com>
         <Y5PqRdlEdBjj72KM@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2022-12-10 at 02:09 +0000, Jarkko Sakkinen wrote:
> On Fri, Dec 09, 2022 at 11:06:01AM -0500, James Bottomley wrote:
> > This separates out the old tpm_buf_... handling functions from
> > static
> > inlines in tpm.h and makes them their own tpm-buf.c file.  This is
> > a
> > precursor so we can add new functions for other TPM type handling
> > 
> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> 
> I don't comprehend that explanation at all.
> 
> Please, add a bit more detail why this precursory change is required.

It's the usual submitting-patches requirement of moving code first
before modifying it.  Since it's the recommended way of doing things in
our process docs, I'm not sure how much more explanation can be given.

James

