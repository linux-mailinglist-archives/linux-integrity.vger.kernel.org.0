Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4603D589B64
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Aug 2022 14:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbiHDMCF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Aug 2022 08:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239610AbiHDMCD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Aug 2022 08:02:03 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2061D54;
        Thu,  4 Aug 2022 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1659614517;
        bh=fCjUUGj0H5+LN32Fc+pxVbqnw9CBv61Qb6x5ZNzenXo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=UHClCpkuushOMkk/R3oi3YHK8sMnllTODfyUNz+ce/67B2kTtZNcH2EPFVBySydEd
         NcGb6CdbPaVfXFSv5lAMGa80NhiF2vRFG3WYmKgFEfbx+LFH71UUoUHlLddmPeBARP
         ljWZ0BBDKmVKv8rWJsFsk+27x0DetB2rwhWNCVnA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 08ADF1281703;
        Thu,  4 Aug 2022 08:01:57 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KjdDuEFOdhpJ; Thu,  4 Aug 2022 08:01:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1659614516;
        bh=fCjUUGj0H5+LN32Fc+pxVbqnw9CBv61Qb6x5ZNzenXo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=MQ2YdagDcLWbTuU34z/RTW2/Fmj+aJGZqST2OBM/1OWiH95bakfXWWEHUPlmu8XkS
         XfN/PIxZqy8LeBQ9X4xYEtm3mSV+l00sL5nu5GJZULMAkut7FQRsnv2nuiHRpBeO7s
         GWyNfgruAvhVCsB9m5dLCC0Gnjdslu+F/7xgpV88=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AA48212816BC;
        Thu,  4 Aug 2022 08:01:55 -0400 (EDT)
Message-ID: <5653318a776a8044f413ed1a4b6e3965fac2297e.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] tpmdd updates for v5.20
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kalle Valo <kvalo@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Thu, 04 Aug 2022 08:01:53 -0400
In-Reply-To: <87pmhgikhk.fsf@kernel.org>
References: <20220803210228.158993-1-jarkko@kernel.org>
         <87pmhgikhk.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-08-04 at 09:35 +0300, Kalle Valo wrote:
> Jarkko Sakkinen <jarkko@kernel.org> writes:
[...]
> > M...rten Lindahl (1):
> >       tpm: Add check for Failure mode for TPM2 modules
> 
> Some encoding problems in the name? At least my Gnus didn't show them
> correctly.

My mail tool correctly renders the 'å' character, and lore has it too:

https://lore.kernel.org/all/20220803210228.158993-1-jarkko@kernel.org/

So I think you have a local UTF-8 translation problem.

James


