Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB91F484535
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jan 2022 16:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiADPvb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 10:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiADPva (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 10:51:30 -0500
X-Greylist: delayed 375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jan 2022 07:51:30 PST
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DABC061761
        for <linux-integrity@vger.kernel.org>; Tue,  4 Jan 2022 07:51:30 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4JSxtT3mH9zMptZJ;
        Tue,  4 Jan 2022 16:51:29 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4JSxtR5Z2WzljsVx;
        Tue,  4 Jan 2022 16:51:27 +0100 (CET)
Message-ID: <5030a9ff-a1d1-a9bd-902a-77c3d1d87446@digikod.net>
Date:   Tue, 4 Jan 2022 16:56:36 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andreas Rammhold <andreas@rammhold.de>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <20210712170313.884724-1-mic@digikod.net>
 <7e8d27da-b5d4-e42c-af01-5c03a7f36a6b@digikod.net> <YcGVZitNa23PCSFV@iki.fi>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v8 0/5] Enable root to update the blacklist keyring
In-Reply-To: <YcGVZitNa23PCSFV@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 21/12/2021 09:50, Jarkko Sakkinen wrote:
> On Mon, Dec 13, 2021 at 04:30:29PM +0100, Mickaël Salaün wrote:
>> Hi Jarkko,
>>
>> Since everyone seems OK with this and had plenty of time to complain, could
>> you please take this patch series in your tree? It still applies on
>> v5.16-rc5 and it is really important to us. Please let me know if you need
>> something more.
>>
>> Regards,
>>   Mickaël
> 
> I'm off-work up until end of the year, i.e. I will address only important
> bug fixes and v5.16 up until that.
> 
> If any of the patches is yet missing my ack, feel free to
> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks Jarkko. Can you please take it into your tree?

Regards,
  Mickaël
