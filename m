Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5356D172504
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 18:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgB0RYW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 12:24:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37493 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbgB0RYW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 12:24:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id q4so62999pls.4;
        Thu, 27 Feb 2020 09:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ve6qlx8n2PD18qldHOCvvQzmVGt26kw1krXgvZVa2fA=;
        b=RhtdcVGIp9Lr8sdyljy+TtnRoDkotEK9M9n5K/7aurWpF/DsuCn58K0pdtCc++BANB
         xFfCMWwZblhiX15ykAyE3m0XGaz84oYiJlgLIp+UUW7NIlDOR8Ph38RbNkzv2KPiHoTu
         C+zZbGCILXUaYTlHbHnPDCpfuaqXrlq3wRqQMgSfAXA0KrWKvOS/oQgBlKTjGQg6mmdB
         AtewLVqMQd4DL5CbHPnMqndVareFVVx/KETxtypXGYtoKkcniusieiFmL95BkK5DvYS9
         M+WCvlGF8GVqC6T2eV7Ne/mxCzn4aygjFBIZLLcCEaS2RvDMxCJ3fUOVGUirqpjdoUAL
         9tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ve6qlx8n2PD18qldHOCvvQzmVGt26kw1krXgvZVa2fA=;
        b=mgsvNPLiLR/F2Pw3J3LyaVSbkRiUusIBfwIzge3QiYNxximCyTUaI3BJWIkDTy647m
         BoqWNSQG1LQBEeateyLnlOpgQSJAt6xZah4ghxaXzP3sPz9w+XguH4mU8KXiiHOjcccs
         XqoMlPewjSbuBOCLJB9nA+WfhCdOugWWwdjDTBkCHmZ89f7CxqWwxZNB989GMV3lnIIJ
         dzNTAPWoYCtnZ5MGBfhpVBgT3zLCWXaP1RFGWZdwofD03xWdxhs+ZiZ1IQyZ51/qDh7t
         TkAb9K8t1DaYRuZkNR5X/oO0v+LJklRNYeLP1t7UM1S1KbJ/xJL7D+xN2eQKbYKsp9r8
         nJYw==
X-Gm-Message-State: APjAAAWkkCePlBQkcnV4GhkLFwMrMgD1LK8HX6zPER6f2ZNO1/4mKxRj
        d2+WKvpu+QMXFo9tvEPKiwfIPre6tlU=
X-Google-Smtp-Source: APXvYqxD4FWx33tca2D/Y8lS4VB2ItILQV3VYsuBJ14UrRpGShMaOdukW0cIVqhvsZUrwielv/XN+g==
X-Received: by 2002:a17:90a:d783:: with SMTP id z3mr15761pju.3.1582824259020;
        Thu, 27 Feb 2020 09:24:19 -0800 (PST)
Received: from jprestwo-test.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.googlemail.com with ESMTPSA id d3sm7647681pfn.113.2020.02.27.09.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 09:24:18 -0800 (PST)
Message-ID: <17e025e222cb6aefb5680d6cdad64a9ecf76fa97.camel@gmail.com>
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Prestwood <prestwoj@gmail.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Thu, 27 Feb 2020 09:19:49 -0800
In-Reply-To: <1582764844.4245.29.camel@HansenPartnership.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
         <1582761736.4245.12.camel@HansenPartnership.com>
         <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
         <1582764844.4245.29.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-02-26 at 16:54 -0800, James Bottomley wrote:
> On Wed, 2020-02-26 at 16:20 -0800, James Prestwood wrote:
> > > > I have been using your set of patches in order to get this
> > > > ASN.1
> > > > parser/definition. I am implementing an asymmetric key
> > > > parser/type TPM2 keys for enc/dec/sign/verify using keyctl.
> > > > Note
> > > > that this implementation goes in crypto/asymmetric_keys/, and
> > > > your patches sit in security/keys/trusted-keys/.
> > > > 
> > > > Currently I am just including "../../security/keys/trusted-
> > > > keys/{tpm2key.asn1.h,tpm2-policy.h}" in order to use the ASN.1
> > > > parser to verify my keys, but this obviously isn't going to
> > > > fly.
> > > > 
> > > > Do you (or anyone) have any ideas as to how both trusted keys
> > > > and
> > > > asymmetric keys could share this ASN.1 parser/definition? Some
> > > > common area that both security and crypto could include? Or
> > > > maybe
> > > > there is some common way the kernel does things like this?
> > > 
> > > Actually TPM2 asymmetric keys was also on my list.  I was going
> > > to
> > > use the existing template and simply move it somewhere everyone
> > > could use.  I also think you need the policy parser pieces
> > > because
> > > at least one implementation we'd need to be compatible with
> > > supports key policy.
> > 
> > In terms of policy, I haven't looked into that at all for
> > asymmetric
> > keys. I do already have enc/dec/sign/verify asymmetric key
> > operations
> > all working, and used your ASN1 template for parsing (just copied
> > it
> > into asymmetric_keys for now). Since the asymmetric operations use
> > HMAC sessions I didn't see much carry over from your patches (but
> > this could change if policy stuff gets introduced).
> 
> There's a related patch that introduces HMAC and encryption sessions
> for pretty much everything in the TPM:
> 
> 
https://lore.kernel.org/r/1568031408.6613.29.camel@HansenPartnership.com
> 
> I didn't resend this time around because of patch overload, and
> anyway,
> the last patch needs updating for the current policy c

