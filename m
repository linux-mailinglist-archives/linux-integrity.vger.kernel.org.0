Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125147323C1
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 01:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjFOXjF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jun 2023 19:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbjFOXjE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jun 2023 19:39:04 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D392955
        for <linux-integrity@vger.kernel.org>; Thu, 15 Jun 2023 16:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1686872339;
        bh=kufQise8i4090Kn8lSJ5zTFFJL6uHnVTcElHpYrBb6Q=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=p7/PgDt12rbVmxUs9wJ7fWsjGy/zGEN3LRhYoDbchewOMU0b8IB1wpGAshwEG/kdp
         u01Slv8Fvv7BMS/II9ASE7hRxwhfagiOy9rrqOZTSS3gKDcn5JkGv+cIPtM3gH09Uz
         bhrSPpF6/DNzAJrkQrho90D1tnWp1CVlN9sY/sVM=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EF14D1285E1C;
        Thu, 15 Jun 2023 19:38:59 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id BBNtsAeoUxFx; Thu, 15 Jun 2023 19:38:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1686872339;
        bh=kufQise8i4090Kn8lSJ5zTFFJL6uHnVTcElHpYrBb6Q=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=p7/PgDt12rbVmxUs9wJ7fWsjGy/zGEN3LRhYoDbchewOMU0b8IB1wpGAshwEG/kdp
         u01Slv8Fvv7BMS/II9ASE7hRxwhfagiOy9rrqOZTSS3gKDcn5JkGv+cIPtM3gH09Uz
         bhrSPpF6/DNzAJrkQrho90D1tnWp1CVlN9sY/sVM=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3DFE31285E1B;
        Thu, 15 Jun 2023 19:38:59 -0400 (EDT)
Message-ID: <d157ccc308103b8bf158c903dfa53ee723db58fb.camel@HansenPartnership.com>
Subject: Re: Avoiding EBUSY on TPM writes
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Date:   Thu, 15 Jun 2023 19:38:57 -0400
In-Reply-To: <20230615210946.GA13094@srcf.ucam.org>
References: <20230615210946.GA13094@srcf.ucam.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-06-15 at 22:09 +0100, Matthew Garrett wrote:
> We're running into a situation where concurrent TPM accesses can
> trigger EBUSY on write due to there either being a queued command or
> a response not yet having been read. Obviously one approach would be
> to retry, but  that involves us either spinning or waiting for an
> arbitrary amount of  time between attempts, which doesn't seem ideal.
> There's a poll  interface that tells us whether there's a response to
> read but (a) that  doesn't help in the enqueued command situation and
> (b) this would still  be racy - we could be notified that the
> response has been read, be  preempted, and have another process
> perform a write before we get the opportunity to.

That's by design: the fd interface is command/response per open fd, so
if you try to send another command before you get a response you'll get
an EBUSY by design.  If you didn't, how would you know which response
belonged to which command (there's no counter or other identifier)?

However, this behaviour is per-fd, why can't you just open multiple
fd's for your multiple accesses?  /dev/tpmrm0 will assure that they
don't see each other and that the commands are properly sequenced
without giving you an EBUSY.  And bonus you don't have to keep global
track of how many transient resources you've used.

James

