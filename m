Return-Path: <linux-integrity+bounces-557-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A381B342
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Dec 2023 11:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C653FB2428B
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Dec 2023 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032C64F602;
	Thu, 21 Dec 2023 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="k4kmueI8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ADA51039;
	Thu, 21 Dec 2023 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1703153477; x=1734689477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5ZnwB0Mkp23zI0UrzDs+gOm1+x3wrtuME4pCko7xwcE=;
  b=k4kmueI80Twm2t1TUtYrY/PxUGECiW1HbniG+zMuDx7F+E47BkMqANea
   Luy4WPWBJs0mDq7db6Zxuh/u7/hT5ryBuU733tU9cwSD6GAllSTi1Hgr/
   Ben+rS7n+xcxrspjFfYM+ZoApDmoKg13557N9u0OEoAK5GdwEeWJQYeJA
   A=;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="38373642"
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="38373642"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 11:10:05 +0100
Received: from MUCSE844.infineon.com (172.23.7.73) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 11:10:03 +0100
Received: from [10.160.230.42] (10.160.230.42) by MUCSE844.infineon.com
 (172.23.7.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 11:10:03 +0100
Message-ID: <d21fdf8b-571b-4783-8a20-7290b4b3f46b@infineon.com>
Date: Thu, 21 Dec 2023 11:09:57 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] reset: Add Infineon SLB9670 TPM reset driver
To: Lukas Wunner <lukas@wunner.de>, Francesco Dolcini <francesco@dolcini.it>
CC: Lino Sanfilippo <l.sanfilippo@kunbus.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, <linux-integrity@vger.kernel.org>,
	<devicetree@vger.kernel.org>
References: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
 <75b775d0526e72f292e0546a306b37680714686c.1695754856.git.lukas@wunner.de>
 <ZV0+Zk590YSsvhFo@francesco-nb.int.toradex.com>
 <20231122112949.GA18812@wunner.de>
 <ZV4bBowT9ij+BQup@francesco-nb.int.toradex.com>
 <20231123085943.GA15463@wunner.de>
 <ZYCCiMzTQWztcFk9@francesco-nb.int.toradex.com>
 <20231218175137.GA12115@wunner.de>
From: Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <20231218175137.GA12115@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MUCSE820.infineon.com (172.23.29.46) To
 MUCSE844.infineon.com (172.23.7.73)

On 18.12.2023 18:51, Lukas Wunner wrote:
> Hi Francesco,
> 
> On Mon, Dec 18, 2023 at 06:34:00PM +0100, Francesco Dolcini wrote:
>> On Thu, Nov 23, 2023 at 09:59:43AM +0100, Lukas Wunner wrote:
>>> On Wed, Nov 22, 2023 at 04:15:18PM +0100, Francesco Dolcini wrote:
>>>> On Wed, Nov 22, 2023 at 12:29:49PM +0100, Lukas Wunner wrote:
>>>>> On Wed, Nov 22, 2023 at 12:33:58AM +0100, Francesco Dolcini wrote:
>>>>>> Not to mention that I was able to see the driver probe succeed in a
>>>>>> similar setup to the one you are describing in the commit message
>>>>>> (different board, arm64, but nothing done by the platform firmware).
>>>>>
>>>>> Hm, is the RST# pin even connected on that board?
>>>>
>>>> Yes, it's connected and it is asserted/de-asserted (aka toggled) during
>>>> startup from the HW reset circuit. However this is not implementing the
>>>> reset sequence you are implementing here.
>>>
>>> Section 4.5 of the datasheet seems to indicate that unless the sequence
>>> in Figure 3 is observed, the TPM may enter a defense mode against
>>> dictionary attacks "from which a recovery is very complex or even not
>>> possible."
>>>
>>> Simply toggling the RST# pin might therefore not be sufficient to ensure
>>> the TPM is operable.
>>
>> I am trying to follow-up with infineon on this regard, do you already
>> have any insight from them maybe?
>>
>> Maybe this procedure is relevant only when the device is in "security
>> defense state"?
> 
> Sorry, I honestly don't know.  A colleague has talked to an FAE at an
> Infineon reseller but they couldn't give a definitive answer either.
> I'm very interested to hear whatever you learn from Infineon.

Infineon is here :)

I'm sorry, the document is a little confusing, we'll fix that in the 
future. What the document wants to say is this: Any time you assert 
RST#, the TPM will reset. But if you reset the TPM at certain points in 
time, you will trigger some security functions. In general, as long as 
it only happens occasionally, this is not a problem (you can't avoid all 
power outages). Only if you happen to frequently issue resets (e.g. if 
your reset pin is not a dedicated TPM reset pin but is also used for 
other things), then you should make sure to wait at least t_RSTIN 
between those resets (and avoid interrupting TPM command execution).

So in your case, you probably don't need to do anything special: Just 
assert RST# once and the TPM will reset. This should work with basically 
any TPM, so there is no need for a dedicated SLB9670 reset driver.

Alexander

