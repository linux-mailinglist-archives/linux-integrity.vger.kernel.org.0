Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E697371FE
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjFTQps (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jun 2023 12:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjFTQpr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jun 2023 12:45:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C233D1;
        Tue, 20 Jun 2023 09:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F2061316;
        Tue, 20 Jun 2023 16:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CE1C433C0;
        Tue, 20 Jun 2023 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687279541;
        bh=1pH/WxwiVtJnpUNwMQQu9BYTEAUYFRwf+zte4hqfFYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cCeU3J+8c1U4/8kXwVoiKAS/ATZ3p3JF0hB/IsGrPKpd4b5iP4D7197t2EUEmA5DP
         iH70sfLnkCmbFW9dorP9c+7pOyIFkcvGH8mQYaaNz2pQBNA42kW3j0V+t2ak5slRDQ
         S1Glfb2YzMpQijcV7w1EJ2hk6rbsjSB+GGVbLXUcJyv91wO+drf393mbYU5sM2/w4q
         sWGA4TqT1rHczNQ7DFjdnnd9fGXA7UAqmInHzf57CCJ463I07ORSuyv8KpBXHmCseP
         gvvFPG1dioKqmPkADmyUscvsFqmsDChOzGBgd+v9Ejeru7kmwpVCSx2vCUaxTj+EPn
         6/shUDhp1tKEw==
Date:   Tue, 20 Jun 2023 09:45:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Luca Boccassi <bluca@debian.org>, fsverity@lists.linux.dev,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH v2] fsverity: improve documentation for builtin signature
 support
Message-ID: <20230620164539.GB864@sol.localdomain>
References: <20230619221048.10335-1-ebiggers@kernel.org>
 <CAMw=ZnQCBJM71wi-yO99yi+KTy=WtR2+jJxU2snvWgJTzTeeFw@mail.gmail.com>
 <20230619234939.GA2320@sol.localdomain>
 <CAMw=ZnRVKQz9tY=DH9eoAMeEd07tdXMENW0Lhbx2tApH==5D_Q@mail.gmail.com>
 <b2ee0120b5f3caec6ddd617c1594cc05d66a6687.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2ee0120b5f3caec6ddd617c1594cc05d66a6687.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

