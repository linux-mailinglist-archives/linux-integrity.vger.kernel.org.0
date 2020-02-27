Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38915172964
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 21:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgB0UTX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 15:19:23 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52186 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbgB0UTX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 15:19:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2D9308EE181;
        Thu, 27 Feb 2020 12:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582834762;
        bh=aZk0nCOPMafBwK9OhQh1WNrujSZbK1zZGEy6h2/Bi1w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lTZWP74d9gxtqzfbu5X9jD+lnKa3/MnRVk0Kd8L3k4BJ2Bc6XD8PgAgek4u4zT06b
         klfc+C7NL9qcaxVIYnhXbBi2z6OE2SSIsh/pk8Nn85/K3vDJXPUcibtgMR0KN5LXUF
         F5KRejiiix5z4Xa2Wn3YkXR6D3bQxekfByT07lTc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T43-mi91Dsg3; Thu, 27 Feb 2020 12:19:21 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 57CB48EE079;
        Thu, 27 Feb 2020 12:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582834761;
        bh=aZk0nCOPMafBwK9OhQh1WNrujSZbK1zZGEy6h2/Bi1w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OJ2J3rOuRDf2NfnGJEK6Cy9E8myRko9sUFMdgLSI23bli2JruAP1j6jzTuntyJvsd
         MvCgh3E/BSvMhnZw4vevEmrWb3+/IAdWNbEsZzGk47+pIgZpcQBk1+oXHXrbahkgn9
         B6NWIku6pNcpBS2h54FpXcrQMHb+1VGb2dY54yEM=
Message-ID: <1582834760.18538.15.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Thu, 27 Feb 2020 12:19:20 -0800
In-Reply-To: <17e025e222cb6aefb5680d6cdad64a9ecf76fa97.camel@gmail.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
         <1582761736.4245.12.camel@HansenPartnership.com>
         <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
         <1582764844.4245.29.camel@HansenPartnership.com>
         <17e025e222cb6aefb5680d6cdad64a9ecf76fa97.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-02-27 at 09:19 -0800, James Prestwood wrote:
> On Wed, 2020-02-26 at 16:54 -0800, James Bottomley wrote:
> > On Wed, 2020-02-26 at 16:20 -0800, James Prestwood wrote:
> > > > > I have been using your set of patches in order to get this
> > > > > ASN.1 parser/definition. I am implementing an asymmetric key
> > > > > parser/type TPM2 keys for enc/dec/sign/verify using keyctl.
> > > > > Note that this implementation goes in
> > > > > crypto/asymmetric_keys/, and your patches sit in
> > > > > security/keys/trusted-keys/.
> > > > > 
> > > > > Currently I am just including "../../security/keys/trusted-
> > > > > keys/{tpm2key.asn1.h,tpm2-policy.h}" in order to use the
> > > > > ASN.1 parser to verify my keys, but this obviously isn't
> > > > > going to fly.
> > > > > 
> > > > > Do you (or anyone) have any ideas as to how both trusted keys
> > > > > and asymmetric keys could share this ASN.1 parser/definition?
> > > > > Some common area that both security and crypto could include?
> > > > > Or maybe there is some common way the kernel does things like
> > > > > this?
> > > > 
> > > > Actually TPM2 asymmetric keys was also on my list.  I was going
> > > > to use the existing template and simply move it somewhere
> > > > everyone could use.  I also think you need the policy parser
> > > > pieces because at least one implementation we'd need to be
> > > > compatible with supports key policy.
> > > 
> > > In terms of policy, I haven't looked into that at all for
> > > asymmetric keys. I do already have enc/dec/sign/verify asymmetric
> > > key operations all working, and used your ASN1 template for
> > > parsing (just copied it into asymmetric_keys for now). Since the
> > > asymmetric operations use HMAC sessions I didn't see much carry
> > > over from your patches (but this could change if policy stuff
> > > gets introduced).
> > 
> > There's a related patch that introduces HMAC and encryption
> > sessions for pretty much everything in the TPM:
> > 
> > 
> 
> https://lore.kernel.org/r/1568031408.6613.29.camel@HansenPartnership.
> com
> > 
> > I didn't resend this time around because of patch overload, and
> > anyway, the last patch needs updating for the current policy c
> 
> Well... I sure duplicated a lot of work. I haven't been on these
> lists long enough to see that come through. I am still reading
> through these patches, but noticed some differences already with how
> the session is started. I use the parent key handle for "salt key
> handle" ratherthan the null key.

That's a minor detail.  The routines could be updated to use anything
for the parent.  The null seed is just convenient and has nice security
properties.

>  Also I used RSA/OAEP for encrypting the salt value rather than ECC.
> I hadn't read into the null key thing, but I will now. I would be
> more than happy to rip out the OAEP code though. I was just modeling
> everything how libtpms did it, which used OAEP.

