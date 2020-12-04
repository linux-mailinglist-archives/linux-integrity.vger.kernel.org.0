Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40A82CF003
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 15:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgLDOtg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 09:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbgLDOtf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 09:49:35 -0500
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [IPv6:2001:1600:4:17::8faa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99993C0613D1
        for <linux-integrity@vger.kernel.org>; Fri,  4 Dec 2020 06:48:50 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CnbDv6MYszlhrjs;
        Fri,  4 Dec 2020 15:48:47 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CnbDt1CdYzlh8TT;
        Fri,  4 Dec 2020 15:48:46 +0100 (CET)
Subject: Re: [PATCH v1 1/9] certs: Fix blacklisted hexadecimal hash string
 check
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20201120180426.922572-2-mic@digikod.net>
 <20201120180426.922572-1-mic@digikod.net>
 <113785.1607090759@warthog.procyon.org.uk>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <c9664a67-61b7-6b4a-86d7-5aca9ff06fa5@digikod.net>
Date:   Fri, 4 Dec 2020 15:48:45 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <113785.1607090759@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 04/12/2020 15:05, David Howells wrote:
> Mickaël Salaün <mic@digikod.net> wrote:
> 
>> When looking for a blacklisted hash, bin2hex() is used to transform a
>> binary hash to an ascii (lowercase) hexadecimal string.  This string is
>> then search for in the description of the keys from the blacklist
>> keyring.  When adding a key to the blacklist keyring,
>> blacklist_vet_description() checks the hash prefix and the hexadecimal
>> string, but not that this string is lowercase.  It is then valid to set
>> hashes with uppercase hexadecimal, which will be silently ignored by the
>> kernel.
>>
>> Add an additional check to blacklist_vet_description() to check that
>> hexadecimal strings are in lowercase.
> 
> I wonder if it would be a better idea to allow the keyring type to adjust the
> description string - in this instance to change it to all lowercase.

Right now, this patch helps user space identifies which hashes where
ignored. I think it is an interesting information on its own because it
enables to remove a false sense of security and warns about
mis-blacklisted certificates or binaries.

When authenticity/signature of such hash is taken into account, I also
prefer to not change the data that user space signed and pushed to the
kernel, but to teach user space what is correct.

Moreover, modifying the description cannot be done with the
vet_description-type function and would be a more invasive keyring
modification because, AFAIK, no current key type already does such change.

> 
> David
> 
