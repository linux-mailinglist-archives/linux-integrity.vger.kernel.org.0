Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066F623835
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 01:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiKJAgr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Nov 2022 19:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKJAgr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Nov 2022 19:36:47 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5FC2733
        for <linux-integrity@vger.kernel.org>; Wed,  9 Nov 2022 16:36:46 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id f5so1193135ejc.5
        for <linux-integrity@vger.kernel.org>; Wed, 09 Nov 2022 16:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nlqLQiiaOaZsIVqPkpURbCqECGxlhLAGf8/oZgDPEwg=;
        b=TibEJ/dS9oqIAlyw0U4d9Y17tk1l/5W9NiA/VJLZylVbn2FOy3zk5VI/yoCYNAuGoE
         Oc/Um2qfEuVCzsSWM/0hQdPyYt1cE7yzSxpdx7nS7ovvnFNjrDg/SO+IHB7dUcl1WCSg
         iWprIbuqzyqir3yxeR8YrLGkhepBTjIioA0E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlqLQiiaOaZsIVqPkpURbCqECGxlhLAGf8/oZgDPEwg=;
        b=uXwdYyBdWQi4BLhXEiKCyWWXe8YIHRk8VZROb/1EtMQUoh2EucGN2I1xGdxQAcGxwz
         OJEenMqlrTmJykIg/c7kjLMdqYLmlhojv+qSglDONYri4vTO8tpmRlNEcEAygzS1s1lK
         rVxmeGfkr8n89aUxEwt4aEWWAAK+UifTyAy6vK33q1o+CxOFgaJW9DrbOh7VgPdRKzws
         Dhtthrs2lpcnj5ZDcgcMEtvfrTblgJGaCW+KK8+lHE693PHKvT+6ChPhdnFHZ+Hfv3Vq
         cWlj+b7GiXTfhKDR95Y1QHa80fBdf2EH1uEKP++lNSWaiG/8ej+N3XeiFNhrjzdhIIAq
         iGPQ==
X-Gm-Message-State: ACrzQf1PpCAdHgBqdOazOa2MnygAcRvVKET3rAtwtePbkBP7sNTHpkXG
        CVJ/mpozPoiF1/r1GxdZaoLZuGaAENS2xQ==
X-Google-Smtp-Source: AMsMyM6CDjGieI+1KpCKVssfAJsVEcMeyVeJJQOyBHFLEPe1o5PJ6zw/d+AobOO1Kh5YRSJra2qzgA==
X-Received: by 2002:a17:907:805:b0:782:1a0d:337f with SMTP id wv5-20020a170907080500b007821a0d337fmr59413499ejb.475.1668040604459;
        Wed, 09 Nov 2022 16:36:44 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090630c300b007ae0fde7a9asm6348601ejb.201.2022.11.09.16.36.44
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 16:36:44 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id w14so145243wru.8
        for <linux-integrity@vger.kernel.org>; Wed, 09 Nov 2022 16:36:44 -0800 (PST)
X-Received: by 2002:adf:e44f:0:b0:236:59a3:c5a8 with SMTP id
 t15-20020adfe44f000000b0023659a3c5a8mr40946801wrm.396.1668040203082; Wed, 09
 Nov 2022 16:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <202211041132.E8CB636@keescook> <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
In-Reply-To: <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 9 Nov 2022 16:29:26 -0800
X-Gmail-Original-Message-ID: <CAE=gft6O6WFbVL4mQ6trS4UkfkvNEFcUT0eN+6QAsXbf6DLdvQ@mail.gmail.com>
Message-ID: <CAE=gft6O6WFbVL4mQ6trS4UkfkvNEFcUT0eN+6QAsXbf6DLdvQ@mail.gmail.com>
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

On Mon, Nov 7, 2022 at 12:11 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Fri, Nov 4, 2022 at 11:33 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Nov 03, 2022 at 11:01:12AM -0700, Evan Green wrote:
> > > In addition to the private key and public key, the TPM2_Create
> > > command may also return creation data, a creation hash, and a creation
> > > ticket. These fields allow the TPM to attest to the contents of a
> > > specified set of PCRs at the time the trusted key was created. Encrypted
> > > hibernation will use this to ensure that PCRs settable only by the
> > > kernel were set properly at the time of creation, indicating this is an
> > > authentic hibernate key.
> > >
> > > Encode these additional parameters into the ASN.1 created to represent
> > > the key blob. The new fields are made optional so that they don't bloat
> > > key blobs which don't need them, and to ensure interoperability with
> > > old blobs.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > There's a lot of open-coded math for the bounds checking. I didn't
> > immediately see any problems, but it'd be nice if there was a way to
> > hook a fuzzer up to this, or at least write some KUnit tests to check
> > boundary conditions explicitly.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Thank you! Yes, agreed about all the bounds checking. I could probably
> pull out the "check for src + 2 > end, then get_unaligned_be16()" into
> a helper function. Let me see if that makes things look better or ends
> up looking the same.

A helper function cleaned this up nicely, so I'll send that in the
next spin but not yet pick up your reviewed tag.
