Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3295133C517
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Mar 2021 19:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhCOSC1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Mar 2021 14:02:27 -0400
Received: from smtp-bc0b.mail.infomaniak.ch ([45.157.188.11]:53169 "EHLO
        smtp-bc0b.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233068AbhCOSB4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Mar 2021 14:01:56 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Dzkl642lMzMqGSq;
        Mon, 15 Mar 2021 19:01:54 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Dzkl16VGbzlh8T3;
        Mon, 15 Mar 2021 19:01:49 +0100 (CET)
Subject: Re: [PATCH v7 5/5] certs: Allow root user to append signed hashes to
 the blacklist keyring
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
References: <20210312171232.2681989-1-mic@digikod.net>
 <20210312171232.2681989-6-mic@digikod.net>
 <A4CD568A-6D8E-4043-971B-8E79FFB58709@oracle.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <bd28dd0b-b183-44bd-1928-59e3e1274045@digikod.net>
Date:   Mon, 15 Mar 2021 19:01:36 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <A4CD568A-6D8E-4043-971B-8E79FFB58709@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 15/03/2021 17:59, Eric Snowberg wrote:
> 
>> On Mar 12, 2021, at 10:12 AM, Mickaël Salaün <mic@digikod.net> wrote:
>>
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> Add a kernel option SYSTEM_BLACKLIST_AUTH_UPDATE to enable the root user
>> to dynamically add new keys to the blacklist keyring.  This enables to
>> invalidate new certificates, either from being loaded in a keyring, or
>> from being trusted in a PKCS#7 certificate chain.  This also enables to
>> add new file hashes to be denied by the integrity infrastructure.
>>
>> Being able to untrust a certificate which could have normaly been
>> trusted is a sensitive operation.  This is why adding new hashes to the
>> blacklist keyring is only allowed when these hashes are signed and
>> vouched by the builtin trusted keyring.  A blacklist hash is stored as a
>> key description.  The PKCS#7 signature of this description must be
>> provided as the key payload.
>>
>> Marking a certificate as untrusted should be enforced while the system
>> is running.  It is then forbiden to remove such blacklist keys.
>>
>> Update blacklist keyring, blacklist key and revoked certificate access rights:
>> * allows the root user to search for a specific blacklisted hash, which
>>  make sense because the descriptions are already viewable;
>> * forbids key update (blacklist and asymmetric ones);
>> * restricts kernel rights on the blacklist keyring to align with the
>>  root user rights.
>>
>> See help in tools/certs/print-cert-tbs-hash.sh .
>>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Eric Snowberg <eric.snowberg@oracle.com>
>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20210312171232.2681989-6-mic@digikod.net
> 
> I tried testing this, it doesn’t work as I would expect.  
> Here is my test setup:
> 
> Kernel built with two keys compiled into the builtin_trusted_keys keyring
> 
> Generated a tbs cert from one of the keys and signed it with the other key
> 
> As root, added the tbs cert hash to the blacklist keyring
> 
> Verified the tbs hash is in the blacklist keyring
> 
> Enabled lockdown to enforce kernel module signature checking
> 
> Signed a kernel module with the key I just blacklisted
> 
> Load the kernel module 
> 
> I’m seeing the kernel module load, I would expect this to fail, since the 
> key is now blacklisted.  Or is this change just supposed to prevent new keys 
> from being added in the future?

This is the expected behavior and the way the blacklist keyring is
currently used, as explained in the commit message:
"This enables to invalidate new certificates, either from being loaded
in a keyring, or from being trusted in a PKCS#7 certificate chain."

If you want a (trusted root) key to be untrusted, you need to remove it
from the keyring, which is not allowed for the builtin trusted keyring.
