Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF4576E367
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Aug 2023 10:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjHCInt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjHCInr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 04:43:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8076106
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 01:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C77761CC5
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 08:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286F2C433C8;
        Thu,  3 Aug 2023 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691052224;
        bh=AOLcJ1KhDLBUtJkrbox+j2nDyJDRZd0wvc7q6oNEZ84=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=oecah8j38u05dygko8uIB5G9QKEi6ghHOE0ekaFXtkj0pFDBi0dmUinbfSb+kFYuC
         3hDEX+ur50/KCCLz3B9MXq2yQrlijYdliuhrQrk93MhBCfrkCIS+zGtRl1v2yGSldM
         R6vEqv1x6STh1V3Cli5ApR1K7KCwjaIFKRabpxpcnz4i5MLLytCLygJdjl+2nwYuu9
         RdS4OnF9/M20dZKFFUtl1E/J+Kk8JIcl6QycW8t1Hl6ZjWM9zvqoSvWzFMfEe0sCMH
         vJekB2+bQjs3Ug7st63UwWwMF7Vfyv2w7aJujhoKKiBhIm5w7h4AIkuSaLMHFu2Ith
         b9ic6xWikVyfg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 03 Aug 2023 11:43:37 +0300
Cc:     <code@tyhicks.com>, <nramas@linux.microsoft.com>,
        <paul@paul-moore.com>
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Tushar Sugandhi" <tusharsu@linux.microsoft.com>,
        <zohar@linux.ibm.com>, <noodles@fb.com>, <bauermann@kolabnow.com>,
        <ebiederm@xmission.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
        <dyoung@redhat.com>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <kexec@lists.infradead.org>, <linux-integrity@vger.kernel.org>
Message-Id: <CUIRWHEMXL38.29Z2XR564KV33@suppilovahvero>
X-Mailer: aerc 0.14.0
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
 <dd126081-3216-c15e-124e-ef137b376cdb@linux.microsoft.com>
In-Reply-To: <dd126081-3216-c15e-124e-ef137b376cdb@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 3, 2023 at 12:04 AM EEST, Tushar Sugandhi wrote:
> Btw, the function tpm2_pcr_read is not exposed directly to the other
> subsystems (like IMA).=C2=A0 It is exposed via tpm_pcr_read.
>
> Do you want to expose tpm2_pcr_read directly,
> or do you want me to update the function signature of tpm_pcr_read as wel=
l?

As long as you mention that 'update_cnt' causes divegence in the
in-kernel API, and therefore tpm[12]_pcr_read() cannnot be under the
same orchestrator.

If you take this path, please implement a precursory patch, which
replace the existing call sites with some sequence of tpm[12]_pcr_read()
and tpm_is_tpm2() calls.

BR, Jarkko
