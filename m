Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA1F117367
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 19:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLISDN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 13:03:13 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59358 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbfLISDN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 13:03:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 05DF68EE112;
        Mon,  9 Dec 2019 10:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575914593;
        bh=08b0Fz5AXds2bGvo8jxx07YYZ9wE7u82lajOhOABa68=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wN8WVE+Qgp9sKgGgS8zs7OYZi1xzGkmyuYZVkwvO8GriVQnSH01iyluE7skbh1W/n
         vSeystdcsbNh6byLzvNYaYYZK1PK4EVyZirXiYm9JSJNo3fpPgrA6S40vM93a9uu7U
         HLxzK8hgLQlRWc96RI1vl6fEV9izRYr+nvGeSCD8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id diF7XbSFuEGi; Mon,  9 Dec 2019 10:03:12 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 79AB38EE0FC;
        Mon,  9 Dec 2019 10:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575914592;
        bh=08b0Fz5AXds2bGvo8jxx07YYZ9wE7u82lajOhOABa68=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IKrsltJAli1GwAAYoAiwooKy+lEa5DbFtjk9Us5ZLT0Y0Dxozf1dBv6Hv712wJn7S
         zYCJrj4ctkhnFJiKPLiUJmS79XFbMJsFDJLEsmNYXGkwXvjwW8IfXqU40fdnbsEfvK
         /EQ0VpEKh4p0UJWb7M5+71cM1GpmoP7eOOpMsX78=
Message-ID: <1575914591.31378.11.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/8] security: keys: trusted: add PCR policy to TPM2 keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Dec 2019 10:03:11 -0800
In-Reply-To: <c2de442430dc0e6cd8e66af8479f6cc382545ac5.camel@infradead.org>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781957.14069.16.camel@HansenPartnership.com>
         <c2de442430dc0e6cd8e66af8479f6cc382545ac5.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-09 at 10:18 +0000, David Woodhouse wrote:
> On Sat, 2019-12-07 at 21:12 -0800, James Bottomley wrote:
> > This commit adds the ability to specify a PCR lock policy to TPM2
> > keys.  There is a complexity in that the creator of the key must
> > chose either to use a PCR lock policy or to use authentication.  At
> > the current time they can't use both due to a complexity with the
> > way authentication works when policy registers are in use.  The way
> > to construct a pcrinfo statement for a key is simply to use the
> > TPMS_PCR_SELECT structure to specify the PCRs and follow this by a
> > hash of all their values in order of ascending PCR number.
> > 
> > For simplicity, we require the policy name hash and the hash used
> > for the PCRs to be the same.  Thus to construct a policy around the
> > value of the resettable PCR 16 using the sha1 bank, first reset the
> > pcr to zero giving a hash of all zeros as:
> > 
> > 6768033e216468247bd031a0a2d9876d79818f8f
> > 
> > Then the TPMS_PCR_SELECT value for PCR 16 is
> > 
> > 03000001
> > 
> > So create a new 32 byte key with a policy policy locking the key to
> > this value of PCR 16 with a parent key of 81000001 would be:
> > 
> > keyctl new 32 keyhandle=0x81000001 hash=sha1
> > pcrinfo=030000016768033e216468247bd031a0a2d9876d79818f8f" @u
> 
> OK... but I've love to see a more formal definition of this binary
> format, as part of the "standard" we allegedly have for the overall
> ASN.1 representation.

It's actually defined in the TPM2 command manual ... it's basically the
policy commands you send to the TPM ordered so they can be directly
hashed.

However, I agree a standards definition would be good.  This format
doesn't support TPM2_PolicyOr directly (and the command manual is
silent on how it should be supported), so that's going to have to be
defined in the standard anyway.

[...]
> > +int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32
> > *len)
> > +{
> > +	u8 *buf = kmalloc(2 * PAGE_SIZE, GFP_KERNEL);
> > +	u8 *work = buf + PAGE_SIZE, *ptr;
> > +	int i;
> > +
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < pols->count; i++) {
> > +		u8 *seq_len, *tag_len;
> > +		u32 cmd = pols->code[i];
> > +		int l;
> > +
> > +		/*
> > +		 * cheat a bit here: we know a policy is < 128
> > bytes,
> > +		 * so the sequence and cons tags will only be two
> > +		 * bytes long
> > +		 */
> > +		*work++ = _tag(UNIV, CONS, SEQ);
> > +		seq_len = work++;
> > +		*work++ = _tagn(CONT, CONS, 0);
> > +		tag_len = work++;
> > +		asn1_encode_integer(&work, cmd);
> > +		*tag_len = work - tag_len - 1;
> > +		*work++ = _tagn(CONT, CONS, 1);
> > +		tag_len = work++;
> > +		asn1_encode_octet_string(&work, pols->policies[i],
> > +					 pols->len[i]);
> > +		*tag_len = work - tag_len - 1;
> > +		l = work - seq_len - 1;
> > +		/* our assumption about policy length failed */
> > +		if (WARN(l > 127,
> > +			 "policy is too long: %d but must be <
> > 128", l)) {
> > +			kfree(buf);
> > +			return -EINVAL;
> > +		}
> > +		*seq_len = l;
> 
> 
> 
> You're not even using your own sequence encoding here, because it
> only works when you know the length in advance. How about setting
> *seq_len to 0x80 to start with, for an indeterminate length.

I already did that in the asn.1 patch, so I've updated this one to use
it.

> Then in the happy case where it is <128, just go back and fill it in
> as you currently do. Otherwise append 0x00 0x00 as the end marker.

That doesn't work ... the format of these octet strings is likely to
have two zeros together, so they *have* to be definite length encoded.

> None of this has to be DER, does it?

None of what?  The policy?  the DER format is already in use so we
can't change it.

> <Insert more whining about PAGE_SIZE assumptions and buffer
> overflows>

OK, OK, I fixed that too.

James

