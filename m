Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB6851963D
	for <lists+linux-integrity@lfdr.de>; Wed,  4 May 2022 06:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbiEDENK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 00:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiEDENJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 00:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A2F2180E;
        Tue,  3 May 2022 21:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77DA461994;
        Wed,  4 May 2022 04:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD95C385A4;
        Wed,  4 May 2022 04:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651637373;
        bh=MRs4nB2lV3N57W1w2TRtVbdRp6xHsxyYRmRSSLkKL2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLoLN7zvcgI3p2rlMEzh94MwRo/MGTXspasaHzXxS+BKIine0R1Tkxqo4EgUB3HF1
         WtoOUg3KyEDnqMYjn0sV5sX9M35eVG3FOwsXse5PDa2bHemurz3+YREgfijN3c+6Yh
         6652LILOHFoSJAbXfU0/258qoVj1uoIupKHEEOl2n6kIQxGf3KVq/1id8kO91zVunU
         +C+UGmBoXbxY+ObC2OAT/lg7ea8E86lJ3OYBvHDXqNjsad/NG6g5B2Ffe2ul3KVl06
         S4bOEqs16yD2FyBDDFNwzX8M3mWlTZmUWhxdNXPA5BcXLjcKKtIywdEZsTQWRB6tMp
         LdU3t7OEmnOPw==
Date:   Wed, 4 May 2022 07:08:08 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Horia Geanta <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andreas Rammhold <andreas@rammhold.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [EXT] [PATCH v7 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Message-ID: <YnH8KGGubFFMcRRU@kernel.org>
References: <20220415205647.46056-1-a.fatoum@pengutronix.de>
 <DU2PR04MB86306B75C018C7CAB9FFA57195FD9@DU2PR04MB8630.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR04MB86306B75C018C7CAB9FFA57195FD9@DU2PR04MB8630.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 28, 2022 at 12:50:50PM +0000, Pankaj Gupta wrote:
> Hi Ahmad,
> 
> I have tested the patch-set.
> It is working as expected even when CAAM is compiled as kernel module.
> 
> Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Tested-by: Pankaj Gupta <pankaj.gupta@nxp.com>

1. Please do not top-post.
2. Tag the exact patches you tested.

BR, Jarkko
