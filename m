Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE31F6FE73B
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 00:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjEJWby (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 May 2023 18:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEJWbx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 May 2023 18:31:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A562121;
        Wed, 10 May 2023 15:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F98263486;
        Wed, 10 May 2023 22:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF62C433D2;
        Wed, 10 May 2023 22:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683757911;
        bh=SXZNrDrjUN5ZxubONGX1Mhe4Ure+4nPvVJo9X7HC3dI=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=XBFqv/L6LDobHaNoWPK8f3v+AHZImEz7N32At1T08nG14bStw5ZJO5Jt0GNQWQJ3H
         S8WgqTj/1JXQt7vAA1CIgq1r1mgW63XcV2NPzCa1fZR70De+s4zkuFjEzBB5qevx6Y
         00dsFmH1Ba9cyv/amXZmr7U2ze5PbqPEq4Ck/pQxnJApzfLaOzDy6VTZzqBJPT02ia
         fPDhtEB2t5Q7iz7kieTVfWPLJIRT981DKaK0zaMptG1J6dr1OWc7TUfpwXJdY9OJeL
         InOX+9947NFSg+L0jyys8rHf1F7C5u/zGhC2x1gCftcAP4d2/t9LDHa+ApJTxCFeoR
         tzRySqOZfJjKg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 01:31:45 +0300
Message-Id: <CSIYD3JL1PYK.ZXS8CODB7QYT@suppilovahvero>
Cc:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <jlee@suse.com>,
        <kanth.ghatraju@oracle.com>, <konrad.wilk@oracle.com>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 0/3] Add digitalSignature enforcement keyring
 restrictions
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Eric Snowberg" <eric.snowberg@oracle.com>, <zohar@linux.ibm.com>,
        <dhowells@redhat.com>, <dwmw2@infradead.org>
X-Mailer: aerc 0.14.0
References: <20230508220708.2888510-1-eric.snowberg@oracle.com>
In-Reply-To: <20230508220708.2888510-1-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 9, 2023 at 1:07 AM EEST, Eric Snowberg wrote:
> X.509 certificates may contain a key usage extension [1]. The key usage
> extension defines the purpose of the certificate. One area of
> interest is the digitalSignature. The digitalSignature usage is
> typically used for code signing (integrity).=20
>
> Within the "Add CA enforcement key restrictions" [2] series, the
> digitalSignature is being saved.  This series builds upon the previous
> one and adds restrictions based on the digitalSignature usage. =20
>
> A new keyring restriction called restrict_link_by_digsig is added. The ne=
w
> restriction only allows keys that contain digitalSignature usage within
> it.
>
> The first two keyrings to use this restriction are the .ima and .evm
> keyrings.  With this update, only keys containing a digitalSignature=20
> will be allowed in either keyring.

... and disallowed if not (for completeness)?

Maybe you want to say that "With this update, keys can be filtered based
on digitalSignature"?

I know, it is only cover letter, not a big deal...

>
> 1. https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.3
> 2. https://lore.kernel.org/all/20230329220231.h6afgarrvdlwwdjc@kernel.org=
/T/
>
> Eric Snowberg (3):
>   KEYS: DigitalSignature link restriction
>   integrity: Enforce digitalSignature usage in the ima and evm keyrings
>   integrity: Remove EXPERIMENTAL from Kconfig
>
>  certs/system_keyring.c            | 52 +++++++++++++++++++++++++++++++
>  crypto/asymmetric_keys/restrict.c | 44 ++++++++++++++++++++++++++
>  include/crypto/public_key.h       | 11 +++++++
>  include/keys/system_keyring.h     | 11 +++++++
>  security/integrity/digsig.c       |  4 +--
>  security/integrity/evm/Kconfig    |  3 +-
>  security/integrity/ima/Kconfig    |  5 +--
>  7 files changed, 125 insertions(+), 5 deletions(-)
>
>
> base-commit: ac9a78681b921877518763ba0e89202254349d1b
> --=20
> 2.27.0


BR, Jarkko
