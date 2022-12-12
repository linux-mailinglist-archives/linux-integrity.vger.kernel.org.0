Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801F3649824
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Dec 2022 04:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiLLDNR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Dec 2022 22:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLLDNQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Dec 2022 22:13:16 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0196440;
        Sun, 11 Dec 2022 19:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670814794;
        bh=3pwUeiuQl2P6ZzeWQP7mWvlObCqVesXJUIe5ZOYF/+c=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Y9pIpYfAk46K/YSzlZsmZByg8puCl8k/rMPzA9fvqumvIo2JAhRf+hZTBEjTYMj2N
         yRVf46zw5VH3PJF1N8dIrZPhpIO/gm5n2wV4f7W7nmAakMMvYWECnUfNq2opXxwpZC
         B4v0FVgDgwnPcIfbMjHcnnauwuZGLWdQIWv+gi7o=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BA8C21280C74;
        Sun, 11 Dec 2022 22:13:14 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vjleZP4xKEMS; Sun, 11 Dec 2022 22:13:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670814794;
        bh=3pwUeiuQl2P6ZzeWQP7mWvlObCqVesXJUIe5ZOYF/+c=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Y9pIpYfAk46K/YSzlZsmZByg8puCl8k/rMPzA9fvqumvIo2JAhRf+hZTBEjTYMj2N
         yRVf46zw5VH3PJF1N8dIrZPhpIO/gm5n2wV4f7W7nmAakMMvYWECnUfNq2opXxwpZC
         B4v0FVgDgwnPcIfbMjHcnnauwuZGLWdQIWv+gi7o=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 13CA7128064E;
        Sun, 11 Dec 2022 22:13:13 -0500 (EST)
Message-ID: <08f138d9df19b508bc4892d34f117ac15db9570a.camel@HansenPartnership.com>
Subject: Re: [PATCH 03/11] tpm: add cursor based buffer functions for
 response parsing
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        keyrings@vger.kernel.org
Date:   Sun, 11 Dec 2022 22:13:12 -0500
In-Reply-To: <Y5Z62HPEDHGaK+Uq@kernel.org>
References: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
         <20221209160611.30207-4-James.Bottomley@HansenPartnership.com>
         <Y5Z62HPEDHGaK+Uq@kernel.org>
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

On Mon, 2022-12-12 at 00:50 +0000, Jarkko Sakkinen wrote:
> On Fri, Dec 09, 2022 at 11:06:03AM -0500, James Bottomley wrote:
> > It's very convenient when parsing responses to have a cursor you
> > simply move over the response extracting the data.  Add such cursor
> > functions for the TPM unsigned integer types.
> > 
> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> 
> Saying that something is convenient is not really an argument.
> 
> What you are going to use it for? Is it complex enough that what we
> have not doesn't scale. I'd just answer these questions and write
> more reasonable commit message.

It's all used int patch 6 which gets into the complex building of
authenticated and hmac'd requests and responses via sessions using
these primitives.

James

