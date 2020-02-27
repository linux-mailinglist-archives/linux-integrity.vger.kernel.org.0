Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24602170CE7
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 01:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgB0ACS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 19:02:18 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59630 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727974AbgB0ACS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 19:02:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CB4BE8EE182;
        Wed, 26 Feb 2020 16:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582761737;
        bh=TQ1e9SIyfMmS0UrMKDlw7s2ayCtwksvDJfQJeyINwfM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nK+zuuE/jg97CJJCuGzXWwS6vZ2QtsRQoir81JfnrF50tU1u1a1wI9lKKQN4Cu0yg
         VnPpgeBHWGT8KgLfHa4Qva/kbZvU+5OLRHigcVhcrrME3vNzfg7YGs+3pd2fzLPJ1E
         leayAwUJo3OYGwL3gp/QwimDDtd6mRoCcmzAL4jo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z-_FMgbZsd_U; Wed, 26 Feb 2020 16:02:17 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1D36F8EE0D2;
        Wed, 26 Feb 2020 16:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582761737;
        bh=TQ1e9SIyfMmS0UrMKDlw7s2ayCtwksvDJfQJeyINwfM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nK+zuuE/jg97CJJCuGzXWwS6vZ2QtsRQoir81JfnrF50tU1u1a1wI9lKKQN4Cu0yg
         VnPpgeBHWGT8KgLfHa4Qva/kbZvU+5OLRHigcVhcrrME3vNzfg7YGs+3pd2fzLPJ1E
         leayAwUJo3OYGwL3gp/QwimDDtd6mRoCcmzAL4jo=
Message-ID: <1582761736.4245.12.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Wed, 26 Feb 2020 16:02:16 -0800
In-Reply-To: <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-02-03 at 08:54 -0800, James Prestwood wrote:
> Hi James,
> 
> <snip>
> 
> > diff --git a/security/keys/trusted-keys/tpm2key.asn1
> > b/security/keys/trusted-keys/tpm2key.asn1
> > new file mode 100644
> > index 000000000000..f930fd812db3
> > --- /dev/null
> > +++ b/security/keys/trusted-keys/tpm2key.asn1
> > @@ -0,0 +1,23 @@
> > +---
> > +--- Note: This isn't quite the definition in the standard
> > +---       However, the Linux asn.1 parser doesn't understand
> > +---       [2] EXPLICIT SEQUENCE OF OPTIONAL
> > +---       So there's an extra intermediate TPMPolicySequence
> > +---       definition to work around this
> > +
> > +TPMKey ::= SEQUENCE {
> > +	type		OBJECT IDENTIFIER ({tpmkey_type}),
> > +	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> > +	policy		[1] EXPLICIT TPMPolicySequence
> > OPTIONAL,
> > +	secret		[2] EXPLICIT OCTET STRING OPTIONAL,
> > +	parent		INTEGER ({tpmkey_parent}),
> > +	pubkey		OCTET STRING ({tpmkey_pub}),
> > +	privkey		OCTET STRING ({tpmkey_priv})
> > +	}
> > +
> > +TPMPolicySequence ::= SEQUENCE OF TPMPolicy
> > +
> > +TPMPolicy ::= SEQUENCE {
> > +	commandCode		[0] EXPLICIT INTEGER
> > ({tpmkey_code}),
> > +	commandPolicy		[1] EXPLICIT OCTET STRING
> > ({tpmkey_policy})
> > +	}
> 
> I have been using your set of patches in order to get this ASN.1
> parser/definition. I am implementing an asymmetric key parser/type
> TPM2
> keys for enc/dec/sign/verify using keyctl. Note that this
> implementation goes in crypto/asymmetric_keys/, and your patches sit
> in
> security/keys/trusted-keys/.
> 
> Currently I am just including "../../security/keys/trusted-
> keys/{tpm2key.asn1.h,tpm2-policy.h}" in order to use the ASN.1 parser
> to verify my keys, but this obviously isn't going to fly.
> 
> Do you (or anyone) have any ideas as to how both trusted keys and
> asymmetric keys could share this ASN.1 parser/definition? Some common
> area that both security and crypto could include? Or maybe there is
> some common way the kernel does things like this?

Actually TPM2 asymmetric keys was also on my list.  I was going to use
the existing template and simply move it somewhere everyone could use. 
I also think you need the policy parser pieces because at least one
implementation we'd need to be compatible with supports key policy.

Regards,

James

