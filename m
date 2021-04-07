Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6098B35732C
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 19:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348044AbhDGR1e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Apr 2021 13:27:34 -0400
Received: from smtp-bc0d.mail.infomaniak.ch ([45.157.188.13]:53865 "EHLO
        smtp-bc0d.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343919AbhDGR1d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Apr 2021 13:27:33 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4FFrjv6HTZzMqFPy;
        Wed,  7 Apr 2021 19:19:47 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4FFrjs34sYzlppyr;
        Wed,  7 Apr 2021 19:19:45 +0200 (CEST)
Subject: Re: [PATCH v7 0/5] Enable root to update the blacklist keyring
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
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
        David Woodhouse <dwmw2@infradead.org>
References: <20210312171232.2681989-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <52f54ebb-6ac7-4d68-f97a-74219ed88d0b@digikod.net>
Date:   Wed, 7 Apr 2021 19:21:30 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20210312171232.2681989-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi David and Jarkko,

What is the status of this patchset? Could someone take it to -next?

Regards,
 Mickaël


On 12/03/2021 18:12, Mickaël Salaün wrote:
> This new patch series is a rebase on David Howells's and Eric Snowberg's
> keys-cve-2020-26541-v3.
> 
> I successfully tested this patch series with the 186 entries from
> https://uefi.org/sites/default/files/resources/dbxupdate_x64.bin (184
> binary hashes and 2 certificates).
> 
> The goal of these patches is to add a new configuration option to enable the
> root user to load signed keys in the blacklist keyring.  This keyring is useful
> to "untrust" certificates or files.  Enabling to safely update this keyring
> without recompiling the kernel makes it more usable.
> 
> This can be applied on top of David Howells's keys-cve-2020-26541-branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-cve-2020-26541-branch
> 
> Previous patch series:
> https://lore.kernel.org/lkml/20210210120410.471693-1-mic@digikod.net/
> 
> Regards,
> 
> Mickaël Salaün (5):
>   tools/certs: Add print-cert-tbs-hash.sh
>   certs: Check that builtin blacklist hashes are valid
>   certs: Make blacklist_vet_description() more strict
>   certs: Factor out the blacklist hash creation
>   certs: Allow root user to append signed hashes to the blacklist
>     keyring
> 
>  MAINTAINERS                                   |   2 +
>  certs/.gitignore                              |   1 +
>  certs/Kconfig                                 |  17 +-
>  certs/Makefile                                |  17 +-
>  certs/blacklist.c                             | 218 ++++++++++++++----
>  crypto/asymmetric_keys/x509_public_key.c      |   3 +-
>  include/keys/system_keyring.h                 |  14 +-
>  scripts/check-blacklist-hashes.awk            |  37 +++
>  .../platform_certs/keyring_handler.c          |  26 +--
>  tools/certs/print-cert-tbs-hash.sh            |  91 ++++++++
>  10 files changed, 346 insertions(+), 80 deletions(-)
>  create mode 100755 scripts/check-blacklist-hashes.awk
>  create mode 100755 tools/certs/print-cert-tbs-hash.sh
> 
> 
> base-commit: ebd9c2ae369a45bdd9f8615484db09be58fc242b
> 
