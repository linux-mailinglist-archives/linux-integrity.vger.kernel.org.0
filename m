Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A5340003
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Mar 2021 08:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCRHHE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Mar 2021 03:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCRHHC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Mar 2021 03:07:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04ABC06175F
        for <linux-integrity@vger.kernel.org>; Thu, 18 Mar 2021 00:07:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lMmkF-0004vU-6M; Thu, 18 Mar 2021 08:06:59 +0100
Subject: Re: [PATCH] KEYS: trusted: tee: fix build error due to missing
 include
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210317142904.27855-1-a.fatoum@pengutronix.de>
 <YFJ7UOagBgm5Fn0/@kernel.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <94f5e918-21d4-ddbb-1db5-35c7f8be347a@pengutronix.de>
Date:   Thu, 18 Mar 2021 08:06:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YFJ7UOagBgm5Fn0/@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On 17.03.21 22:57, Jarkko Sakkinen wrote:
> On Wed, Mar 17, 2021 at 03:29:05PM +0100, Ahmad Fatoum wrote:
>> MODULE_DEVICE_TABLE is defined in <linux/module.h>, which is not
>> included. Add the include to fix the build error its lack caused.
>>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> Hi, I appreciate your work, thanks for taking action, but unfortunately
> I already incorporated this fix to the original patch.

Nothing unfortunate about this! :)

Cheers,
Ahmad

> 
> /Jarkko
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
