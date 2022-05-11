Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EFD523E8E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 22:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbiEKUMy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 16:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiEKUMY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 16:12:24 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0531F9A0C
        for <linux-integrity@vger.kernel.org>; Wed, 11 May 2022 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1652299940;
        bh=TZ96nFUoy4ItquLnLGZHQelrrGX6tD17Umvjt9VhEhY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=YOOLwxWOb4hts+xt6qfaBLK/YsoOjxmOESibSpoI5avvO7W19GWtrxYM5nJv2vJRH
         8eipurpo1VMGoze3LmKwhi3GjrkEl4l2CMMcZ93gyf2j78Q7LZQicFyRW7gFrhol7P
         5a3pQY0mAg9Gi/bFhu0FOsInlXKttItxv6JTmmmE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DB4761280D84;
        Wed, 11 May 2022 16:12:20 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4DfTenkQ6VpM; Wed, 11 May 2022 16:12:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1652299940;
        bh=TZ96nFUoy4ItquLnLGZHQelrrGX6tD17Umvjt9VhEhY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=YOOLwxWOb4hts+xt6qfaBLK/YsoOjxmOESibSpoI5avvO7W19GWtrxYM5nJv2vJRH
         8eipurpo1VMGoze3LmKwhi3GjrkEl4l2CMMcZ93gyf2j78Q7LZQicFyRW7gFrhol7P
         5a3pQY0mAg9Gi/bFhu0FOsInlXKttItxv6JTmmmE=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 393B11280064;
        Wed, 11 May 2022 16:12:20 -0400 (EDT)
Message-ID: <e3ce7c535e27369c07500064dc25c2fc8e7b3f86.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Johannes Holland <johannes.holland@infineon.com>,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca
Date:   Wed, 11 May 2022 16:12:18 -0400
In-Reply-To: <20220510112902.23213-1-johannes.holland@infineon.com>
References: <20220510112902.23213-1-johannes.holland@infineon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-05-10 at 13:29 +0200, Johannes Holland wrote:
> To comply with protocol requirements, minimum polling times must
> often be adhered to. Therefore, a macro like tpm_msleep() should
> sleep at least the given amount of time (not up to the given period).
> Have tpm_msleep() sleep at least the given number of milliseconds.
> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>

This seems to fix the problem I reported years ago with my Nuvoton
laptop TPM.

https://lore.kernel.org/linux-integrity/1531328689.3260.8.camel@HansenPartnership.com/

It probably needs to soak a bit longer to declare victory (this timeout
failure is very intermittent), but it looks hopeful.

Regards,

James


