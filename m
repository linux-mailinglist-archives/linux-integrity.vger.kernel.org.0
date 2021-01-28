Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC58307CCD
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jan 2021 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhA1Rk5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jan 2021 12:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbhA1Rj2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jan 2021 12:39:28 -0500
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C6C0613D6;
        Thu, 28 Jan 2021 09:38:38 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DRSPS0MR1zMprKK;
        Thu, 28 Jan 2021 18:38:36 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DRSPP72nZzlh8TG;
        Thu, 28 Jan 2021 18:38:33 +0100 (CET)
Subject: Re: [PATCH v4 00/10] Enable root to update the blacklist keyring
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20210121155513.539519-1-mic@digikod.net>
 <3613306.1611852751@warthog.procyon.org.uk>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <03ddd243-db25-a054-489d-e64ead4d6f59@digikod.net>
Date:   Thu, 28 Jan 2021 18:38:40 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <3613306.1611852751@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 28/01/2021 17:52, David Howells wrote:
> 
> Hi Mickaël,
Hi David,

> 
> I could pull your patches (unless Jarkko wants to), but can you please drop
> the patches that are also in my keys-misc branch lest one or other (or both)
> of our branches get dropped in the next merge window due to conflicts?
> 
> Ideally, can you base your branch on my keys-misc branch?

Sure, I'm rebasing and testing a new patch series.

> 
> Thanks,
> David
> 
