Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF61652267
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Dec 2022 15:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiLTOYX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Dec 2022 09:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiLTOXx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Dec 2022 09:23:53 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65C11BE98
        for <linux-integrity@vger.kernel.org>; Tue, 20 Dec 2022 06:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1671546212;
        bh=HAx/ZFU1MH9QfmorX2GjBkbNGEsKnZ5AnPYr0DRMoSA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ja3mJzC7NFTLIQfeoKhXin5TqLOZryX5gmCdypBBMs/Zjc8qpz3j54mAOXkoqpuPE
         mXjNm5Yrl8lxkltrqaVy/BdmIxvKkX+PUwDuZuPqOS+ZS2wSorU2B/vSEYYbzLS+Us
         Kv1At6t2mefEpllIwNbPHRpQE3VxiqlVfNukJVKQ=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 008141285CE3;
        Tue, 20 Dec 2022 09:23:32 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ys0AWBV7TwYe; Tue, 20 Dec 2022 09:23:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1671546211;
        bh=HAx/ZFU1MH9QfmorX2GjBkbNGEsKnZ5AnPYr0DRMoSA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=OICtkQwYtd15yOSMBbippClfk8iPF7GtrGEeypzHaOJRaoZi5hXyjHTgymZ0jx6U6
         Kg1U60rIdnebGG1w1X7cH0gIe7zqoiG61+gC09T5urgI89ZWOPD1U6XapMRUt0U8L8
         VUQH2C+30TipsZSR/5DHn0N5oJAwHYxoIQO9ub5I=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C4BD41281ED1;
        Tue, 20 Dec 2022 09:23:30 -0500 (EST)
Message-ID: <89ed5619ff41ea8a3651e3388ff7309b13646896.camel@HansenPartnership.com>
Subject: Re: Question on loading trusted key with keyctl command
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 20 Dec 2022 09:23:29 -0500
In-Reply-To: <555e740263323e4dddecc48224717a5baad145ee.camel@linux.ibm.com>
References: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
         <ddefa55ad5c5f0dc0248a4017ea31e8e5d7a5328.camel@HansenPartnership.com>
         <CADg8p972AxWMTQbAXc=+zX9STtLdRKUmopbjEbq0rfFP_TKwrg@mail.gmail.com>
         <e26b33be6ae53d4b566cffda092bcd45a3691c06.camel@HansenPartnership.com>
         <5e1c8d3bd5742979e328a267522347ad39b483a3.camel@linux.ibm.com>
         <d8df26bb38ac342ab32c31ba0b5f17da4c79560a.camel@HansenPartnership.com>
         <555e740263323e4dddecc48224717a5baad145ee.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
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

On Tue, 2022-12-20 at 09:13 -0500, Mimi Zohar wrote:
> On Tue, 2022-12-20 at 09:03 -0500, James Bottomley wrote:
> > On Tue, 2022-12-20 at 08:54 -0500, Mimi Zohar wrote:
> > > On Tue, 2022-12-20 at 07:50 -0500, James Bottomley wrote:
> > > > On Tue, 2022-12-20 at 12:03 +0530, Sughosh Ganu wrote:
> > [...]
> > > > > I was able to load the key after clearing the keyring. Thanks
> > > > > James and Mimi for your pointers.
> > > > 
> > > > Actually, I think this is a bug in trusted keys.  Add on
> > > > existing key is supposed to go through the update path.  If the
> > > > path doesn't exist it returns -EEXIST.  Trusted keys have an
> > > > update path but they return - EINVAL if the trusted key command
> > > > is anything but update (which is used to reseal a key). 
> > > > Obviously this is incorrect and the code should be returning -
> > > > EEXIST for a key we refuse to update to match every other key
> > > > type.
> > > 
> > > Re-loading an existing key was previously permitted.  Obviously
> > > this changed at some point.   Any "fixes" should point out when
> > > it changed.
> > 
> > Git history doesn't think so.  It thinks when you    added trusted
> > keys with d00a1c72f7f4661212299e6cb132dfa58030bcdb the update path
> > already had the -EINVAL return, so reload has always failed this
> > way unless we were doing a reseal update.  We could certainly
> > permit overwriting an existing key with load, but that would be a
> > more extensive change.
> 
> Replacing existing keys/keyrings was part of the infrastructure.  I
> don't think this change has anything to do with trusted type keys.  
> The ability of replacing keys/keyrings was one of the main reasons
> for trusted keyrings (dot prefixed keyrings).

Keys can only be replaced by calling the ->update() helper for the key
type.  If that doesn't exist keyctl add will return -EEXIST (behaviour
for at least the last 12 years).  Most key type update routines do
unconditionally update, so the error they return is the same error they
would have returned for an add of a non existent key (EINVAL if the
payload is too large, for instance).  The trusted keys ->update()
helper (trusted_update()) only allows update if the trusted operation
is update, so they've always failed a load with EINVAL going back to
the original commit I quoted.  At no time that I can find has there
ever been a modification to this supporting updating trusted keys with
anything other than an update trusted operation.  So they've supported
changing the sealing parameters (PCR values) but not changing the
payload.  This contrasts with user keys where add of a new payload on
an existing key changes the payload.

James

