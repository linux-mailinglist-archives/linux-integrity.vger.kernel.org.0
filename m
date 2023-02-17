Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD8269ADF4
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Feb 2023 15:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBQOXH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Feb 2023 09:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjBQOXD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Feb 2023 09:23:03 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F1459CF;
        Fri, 17 Feb 2023 06:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1676643766;
        bh=wnHtQHm3Vd0BAGqOohSWpT4bj2ozCkSo/O3DEebTsT8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=eY/sXyjSCnMd94zmvR5HFOWJieP5BI5QZT2nxPEkaXMnC21UdWuymVf3I4TksIPlR
         OqSVTlmUJ2Uf9f+iEtFXaRLfrnoYoVyc8LlIV3kJVjKeuAwHaG50yKPQvtslhKk7uL
         HVSr+b+Hrs4P/cw3B1l9aoCXx3G5Vtlfz1I4MlCA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C01451286A27;
        Fri, 17 Feb 2023 09:22:46 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lKs10U9DBOOm; Fri, 17 Feb 2023 09:22:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1676643766;
        bh=wnHtQHm3Vd0BAGqOohSWpT4bj2ozCkSo/O3DEebTsT8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=eY/sXyjSCnMd94zmvR5HFOWJieP5BI5QZT2nxPEkaXMnC21UdWuymVf3I4TksIPlR
         OqSVTlmUJ2Uf9f+iEtFXaRLfrnoYoVyc8LlIV3kJVjKeuAwHaG50yKPQvtslhKk7uL
         HVSr+b+Hrs4P/cw3B1l9aoCXx3G5Vtlfz1I4MlCA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0AA251286948;
        Fri, 17 Feb 2023 09:22:45 -0500 (EST)
Message-ID: <261954a66afd92a6d09b1097191f717bbb54b7d1.camel@HansenPartnership.com>
Subject: Re: [PATCH 07/12] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 17 Feb 2023 09:22:43 -0500
In-Reply-To: <202302171905.Ornmq8g3-lkp@intel.com>
References: <20230216201410.15010-8-James.Bottomley@HansenPartnership.com>
         <202302171905.Ornmq8g3-lkp@intel.com>
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

On Fri, 2023-02-17 at 19:30 +0800, kernel test robot wrote:
[...]
> > > ERROR: modpost: "aescfb_encrypt" [drivers/char/tpm/tpm.ko]
> > > undefined!
> > > ERROR: modpost: "aescfb_decrypt" [drivers/char/tpm/tpm.ko]
> > > undefined!

Ard,

This happens because your aescfb_encrypt/decrypt() routines are missing
EXPORT_SYMBOL statements.

Regards,

James