Well... I sure duplicated a lot of work. I haven't been on these lists
long enough to see that come through. I am still reading through these
patches, but noticed some differences already with how the session is
started. I use the parent key handle for "salt key handle" rather than
the null key. Also I used RSA/OAEP for encrypting the salt value rather
than ECC. I hadn't read into the null key thing, but I will now. I
would be more than happy to rip out the OAEP code though. I was just
modeling everything how libtpms did it, which used OAEP.

Obviously we don't want a bunch of duplicated code, but I am somewhat
concerned about going right in and using these patches as they have
been sitting around quite a while (plus you said they will need
updating). Seems like the best route is get these merged, then
update/send my patches.

> 
> > This will go in the eventual RFC soon but while I have you here:
> > 
> > I also implemented key wrapping. Exposing this as a keyctl API may
> > take some rework, hopefully with some help from others in this
> > subsystem.
> 
> Wrapping for what?  The output privkey in the ASN.1 is wrapped by the
> TPM using its internal AES key.  The ASN.1 also defines ECDH
> wrapping,
> that's what the secret element of the sequence is for, but you'd only
> use that for creating a wrapped key to pass in to the TPM knowing the
> parent.  The way current TPM crypto systems use this is they generate
> an EC parent from the storage primary seed on the NIST P256 curve.

I implemented CC_Import(). You generate the private key yourself
(openssl or however) and import it into the TPM. Then the result of
that is the TPM wrapped key that can be loaded later on. And yes this
depends on knowing the parent handle.

I basically just implemented:

create_tpm2_key -w privkey.pem -p <handle> privkey.tpm

My reasoning for this was because I had issues with the
openssl_tpm2_engine, and just the whole TPM2 on Linux support as it
stands now. I was able to get everything working on Debian, but then I
went to test on real TPM hardware, which happened to be a Fedora box.
This was a complete disaster; openssl_tpm2_engine did not compile due
to (I think) a library versioning issue and build warnings. I ignored
warnings, and manually built my own version of libtpms but this just
resulted in create_tpm2_key to segfault. At this point I just thought
it would be more worth my time to implement Import() myself.

I think this was all a result of bad packaging on Fedora's part, but
still, the experience didn't sit well with me and I felt it would be
worth while to add support for this in keyctl.

> 
> It's on my todo list to accept bare primary identifiers as parents in
> the kernel code and create the EC primary on the fly, but it's not in
> this patch set.
> 
> There's also another policy problem in that generating an RSA2048 key
> can lock the TPM up for ages, so there should likely be some type of
> block on someone doing this.  I was thinking that an unprivileged
> user
> should be allowed to create EC keys but not RSA ones.

I didn't have any plans for RSA key generation inside the TPM itself,
just wrapping/asym operations.

> 
> > As it stand now you have to padd a key pair, then do a (new)
> > pkey_wrap operation on it. This returns a DER with the wrapped TPM2
> > key. This required modifying the public_key type, which I really
> > did
> > not like since it now depends on TPM. Not sure if the route I went
> > is
> > gonna fly without tweaking, but this is all new to me :) Again,
> > some
> > guidance for how this should be is needed.
> 
> The way it's defined to be done using the ASN.1 secret parameter is
> simply the way the TPM2 command manual defines duplication with an
> outer wrapper.  The TPM2 manual even has a coded example in section 4
> and the secret is simply a TPM2B_ENCRYPTED_SECRET.

I actually didn't do any inner/outer encryption when sending the key to
the TPM (if this isn't what your talking about disregard). I just sent
the private key over plainly. Maybe bus snooping is a concern, but as a
first pass I just punted on this.

> 
> > Before I send these patches I need to get some testing done on real
> > TPM2 hardware. So far its just been emulation. But these patches
> > should be coming very soon.
> 
> Sure thing, but you may want to look at some of the existing code
> that
> this will need to interoperate with.  The most complete is the
> openssl
> engine, but there's also the intel version of that and openconnect
> which all use the same key format:
> 
> 
https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

Yes, as far as wrapping/enc/dec/sign/verify, these all inter-operate
with openssl_tpm2_engine. I have not tried openconnect or the intel
tools but I'll check those out to verify.

Thanks,
James

> 
> Regards,
> 
> James
> 

