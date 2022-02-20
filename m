Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32FD4BD279
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 00:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbiBTXJx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Feb 2022 18:09:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiBTXJw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Feb 2022 18:09:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A3A24085;
        Sun, 20 Feb 2022 15:09:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9122C60FA9;
        Sun, 20 Feb 2022 23:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4565AC340E8;
        Sun, 20 Feb 2022 23:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645398568;
        bh=TwVKR8OMjO5PwA68ho99LIr7K9ut7SglljH+FBRtHrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VhbFS/ZCJRjl5TmE3eTb4bEW78UgvKLQDi23tkjhzZLkHvdaEKmHqtrJenot5epsi
         0HPm1CaAhr60VVMShR1qtOppNNjPMLIVS7V0V6d+FCoU5ohYR7CXG8/LqSzXR7Mt3+
         PiPgbsZseyKQeN1tjbi2/jsWRu3bqB7/u/Z3HtQtDvaQmJeMKLWQjzuuO8SHu8ro5B
         A2DkGzIRAPMfKkuEe4mZMe5soli9aOx4NHPbd7YXJKrH7H8+vr+BuPs+hyqCS0Uf0O
         idgsfL5N2Va833j/RJg3CdtksNhrVBiHFet/qD/uyXvlltzHSNY43oPGZFihiWUP0R
         qolmW+9IpRFaQ==
Date:   Mon, 21 Feb 2022 00:10:06 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Tong Zhang <ztong0001@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Rammhold <andreas@rammhold.de>
Subject: Re: [PATCH] KEYS: trusted: fix crash when TPM/TEE are built as module
Message-ID: <YhLKTjuGnIIA8FAd@iki.fi>
References: <20220204200342.48665-1-ztong0001@gmail.com>
 <a45010a4-2b86-aa22-d7bd-3c4839356cf1@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a45010a4-2b86-aa22-d7bd-3c4839356cf1@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Feb 06, 2022 at 11:36:48AM +0100, Ahmad Fatoum wrote:
> Hello Tong,
> 
> On 04.02.22 21:03, Tong Zhang wrote:
> > when TCG_TPM and TEE are built as module, trusted_key_sources will be an
> > empty array, loading it won't do what it is supposed to do and unloading
> > it will cause kernel crash.
> 
> Jarkko reported picking up an equivalent fix two months ago:
> https://lkml.kernel.org/keyrings/YadRAWbl2aiapf8l@iki.fi/
> 
> But it seems to have never made it to Linus.

Sorry, was not done purposely. I pushed the original fix.

BR, Jarkko
