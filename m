Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C66521F3
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Dec 2022 15:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLTOEN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Dec 2022 09:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiLTOD7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Dec 2022 09:03:59 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568911B1CA
        for <linux-integrity@vger.kernel.org>; Tue, 20 Dec 2022 06:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1671545036;
        bh=mne194LLKEEWUzgLVwljBQ8IK/w8LLOTkcvQ+P5no3U=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ftsG62FjUwq1a53OpkmdQnVP0e/lXq5WKOy1M6rumQgUYYKFwZoRDxU84xQ7c54Bu
         4x8IM29IQsbKfsRRFd+Gd7/AvQdBNR8WjRvkctgEmCQbO/MMqLkT7Je+BkOthKL87/
         gC+L+5Cs4E1guXfDiS6TsW6I6QX12OkHdSlT/ZQM=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 130E31281ECC;
        Tue, 20 Dec 2022 09:03:56 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6eWUj8jeFt2R; Tue, 20 Dec 2022 09:03:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1671545035;
        bh=mne194LLKEEWUzgLVwljBQ8IK/w8LLOTkcvQ+P5no3U=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=O+0sQ8LXpJ/dBtK0zqH3qyvLxwVmNqcRjRRMRMRav7RsKvILo+hdoyIf61GiqoUFj
         31ticuqpWGzIk4jQWuwI3eZWJr3forHm1qjdFUTUQcj+1X5zPFbn0PFN0aCgzbOkDx
         TTGNrrnJUyWB5i720TITnx6VPKAV91TBUWBqRUs8=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 71B421281E49;
        Tue, 20 Dec 2022 09:03:55 -0500 (EST)
Message-ID: <d8df26bb38ac342ab32c31ba0b5f17da4c79560a.camel@HansenPartnership.com>
Subject: Re: Question on loading trusted key with keyctl command
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 20 Dec 2022 09:03:53 -0500
In-Reply-To: <5e1c8d3bd5742979e328a267522347ad39b483a3.camel@linux.ibm.com>
References: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
         <ddefa55ad5c5f0dc0248a4017ea31e8e5d7a5328.camel@HansenPartnership.com>
         <CADg8p972AxWMTQbAXc=+zX9STtLdRKUmopbjEbq0rfFP_TKwrg@mail.gmail.com>
         <e26b33be6ae53d4b566cffda092bcd45a3691c06.camel@HansenPartnership.com>
         <5e1c8d3bd5742979e328a267522347ad39b483a3.camel@linux.ibm.com>
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

On Tue, 2022-12-20 at 08:54 -0500, Mimi Zohar wrote:
> On Tue, 2022-12-20 at 07:50 -0500, James Bottomley wrote:
> > On Tue, 2022-12-20 at 12:03 +0530, Sughosh Ganu wrote:
[...]
> > > I was able to load the key after clearing the keyring. Thanks
> > > James and Mimi for your pointers.
> > 
> > Actually, I think this is a bug in trusted keys.  Add on existing
> > key is supposed to go through the update path.  If the path doesn't
> > exist it returns -EEXIST.  Trusted keys have an update path but
> > they return - EINVAL if the trusted key command is anything but
> > update (which is used to reseal a key).  Obviously this is
> > incorrect and the code should be returning -EEXIST for a key we
> > refuse to update to match every other key type.
> 
> Re-loading an existing key was previously permitted.  Obviously this
> changed at some point.   Any "fixes" should point out when it
> changed.

Git history doesn't think so.  It thinks when you added trusted keys
with d00a1c72f7f4661212299e6cb132dfa58030bcdb the update path already
had the -EINVAL return, so reload has always failed this way unless we
were doing a reseal update.  We could certainly permit overwriting an
existing key with load, but that would be a more extensive change.

James

