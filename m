Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8815BBD7F
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Sep 2022 12:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIRK6V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Sep 2022 06:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIRK6U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Sep 2022 06:58:20 -0400
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Sep 2022 03:58:18 PDT
Received: from smtp.sws.net.au (smtp.sws.net.au [IPv6:2a01:4f8:201:1e6::dada:cafe])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3721FCC3
        for <linux-integrity@vger.kernel.org>; Sun, 18 Sep 2022 03:58:18 -0700 (PDT)
Received: from xev.coker.com.au (localhost [127.0.0.1])
        by smtp.sws.net.au (Postfix) with ESMTP id 91B45FF9F;
        Sun, 18 Sep 2022 20:48:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1663498091;
        bh=GLx1fexzUulcYPs/0+79P0rAlxlaevhRnP5bupunXOs=; l=1795;
        h=From:To:Reply-To:Subject:Date:In-Reply-To:References:From;
        b=QO1DCwmyNDyCSDwPN1i6Rd4zH64yFPfyPeQaR8dvSjH0Ia5IpZ+UyEJYyWsnHZkD5
         FYi9/9+jeCDnNx6ATvWZnNgqbiMi0JQgoK4WAl5ChB78XVBf4ZiKCEIAtiuH5nmdr1
         0mChqB8EeuHm+8UuVRlup4Ww0nHu5d+NBt83pEEw=
Received: by xev.coker.com.au (Postfix, from userid 1001)
        id BD4D81A85311; Sun, 18 Sep 2022 20:48:06 +1000 (AEST)
From:   Russell Coker <russell@coker.com.au>
To:     linux-integrity@vger.kernel.org, Ken Williams <ken@williamsclan.us>
Reply-To: russell@coker.com.au
Subject: Re: User questions
Date:   Sun, 18 Sep 2022 20:48:06 +1000
Message-ID: <4153672.NgBsaNRSFp@xev>
In-Reply-To: <CADrftwOUDT5CuwHsrgEM1GTu_N3TAhZTpxFBERKa7zwUHkQscw@mail.gmail.com>
References: <CADrftwOUDT5CuwHsrgEM1GTu_N3TAhZTpxFBERKa7zwUHkQscw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Friday, 16 September 2022 15:36:52 AEST Ken Williams wrote:
> If yes, then let me describe my environment;
> I am running an older kernel, 4.14.238,

Things are changing all the time in IMA, getting an older kernel to work might 
be a problem.  However I have seen some documentation about using it in 
embedded systems in vehicles which is a use that tends to have long support 
times, so some old versions will be supported.

> learning curve in this area may not be out of line.  My plan is to
> pre-sign the files prior to installation and I see that effort as
> being outside of the scope of my inquiries here.  So now, does it look
> like I am starting in the right direction?

For typical uses of Linux you would want pre-signed executables.  You want to 
have the system running the programs to not have the signing key and provide 
the signatures from a trusted system.

I've been thinking of having some sort of system that proxies the packages of 
software and creates signatures for them.  The default signing includes the 
Inode number of the file, that can be disabled or the system installing could 
say "give me a signature for /bin/bash from package bash version 5.2~rc2-2 
with Inode 27597791".

The next issue is that the current kernel code doesn't allow signing unsigned 
files unless you boot with "ima_appraise=fix evm=fix" on the kernel command-
line.  I've been thinking of writing a kernel patch to give a compile time 
option to remove that requirement.

As for reasons to use IMA without TPM, one example is virtual machines.  The 
host OS provides a known good kernel and initramfs and we want that kernel to 
ensure that it's not running a corrupt user-space.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

