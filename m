Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1681661FF72
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 21:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiKGUSv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 15:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiKGUSp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 15:18:45 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881F61EACF
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 12:18:44 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id q9so33353155ejd.0
        for <linux-integrity@vger.kernel.org>; Mon, 07 Nov 2022 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=enMdjmIsSbUUYGb+RiHPQULVTIcs0r1uA7QvgYehDfo=;
        b=cK5mzUepaprD41nCiRUmaLmzTIgcnNw5msQaClmACmYhAcO7XK6rJUBvOqZtgby6y8
         52QvjVVQH7ojFFZrM7qfAy0IdolyIX8knrA6IaYyvW21uhXHySccJ3/m2Wleu58EVtDt
         6MIVe9aRiDrWdsThdVgafQbhigdkLUk4g2knQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enMdjmIsSbUUYGb+RiHPQULVTIcs0r1uA7QvgYehDfo=;
        b=MjLAKCuKYd0qA8enqv/F4ryyKz7YslEXu2XuDglzp1RbnFi3SKDBPw1qEr8Iq2ZKxg
         BgeBjEX1aUjFDxTV3bj4YAeOzgMMPdA/1v9pU9NGWQBBVnZIvR2+jLtwvuWS+jZ//eRn
         bRglKKk4cOtWJsd+cMw5CYR+c+pSf1d3stEYo2bWE2L5DzKp6RwCeSR906e+Mc/Wj7VQ
         TDx2BBVTyRg4kALwh69LLAgKhrLu1M5f5IayEBXE9qt0EmbfDzck8cJuMv+oboVSeqn8
         m6b2aqSmtsD3s4mjfGit6EIEEv7L2oBVugPbXRZTiy4AH3raTOjC0r/w7lIyNO9NlPLe
         EJjw==
X-Gm-Message-State: ACrzQf1U0NeUBJ7zSEc/LfPxnTmr/6TM6Mx9/BWiTCjn0rIaNcUW2QjU
        eeY1Tx40IqdLCwCk643PpcDYEnSUnbhP8Q==
X-Google-Smtp-Source: AMsMyM6CAAIftgbPR7aYbrg5AdMWaItErpFuTq06oMPiOutshklj/T6y7flpJnj1nGzkYiKiZMk7QQ==
X-Received: by 2002:a17:907:8b18:b0:7ad:d1f5:2f80 with SMTP id sz24-20020a1709078b1800b007add1f52f80mr42541262ejc.661.1667852322937;
        Mon, 07 Nov 2022 12:18:42 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id x4-20020aa7d6c4000000b0045cf4f72b04sm4606328edr.94.2022.11.07.12.18.42
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:18:42 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id j15so17907931wrq.3
        for <linux-integrity@vger.kernel.org>; Mon, 07 Nov 2022 12:18:42 -0800 (PST)
X-Received: by 2002:a5d:6dc3:0:b0:22a:bcc3:21c6 with SMTP id
 d3-20020a5d6dc3000000b0022abcc321c6mr34070892wrz.450.1667851934711; Mon, 07
 Nov 2022 12:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <202211041132.E8CB636@keescook>
In-Reply-To: <202211041132.E8CB636@keescook>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 7 Nov 2022 12:11:38 -0800
X-Gmail-Original-Message-ID: <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
Message-ID: <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] security: keys: trusted: Include TPM2 creation data
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 4, 2022 at 11:33 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Nov 03, 2022 at 11:01:12AM -0700, Evan Green wrote:
> > In addition to the private key and public key, the TPM2_Create
> > command may also return creation data, a creation hash, and a creation
> > ticket. These fields allow the TPM to attest to the contents of a
> > specified set of PCRs at the time the trusted key was created. Encrypted
> > hibernation will use this to ensure that PCRs settable only by the
> > kernel were set properly at the time of creation, indicating this is an
> > authentic hibernate key.
> >
> > Encode these additional parameters into the ASN.1 created to represent
> > the key blob. The new fields are made optional so that they don't bloat
> > key blobs which don't need them, and to ensure interoperability with
> > old blobs.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> There's a lot of open-coded math for the bounds checking. I didn't
> immediately see any problems, but it'd be nice if there was a way to
> hook a fuzzer up to this, or at least write some KUnit tests to check
> boundary conditions explicitly.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thank you! Yes, agreed about all the bounds checking. I could probably
pull out the "check for src + 2 > end, then get_unaligned_be16()" into
a helper function. Let me see if that makes things look better or ends
up looking the same.
-Evan
