Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AE051C62B
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350737AbiEERiC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 May 2022 13:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382727AbiEERiA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 May 2022 13:38:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A154FB2
        for <linux-integrity@vger.kernel.org>; Thu,  5 May 2022 10:34:20 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nmfMT-0002m8-KI; Thu, 05 May 2022 19:33:57 +0200
Message-ID: <09e2552c-7392-e1da-926b-53c7db0b118d@pengutronix.de>
Date:   Thu, 5 May 2022 19:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v8 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Content-Language: en-US
To:     John Ernberg <john.ernberg@actia.se>
Cc:     "andreas@rammhold.de" <andreas@rammhold.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "franck.lenormand@nxp.com" <franck.lenormand@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "j.luebbe@pengutronix.de" <j.luebbe@pengutronix.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "pankaj.gupta@nxp.com" <pankaj.gupta@nxp.com>,
        "richard@nod.at" <richard@nod.at>,
        "s.trumtrar@pengutronix.de" <s.trumtrar@pengutronix.de>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
References: <20220428140145.870527-1-a.fatoum@pengutronix.de>
 <20220505145756.2492566-1-john.ernberg@actia.se>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220505145756.2492566-1-john.ernberg@actia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello John,

On 05.05.22 16:58, John Ernberg wrote:
> Gave this a go on iMX8QXP with Linux 5.17.5 and I can't quite get it working.
> 
> I get -ENODEV from add_key() via keyctl. When I traced it in dmesg I couldn't
> get an as clear picture as I would like but CAAM (and thus possibly JRs?)
> initialzing after trusted_key.
> 
> dmesg snips:
> [    1.296772] trusted_key: Job Ring Device allocation for transform failed
> ...
> [    1.799768] caam 31400000.crypto: device ID = 0x0a16040000000100 (Era 9)
> [    1.807142] caam 31400000.crypto: job rings = 2, qi = 0
> [    1.822667] caam algorithms registered in /proc/crypto
> [    1.830541] caam 31400000.crypto: caam pkc algorithms registered in /proc/crypto
> [    1.841807] caam 31400000.crypto: registering rng-caam
> 
> I didn't quite have the time to get a better trace than that.

I don't see a crypto@31400000 node upstream. Where can I see your device tree?
Initcall ordering does the right thing, but if CAAM device probe is deferred beyond
late_initcall, then it won't help.

This is a general limitation with trusted keys at the moment. Anything that's
not there by the time of the late_initcall won't be tried again. You can work
around it by having trusted keys as a module. We might be able to do something
with fw_devlinks in the future and a look into your device tree would help here,
but I think that should be separate from this patch series.

Please let me know if the module build improves the situation for you.

Cheers,
Ahmad

>
> Best regards // John Ernberg


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