On Tue, Jun 20, 2023 at 08:43:00AM -0400, James Bottomley wrote:
> On Tue, 2023-06-20 at 01:42 +0100, Luca Boccassi wrote:
> > On Tue, 20 Jun 2023 at 00:49, Eric Biggers <ebiggers@kernel.org>
> > wrote:
> > > On Tue, Jun 20, 2023 at 12:04:39AM +0100, Luca Boccassi wrote:
> [...]
> > > > > +- fs-verity builtin signatures are in PKCS#7 format, and the
> > > > > public
> > > > > +  keys are in X.509 format.  These data formats are
> > > > > unnecessarily
> > > > > +  complex and prone to vulnerabilities.  (fs-verity builtin
> > > > > signatures
> > > > > +  were made to use these formats because other kernel
> > > > > subsystems, such
> > > > > +  as the module loader, unfortunately used these formats
> > > > > already.
> > > > > +  Note, these formats should still be used when they are the
> > > > > only
> > > > > +  option to have signatures at all.)  Userspace signature
> > > > > verification
> > > > > +  avoids having to enable CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> > > > > and the
> > > > > +  associated kernel attack surface.  Userspace also has the
> > > > > +  flexibility to choose simpler formats.  For example,
> > > > > consider using
> > > > > +  straightforward Ed25519 keys and signatures with `libsodium
> > > > > + 
> > > > > <https://libsodium.gitbook.io/doc/public-key_cryptography/publi
> > > > > c-key_signatures>`_.
> > > > > +
> > > > > +  IMA appraisal, which supports fs-verity, does not use
> > > > > PKCS#7, so it
> > > > > +  partially avoids this issue as well (though it does use
> > > > > X.509).
> > > > > +
> > > > > +  If you are considering making use of "advanced" features of
> > > > > X.509
> > > > > +  and/or PKCS#7, please also keep in mind that these
> > > > > "advanced"
> > > > > +  features do not always work as intended with the kernel. 
> > > > > For
> > > > > +  example, the kernel does not check X.509 certificate
> > > > > validity times.
> > > > 
> > > > Sorry but this still reads as way too opinionated and generic,
> > > > rather than being fsverity-specific.
> > > > 
> > > > Please simplify to convey the same
> > > > message in more concise way, perhaps something along these lines:
> > > > 
> > > > - fs-verity builtin signatures are in PKCS#7 format, and the
> > > > public keys are in X.509 format. IMA appraisal, which supports
> > > > fs-verity, uses a custom signature format rather than PKCS#7 and
> > > > X.509 for public keys. Alternative formats for signatures and
> > > > public keys are not supported for builtin signatures or IMA
> > > > appraisal. For fully flexible and customized signature and public
> > > > keys formats, while also avoiding to expose the kernel to
> > > > untrusted input, signature verification can be implemented by a
> > > > trusted userspace component as described at <pointer to
> > > > appropriate section>
> > > 
> > > That is not the same message at all, as it omits the mention of the
> > > disadvantages of PKCS#7 and X.509 compared to raw signatures, which
> > > was the main point.  So no, I don't think your version would be
> > > better.
> > 
> > The 'disadvantages' are your personal opinions. It's fine to have
> > opinions, it's less fine to present them as if they were industry
> > consensus in public project-wide documentation.
> > 
> > > It seems that what is going on here is that you are invested
> > > heavily into existing X.509 and PKCS#7 based systems, and as a
> > > result you do not want the problems with these formats to be
> > > described anywhere in the kernel documentation.  That is
> > > understandable, but that is a special interest that should not be
> > > catered to here.  This documentation is trying to help users make
> > > a decision of what type of signature to use in new systems.  And
> > > yes, it is fsverity specific documentation, but there is no way for
> > > it to make the needed point without dicussing the underlying data
> > > formats.
> > 
> > Industry standards are by very definition the opposite of 'special
> > interests'. Look, I tried my best to provide constructive and
> > actionable feedback in previous replies, but given you seem only
> > interested in casting aspersions and hijacking kernel documentation
> > to promote the latest proprietary google-toy-of-the-month:
> 
> OK, could I try to share the perspective of of someone who's worked in
> security with users for a long time. I get that every security expert
> thinks standard key formats are insecure, usually for two reasons
> 
>    1. In security simpler is better
>    2. They can always come up with a simple, totally secure, key
>       representation
> 
> The problem with the above is that it means every tool invented by a
> different security expert has a different key format and we don't have
> any interoperability between them. This is great from a security point
> of view but terrible for usability: users want both interoperability
> and pluggability (particularly the ability to use tokens or other
> security devices in place of keys). Our security systems are not coded
> for absolute security (otherwise they would be completely balkanized);
> they're a tradeoff between usability and security. There's actually
> even a security reason for this: a security tool no-one can use isn't
> contributing to the security of the ecosystem, however internally
> secure and up to date the tool is. It's not just Google who has a habit
> of special coding security systems to work on Android (with Titan-M), I
> can't use wireguard on Linux because I long ago mandated that critical
> things like VPN keys should be in secure keystores and I use the TPM on
> Linux for openvpn. Wireguard, because it has a simple and secure key
> format, won't plug into the kernel TPM system without a whole load of
> speciallised glue, so I'm stuck with openvpn.
> 
> The debate you two are having now is about the most important thing we
> can ever decide: where to draw the line between usability and security.
> If you conduct it in a more constructive manner and try to see each
> other's point of view (Eric: how would I use a TPM with fsverity on
> Linux? and Luca: how much interoperability does fsverity really need
> for debian?) because usability without security is as equally useless
> as security without usability.

By using a TPM with fsverity, I assume you mean doing the signing with a TPM?
(Note that signing usually occurs on a system different from the one that
verifies the signature.)  Even that implies the use of X.509, which I don't
think it does, I don't think it implies the use of PKCS#7.  And it certainly
doesn't imply the use of in-kernel signature verification.  So don't immediately
see the relevance of this.

In any case, I think my latest patch (v3) is very reasonable.  I've worked hard
to address Luca's concerns, and the patch makes it clear that there are multiple
options for verification of signatures of fsverity files, both with and without
PKCS#7, and with and without in-kernel verification.  Each has its advantages
and disadvantages.  I would encourage you to read the latest patch fully; I
think Luca's comments are making it sound like it says things that it doesn't
actually say (and I also made some further revisions v2 => v3).

- Eric
