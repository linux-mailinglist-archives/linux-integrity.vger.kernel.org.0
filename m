Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1744D1729DD
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 22:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgB0VCY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 16:02:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43637 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0VCY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 16:02:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id u12so300135pgb.10;
        Thu, 27 Feb 2020 13:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBmvD7uLXP5SNcixgwHe8khSG7aleeTsk8a1m1cNQPI=;
        b=jl0+o6QvHLdDuH5PoS+azj/pDi2HO/KPNua6BFSOt5d+Ih4Qut3Q3XLDC0NFq0A7or
         h4w2XUE6a5b8X5j01vv21zMr2OQ01evO19zSXH/kFUd+o+4Kusv1FvVdaOZJfRErOF7h
         J2vSJdG4Tp85TgxhKzc+HnAJIPBNH8USM7StE0DfXw+zVSz5BD6eHzA+P3atGZMpa0g4
         dzCBgrN5JlwgeOGsGMJ1A5FiwFb20pSYw+7senbVBDbEuSJJ/p/1TA9cDjr2kyaxc1Hd
         GCGy31X79j0wbzBiqNxhsC525GP9h2QM4HC9FkxDSpEju5ZZNF16+pca+2t29ew6tsse
         if0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBmvD7uLXP5SNcixgwHe8khSG7aleeTsk8a1m1cNQPI=;
        b=mz+NrxoM4nXxm/wcMJCVSf8xSEX3ShZOelaOTD3CC38qWjDGdhf/wR8CieOSpK74S3
         DyA+iT40pwq45ITbx9gIXGveFIvCbKNUy9CEA1mAgWQdNLWM2gQMctmh7bqGHInQyk6f
         AybI9Fo7p+f93z45coYU+vfQerV8teIFlywTy/ACy3VnCmRLPiZk0hZ6NUj2kHZWC2bz
         GF1gMdcdkSmaTNijUUXVlBcrPiGSBxd+AROuyksonNptA/p3dS0xbKboBGJZJiZ8+g8n
         Z9OVqvIsYk4CjxwZ9cg1pgr4CRy5Xy5YgMxM2WWZE23takb+eWtGlXznpFKneRWT2OWB
         UxFQ==
X-Gm-Message-State: APjAAAUPE9J4LlX6fIrxIC52/WUly6KWGunKyNv0E7YK3UqhNPW0wzKs
        c2m4wkq6ZdIoOEZBQWu+KWE=
X-Google-Smtp-Source: APXvYqyR6r2+b/kPLqnnfaySZKoiPB5CqnvuaJCmj7o17HpLdvhPxY/kO2XEaksMvebRiNTotoCn3w==
X-Received: by 2002:a62:3304:: with SMTP id z4mr816776pfz.79.1582837342568;
        Thu, 27 Feb 2020 13:02:22 -0800 (PST)
Received: from jprestwo-test.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.googlemail.com with ESMTPSA id w184sm7169404pgw.84.2020.02.27.13.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 13:02:22 -0800 (PST)
Message-ID: <3feaa7a3265b472bb3694045448fc44368f1fb99.camel@gmail.com>
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Prestwood <prestwoj@gmail.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Thu, 27 Feb 2020 12:57:52 -0800
In-Reply-To: <1582834760.18538.15.camel@HansenPartnership.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
         <1582761736.4245.12.camel@HansenPartnership.com>
         <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
         <1582764844.4245.29.camel@HansenPartnership.com>
         <17e025e222cb6aefb5680d6cdad64a9ecf76fa97.camel@gmail.com>
         <1582834760.18538.15.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-02-27 at 12:19 -0800, James Bottomley wrote:
