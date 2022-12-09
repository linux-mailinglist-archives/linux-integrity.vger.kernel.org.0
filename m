Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5CA648662
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Dec 2022 17:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiLIQQE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Dec 2022 11:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLIQPv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Dec 2022 11:15:51 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C0A80A18;
        Fri,  9 Dec 2022 08:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670602550;
        bh=+mlKx63NA5e7YuHIFGoTjYHHNKewPSbGFbu2Vyi7sd4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=a027KazE/8xLuI/TT95Mgn1z5OoboU0d0cslu0LMzyfXdXbDZr28KAvyXVbke9MM3
         IrWpSeadTjd5oeAVuIQTl16BomOw7hlkAPht0vG4I5gVk5T+0ox8rF9IeR6KeFk7jV
         vWGpIuTZR0RL1hKSd91hrVrpIyZiKs4H2BQK2hLc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D734E1285ED4;
        Fri,  9 Dec 2022 11:15:50 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kjuxsnYbrp2c; Fri,  9 Dec 2022 11:15:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670602550;
        bh=+mlKx63NA5e7YuHIFGoTjYHHNKewPSbGFbu2Vyi7sd4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=a027KazE/8xLuI/TT95Mgn1z5OoboU0d0cslu0LMzyfXdXbDZr28KAvyXVbke9MM3
         IrWpSeadTjd5oeAVuIQTl16BomOw7hlkAPht0vG4I5gVk5T+0ox8rF9IeR6KeFk7jV
         vWGpIuTZR0RL1hKSd91hrVrpIyZiKs4H2BQK2hLc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 40AAA1285E6B;
        Fri,  9 Dec 2022 11:15:50 -0500 (EST)
Message-ID: <4406801fabc0c9dee9a17b045a392e5f8ab27aa6.camel@HansenPartnership.com>
Subject: Re: [PATCH 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Date:   Fri, 09 Dec 2022 11:15:48 -0500
In-Reply-To: <20221209160611.30207-7-James.Bottomley@HansenPartnership.com>
References: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
         <20221209160611.30207-7-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-12-09 at 11:06 -0500, James Bottomley wrote:
> Signed-off-by: James Bottomley
> <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto API
> parts

Ard,

I kept your reviewed by because the only minor change to this code over
the last four years I've been running it is to accommodate the crypto
layer move of the curve type from the key to the algorithm specifier
(6763f5ea2d9a crypto: ecdh - move curve_id of ECDH from the key to
algorithm name)

Regards,

James

