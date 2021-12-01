Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCA5464BEF
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 11:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348805AbhLAKuk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 05:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348797AbhLAKuj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 05:50:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04503C061574
        for <linux-integrity@vger.kernel.org>; Wed,  1 Dec 2021 02:47:19 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1msN8t-0006IR-KT; Wed, 01 Dec 2021 11:47:15 +0100
Subject: Re: [PATCH v4] KEYS: trusted: Fix trusted key backends when building
 as module
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     andreas@rammhold.de, James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20211201095900.3009225-1-a.fatoum@pengutronix.de>
 <YadRAWbl2aiapf8l@iki.fi>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <98c8df77-22c4-ae83-eefd-f55fbb2891e8@pengutronix.de>
Date:   Wed, 1 Dec 2021 11:47:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YadRAWbl2aiapf8l@iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 01.12.21 11:40, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 10:59:00AM +0100, Ahmad Fatoum wrote:
>> From: Andreas Rammhold <andreas@rammhold.de>
>>
>> Before this commit the kernel could end up with no trusted key sources
>> even though both of the currently supported backends (TPM and TEE) were
>> compiled as modules. This manifested in the trusted key type not being
>> registered at all.
>>
>> When checking if a CONFIG_… preprocessor variable is defined we only
>> test for the builtin (=y) case and not the module (=m) case. By using
>> the IS_REACHABLE() macro we do test for both cases.
>>
>> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>> Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
>> Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> Thank you, I picked this.

Excellent. Could I know your opinion on my CAAM Trusted Keys series as well? :-)

Thanks,
Ahmad

> 
> /Jarkko
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
