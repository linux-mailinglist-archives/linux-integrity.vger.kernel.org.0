Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A1C76C3CB
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Aug 2023 05:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjHBD63 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 23:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHBD62 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 23:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FF0119
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 20:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46297617A2
        for <linux-integrity@vger.kernel.org>; Wed,  2 Aug 2023 03:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5E8C433C8;
        Wed,  2 Aug 2023 03:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690948705;
        bh=Z93Cm/pqJCTfoBFO1+c0PbkRrs7zUpJNV0ZkQnxbF1k=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=swjGqCCfdAbWZI/FIIpImPv9ppSKsNhhrBj0qPHd9vV4kE3hlDDfC0l0nEFih3nqW
         goJUDznUpSJjVgzejLLd+yZYjrziWOlsC1d3EBDMHHBdVJAeYzE6f9cy61TDq576bT
         ZFVXS3obEyjab1VNYncWUU8zuG1EFaoEN+rLMtzce4L1+ztPgmaQaQixvKFxYUx9n4
         VK9ixu9BRGIzTUlnmL72h56WBoVNLr1IrWOS0FFElviR+BXMQGW7P91XqrcPAWr6Mg
         orOO5cXVp85fBPadNwwPRFwzTHsfp3de5pzKCh2C7fTWhe/Br9XrP3P8h4itQhmpg/
         okNDYgRgV1KTw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 02 Aug 2023 06:58:18 +0300
Message-Id: <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
Cc:     <code@tyhicks.com>, <nramas@linux.microsoft.com>,
        <paul@paul-moore.com>
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Tushar Sugandhi" <tusharsu@linux.microsoft.com>,
        <zohar@linux.ibm.com>, <noodles@fb.com>, <bauermann@kolabnow.com>,
        <ebiederm@xmission.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
        <dyoung@redhat.com>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <kexec@lists.infradead.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
In-Reply-To: <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Aug 2, 2023 at 12:01 AM EEST, Tushar Sugandhi wrote:
> Thanks for the response Jarkko.
>
> On 8/1/23 12:02, Jarkko Sakkinen wrote:
> > The short summary is cryptic to say the least.
> Do you mean the patch subject line, or the description below?

It is in the process documentation:

https://www.kernel.org/doc/html/v6.3/process/submitting-patches.html#the-ca=
nonical-patch-format

> > "update counter" does not map it to have anything to do with PCRs.
> Agreed.=C2=A0 I noticed that when I was testing the patches.
> The update counter is same for all PCRs.=C2=A0 It was also the same for
> the two hash algo's I tested it for (SHA1 and SHA256). But the spec
> description and Kernel implementation requires to pass the
> pcr_idx and hash algo to PCR_Read command to get the update counter.

I was referring to the fact that TPM2_PCR_Read does not have a field
called "update counter" in its response but it has a field called
"pcrUpdateCounter". Please refer to thigs that actually exist.

In the long description you are in some occasions referring to the same
object as:

1. "update counter"
2. "pcrUpdateCounter"
3. "PcrUpdateCounter"

This is ambiguous and wrong.

From long description I see zero motivation to ack this change, except
some heresay about IMA requiring it. Why does IMA need update_cnt and
why this is not documented to the long description?

> But I can update tpm2_pcr_read() if you are ok with it.
> Please let me know.

You can add "u32 *update_cnt".

BR, Jarkko
