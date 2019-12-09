Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C321174C6
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 19:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfLISo6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 13:44:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLISo5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 13:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-ID:From:CC:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E2cbyOaPf5v2lfjaYg4al6oOWc/CvzCodRE7lOrKfM0=; b=nxzKeqrrKfNvGN72Rbhl0D60nX
        YhLNOgMJMmShtw8YPr0ercNowNMopUj5fJvsV/uLRmiL2wQeYOk7ky3HOgGTKYXLhKdWqN6bKFg8B
        tXTj9zK6T+m5qhDwczjoZkCFM3Tbp193kWpcAGAOsUGJZzEwRpDO0knb+rQKv+HjIxkKY0dZwyCv5
        EaUJp4JKHUN/DU5HbvkgA0/+uSBSweguZW0sKJGeKGQK7NJNliWYmdfMfAQ6tC2RiRk8T9kKj+Glc
        9HBOZ57abJVdKc7qUu+hhdijYJKUYta8PlctQ2/xX5nu376NEY0J9aRecc4kQZXUJR8mYq1KtbWV+
        zYEJHksQ==;
Received: from host109-153-123-236.range109-153.btcentralplus.com ([109.153.123.236] helo=android-dhcp-10-7c-d9-5c-b5-83-5a-2.home)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieO1h-0004lC-5h; Mon, 09 Dec 2019 18:44:57 +0000
Date:   Mon, 09 Dec 2019 18:44:49 +0000
User-Agent: K-9 Mail for Android
In-Reply-To: <1575914591.31378.11.camel@HansenPartnership.com>
References: <1575781600.14069.8.camel@HansenPartnership.com> <1575781957.14069.16.camel@HansenPartnership.com> <c2de442430dc0e6cd8e66af8479f6cc382545ac5.camel@infradead.org> <1575914591.31378.11.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6/8] security: keys: trusted: add PCR policy to TPM2 keys
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
From:   David Woodhouse <dwmw2@infradead.org>
Message-ID: <59E96950-5803-4231-88B2-33278357F934@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9 December 2019 18:03:11 GMT, James Bottomley <James=2EBottomley@Hansen=
Partnership=2Ecom> wrote:
>On Mon, 2019-12-09 at 10:18 +0000, David Woodhouse wrote:
>> On Sat, 2019-12-07 at 21:12 -0800, James Bottomley wrote:
>> > This commit adds the ability to specify a PCR lock policy to TPM2
>> > keys=2E  There is a complexity in that the creator of the key must
>> > chose either to use a PCR lock policy or to use authentication=2E  At
>> > the current time they can't use both due to a complexity with the
>> > way authentication works when policy registers are in use=2E  The way
>> > to construct a pcrinfo statement for a key is simply to use the
>> > TPMS_PCR_SELECT structure to specify the PCRs and follow this by a
>> > hash of all their values in order of ascending PCR number=2E
>> >=20
>> > For simplicity, we require the policy name hash and the hash used
>> > for the PCRs to be the same=2E  Thus to construct a policy around the
>> > value of the resettable PCR 16 using the sha1 bank, first reset the
>> > pcr to zero giving a hash of all zeros as:
>> >=20
>> > 6768033e216468247bd031a0a2d9876d79818f8f
>> >=20
>> > Then the TPMS_PCR_SELECT value for PCR 16 is
>> >=20
>> > 03000001
>> >=20
>> > So create a new 32 byte key with a policy policy locking the key to
>> > this value of PCR 16 with a parent key of 81000001 would be:
>> >=20
>> > keyctl new 32 keyhandle=3D0x81000001 hash=3Dsha1
>> > pcrinfo=3D030000016768033e216468247bd031a0a2d9876d79818f8f" @u
>>=20
>> OK=2E=2E=2E but I've love to see a more formal definition of this binar=
y
>> format, as part of the "standard" we allegedly have for the overall
>> ASN=2E1 representation=2E
>
>It's actually defined in the TPM2 command manual =2E=2E=2E it's basically=
 the
>policy commands you send to the TPM ordered so they can be directly
>hashed=2E
>
>However, I agree a standards definition would be good=2E  This format
>doesn't support TPM2_PolicyOr directly (and the command manual is
>silent on how it should be supported), so that's going to have to be
>defined in the standard anyway=2E
>
>[=2E=2E=2E]
>> > +int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32
>> > *len)
>> > +{
>> > +	u8 *buf =3D kmalloc(2 * PAGE_SIZE, GFP_KERNEL);
>> > +	u8 *work =3D buf + PAGE_SIZE, *ptr;
>> > +	int i;
>> > +
>> > +	if (!buf)
>> > +		return -ENOMEM;
>> > +
>> > +	for (i =3D 0; i < pols->count; i++) {
>> > +		u8 *seq_len, *tag_len;
>> > +		u32 cmd =3D pols->code[i];
>> > +		int l;
>> > +
>> > +		/*
>> > +		 * cheat a bit here: we know a policy is < 128
>> > bytes,
>> > +		 * so the sequence and cons tags will only be two
>> > +		 * bytes long
>> > +		 */
>> > +		*work++ =3D _tag(UNIV, CONS, SEQ);
>> > +		seq_len =3D work++;
>> > +		*work++ =3D _tagn(CONT, CONS, 0);
>> > +		tag_len =3D work++;
>> > +		asn1_encode_integer(&work, cmd);
>> > +		*tag_len =3D work - tag_len - 1;
>> > +		*work++ =3D _tagn(CONT, CONS, 1);
>> > +		tag_len =3D work++;
>> > +		asn1_encode_octet_string(&work, pols->policies[i],
>> > +					 pols->len[i]);
>> > +		*tag_len =3D work - tag_len - 1;
>> > +		l =3D work - seq_len - 1;
>> > +		/* our assumption about policy length failed */
>> > +		if (WARN(l > 127,
>> > +			 "policy is too long: %d but must be <
>> > 128", l)) {
>> > +			kfree(buf);
>> > +			return -EINVAL;
>> > +		}
>> > +		*seq_len =3D l;
>>=20
>>=20
>>=20
>> You're not even using your own sequence encoding here, because it
>> only works when you know the length in advance=2E How about setting
>> *seq_len to 0x80 to start with, for an indeterminate length=2E
>
>I already did that in the asn=2E1 patch, so I've updated this one to use
>it=2E
>
>> Then in the happy case where it is <128, just go back and fill it in
>> as you currently do=2E Otherwise append 0x00 0x00 as the end marker=2E
>
>That doesn't work =2E=2E=2E the format of these octet strings is likely t=
o
>have two zeros together, so they *have* to be definite length encoded=2E

The octet-strings sure, but we know the length of those=2E It was the sequ=
ence you have that <127 check and bail out for=2E=2E=2E wasn't it?

>> None of this has to be DER, does it?
>
>None of what?  The policy?  the DER format is already in use so we
>can't change it=2E

What we *output* doesn't need to be DER (mandatory definite length) and ca=
n be BER though, right?

>> <Insert more whining about PAGE_SIZE assumptions and buffer
>> overflows>
>
>OK, OK, I fixed that too=2E
>
>James

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
