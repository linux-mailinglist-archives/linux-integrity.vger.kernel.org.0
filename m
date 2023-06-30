Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9480974328C
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jun 2023 04:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjF3CJS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jun 2023 22:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjF3CJP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jun 2023 22:09:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9B2D52;
        Thu, 29 Jun 2023 19:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C2661644;
        Fri, 30 Jun 2023 02:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BE2C433C0;
        Fri, 30 Jun 2023 02:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688090943;
        bh=99+qyG4HyN593oTHFFKBfrO8v3BLt6plCiPCDBJrrj0=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=RQpIklMzC6Gj50RQy+L9JqgzLCE7m3UVuk8/4DRU1k+klF8vtYEb+eZXcTzz3eJuX
         fP5v8XrGYj9FJQUiQZ4vHWZ0L1azkltCChJCSqvvbGAecYUvEOrmc4WgpWDBmvJy6k
         JkJtQR+Z8Z3fqL4AHw6p/gKLC1cYR64EewjbU7Sj+RngqlcsZuonAFfp5XYi1anbCS
         Omx+AdWPt0qRJLAJaU8ln0ggMz8xRxDpEArYq5VAzSg8wpmsJntdCnqeT5/ykHWqsd
         80JqL5SYQy9WpgVukxb1PMS3E3txrRY3UQSo6bhE4xbtl5bNl68VTo1Xhq4WA6lD+9
         XMyXZS0OJi+uA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 30 Jun 2023 05:08:58 +0300
Message-Id: <CTPMANARFO9J.1FXO8N3EI5Q2S@suppilovahvero>
Cc:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Sachin Sant" <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tpm: Ensure that tpm chip has ops to check if it's
 defective
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Greg KH" <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.14.0
References: <20230623030427.908-1-mario.limonciello@amd.com>
 <2023062317-daytime-angles-3c5a@gregkh>
 <4d3c4b8a-1788-08af-97ef-a1466a8cda5c@amd.com>
In-Reply-To: <4d3c4b8a-1788-08af-97ef-a1466a8cda5c@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jun 23, 2023 at 4:42 PM EEST, Limonciello, Mario wrote:
>
> On 6/23/2023 1:08 AM, Greg KH wrote:
> > On Thu, Jun 22, 2023 at 10:04:27PM -0500, Mario Limonciello wrote:
> >> The ibmvtpm doesn't have `chip->ops` set, and so trying to check
> >> if it's a defective AMD fTPM doesn't work.
> >>
> >> Add an extra check to tpm_amd_is_rng_defective() to ensure the
> >> TPM being checked has `chip->ops`.
> >>
> >> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> >> Reported-by: Aneesh Kumar K. V <aneesh.kumar@linux.ibm.com>
> >> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> >> Link: https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC=
3@linux.ibm.com/
> >> Tested-by: Sachin Sant <sachinp@linux.ibm.com>
> >> Fixes: bd8621ca1510 ("tpm: Add !tpm_amd_is_rng_defective() to the hwrn=
g_unregister() call site")
> >> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs"=
)
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/char/tpm/tpm-chip.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> > No cc: stable on that list above?
>
> Good point, my mistake on that miss.
>
> If Jarkko agrees with the direction of this patch, I think
> it can be added while committing.

Hmm... sorry Midsummer weekend, which is kind of big thing in Finland,
and also helping toe expose neo-nazi affiliated minister (sounds crazy
but it is literally true) have made me lag a bit with LKML.

I'm presuming that we are going in the direction of Jerry's patch,
right?

BR, Jarkko
