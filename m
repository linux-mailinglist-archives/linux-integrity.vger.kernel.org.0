Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F15AFE95
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 10:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiIGILM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 04:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiIGILK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 04:11:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92DA7FE48
        for <linux-integrity@vger.kernel.org>; Wed,  7 Sep 2022 01:11:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1oVq8u-0003JH-A5; Wed, 07 Sep 2022 10:10:40 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1oVq8p-0008M0-VS; Wed, 07 Sep 2022 10:10:36 +0200
Message-ID: <843e1f1cbed67ce558e20d1e56a82dfe27732028.camel@pengutronix.de>
Subject: Re: [EXT] Re: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Reply-To: jlu@pengutronix.de
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "michael@walle.cc" <michael@walle.cc>,
        "john.ernberg@actia.se" <john.ernberg@actia.se>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "j.luebbe@pengutronix.de" <j.luebbe@pengutronix.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Date:   Wed, 07 Sep 2022 10:10:34 +0200
In-Reply-To: <DU2PR04MB86303DE3507B6FF37BD5B6A595419@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
         <YxcLqepquOuOOjvq@kernel.org>
         <DU2PR04MB86303DE3507B6FF37BD5B6A595419@DU2PR04MB8630.eurprd04.prod.outlook.com>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-09-07 at 07:22 +0000, Pankaj Gupta wrote:
> Even if somehow the key is retrieved from the keyring, the retrieved key 
> would be an encrypted key.
> This encrypted key can only be decrypted by Hardware, which generated it.
> 
> Hence, the retrieved key is unusable outside of the hardware.

NXP's CAAM unit (i.e. on i.MX6) supports several modes of sealed/encrypted keys.
The (un)sealing process uses a key that is normally derived from a per-device
key in eFUSES. One aspect of these modes is whether the plaintext key material
is accessible to the kernel or not.

Ahmad's patch set added support for a mode where the CAAM is used to seal
plaintext known to the kernel to a "blob" (in CAAM terminology) on export to
userspace and the reverse on import. This mode allows the kernel to use the
plaintext for dm-crypt, to encrypt other keyrings and similar.

The CAAM has another sealing mode, where it will not allow writing of the
plaintext key to memory. Instead, it is kept in one of the CAAM-internal key
registers. There, it can be used for cryptographic operations (i.e. AES). This
way, the plaintext key is protected even from the kernel. The kernel could keep
a copy of in sealed form, so it can reload the CAAM's key register when needed.


Pankaj, is that the mode you intend to support with this series?

Could you describe the high-level use-cases this would be need for, compared to
the existing mode where plaintext keys are accessible to the kernel? In which
cases would you use each mode?

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

