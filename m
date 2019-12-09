Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43EA31172AB
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 18:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfLIRXn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 12:23:43 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58660 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfLIRXn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 12:23:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 35E9C8EE112;
        Mon,  9 Dec 2019 09:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575912223;
        bh=WQp0WLZ/TGCXlnEyPRTF8ySlNqgH7JXAnr7SvZGD3Sg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TK9rwkHDiS2Vyv7eq+iKi4QoAaE43DQTLxlg6qA9Fihnja187MOAzl47T1bBq1SjV
         88TIHerKrduUb5e3WsvRq+a6N1x8d2jRCzT0NYCo/CTKBmnk3POM4HPcCQORpv9wL1
         1FoP689CrYxLqlB4YLcFKC2d9S9lvxZvp+wfv/Ic=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oKzuLtJxkd9q; Mon,  9 Dec 2019 09:23:43 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B926E8EE0FC;
        Mon,  9 Dec 2019 09:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575912222;
        bh=WQp0WLZ/TGCXlnEyPRTF8ySlNqgH7JXAnr7SvZGD3Sg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p+ABcW5sdSETPTUc0gO5gzLk4rmGfd9CF3qOXuau6eNGcymcT8RPc82x7Kht1oU7g
         pgIvuBpZPmjq6+NG56J/+U9e7ng8GBVD2E088VVxQIeJdPeb77ND6tfAwG4KAvnonU
         mwZLxwTg3qTGlu8XPlIWVrO2/da6+SP3CW+WwBhE=
Message-ID: <1575912221.31378.2.camel@HansenPartnership.com>
Subject: Re: [PATCH 5/8] security: keys: trusted: Make sealed key properly
 interoperable
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Dec 2019 09:23:41 -0800
In-Reply-To: <6fa42aee37f8207c7dcb037615b87cc02b708ec4.camel@infradead.org>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781888.14069.14.camel@HansenPartnership.com>
         <6fa42aee37f8207c7dcb037615b87cc02b708ec4.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-09 at 10:09 +0000, David Woodhouse wrote:
> On Sat, 2019-12-07 at 21:11 -0800, James Bottomley wrote:
[...]
> > @@ -330,13 +332,16 @@ static int tpm2_load_cmd(struct tpm_chip
> > *chip,
> >  	unsigned int private_len;
> >  	unsigned int public_len;
> >  	unsigned int blob_len;
> > -	u8 *blob;
> > +	u8 *blob, *pub;
> >  	int rc;
> > +	u32 attrs;
> >  
> >  	rc = tpm2_key_decode(payload, options, &blob);
> > -	if (rc)
> > +	if (rc) {
> >  		/* old form */
> >  		blob = payload->blob;
> > +		payload->old_format = 1;
> > +	}
> >  
> >  	/* new format carries keyhandle but old format doesn't */
> >  	if (!options->keyhandle)
> > @@ -347,6 +352,16 @@ static int tpm2_load_cmd(struct tpm_chip
> > *chip,
> >  		return -E2BIG;
> >  
> >  	public_len = be16_to_cpup((__be16 *) &blob[2 +
> > private_len]);
> > +
> > +	pub = blob + 2 + private_len + 2;
> > +	/* key attributes are always at offset 4 */
> > +	attrs = get_unaligned_be32(pub + 4);
> 
> 
> At this point I don't believe you've checked yet that payload-
> >blob_len  is sufficient to know that these bytes exist.

Check added.

> I think you're reading 'private_len' from non-existent bytes too, if
> payload->blob_len is zero or one? Which I think was there before you
> started, but you touched it last...

Well, I started this because of bugs in the current code, so this is
just one more bug I have to fix.

James

