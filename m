Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A4E76BF21
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 23:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjHAVWD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 17:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjHAVWC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 17:22:02 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD55C3;
        Tue,  1 Aug 2023 14:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690924919;
        bh=w46ldPzBqQOY7Xq8/bGltCOTcrgrcgMnCH9vMYcu8B4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=PHjVNE77XUFzDR7e7N6e8/9XX2+1/0EWb1HxD+SUkd7iLLf4zcVLR2KEpl9Fdda4d
         227a067AawQ5WhGiidtCiKiXq/tCeZiBW/qWCtnVFOFOejRzJKbwlUzUu3kOO5Hla8
         Sptcu8xVSxG9M/HH29H1QBz94rEVPCZBy5Y8HqQE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 18C031285E73;
        Tue,  1 Aug 2023 17:21:59 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id tPG9IWaaoNFL; Tue,  1 Aug 2023 17:21:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690924918;
        bh=w46ldPzBqQOY7Xq8/bGltCOTcrgrcgMnCH9vMYcu8B4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=P4e8OZ/iq/7XbOKyN0isx3wCiAFQfBH+xusN3H+CvbOuphM7D8sG/w70uuEFcx9jD
         quvk7jH/Bf4lEPYmMJNuzD6mV5KgiyRTUv1DRaoiaeE0LouugNPGeOTg9DmWL2BIQu
         dbuBbmhdJ6wn9dbvY4wO4sDasWKK678PA+TY34Mw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 699C81285E58;
        Tue,  1 Aug 2023 17:21:57 -0400 (EDT)
Message-ID: <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
Date:   Tue, 01 Aug 2023 17:21:55 -0400
In-Reply-To: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
[...]
> Truncating IMA log to reclaim memory is not feasible, since it makes
> the log go out of sync with the TPM PCR quote making remote
> attestation fail.

This assumption isn't entirely true.  It's perfectly possible to shard
an IMA log using two TPM2_Quote's for the beginning and end PCR values
to validate the shard.  The IMA log could be truncated in the same way
(replace the removed part of the log with a TPM2_Quote and AK, so the
log still validates from the beginning quote to the end).

If you use a TPM2_Quote mechanism to save the log, all you need to do
is have the kernel generate the quote with an internal AK.  You can
keep a record of the quote and the AK at the beginning of the truncated
kernel log.  If the truncated entries are saved in a file shard it
should have a beginning and end quote and a record of the AK used. 
Since verifiers like Keylime are already using this beginning and end
quote for sharded logs, it's the most natural format to feed to
something externally for verification and it means you don't have to
invent a new format to do the same thing.

Regards,

James

