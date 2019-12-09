Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE8117997
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 23:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLIWnc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 17:43:32 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36022 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726207AbfLIWnb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 17:43:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 011AB8EE112;
        Mon,  9 Dec 2019 14:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575931411;
        bh=tI86EOiTxTwFYLwOcFaF7VRk0cDONI7QpU9xwxLbrkQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ejhSM5hAFH8j6FZfjva+MYz3GZoo5Z4BOZMxXPsidcA+60gCdws0p43YVkZjI5LgK
         z5TA4lqDK+syZjAEe4+XfZ/zwdtqG0Cgi4p9OH34U7TTabb3QDtFWTYvZWp2EPJ1OR
         9h3DL/3pG3BFsBedaFhecLD10Y14cy5snfbUS+gc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5Ng0Oy8grPlk; Mon,  9 Dec 2019 14:43:30 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C5D128EE0FC;
        Mon,  9 Dec 2019 14:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575931410;
        bh=tI86EOiTxTwFYLwOcFaF7VRk0cDONI7QpU9xwxLbrkQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pEXx5gL44K2Bx2aPlI/vvIOGIj0YQcdNR/xFnt0CFkzMe+Canmi/dIVJWj0Vxfv/R
         2hTSmtMX9xvxJI2ZYGl4V+08rI0RklrnjwWBG6VC4BDYyJaZHs1KEM3mPHyJhzUWzZ
         AMRAWx1TSq7LWVgLzO/wn1D8Sqf3hlQVewp+UdRs=
Message-ID: <1575931408.31378.37.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/8] lib: add asn.1 encoder
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Dec 2019 14:43:28 -0800
In-Reply-To: <CACdnJuuFoOd-fCCFRWHF6b59YJpA2XPwKw35TH-PWUDUO96vTw@mail.gmail.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781706.14069.10.camel@HansenPartnership.com>
         <CACdnJuuFoOd-fCCFRWHF6b59YJpA2XPwKw35TH-PWUDUO96vTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-09 at 14:05 -0800, Matthew Garrett wrote:
> On Sat, Dec 7, 2019 at 9:08 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > We have a need in the TPM trusted keys to return the ASN.1 form of
> > the TPM key blob so it can be operated on by tools outside of the
> > kernel. To do that, we have to be able to read and write the key
> > format.  The current ASN.1 decoder does fine for reading, but we
> > need pieces of an ASN.1 encoder to return the key blob.
> 
> Is there a reason the kernel needs to do this encoding, rather than
> having something in userland do the translation?

Well, yes, we'd have to define a format to pass up first and then you'd
always need an encoder programme to do it.  Given it's fairly simple to
encode the key format, doing it directly in ASN.1 ... especially as we
already read ASN.1 keys, seems to be the best for the user.

James

