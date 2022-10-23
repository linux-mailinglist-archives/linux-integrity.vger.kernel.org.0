Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4188B60967B
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Oct 2022 23:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJWVYd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Oct 2022 17:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJWVYb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Oct 2022 17:24:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CBBC86;
        Sun, 23 Oct 2022 14:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E66E9B80D5F;
        Sun, 23 Oct 2022 21:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C1FC433D6;
        Sun, 23 Oct 2022 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666560267;
        bh=+Xtjv/IQXjonunfO3JI+ovsB9FIdpoITMCdSerdKZ1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TBBXPTY9EtN+feVt2EiR2ce1LQONd3cdEs9WWnrtIJVO9y+GeQHFJiMG3bc2CwJfq
         39QysLuPybbfTITCBdC+ErS7AwJBHBZCBCS4F2vMfufIRa7Bpgu/lk9Cu8UR0ChVd3
         GLBvnJtIUamNuKRcHPAcDHseezVYWei16RLS/OV/+ptL9vvCBFJbjowKugaUxL5z03
         RraQlRkcKSdkhLgpqeNss6Uk0DEWk4EPYopTafS9+dn2zpk6Fy/OIfmmTwyVEG1IUz
         DA1AtToBb4KoLjUqvmcXXpFdqnddexc49h/o3TNdDdfzSIGGNA/AmK7KiOQMFYinbV
         zVmWgttIGiCKg==
Date:   Mon, 24 Oct 2022 00:24:20 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Nikolaus Voss <nikolaus.voss@haag-streit.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Yael Tzur <yaelt@google.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] KEYS: encrypted: fix key instantiation with
 user-provided data
Message-ID: <Y1WxBBnaiIP3fnHB@kernel.org>
References: <20221019164526.B70DF1C59@mail.steuer-voss.de>
 <075b53e67638b4da85da9299b59fe2662a765c92.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075b53e67638b4da85da9299b59fe2662a765c92.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 19, 2022 at 05:28:23PM -0400, Mimi Zohar wrote:
> On Wed, 2022-10-19 at 18:38 +0200, Nikolaus Voss wrote:
> > Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with
> > user-provided decrypted data") added key instantiation with user
> > provided decrypted data.  The user data is hex-ascii-encoded but was
> > just memcpy'ed to the binary buffer. Fix this to use hex2bin instead.
> > 
> > Old keys created from user provided decrypted data saved with "keyctl
> > pipe" are still valid, however if the key is recreated from decrypted
> > data the old key must be converted to the correct format. This can be
> > done with a small shell script, e.g.:
> > 
> > BROKENKEY=abcdefABCDEF1234567890aaaaaaaaaa
> > NEWKEY=$(echo -ne $BROKENKEY | xxd -p -c32)
> > keyctl add user masterkey "$(cat masterkey.bin)" @u
> > keyctl add encrypted testkey "new user:masterkey 32 $NEWKEY" @u
> > 
> > However, NEWKEY is still broken: If for BROKENKEY 32 bytes were
> > specified, a brute force attacker knowing the key properties would only
> > need to try at most 2^(16*8) keys, as if the key was only 16 bytes long.
> > 
> > The security issue is a result of the combination of limiting the input
> > range to hex-ascii and using memcpy() instead of hex2bin(). It could
> > have been fixed either by allowing binary input or using hex2bin() (and
> > doubling the ascii input key length). This patch implements the latter.
> > 
> > The corresponding test for the Linux Test Project ltp has also been
> > fixed (see link below).
> > 
> > Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
> > Cc: stable@kernel.org
> > Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
> 
> Thanks!  This patch is now queued in next-integrity/next-integrity-
> testing.

Did you check the checkpatch.pl because earlier versions did not pass.

BR, Jarkko