> On Thu, 2020-02-27 at 09:19 -0800, James Prestwood wrote:
> > On Wed, 2020-02-26 at 16:54 -0800, James Bottomley wrote:
> > > On Wed, 2020-02-26 at 16:20 -0800, James Prestwood wrote:
> > > > > > I have been using your set of patches in order to get this
> > > > > > ASN.1 parser/definition. I am implementing an asymmetric
> > > > > > key
> > > > > > parser/type TPM2 keys for enc/dec/sign/verify using keyctl.
> > > > > > Note that this implementation goes in
> > > > > > crypto/asymmetric_keys/, and your patches sit in
> > > > > > security/keys/trusted-keys/.
> > > > > > 
> > > > > > Currently I am just including "../../security/keys/trusted-
> > > > > > keys/{tpm2key.asn1.h,tpm2-policy.h}" in order to use the
> > > > > > ASN.1 parser to verify my keys, but this obviously isn't
> > > > > > going to fly.
> > > > > > 
> > > > > > Do you (or anyone) have any ideas as to how both trusted
> > > > > > keys
> > > > > > and asymmetric keys could share this ASN.1
> > > > > > parser/definition?
> > > > > > Some common area that both security and crypto could
> > > > > > include?
> > > > > > Or maybe there is some common way the kernel does things
> > > > > > like
> > > > > > this?
> > > > > 
> > > > > Actually TPM2 asymmetric keys was also on my list.  I was
> > > > > going
> > > > > to use the existing template and simply move it somewhere
> > > > > everyone could use.  I also think you need the policy parser
> > > > > pieces because at least one implementation we'd need to be
> > > > > compatible with supports key policy.
> > > > 
> > > > In terms of policy, I haven't looked into that at all for
> > > > asymmetric keys. I do already have enc/dec/sign/verify
> > > > asymmetric
> > > > key operations all working, and used your ASN1 template for
> > > > parsing (just copied it into asymmetric_keys for now). Since
> > > > the
> > > > asymmetric operations use HMAC sessions I didn't see much carry
> > > > over from your patches (but this could change if policy stuff
> > > > gets introduced).
> > > 
> > > There's a related patch that introduces HMAC and encryption
> > > sessions for pretty much everything in the TPM:
> > > 
> > > 
> > 
> > 
https://lore.kernel.org/r/1568031408.6613.29.camel@HansenPartnership
> > .
> > com
> > > 
> > > I didn't resend this time around because of patch overload, and
> > > anyway, the last patch needs updating for the current policy c
> > 
> > Well... I sure duplicated a lot of work. I haven't been on these
> > lists long enough to see that come through. I am still reading
> > through these patches, but noticed some differences already with
> > how
> > the session is started. I use the parent key handle for "salt key
> > handle" ratherthan the null key.
> 
> That's a minor detail.  The routines could be updated to use anything
> for the parent.  The null seed is just convenient and has nice
> security
> properties.
> 
> >  Also I used RSA/OAEP for encrypting the salt value rather than
> > ECC.
> > I hadn't read into the null key thing, but I will now. I would be
> > more than happy to rip out the OAEP code though. I was just
> > modeling
> > everything how libtpms did it, which used OAEP.
> 
> There's not much the IBM and Intel TSS teams agree on, but we do
> agree
> that RSA is a bad choice for parents and that EC keys are much
> better. 
> The main reason is that most TPM 2's are much worse at RSA operations
> than EC ones ... you're looking at factors of 10x to 100x simply
> because of the huge bignum complexity of RSA, which really slows
> everything down when you use RSA parents for crypto
> operations.  Then,
> as you found, no-one really does the padding with OAEP either.

I am learning lots from this discussion, so thank you. I had assumed
that the parent key crypto had to match the child key, RSA vs EC, but
sounds like that is not the case. And yes, this sounds like a much
better way to go now that I have a bit more info on it.

> 
> > Obviously we don't want a bunch of duplicated code, but I am
> > somewhat
> > concerned about going right in and using these patches as they have
> > been sitting around quite a while (plus you said they will need
> > updating). Seems like the best route is get these merged, then
> > update/send my patches.
> 
> So we figure out the correct precursor patches and have a couple of
> sets ... Jarkko likes stuff done this way anyway.

Ok, I'll figure out exactly what I need. Its looking like the only
duplication is starting the session and all the HMAC helpers.

