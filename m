Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2E711753D
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 20:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLITLi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 14:11:38 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60494 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbfLITLi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 14:11:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0146D8EE18E;
        Mon,  9 Dec 2019 11:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575918698;
        bh=SeDIzjtoGpLlj036iuJgTTwNKpk3GNf/1SPZkuBFIUk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OHyJD2bNs2LYIvwKDZ+VZaFX3SC1inDv++GzVXfvYK1/WTnLlbxzFcTiOQjRJ0TYp
         lHvyqBCcCOp9BM7OtBa6H0013y4Lv/FqEuQ6JvGFBcW6ZU296Iy5WOEYEkadVr4CSt
         xACpdoCpL/Vbq/DeyQ/cREraVv4QhNRma3Vc40zk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kd7VfqiUd6OY; Mon,  9 Dec 2019 11:11:37 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 68D5C8EE0FC;
        Mon,  9 Dec 2019 11:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575918697;
        bh=SeDIzjtoGpLlj036iuJgTTwNKpk3GNf/1SPZkuBFIUk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ifyUm5fRC/wI8qC0hmkb7gteAjhRbvRhoWQP8oIkk4AP5/ezlGw7n+RPZ6LIru6zn
         3ld1x7W9/drcFxGmb0zLnya2aqM0ldNA9uAWO9XtIVAAdQNilTh6kUuWptKRIzVfJJ
         4VALtmzeetPbsiD7fC8mWZnpDkzSzWBc5Gpyavmc=
Message-ID: <1575918695.31378.18.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/8] security: keys: trusted: add PCR policy to TPM2 keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Dec 2019 11:11:35 -0800
In-Reply-To: <59E96950-5803-4231-88B2-33278357F934@infradead.org>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781957.14069.16.camel@HansenPartnership.com>
         <c2de442430dc0e6cd8e66af8479f6cc382545ac5.camel@infradead.org>
         <1575914591.31378.11.camel@HansenPartnership.com>
         <59E96950-5803-4231-88B2-33278357F934@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-09 at 18:44 +0000, David Woodhouse wrote:
> On 9 December 2019 18:03:11 GMT, James Bottomley
> <James.Bottomley@HansenPartnership> wrote:
[...]
> > > Then in the happy case where it is <128, just go back and fill it
> > > in as you currently do. Otherwise append 0x00 0x00 as the end
> > > marker.
> > 
> > That doesn't work ... the format of these octet strings is likely
> > to have two zeros together, so they *have* to be definite length
> > encoded.
> 
> The octet-strings sure, but we know the length of those. It was the
> sequence you have that <127 check and bail out for... wasn't it?

The interior sequence encloses the octet streams.  In theory the
standard requires any parser to skip over the interior structures
rather than simply chunk down the sequence looking for the two byte
zero, but doing definite length allows us not to have to worry about
buggy parsers in that case.

> > > None of this has to be DER, does it?
> > 
> > None of what?  The policy?  the DER format is already in use so we
> > can't change it.
> 
> What we *output* doesn't need to be DER (mandatory definite length)
> and can be BER though, right?

I'm not sure.  I think the openssl routines that save and load the
structure in userspace do BER but I'd rather stick to DER to be on the
safe side.

Plus, I know of no policy statement that's anywhere near 127 bytes
long, so there's no problem with doing the single byte fixed length
that DER requires.

James

