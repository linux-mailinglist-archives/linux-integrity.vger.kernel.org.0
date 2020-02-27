Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3EA17296E
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 21:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgB0U0q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 15:26:46 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52328 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbgB0U0q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 15:26:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 35E768EE181;
        Thu, 27 Feb 2020 12:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582835206;
        bh=KJhb2aBt46LQRY+Zk9XgRVZeXd292dtIMZvrc7nL19o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xadA/kGfQKrzw54ZxEBIAd2CQSK6tlHRgRRo65kKOj5RzqvPyvalpoh0T4alX3K2Q
         cwT5tnV+DIczDqGQrjjSRU8a/lshWjS10bynpCR+IA4WVt1cs7aiN9p2pXUfDgxdww
         qHR5zAKVdBPcwdRPknCNgWOxpcFyg5hwSoE7r6xw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iJH3XlpfdfYm; Thu, 27 Feb 2020 12:26:45 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 529138EE079;
        Thu, 27 Feb 2020 12:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582835205;
        bh=KJhb2aBt46LQRY+Zk9XgRVZeXd292dtIMZvrc7nL19o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IVilGe3okhO7Mq1UWo5dh4FTYKv5DzLdN4TPPxp/cdPKjm5Q57Rr4Ssld+3qRvg/6
         BvoIeMTnueU4Cnt+YJ2HXuyNKaazE81UPozMuohWciWk54ant2zcGKozHXixVumNrO
         ioNRB8SW4svtbzdUl4htfO+wTgaRp6TxVD28HPBA=
Message-ID: <1582835204.18538.21.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Thu, 27 Feb 2020 12:26:44 -0800
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
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-02-27 at 12:19 -0800, James Bottomley wrote:
> On Thu, 2020-02-27 at 09:19 -0800, James Prestwood wrote:
[...]
> > I think this was all a result of bad packaging on Fedora's part,
> > but still, the experience didn't sit well with me and I felt it
> > would be worth while to add support for this in keyctl.
> 
> Well there's a list you can report problems to and get help:
> 
> openssl-tpm2-engine@groups.io
> 
> I've got to confess I develop on openSUSE and debian, so Fedora
> doesn't get much testing.

I should add that even though I don't test on fedora, the opensuse
build service does in my TPM build environment:

https://build.opensuse.org/package/show/home:jejb1:TPM/openssl_tpm2_engine

It says the builds for Fedora 26, 29 and Rawhide all succeeded.  The
build service does both building and testing with the swtpm, so the
engine on fedora gets a pretty extensive workout.

James

