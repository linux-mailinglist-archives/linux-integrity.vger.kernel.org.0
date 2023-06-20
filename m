Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A44736C22
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 14:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjFTMnP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jun 2023 08:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFTMnP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jun 2023 08:43:15 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D41110F1;
        Tue, 20 Jun 2023 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687264991;
        bh=rxD6wxm2k8kadpackQvA1wnGV8UggsJXYeAvB0cfDTo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=VNwBFg+Mv8Nb3APfYpLppneAimj5Jyf1QE9SzK/srIwqlGRCne0aNzVXmOC2r34Ac
         RIzStVawsowjvGhmWcDNzAw/L4AHehHhobB3QxDlkf51owd1MR1hqQNC4vwhBNtMpu
         W6PW1ESq7SUcK6kooH9VCq1TATiJ0YDq/+nTIKmo=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 354071281446;
        Tue, 20 Jun 2023 08:43:11 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 5ie9uAfb3k9R; Tue, 20 Jun 2023 08:43:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687264988;
        bh=rxD6wxm2k8kadpackQvA1wnGV8UggsJXYeAvB0cfDTo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=noITonWSXnWCmrwWNgg0Lh4cNGmm1T/i9J6Wlj4oTr9lLGSaUXLtzKftp2pSOBvhG
         hfhtMF+t9zAVvV0TeOREHSe7npf9ejrt+zeucbaB+T9oVzlTTZ98590/yvilSSHRdK
         p5oCl5gzhHbm24Q4yTYrFlPWX6TmHS9cLhDKR1nw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8D1ED128125E;
        Tue, 20 Jun 2023 08:43:03 -0400 (EDT)
Message-ID: <b2ee0120b5f3caec6ddd617c1594cc05d66a6687.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] fsverity: improve documentation for builtin
 signature support
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Luca Boccassi <bluca@debian.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     fsverity@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Victor Hsieh <victorhsieh@google.com>
Date:   Tue, 20 Jun 2023 08:43:00 -0400
In-Reply-To: <CAMw=ZnRVKQz9tY=DH9eoAMeEd07tdXMENW0Lhbx2tApH==5D_Q@mail.gmail.com>
References: <20230619221048.10335-1-ebiggers@kernel.org>
         <CAMw=ZnQCBJM71wi-yO99yi+KTy=WtR2+jJxU2snvWgJTzTeeFw@mail.gmail.com>
         <20230619234939.GA2320@sol.localdomain>
         <CAMw=ZnRVKQz9tY=DH9eoAMeEd07tdXMENW0Lhbx2tApH==5D_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-06-20 at 01:42 +0100, Luca Boccassi wrote:
