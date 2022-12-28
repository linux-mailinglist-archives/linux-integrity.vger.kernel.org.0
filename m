Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFD65875D
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Dec 2022 23:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiL1WsS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Dec 2022 17:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiL1WsQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Dec 2022 17:48:16 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1348D140E9
        for <linux-integrity@vger.kernel.org>; Wed, 28 Dec 2022 14:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1672267692;
        bh=jwypNmDm+dqCnQKy6QR9l1upy1LgBc/TRyYYj2qjbhM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CFLtMnvBndi2qLUAAl6RjQ1AWt2okBcGln55NpaKbq33k+bkynBJTtYxwOvQ0QQoP
         9a7FxikVRO+IAtXBmDU59U/ShdAnXHygBEqhgOQ9il6oKq6/Zv0JzTsSmmfY+W3Rbc
         2ny1erBjH0w+8ehB1tWShbpTyVj0EPDyf/rgDXP8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C72FD128142F;
        Wed, 28 Dec 2022 17:48:12 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3o6Vzy84mX-P; Wed, 28 Dec 2022 17:48:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1672267692;
        bh=jwypNmDm+dqCnQKy6QR9l1upy1LgBc/TRyYYj2qjbhM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CFLtMnvBndi2qLUAAl6RjQ1AWt2okBcGln55NpaKbq33k+bkynBJTtYxwOvQ0QQoP
         9a7FxikVRO+IAtXBmDU59U/ShdAnXHygBEqhgOQ9il6oKq6/Zv0JzTsSmmfY+W3Rbc
         2ny1erBjH0w+8ehB1tWShbpTyVj0EPDyf/rgDXP8=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4E6291280E5B;
        Wed, 28 Dec 2022 17:48:12 -0500 (EST)
Message-ID: <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
Subject: Re: Seal/Unseal trusted keys against PCR policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sughosh Ganu <sughosh.ganu@linaro.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Wed, 28 Dec 2022 17:48:09 -0500
In-Reply-To: <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
         <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
         <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
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

On Thu, 2022-12-29 at 02:10 +0530, Sughosh Ganu wrote:
[...]
> Thanks for your reply. For reloading the sealed key, I am trying to
> start a policy session through the tpm2_startauthsession command,
> followed by the tpm2_policypcr command to get the same policy digest.
> However, I am not sure how to get the session handle. As per my
> understanding, the policyhandle is a uint32_t object. However, none
> of the above two commands give back the session handle. I tried the
> tpm2_getcap command with the handles-saved-session, which shows a
> handle once I have run the tpm2_startauthsession command. However,
> providing this value to the keyctl command as policyhandle does not
> work. Can you please point out what I am doing wrong?

I'm afraid I gave up on the Intel toolkit long ago because of the
constantly changing command options.  I can show you how to do it with
the IBM toolkit, though:

https://build.opensuse.org/package/show/security/ibmtss

The main thing you have to do is connect to the TPM not through the
resource manager so the policy session survives multiple commands

export TPM_DEVICE=/dev/tpm0

Then you can seal to say PCR7 which simply records the secure boot
state:

root@testdeb:~# cat /sys/class/tpm/tpm0/pcr-sha256/7
65CAF8DD1E0EA7A6347B635D2B379C93B9A1351EDC2AFC3ECDA700E534EB3068

So you can now construct the policy exactly and ask policymaker what
its hash is:

root@testdeb:~# tsspolicymakerpcr -pr -bm 000080 -if /sys/class/tpm/tpm0/pcr-sha256/7 > tmp.policy
root@testdeb:~# tsspolicymaker -if ~/tmp.policy -ns
policy digest:
4cc48043aedaae487452bb407e8fc21d25c3a412ffc9473cf2552ddc659e97c1

So now you know the policy hash, you can create a key

root@testdeb:~# keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha256 policydigest=4cc48043aedaae487452bb407e8fc21d25c3a412ffc9473cf2552ddc659e97c1" @u
214245338
keyctl pipe %trusted:kmk > key.tpm
keyctl unlink %trusted:kmk
1 links removed

Now you can reload it if you construct the correct policy

root@testdeb:~# tssstartauthsession -se p
Handle 03000000
root@testdeb:~# tsspolicypcr -ha 03000000 -bm 000080

Now you can check this policy register matches the hash you have above:

root@testdeb:~# tsspolicygetdigest -ha 03000000
 policyDigest length 32
 4c c4 80 43 ae da ae 48 74 52 bb 40 7e 8f c2 1d 
 25 c3 a4 12 ff c9 47 3c f2 55 2d dc 65 9e 97 c1 

And you can now use this policy handle as the reload policy for the
key:

root@testdeb:~# keyctl add trusted kmk "load `cat ~/key.tpm` policyhandle=0x03000000" @u
872397032


James


