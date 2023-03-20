Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C254C6C10AE
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 12:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCTLW6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 07:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCTLW4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 07:22:56 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C88F
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1679311374;
        bh=AqSBtfxK7tcW0Lcgsn0eHeVwa6/RRsGnWQTGw87w5fQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=AVR7g0ufT9X6XcPVPblUkOUTVHZ34VDWXNp4fFonCIExlpDRWsZEagJ+bGo+vXjPt
         oQfM9OxvU6LAamvPw5J3manBPBQiK1YpUXrXJpah4z+V3XLsBr1vjx76H9OxfgnozG
         cxDZ/Ipg3pGryBrBCcmHFlwG5B36kKL1QkNFnl6I=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DF78C1281DCE;
        Mon, 20 Mar 2023 07:22:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Di3OiHIqFHiJ; Mon, 20 Mar 2023 07:22:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1679311374;
        bh=AqSBtfxK7tcW0Lcgsn0eHeVwa6/RRsGnWQTGw87w5fQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=AVR7g0ufT9X6XcPVPblUkOUTVHZ34VDWXNp4fFonCIExlpDRWsZEagJ+bGo+vXjPt
         oQfM9OxvU6LAamvPw5J3manBPBQiK1YpUXrXJpah4z+V3XLsBr1vjx76H9OxfgnozG
         cxDZ/Ipg3pGryBrBCcmHFlwG5B36kKL1QkNFnl6I=
Received: from [172.20.7.43] (96-86-69-187-static.hfc.comcastbusiness.net [96.86.69.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 19B1712819BC;
        Mon, 20 Mar 2023 07:22:54 -0400 (EDT)
Message-ID: <5cf966e97f9a0fabdf8d3b5a0cbae90abe484813.camel@HansenPartnership.com>
Subject: Re: tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Date:   Mon, 20 Mar 2023 07:22:52 -0400
In-Reply-To: <de3ee520780be213c421685805c751dcda0754df.camel@HansenPartnership.com>
References: <de3ee520780be213c421685805c751dcda0754df.camel@HansenPartnership.com>
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

On Mon, 2023-03-20 at 07:15 -0400, James Bottomley wrote:
> The test for the AMD fTPM problem, which just went in, actually uses
> the wrong function template for request_locality().  It's missing an
> argument so the build breaks:
> 
> drivers/char/tpm/tpm-chip.c:568:8: error: too few arguments to
> function ‘tpm_request_locality’
>   ret = tpm_request_locality(chip);
>         ^~~~~~~~~~~~~~~~~~~~
> drivers/char/tpm/tpm-chip.c:43:12: note: declared here
>  static int tpm_request_locality(struct tpm_chip *chip, int locality)
>             ^~~~~~~~~~~~~~~~~~~~
> 
> Fix this by requesting zero locality.

Actually, this is a bad interaction with the non-upstream patch to run
the kernel in locality two to allow key policy to distinguish kernel
release from user space release, which goes back to the debate over
hibernation keys.  I'll carry it separately until (or if ever) we get a
resolution on how to do this.

James