There's not much the IBM and Intel TSS teams agree on, but we do agree
that RSA is a bad choice for parents and that EC keys are much better. 
The main reason is that most TPM 2's are much worse at RSA operations
than EC ones ... you're looking at factors of 10x to 100x simply
because of the huge bignum complexity of RSA, which really slows
everything down when you use RSA parents for crypto operations.  Then,
as you found, no-one really does the padding with OAEP either.

> Obviously we don't want a bunch of duplicated code, but I am somewhat
> concerned about going right in and using these patches as they have
> been sitting around quite a while (plus you said they will need
> updating). Seems like the best route is get these merged, then
> update/send my patches.

So we figure out the correct precursor patches and have a couple of
sets ... Jarkko likes stuff done this way anyway.

> > > This will go in the eventual RFC soon but while I have you here:
> > >  I also implemented key wrapping. Exposing this as a keyctl API
> > > may take some rework, hopefully with some help from others in
> > > this subsystem.
> > 
> > Wrapping for what?  The output privkey in the ASN.1 is wrapped by
> > the TPM using its internal AES key.  The ASN.1 also defines ECDH
> > wrapping, that's what the secret element of the sequence is for,
> > but you'd only use that for creating a wrapped key to pass in to
> > the TPM knowing the parent.  The way current TPM crypto systems use
> > this is they generate an EC parent from the storage primary seed on
> > the NIST P256 curve.
> 
> I implemented CC_Import(). You generate the private key yourself
> (openssl or however) and import it into the TPM. Then the result of
> that is the TPM wrapped key that can be loaded later on. And yes this
> depends on knowing the parent handle.

Right, that's what the key wrapping code of the engine does as well,
except that we use EC parents and ECDH wrapping.

> I basically just implemented:
> 
> create_tpm2_key -w privkey.pem -p <handle> privkey.tpm
> 
> My reasoning for this was because I had issues with the
> openssl_tpm2_engine, and just the whole TPM2 on Linux support as it
> stands now. I was able to get everything working on Debian, but then
> I went to test on real TPM hardware, which happened to be a Fedora
> box.  This was a complete disaster; openssl_tpm2_engine did not
> compile due to (I think) a library versioning issue and build
> warnings. I ignored warnings, and manually built my own version
> ofopenssl libtpms but this just resulted in create_tpm2_key to
> segfault. At this point I just thought it would be more worth my time
> to implement Import() myself.
> 
> I think this was all a result of bad packaging on Fedora's part, but
> still, the experience didn't sit well with me and I felt it would be
> worth while to add support for this in keyctl.

Well there's a list you can report problems to and get help:

openssl-tpm2-engine@groups.io

I've got to confess I develop on openSUSE and debian, so Fedora doesn't
get much testing.

> > It's on my todo list to accept bare primary identifiers as parents
> > in the kernel code and create the EC primary on the fly, but it's
> > not in this patch set.
> > 
> > There's also another policy problem in that generating an RSA2048
> > key can lock the TPM up for ages, so there should likely be some
> > type of block on someone doing this.  I was thinking that an
> > unprivileged user should be allowed to create EC keys but not RSA
> > ones.
> 
> I didn't have any plans for RSA key generation inside the TPM itself,
> just wrapping/asym operations.

Well as long as we're interoperable with create_tpm2_key, the consumer
can generate a TPM resident key outside the kernel if they want and
then simply pass it in.

> > > As it stand now you have to padd a key pair, then do a (new)
> > > pkey_wrap operation on it. This returns a DER with the wrapped
> > > TPM2 key. This required modifying the public_key type, which I
> > > really did not like since it now depends on TPM. Not sure if the
> > > route I went is gonna fly without tweaking, but this is all new
> > > to me :) Again, some guidance for how this should be is needed.
> > 
> > The way it's defined to be done using the ASN.1 secret parameter is
> > simply the way the TPM2 command manual defines duplication with an
> > outer wrapper.  The TPM2 manual even has a coded example in section
> > 4 and the secret is simply a TPM2B_ENCRYPTED_SECRET.
> 
> I actually didn't do any inner/outer encryption when sending the key
> to the TPM (if this isn't what your talking about disregard). I just
> sent the private key over plainly. Maybe bus snooping is a concern,
> but as a first pass I just punted on this.

Well to get TPM2_Import to work with an encrypted secret *is* what the
manuals call outer wrapping, you just used an RSA encrypted secret
instead of an ECDH protected one.  It's the same sequence of operations
as for duplication.

Regards,

James

> > > Before I send these patches I need to get some testing done on
> > > real TPM2 hardware. So far its just been emulation. But these
> > > patches should be coming very soon.
> > 
> > Sure thing, but you may want to look at some of the existing code
> > that this will need to interoperate with.  The most complete is the
> > openssl engine, but there's also the intel version of that and
> > openconnect which all use the same key format:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_eng
> ine.git/
> 
> Yes, as far as wrapping/enc/dec/sign/verify, these all inter-operate
> with openssl_tpm2_engine. I have not tried openconnect or the intel
> tools but I'll check those out to verify.
> 
> Thanks,
> James

