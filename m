Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B426D6D08
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Apr 2023 21:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjDDTSx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Apr 2023 15:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjDDTSw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Apr 2023 15:18:52 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3E93A92;
        Tue,  4 Apr 2023 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680635927;
        bh=gvpij8NJZEfyuElDO07VEbkFJc4bMaa52Rnb6/fw6Mw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=FHGKSDNl0JHzsZg9FZR03Yrxo7G3bLJAAphonGroJcwzCxegnn8oBiKtGXiWuzej3
         qxh8WFkNndJT5KJzfxD5si/r6eJXHK3ldiFrxuU9IQJsaZrMW3vnaSU00SU3mY4/PF
         r1kv0hF1acO2nomD86+B28XIwg/hiCtdXBUmDr7s=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E2D4212864A8;
        Tue,  4 Apr 2023 15:18:47 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ULZ-QakCYFEa; Tue,  4 Apr 2023 15:18:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680635927;
        bh=gvpij8NJZEfyuElDO07VEbkFJc4bMaa52Rnb6/fw6Mw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=FHGKSDNl0JHzsZg9FZR03Yrxo7G3bLJAAphonGroJcwzCxegnn8oBiKtGXiWuzej3
         qxh8WFkNndJT5KJzfxD5si/r6eJXHK3ldiFrxuU9IQJsaZrMW3vnaSU00SU3mY4/PF
         r1kv0hF1acO2nomD86+B28XIwg/hiCtdXBUmDr7s=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 06DE6128649C;
        Tue,  4 Apr 2023 15:18:46 -0400 (EDT)
Message-ID: <414fd2f5e49f9772dd1de4bd281a63e27e60e934.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 00/13] add integrity and security to TPM2 transactions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 04 Apr 2023 15:18:45 -0400
In-Reply-To: <CAFftDdpTWjtNEf=E5V0X1c5ZrG=LQKo1WH6n0Ok2DE7jsh6yqg@mail.gmail.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
         <CAFftDdpTWjtNEf=E5V0X1c5ZrG=LQKo1WH6n0Ok2DE7jsh6yqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-04-04 at 13:43 -0500, William Roberts wrote:
[...]
> > The final part of the puzzle is that the machine owner must have a
> > fixed idea of the EK of their TPM and should have certified this
> > with the TPM manufacturer.  On every boot, the certified EK public
> > key should be used to do a make credential/activate credential
> > attestation key insertion and then the null key certified with the
> > attestation key.  We can follow a trust on first use model where an
> > OS installation will extract and verify a public EK and save it to
> > a read only file.
> 
> Ahh I was wondering how you were going to bootstrap trust using the
> NULL hierarchy.

Well, actually, I changed my mind on the details of this one: the make
credential/activate credential round trip is a huge faff given that
there's no privacy issue.  I think what we should do is simply store
the name of a known signing EK on first install (using the standard P-
256 derivation of the EK template but with TPMA_OBJECT_SIGN
additionally set).  Then you can use the signing EK to certify the NULL
key directly and merely check the signing EK name against the stored
value to prove everything is correct.

James

