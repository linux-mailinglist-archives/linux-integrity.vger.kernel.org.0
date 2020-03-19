Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9435718C105
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 21:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCSUHn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 16:07:43 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42102 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbgCSUHn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 16:07:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 725858EE369;
        Thu, 19 Mar 2020 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584648462;
        bh=p8jmiYdXD9AjIqj0FesuNfqQD6CPLnioJoAUguBuuyo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KHeVq8Crf6Ix0DcErMXR2XFh6JPth3kkXKEXJF/pQ38lwOKfpjlb3oN0207r7ZzO/
         fwf97s9pjngNpmqVN3WBQFby5ZsobDkPSj843kkIzRNEB5Wo6laAaygEpDeaREUrZT
         2kw5JemkslsxGNUJ8QEXn806ojM3uwzgPU+pl+xc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lRHufYlt6LSF; Thu, 19 Mar 2020 13:07:41 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1A3698EE182;
        Thu, 19 Mar 2020 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584648460;
        bh=p8jmiYdXD9AjIqj0FesuNfqQD6CPLnioJoAUguBuuyo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p5jXTjblR8fI5jMSRe41JCSofSZrbmzOCl/yq5HmU8gXzD8I6vm4c4MsF3nr8x1RQ
         145V6XHhwTRIH48yriqUdxdu0S9JwIZRBVHmotYnoau8aU+SWTqQ4tBjBhWMyviZHl
         LYENMxjhrFgU6FfsCefMGBfnk8q0mqruJB8zd5H0=
Message-ID: <1584648457.3610.42.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 1/8] lib: add ASN.1 encoder
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Thu, 19 Mar 2020 13:07:37 -0700
In-Reply-To: <3192644.1584645125@warthog.procyon.org.uk>
References: <1584639086.3610.28.camel@HansenPartnership.com>
         <20200310051607.30334-2-James.Bottomley@HansenPartnership.com>
         <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
         <3180269.1584636439@warthog.procyon.org.uk>
         <3192644.1584645125@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-03-19 at 19:12 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > > I wonder if it's worth appending a note to the comment that if
> > > indefinite length encoding is selected, then the result is not
> > > DER-compliant and may not be CER-compliant since you're
> > > advertising BER/DER/CER.
> > 
> > We only encode definite length currently, so the comment is
> > superfluous (and probably confusing if you don't know the
> > difference between DER/BER and CER).  Let's add something like this
> > iff we ever start to use indefinite lengths in the encoder.
> 
> Your code appears to actually do indefinite length encoding if -1 is
> passed as len to asn1_encode_tag().  The kdoc says:
> 
> 	To encode in place pass a NULL @string and -1 for @len; all
> this will do is add an indefinite length tag and update the data
> pointer to the place where the tag contents should be placed.
> 
> Granted, your patches might not use it, but you're making a generic
> ASN.1 encoder library.

That was a thing the other David asked for.  But actually, I think the
comment is a lie:  the first time around we encode a definite length
for the max buffer size and on the recode we do the length for the
actual buffer size, so we never actually place an indefinite length tag
there ... I think David wanted us to, to keep the ASN.1 always legal,
but the max len thing does that too so I must have changed it without
updating the comment, I'll fix that.

James

