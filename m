Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F4C318857
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 11:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhBKKit (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 05:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhBKKgp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 05:36:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38A7C061756
        for <linux-integrity@vger.kernel.org>; Thu, 11 Feb 2021 02:34:34 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lA9Ip-0004Vc-KZ; Thu, 11 Feb 2021 11:34:27 +0100
Subject: Re: [PATCH v8 1/4] KEYS: trusted: Add generic trusted keys framework
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-security-module@vger.kernel.org, daniel.thompson@linaro.org,
        op-tee@lists.trustedfirmware.org, corbet@lwn.net,
        jejb@linux.ibm.com, janne.karhunen@gmail.com,
        linux-doc@vger.kernel.org, jmorris@namei.org, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        lhinds@redhat.com, keyrings@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, Markus.Wamser@mixed-mode.de,
        casey@schaufler-ca.com, linux-integrity@vger.kernel.org,
        jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org,
        serge@hallyn.com
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-2-git-send-email-sumit.garg@linaro.org>
 <YCQRPo0o6MZ0pcUa@kernel.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <f51409f7-05b4-31b6-f1c5-d9e6d7c0bb46@pengutronix.de>
Date:   Thu, 11 Feb 2021 11:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCQRPo0o6MZ0pcUa@kernel.org>
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

Hello Jarkko,

On 10.02.21 18:00, Jarkko Sakkinen wrote:
> On Tue, Nov 03, 2020 at 09:31:43PM +0530, Sumit Garg wrote:
>> +	case Opt_new:
>> +		key_len = payload->key_len;
>> +		ret = static_call(trusted_key_get_random)(payload->key,
>> +							  key_len);
>> +		if (ret != key_len) {
>> +			pr_info("trusted_key: key_create failed (%d)\n", ret);
>> +			goto out;
>> +		}
> 
> This repeats a regression in existing code, i.e. does not check
> "ret < 0" condition. I noticed this now when I rebased the code
> on top of my fixes.
> 
> I.e. it's fixed in my master branch, which caused a merge conflict,
> and I found this.

Does that mean this series will go out for the next merge window?
Can you point me where your git tree is, so I can rebase on top?

> 
> /Jarkko
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
