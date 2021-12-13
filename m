Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8017B473076
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 16:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbhLMP2c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 10:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbhLMP2b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 10:28:31 -0500
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374C4C061574;
        Mon, 13 Dec 2021 07:28:31 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4JCQQ441LszMpxck;
        Mon, 13 Dec 2021 16:28:28 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4JCQQ050cTzlj4cD;
        Mon, 13 Dec 2021 16:28:24 +0100 (CET)
Message-ID: <7e8d27da-b5d4-e42c-af01-5c03a7f36a6b@digikod.net>
Date:   Mon, 13 Dec 2021 16:30:29 +0100
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v8 0/5] Enable root to update the blacklist keyring
In-Reply-To: <20210712170313.884724-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

Since everyone seems OK with this and had plenty of time to complain, 
could you please take this patch series in your tree? It still applies 
on v5.16-rc5 and it is really important to us. Please let me know if you 
need something more.

Regards,
  Mickaël


On 12/07/2021 19:03, Mickaël Salaün wrote:
> Hi,
> 
> This new patch series is a rebase on v5.14-rc1 .  David or Jarkko, if
> it's still OK with you, could you please push this to linux-next?
> 
> I successfully tested this patch series with the 211 entries from
> https://uefi.org/sites/default/files/resources/dbxupdate_x64.bin
> 
> The goal of these patches is to add a new configuration option to enable the
> root user to load signed keys in the blacklist keyring.  This keyring is useful
> to "untrust" certificates or files.  Enabling to safely update this keyring
> without recompiling the kernel makes it more usable.
> 
> Previous patch series:
> https://lore.kernel.org/lkml/20210312171232.2681989-1-mic@digikod.net/
> 
> Regards,
> 
> Mickaël Salaün (5):
>    tools/certs: Add print-cert-tbs-hash.sh
>    certs: Check that builtin blacklist hashes are valid
>    certs: Make blacklist_vet_description() more strict
>    certs: Factor out the blacklist hash creation
>    certs: Allow root user to append signed hashes to the blacklist
>      keyring
> 
>   MAINTAINERS                                   |   2 +
>   certs/.gitignore                              |   1 +
>   certs/Kconfig                                 |  17 +-
>   certs/Makefile                                |  17 +-
>   certs/blacklist.c                             | 218 ++++++++++++++----
>   crypto/asymmetric_keys/x509_public_key.c      |   3 +-
>   include/keys/system_keyring.h                 |  14 +-
>   scripts/check-blacklist-hashes.awk            |  37 +++
>   .../platform_certs/keyring_handler.c          |  26 +--
>   tools/certs/print-cert-tbs-hash.sh            |  91 ++++++++
>   10 files changed, 346 insertions(+), 80 deletions(-)
>   create mode 100755 scripts/check-blacklist-hashes.awk
>   create mode 100755 tools/certs/print-cert-tbs-hash.sh
> 
> 
> base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
> 
