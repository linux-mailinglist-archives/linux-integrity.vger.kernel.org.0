Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE46E2C7FC8
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Nov 2020 09:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgK3IZK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 03:25:10 -0500
Received: from smtp-190c.mail.infomaniak.ch ([185.125.25.12]:43947 "EHLO
        smtp-190c.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727534AbgK3IZI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 03:25:08 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ckyv71SkPzlhCHK;
        Mon, 30 Nov 2020 09:24:19 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Ckyv42C21zlh8TB;
        Mon, 30 Nov 2020 09:24:16 +0100 (CET)
Subject: Re: [PATCH v1 0/9] Enable root to update the blacklist keyring
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20201120180426.922572-1-mic@digikod.net>
 <20201130024011.GA24870@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <80fb0eae-8321-5ae2-8d50-eabbe86981da@digikod.net>
Date:   Mon, 30 Nov 2020 09:23:59 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20201130024011.GA24870@kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 30/11/2020 03:40, Jarkko Sakkinen wrote:
> On Fri, Nov 20, 2020 at 07:04:17PM +0100, Mickaël Salaün wrote:
>> Hi,
>>
>> This patch series mainly add a new configuration option to enable the
>> root user to load signed keys in the blacklist keyring.  This keyring is
>> useful to "untrust" certificates or files.  Enabling to safely update
>> this keyring without recompiling the kernel makes it more usable.
> 
> I apologize for latency. This cycle has been difficult because of
> final cuts with the huge SGX patch set.
> 
> I did skim through this and did not see anything striking (but it
> was a quick look).
> 
> What would be easiest way to smoke test the changes?

An easy way to test it is to enable the second trusted keyring to
dynamically load certificates in the kernel. Then we can create a hash
of a valid certificate (but not loaded yet) and sign it as explained in
tools/certs/print-cert-tbs-hash.sh (patch 9/9). Once this hash is loaded
in the kernel, loading the blacklisted certificate will be denied. We
can also test it with a PKCS#7 signature chain, either with the
blacklist keyring itself, or with a signed dm-verity image.

> 
>> Regards,
>>
>> Mickaël Salaün (9):
>>   certs: Fix blacklisted hexadecimal hash string check
>>   certs: Make blacklist_vet_description() more strict
>>   certs: Factor out the blacklist hash creation
>>   certs: Check that builtin blacklist hashes are valid
>>   PKCS#7: Fix missing include
>>   certs: Fix blacklist flag type confusion
>>   certs: Allow root user to append signed hashes to the blacklist
>>     keyring
>>   certs: Replace K{U,G}IDT_INIT() with GLOBAL_ROOT_{U,G}ID
>>   tools/certs: Add print-cert-tbs-hash.sh
>>
>>  MAINTAINERS                                   |   2 +
>>  certs/.gitignore                              |   1 +
>>  certs/Kconfig                                 |  10 +
>>  certs/Makefile                                |  15 +-
>>  certs/blacklist.c                             | 210 +++++++++++++-----
>>  certs/system_keyring.c                        |   5 +-
>>  crypto/asymmetric_keys/x509_public_key.c      |   3 +-
>>  include/keys/system_keyring.h                 |  14 +-
>>  include/linux/verification.h                  |   2 +
>>  scripts/check-blacklist-hashes.awk            |  37 +++
>>  .../platform_certs/keyring_handler.c          |  26 +--
>>  tools/certs/print-cert-tbs-hash.sh            |  91 ++++++++
>>  12 files changed, 335 insertions(+), 81 deletions(-)
>>  create mode 100755 scripts/check-blacklist-hashes.awk
>>  create mode 100755 tools/certs/print-cert-tbs-hash.sh
>>
>>
>> base-commit: 09162bc32c880a791c6c0668ce0745cf7958f576
>> -- 
>> 2.29.2
>>
>>
> 
> /Jarkko
> 