> 
> > > > This will go in the eventual RFC soon but while I have you
> > > > here:
> > > >  I also implemented key wrapping. Exposing this as a keyctl API
> > > > may take some rework, hopefully with some help from others in
> > > > this subsystem.
> > > 
> > > Wrapping for what?  The output privkey in the ASN.1 is wrapped by
> > > the TPM using its internal AES key.  The ASN.1 also defines ECDH
> > > wrapping, that's what the secret element of the sequence is for,
> > > but you'd only use that for creating a wrapped key to pass in to
> > > the TPM knowing the parent.  The way current TPM crypto systems
> > > use
> > > this is they generate an EC parent from the storage primary seed
> > > on
> > > the NIST P256 curve.
> > 
> > I implemented CC_Import(). You generate the private key yourself
> > (openssl or however) and import it into the TPM. Then the result of
> > that is the TPM wrapped key that can be loaded later on. And yes
> > this
> > depends on knowing the parent handle.
> 
> Right, that's what the key wrapping code of the engine does as well,
> except that we use EC parents and ECDH wrapping.
> 
> > I basically just implemented:
> > 
> > create_tpm2_key -w privkey.pem -p <handle> privkey.tpm
> > 
> > My reasoning for this was because I had issues with the
> > openssl_tpm2_engine, and just the whole TPM2 on Linux support as it
> > stands now. I was able to get everything working on Debian, but
> > then
> > I went to test on real TPM hardware, which happened to be a Fedora
> > box.  This was a complete disaster; openssl_tpm2_engine did not
> > compile due to (I think) a library versioning issue and build
> > warnings. I ignored warnings, and manually built my own version
> > ofopenssl libtpms but this just resulted in create_tpm2_key to
> > segfault. At this point I just thought it would be more worth my
> > time
> > to implement Import() myself.
> > 
> > I think this was all a result of bad packaging on Fedora's part,
> > but
> > still, the experience didn't sit well with me and I felt it would
> > be
> > worth while to add support for this in keyctl.
> 
> Well there's a list you can report problems to and get help:
> 
> openssl-tpm2-engine@groups.io
> 
> I've got to confess I develop on openSUSE and debian, so Fedora
> doesn't
> get much testing.
> 
> > > It's on my todo list to accept bare primary identifiers as
> > > parents
> > > in the kernel code and create the EC primary on the fly, but it's
> > > not in this patch set.
> > > 
> > > There's also another policy problem in that generating an RSA2048
> > > key can lock the TPM up for ages, so there should likely be some
> > > type of block on someone doing this.  I was thinking that an
> > > unprivileged user should be allowed to create EC keys but not RSA
> > > ones.
> > 
> > I didn't have any plans for RSA key generation inside the TPM
> > itself,
> > just wrapping/asym operations.
> 
> Well as long as we're interoperable with create_tpm2_key, the
> consumer
> can generate a TPM resident key outside the kernel if they want and
> then simply pass it in.
> 
> > > > As it stand now you have to padd a key pair, then do a (new)
> > > > pkey_wrap operation on it. This returns a DER with the wrapped
> > > > TPM2 key. This required modifying the public_key type, which I
> > > > really did not like since it now depends on TPM. Not sure if
> > > > the
> > > > route I went is gonna fly without tweaking, but this is all new
> > > > to me :) Again, some guidance for how this should be is needed.
> > > 
> > > The way it's defined to be done using the ASN.1 secret parameter
> > > is
> > > simply the way the TPM2 command manual defines duplication with
> > > an
> > > outer wrapper.  The TPM2 manual even has a coded example in
> > > section
> > > 4 and the secret is simply a TPM2B_ENCRYPTED_SECRET.
> > 
> > I actually didn't do any inner/outer encryption when sending the
> > key
> > to the TPM (if this isn't what your talking about disregard). I
> > just
> > sent the private key over plainly. Maybe bus snooping is a concern,
> > but as a first pass I just punted on this.
> 
> Well to get TPM2_Import to work with an encrypted secret *is* what
> the
> manuals call outer wrapping, you just used an RSA encrypted secret
> instead of an ECDH protected one.  It's the same sequence of
> operations
> as for duplication.

Ok this makes more sense now.

Thanks,
James

