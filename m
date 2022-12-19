Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D783650C28
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Dec 2022 13:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiLSMul (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Dec 2022 07:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiLSMuh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Dec 2022 07:50:37 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FD2FD2B
        for <linux-integrity@vger.kernel.org>; Mon, 19 Dec 2022 04:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1671454233;
        bh=Csj51R5RzmD5CqDeAKOhkurKiLCQsHh765r+9++NrA0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ns4nqeecNnC23ou3F+AHEDCeojzbpD+WtBbihC20D7f8jy1tenLZI1gGbYQa1CCSC
         pU5cyxhEGIk35EGD9pE2jH5vKzq5+028QlgqL6naGcnVeACEmb9+hOweRF9HDLYV7M
         BfzYKI293T2RR4SywHzN25hhUNV8aSmX3FyQVWok=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AC1031281C3E;
        Mon, 19 Dec 2022 07:50:33 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yC7vtZA51NKb; Mon, 19 Dec 2022 07:50:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1671454233;
        bh=Csj51R5RzmD5CqDeAKOhkurKiLCQsHh765r+9++NrA0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ns4nqeecNnC23ou3F+AHEDCeojzbpD+WtBbihC20D7f8jy1tenLZI1gGbYQa1CCSC
         pU5cyxhEGIk35EGD9pE2jH5vKzq5+028QlgqL6naGcnVeACEmb9+hOweRF9HDLYV7M
         BfzYKI293T2RR4SywHzN25hhUNV8aSmX3FyQVWok=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 381CE128194E;
        Mon, 19 Dec 2022 07:50:33 -0500 (EST)
Message-ID: <ddefa55ad5c5f0dc0248a4017ea31e8e5d7a5328.camel@HansenPartnership.com>
Subject: Re: Question on loading trusted key with keyctl command
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sughosh Ganu <sughosh.ganu@linaro.org>,
        linux-integrity@vger.kernel.org
Date:   Mon, 19 Dec 2022 07:50:32 -0500
In-Reply-To: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
References: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
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

On Mon, 2022-12-19 at 15:50 +0530, Sughosh Ganu wrote:
> hi,
> I am trying to enable the evm hmac solution on my qemu arm64 virt
> platform running Debian. I am using the swtpm 2.0 implementation for
> the TPM trusted source. Before I get into trying out the evm hmac
> solution on the target system, I wanted to check creating the trusted
> and encrypted keys.  Other details on my set up are as follows
> 
> Distro - Debian 11
> TPM - swtpm
> Linux kernel - Linux version 6.1.0-13032, commit 77856d911a8c [1]
> keyctl --version
> keyctl from keyutils-1.6.1 (Built 2020-02-10)
> 
> When trying to follow the steps highlighted in the
> Documentation/security/keys/trusted-encrypted.rst, I can generate the
> trusted key. However, when I try to load the trusted key using the
> command shown in the document, it throws an error. Has there been a
> change in the code, or am I missing some step when trying to load the
> trusted key?
> 
> Steps that I am following (after having created the SRK).
> 
> # keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
> # keyctl show
> Session Keyring
>  442944693 --alswrv      0     0  keyring: _ses
>  925986946 --alswrv      0 65534   \_ keyring: _uid.0
>  401286062 --alswrv      0     0       \_ trusted: kmk
> # keyctl pipe 401286062 > kmk.blob
> # keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001"
> @u
> add_key: Invalid argument

kmk is your invalid argument ... you already have a key there.  Either
unlink %trusted:kmk or add the new key at kmk1.

James