> On Tue, 20 Jun 2023 at 00:49, Eric Biggers <ebiggers@kernel.org>
> wrote:
> > On Tue, Jun 20, 2023 at 12:04:39AM +0100, Luca Boccassi wrote:
[...]
> > > > +- fs-verity builtin signatures are in PKCS#7 format, and the
> > > > public
> > > > +  keys are in X.509 format.  These data formats are
> > > > unnecessarily
> > > > +  complex and prone to vulnerabilities.  (fs-verity builtin
> > > > signatures
> > > > +  were made to use these formats because other kernel
> > > > subsystems, such
> > > > +  as the module loader, unfortunately used these formats
> > > > already.
> > > > +  Note, these formats should still be used when they are the
> > > > only
> > > > +  option to have signatures at all.)  Userspace signature
> > > > verification
> > > > +  avoids having to enable CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> > > > and the
> > > > +  associated kernel attack surface.  Userspace also has the
> > > > +  flexibility to choose simpler formats.  For example,
> > > > consider using
> > > > +  straightforward Ed25519 keys and signatures with `libsodium
> > > > + 
> > > > <https://libsodium.gitbook.io/doc/public-key_cryptography/publi
> > > > c-key_signatures>`_.
> > > > +
> > > > +  IMA appraisal, which supports fs-verity, does not use
> > > > PKCS#7, so it
> > > > +  partially avoids this issue as well (though it does use
> > > > X.509).
> > > > +
> > > > +  If you are considering making use of "advanced" features of
> > > > X.509
> > > > +  and/or PKCS#7, please also keep in mind that these
> > > > "advanced"
> > > > +  features do not always work as intended with the kernel. 
> > > > For
> > > > +  example, the kernel does not check X.509 certificate
> > > > validity times.
> > > 
> > > Sorry but this still reads as way too opinionated and generic,
> > > rather than being fsverity-specific.
> > > 
> > > Please simplify to convey the same
> > > message in more concise way, perhaps something along these lines:
> > > 
> > > - fs-verity builtin signatures are in PKCS#7 format, and the
> > > public keys are in X.509 format. IMA appraisal, which supports
> > > fs-verity, uses a custom signature format rather than PKCS#7 and
> > > X.509 for public keys. Alternative formats for signatures and
> > > public keys are not supported for builtin signatures or IMA
> > > appraisal. For fully flexible and customized signature and public
> > > keys formats, while also avoiding to expose the kernel to
> > > untrusted input, signature verification can be implemented by a
> > > trusted userspace component as described at <pointer to
> > > appropriate section>
> > 
> > That is not the same message at all, as it omits the mention of the
> > disadvantages of PKCS#7 and X.509 compared to raw signatures, which
> > was the main point.  So no, I don't think your version would be
> > better.
> 
> The 'disadvantages' are your personal opinions. It's fine to have
> opinions, it's less fine to present them as if they were industry
> consensus in public project-wide documentation.
> 
> > It seems that what is going on here is that you are invested
> > heavily into existing X.509 and PKCS#7 based systems, and as a
> > result you do not want the problems with these formats to be
> > described anywhere in the kernel documentation.  That is
> > understandable, but that is a special interest that should not be
> > catered to here.  This documentation is trying to help users make
> > a decision of what type of signature to use in new systems.  And
> > yes, it is fsverity specific documentation, but there is no way for
> > it to make the needed point without dicussing the underlying data
> > formats.
> 
> Industry standards are by very definition the opposite of 'special
> interests'. Look, I tried my best to provide constructive and
> actionable feedback in previous replies, but given you seem only
> interested in casting aspersions and hijacking kernel documentation
> to promote the latest proprietary google-toy-of-the-month:

OK, could I try to share the perspective of of someone who's worked in
security with users for a long time. I get that every security expert
thinks standard key formats are insecure, usually for two reasons

   1. In security simpler is better
   2. They can always come up with a simple, totally secure, key
      representation

The problem with the above is that it means every tool invented by a
different security expert has a different key format and we don't have
any interoperability between them. This is great from a security point
of view but terrible for usability: users want both interoperability
and pluggability (particularly the ability to use tokens or other
security devices in place of keys). Our security systems are not coded
for absolute security (otherwise they would be completely balkanized);
they're a tradeoff between usability and security. There's actually
even a security reason for this: a security tool no-one can use isn't
contributing to the security of the ecosystem, however internally
secure and up to date the tool is. It's not just Google who has a habit
of special coding security systems to work on Android (with Titan-M), I
can't use wireguard on Linux because I long ago mandated that critical
things like VPN keys should be in secure keystores and I use the TPM on
Linux for openvpn. Wireguard, because it has a simple and secure key
format, won't plug into the kernel TPM system without a whole load of
speciallised glue, so I'm stuck with openvpn.

The debate you two are having now is about the most important thing we
can ever decide: where to draw the line between usability and security.
If you conduct it in a more constructive manner and try to see each
other's point of view (Eric: how would I use a TPM with fsverity on
Linux? and Luca: how much interoperability does fsverity really need
for debian?) because usability without security is as equally useless
as security without usability.

Regards,

James



