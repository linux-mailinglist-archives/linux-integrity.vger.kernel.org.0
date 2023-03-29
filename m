Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED5A6CF617
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Mar 2023 00:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjC2WCm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 18:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjC2WCh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 18:02:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAF640CB;
        Wed, 29 Mar 2023 15:02:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FF0EB82340;
        Wed, 29 Mar 2023 22:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2E3C433D2;
        Wed, 29 Mar 2023 22:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680127354;
        bh=OPo9sN5zimeGshEw5ozbepDahpS2FQOu8mYPSuSsopg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tasVUR3w/7HbUcUvL71+kUUOR2MiGkb6hDmAOpNYol06pl/SoE9IuDRPp0KFThY9V
         fveh77XYXgcolVwkJ+lcc6KNHqprlC/97bIAl9y1crNi6vFIRrsJ3vqSc3nevdsgXs
         ebw7rAEbJ6PwVkQz5fQAeVUP1ORyGCzBLTFgV9JhoTHKqH9sLZN98DvrfDO42PNUxx
         LQ8iXzXM3eyfRp+1hf6x1EaHv6REJ8kXIi15E2cxN4ggo0Cg1BtsQJniNVlvCUygoZ
         l4eA3F4v8hxotquzPMr4YsDxWgNxG35HQQUipge4NNqeAnfBnKLW0uj/X1SdaQMxa4
         /qPjrnWm6XIjA==
Date:   Thu, 30 Mar 2023 01:02:31 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, jlee@suse.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 0/6] Add CA enforcement keyring restrictions
Message-ID: <20230329220231.h6afgarrvdlwwdjc@kernel.org>
References: <20230322161634.2233838-1-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322161634.2233838-1-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 22, 2023 at 12:16:28PM -0400, Eric Snowberg wrote:
> Prior to the introduction of the machine keyring, most distros simply 
> allowed all keys contained within the platform keyring to be used
> for both kernel and module verification.  This was done by an out of
> tree patch.  Some distros took it even further and loaded all these keys
> into the secondary trusted keyring.  This also allowed the system owner 
> to add their own key for IMA usage.
> 
> Each distro contains similar documentation on how to sign kernel modules
> and enroll the key into the MOK.  The process is fairly straightforward.
> With the introduction of the machine keyring, the process remains
> basically the same, without the need for any out of tree patches.
> 
> The machine keyring allowed distros to eliminate the out of tree patches
> for kernel module signing.  However, it falls short in allowing the end 
> user to add their own keys for IMA. Currently, the machine keyring can not 
> be used as another trust anchor for adding keys to the ima keyring, since 
> CA enforcement does not currently exist.  This would expand the current 
> integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY 
> Kconfig states that keys may be added to the ima keyrings if the key is 
> validly signed by a CA cert in the system built-in or secondary trusted 
> keyring.  Currently, there is not code that enforces the contents of a
> CA cert.
> 
> This series introduces a way to do CA enforcement with the machine
> keyring.  It introduces three different ways to configure the machine
> keyring.  New Kconfig options are added to control the types of keys
> that may be added to it.  The default option allows all MOK keys into the
> machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING is selected,
> the X.509 CA bit must be true and the key usage must contain keyCertSign; 
> any other usage field may also be set.  When
> CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is also selected, the X.509 CA
> bit must be true and the key usage must contain keyCertSign. With this
> option digitialSignature usage may not be set.  If a key doesn't pass 
> the CA restriction check, instead of going into the machine keyring, it 
> is added to the platform keyring.  With the ability to configure the
> machine keyring with CA restrictions, code that prevented the machine
> keyring from being enabled with
> IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY has been removed.
> 
> Changelog:
> v6:
> - No new code changes
> - Added Reviewed-by and ACKs
> - Formatting change requested by Jarkko
> 
> v5:
> - Removed the Kconfig _MIN Kconfig option and split it into different
>   entries.
> - Added requested commit message changes
> 
> v4:
> - Removed all code that validated the certificate chain back to the root
>   CA. Now the only restriction is what is initially placed in the
>   machine keyring.
> - Check and store if the X.509 usage contains digitalSignature
> - New Kconfig menu item with none, min and max CA restriction on the 
>   machine keyring
> 
> v3:
> - Allow Intermediate CA certs to be enrolled through the MOK. The
>   Intermediate CA cert must contain keyCertSign key usage and have the 
>   CA bit set to true. This was done by removing the self signed
>   requirement.
> 
> Eric Snowberg (6):
>   KEYS: Create static version of public_key_verify_signature
>   KEYS: Add missing function documentation
>   KEYS: X.509: Parse Basic Constraints for CA
>   KEYS: X.509: Parse Key Usage
>   KEYS: CA link restriction
>   integrity: machine keyring CA configuration
> 
>  certs/system_keyring.c                    | 14 +++++--
>  crypto/asymmetric_keys/restrict.c         | 45 ++++++++++++++++++++
>  crypto/asymmetric_keys/x509_cert_parser.c | 50 +++++++++++++++++++++++
>  include/crypto/public_key.h               | 28 +++++++++++++
>  security/integrity/Kconfig                | 23 ++++++++++-
>  security/integrity/digsig.c               |  8 +++-
>  6 files changed, 162 insertions(+), 6 deletions(-)
> 
> 
> base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
> -- 
> 2.27.0
> 

I can pick this, and I guess I can add Mimi's tested-by's to all of the
patches?

BR, Jarkko
