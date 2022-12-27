Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65454656CA2
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Dec 2022 16:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiL0Pkw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Dec 2022 10:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiL0Pko (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Dec 2022 10:40:44 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504102E5
        for <linux-integrity@vger.kernel.org>; Tue, 27 Dec 2022 07:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1672155640;
        bh=1RW09fc0zkieE8ALVmljiWXzC4UEtGARCPDqbPCZo4I=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=s80AO0JtsBUsWlJz6aT2i8xXCWFrtmky5MIyILajY7giYXVESVAVUqCykveSH40pM
         L3oDjmCJTi8uKu7ULiVEcLMQrzMONNOIW9WAUfmViThwnwKNNoPsyNrwWDvad5d0NK
         OwA4W6TgtsTyFXU741Ihyj6VxfNpPiS9/t+JqICU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CE6D51280CE0;
        Tue, 27 Dec 2022 10:40:40 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CuZUTK40CpJh; Tue, 27 Dec 2022 10:40:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1672155640;
        bh=1RW09fc0zkieE8ALVmljiWXzC4UEtGARCPDqbPCZo4I=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=s80AO0JtsBUsWlJz6aT2i8xXCWFrtmky5MIyILajY7giYXVESVAVUqCykveSH40pM
         L3oDjmCJTi8uKu7ULiVEcLMQrzMONNOIW9WAUfmViThwnwKNNoPsyNrwWDvad5d0NK
         OwA4W6TgtsTyFXU741Ihyj6VxfNpPiS9/t+JqICU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 260231280549;
        Tue, 27 Dec 2022 10:40:39 -0500 (EST)
Message-ID: <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
Subject: Re: Seal/Unseal trusted keys against PCR policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sughosh Ganu <sughosh.ganu@linaro.org>,
        linux-integrity@vger.kernel.org
Date:   Tue, 27 Dec 2022 10:40:38 -0500
In-Reply-To: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-12-27 at 09:44 +0530, Sughosh Ganu wrote:
> hi,
> I am looking to use PCR policy to seal and unseal trusted keys. I
> tried using the interface described in the documentation [1], but I
> get an unseal error at the time of a key load operation. I came
> across a thread [2] which is pretty much the error that I get. As per
> my understanding of what James had explained on that thread, the API
> was broken for TPM2.0 based devices. Has that since been fixed.

Yes, that's been fixed for a while:

f2219745250f security: keys: trusted: use ASN.1 TPM2 key format for the
blobs

>  If so, has there been a change in the user interface for sealing and
> unsealing the trusted keys.
> 
> Here are the steps that I follow.
> 
> # tpm2_createpolicy --policy-pcr --pcr-list sha256:10 --policy
> pcr10_bin.policy > pcr.policy
> 
> # cat pcr.policy
> 16ef916486174ed6f68b09629d2920dd7493d0918fff1247420934c3836100d3
> 
> #keyctl add trusted kmk-pcr "new 32 keyhandle=0x81000001 hash=sha256
> policydigest=`cat pcr.policy`" @u
> 588568314
> 
> # keyctl pipe 588568314 > kmk-pcr.blob
> 
> On a reboot (or even w/o a reboot, after deleting the key)
> #keyctl add trusted kmk-pcr "load `cat kmk-pcr.blob`
> keyhandle=0x81000001 hash=sha256 policydigest=`cat pcr.policy`" @u
> add_key: Operation not permitted

To reload a sealed key, you have to construct a policy session with the
matching policy digest and pass it down to the kernel with
policyhandle=

James

