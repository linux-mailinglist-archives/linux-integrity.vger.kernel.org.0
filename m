Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D846520F4
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Dec 2022 13:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLTMvB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Dec 2022 07:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLTMvA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Dec 2022 07:51:00 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE81164
        for <linux-integrity@vger.kernel.org>; Tue, 20 Dec 2022 04:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1671540654;
        bh=g9xYAPTGU7SuGmryaXfbGnpUx+mTeIKo7Kmm5VwU3XY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Vbs3NMHDEORlIEZWlJPWHPShDsFJIQ8aGkh5+KC6ON57ntQcYvXjFq702qPaGfCCZ
         tD2gdEq5iOzg664eRymkPB/1jFXoZiaoaNGK1cP19WLh2Mgk97YoL2eenZThfFVdvP
         fTtUyVj7GOK7pwDg1vAQoaz7tm4i9FshaWxuvwpU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EA4C7128165D;
        Tue, 20 Dec 2022 07:50:54 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zjw9U4G-SKXz; Tue, 20 Dec 2022 07:50:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1671540654;
        bh=g9xYAPTGU7SuGmryaXfbGnpUx+mTeIKo7Kmm5VwU3XY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Vbs3NMHDEORlIEZWlJPWHPShDsFJIQ8aGkh5+KC6ON57ntQcYvXjFq702qPaGfCCZ
         tD2gdEq5iOzg664eRymkPB/1jFXoZiaoaNGK1cP19WLh2Mgk97YoL2eenZThfFVdvP
         fTtUyVj7GOK7pwDg1vAQoaz7tm4i9FshaWxuvwpU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 59BC612812B3;
        Tue, 20 Dec 2022 07:50:54 -0500 (EST)
Message-ID: <e26b33be6ae53d4b566cffda092bcd45a3691c06.camel@HansenPartnership.com>
Subject: Re: Question on loading trusted key with keyctl command
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sughosh Ganu <sughosh.ganu@linaro.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 20 Dec 2022 07:50:52 -0500
In-Reply-To: <CADg8p972AxWMTQbAXc=+zX9STtLdRKUmopbjEbq0rfFP_TKwrg@mail.gmail.com>
References: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
         <ddefa55ad5c5f0dc0248a4017ea31e8e5d7a5328.camel@HansenPartnership.com>
         <CADg8p972AxWMTQbAXc=+zX9STtLdRKUmopbjEbq0rfFP_TKwrg@mail.gmail.com>
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

On Tue, 2022-12-20 at 12:03 +0530, Sughosh Ganu wrote:
> On Mon, 19 Dec 2022 at 18:20, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Mon, 2022-12-19 at 15:50 +0530, Sughosh Ganu wrote:
> > > hi,
> > > I am trying to enable the evm hmac solution on my qemu arm64 virt
> > > platform running Debian. I am using the swtpm 2.0 implementation
> > > for
> > > the TPM trusted source. Before I get into trying out the evm hmac
> > > solution on the target system, I wanted to check creating the
> > > trusted
> > > and encrypted keys.  Other details on my set up are as follows
> > > 
> > > Distro - Debian 11
> > > TPM - swtpm
> > > Linux kernel - Linux version 6.1.0-13032, commit 77856d911a8c [1]
> > > keyctl --version
> > > keyctl from keyutils-1.6.1 (Built 2020-02-10)
> > > 
> > > When trying to follow the steps highlighted in the
> > > Documentation/security/keys/trusted-encrypted.rst, I can generate
> > > the
> > > trusted key. However, when I try to load the trusted key using
> > > the
> > > command shown in the document, it throws an error. Has there been
> > > a
> > > change in the code, or am I missing some step when trying to load
> > > the
> > > trusted key?
> > > 
> > > Steps that I am following (after having created the SRK).
> > > 
> > > # keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
> > > # keyctl show
> > > Session Keyring
> > >  442944693 --alswrv      0     0  keyring: _ses
> > >  925986946 --alswrv      0 65534   \_ keyring: _uid.0
> > >  401286062 --alswrv      0     0       \_ trusted: kmk
> > > # keyctl pipe 401286062 > kmk.blob
> > > # keyctl add trusted kmk "load `cat kmk.blob`
> > > keyhandle=0x81000001"
> > > @u
> > > add_key: Invalid argument
> > 
> > kmk is your invalid argument ... you already have a key there. 
> > Either
> > unlink %trusted:kmk or add the new key at kmk1.
> 
> I was able to load the key after clearing the keyring. Thanks James
> and Mimi for your pointers.

Actually, I think this is a bug in trusted keys.  Add on existing key
is supposed to go through the update path.  If the path doesn't exist
it returns -EEXIST.  Trusted keys have an update path but they return -
EINVAL if the trusted key command is anything but update (which is used
to reseal a key).  Obviously this is incorrect and the code should be
returning -EEXIST for a key we refuse to update to match every other
key type.

This should be the fix.

James

---

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index c6fc50d67214..8dcd84137035 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -254,7 +254,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	datablob[datalen] = '\0';
 	ret = datablob_parse(&datablob, new_p);
 	if (ret != Opt_update) {
-		ret = -EINVAL;
+		ret = -EEXIST;
 		kfree_sensitive(new_p);
 		goto out;
 	}

