Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31B6531AC9
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiEWUAs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 16:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiEWUAs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 16:00:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358967939B;
        Mon, 23 May 2022 13:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C41CE60C1D;
        Mon, 23 May 2022 20:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E5DC385A9;
        Mon, 23 May 2022 20:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653336046;
        bh=JY+z+d7cAHPQ6gNjtI2yZLh/aTovUuF16/aRcdgnfMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njt5pfYUeH14X3vXFRh/Vsi1gvaB8qQ7qi8Kb4toIE+vVIqRr6SxMGCq9sqJoCSZn
         S2fej/8xTP2c54TlTIIsOkrVxxbkr3VMVeYUZmGXHmqHtD8XTSqiObzI5mGHlcKSTC
         ZI2k3LGZmIcRL5McG/4QTlEVeV+qrxRXCCCr2z0DSeJ9BBxNyeGzqiTYT8vnzvxX0o
         K/4gh+oFXDol0+nkuNMuJFs/6tZJCTduS59A3A3L2n/OaxDjD+JY9mCTVB52lqgIlp
         HM9H0kv8vaP3AXRGOui+JeC5U2O5ia3fXAaNIH0fOtAtFjx31SMLpmZ5zVfYRjPQLV
         UZE3NEBeFhCjA==
Date:   Mon, 23 May 2022 22:59:05 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Cc:     Johannes Holland <johannes.holland@infineon.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: increase timeout for kselftests
Message-ID: <YovniXv6ATJ/vpt6@kernel.org>
References: <20220510111607.22984-1-johannes.holland@infineon.com>
 <YnvSwJxOg+IZxrxz@kernel.org>
 <51a14f28-ce94-ade9-6512-a265f7b32dfb@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a14f28-ce94-ade9-6512-a265f7b32dfb@infineon.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 20, 2022 at 03:28:42PM +0200, Stefan Mahnke-Hartmann wrote:
> 
> 
> On 11.05.22 17:14, Jarkko Sakkinen wrote:
> > On Tue, May 10, 2022 at 01:16:08PM +0200, Johannes Holland wrote:
> >> Due to CreatePrimary commands which need to create RSA keys of
> >> increasing size, the timeout value need to be raised, as well.
> >> Default is 300s.
> >>
> >> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> >> ---
> >> A timeout of anything below 600s still lead to occasional timeouts for
> >> me. Therefore, I propose 600s as a new value. 
> >>
> >>  tools/testing/selftests/tpm2/settings | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>  create mode 100644 tools/testing/selftests/tpm2/settings
> >>
> >> diff --git a/tools/testing/selftests/tpm2/settings b/tools/testing/selftests/tpm2/settings
> >> new file mode 100644
> >> index 000000000000..919bc3803f03
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/tpm2/settings
> >> @@ -0,0 +1,2 @@
> >> +timeout=600
> >> +
> >> -- 
> >> 2.34.1
> >>
> > Could cope but I did not get why it needs to be raised.
> 
> The TPM2 SpaceTest testsuite currently creates 8 primary RSA 2k keys + 1 for
> setup. Generating a RSA2k key can take up to ~1-2 minutes on some of our TPMs.
> => 2x9 = 18 minutes. In the kernel we even define a duration timeout for rsa2k
> keygen of 5 min per key! (TPM2_DURATION_LONG_LONG = 300000) => up to 45 minutes
> would be "acceptable".
> 
> However since the average key generation time is much faster, a value of ~10
> minutes should be fine enough.
> 
> The reason why you did not experience this yet on your test system is either
> because PTT TPMs are faster in that respect and/or some TPMs implement pre-gen
> mechanisms for key generation, (or just plain luck)
> 
> BR, Stefan
> 
> > BR, Jarkko

I think this is ok.


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
