Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B476E3BE
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Aug 2023 10:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjHCI5Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjHCI5Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 04:57:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4769E53
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 01:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D97B61CE3
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 08:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C709C433C7;
        Thu,  3 Aug 2023 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691053038;
        bh=8zuKLEw8Pz3rRWw3o+O48AfxI5v0Rox/L6Yf6SEhJbM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=mQUlpj8NyJkcTbWb/e3JtGfGNp/whhYZaAlIp81ozB/CB+KMVBojN0zaspUbT+SA/
         V5ZoRTRqvukVWaLAMaslXEYcmazwTby72HeTYvjODoNHaeMKJQOGhWaM/61ucCsU1A
         hgQ3n3t6B49NGVC9ixf/Q347/MBw5D7XfZzjhs/t7lVJDWjKYYa7mabupy0ZxwBlfv
         zUD7HZMG2jQ8GjZyWctdf9vAc3deDTOe2En0WiANI+VOd6zRxPTki3T7zXZQ1imP4o
         HWkYFqwsrHyIzJhiqjubf2PruNzC0cax5cDWZyBDct+EDkNSiOgzcP6TSh38el2hti
         4OckI/QN5EV1w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 03 Aug 2023 11:57:11 +0300
Message-Id: <CUIS9Q2RKN2Q.4V9YYAYHE2BD@suppilovahvero>
Cc:     <code@tyhicks.com>, <nramas@linux.microsoft.com>,
        <paul@paul-moore.com>
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Tushar Sugandhi" <tusharsu@linux.microsoft.com>, <noodles@fb.com>,
        <bauermann@kolabnow.com>, <ebiederm@xmission.com>,
        <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <kexec@lists.infradead.org>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
 <8c4257fb07a8c9fd26b70ce716665a9535e6af54.camel@linux.ibm.com>
In-Reply-To: <8c4257fb07a8c9fd26b70ce716665a9535e6af54.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 3, 2023 at 4:22 AM EEST, Mimi Zohar wrote:
> On Wed, 2023-08-02 at 06:58 +0300, Jarkko Sakkinen wrote:
> >=20
> > From long description I see zero motivation to ack this change, except
> > some heresay about IMA requiring it. Why does IMA need update_cnt and
> > why this is not documented to the long description?
>
> The motivation is to detect whether the IMA measurement list has been
> truncated, for whatever reason.  A new IMA record should be defined
> containing the "pcrCounter" value.  (I have not had a chance to review
> this patch set.)
>
> This new record would be a pre-req for both Tushar's "ima: measure
> events between kexec load and execute" patch set and Sush's proposal to
> trim the measurement list.  (I haven't looked at it yet either.)

Please describe the story in a bit more understandable form. In the
commit messages it is not good to have some redundancy in patch sets.

BR, Jarkko
