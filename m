Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6FA52AAB7
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 20:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352086AbiEQS1v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240924AbiEQS1r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 14:27:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9034738A
        for <linux-integrity@vger.kernel.org>; Tue, 17 May 2022 11:27:46 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nr1up-0006SK-Go; Tue, 17 May 2022 20:27:27 +0200
Message-ID: <51473b0c-657e-9661-c9e1-5a066c5719d3@pengutronix.de>
Date:   Tue, 17 May 2022 20:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 2/7] KEYS: trusted: allow use of kernel RNG for key
 material
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Sumit Garg <sumit.garg@linaro.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        David Gstir <david@sigma-star.at>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <20220513145705.2080323-3-a.fatoum@pengutronix.de>
 <YoPa7C8xs8lgKtwv@zx2c4.com>
 <21250bc0-623b-f11d-7dbf-458d144b7963@pengutronix.de>
 <YoPizavHFXHah2z3@zx2c4.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <YoPizavHFXHah2z3@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Jason,

On 17.05.22 20:00, Jason A. Donenfeld wrote:
> On Tue, May 17, 2022 at 07:52:51PM +0200, Ahmad Fatoum wrote:
>> The trusted keys module is trusted.ko and directly before my added lines is
>> the trusted.source=  documentation, so I think this is already at the correct place.
> 
> My apologies; I should have looked at the file itself instead of just
> relying on git line context. You're right, the module itself is called
> trusted.ko. This is confusing (shouldn't it be trusted_keys or
> something?)

Encrypted keys are encrypted-keys.ko, so ye, trusted.ko is a bit unfortunate..

> , but what you propose sounds consistent from a namespacing
> perspective with what's already there.

Thanks!
Ahmad

> 
> Jason
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
