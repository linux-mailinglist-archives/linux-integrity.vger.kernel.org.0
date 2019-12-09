Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F0117907
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 23:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIWFu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 17:05:50 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41996 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIWFu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 17:05:50 -0500
Received: by mail-il1-f194.google.com with SMTP id f6so14199118ilh.9
        for <linux-integrity@vger.kernel.org>; Mon, 09 Dec 2019 14:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4d99rdcJEhnL7/cP2RgimdrOj1crcG/Foc9CU8wtD1k=;
        b=PGwobsNFczZWRZkynfWmhal2g/jndE4tCw6mJdgmLcQKNzP4Vj1y736OI9YQ5DWQCW
         N2xYe6pqgd3Cs8O0kWBxFZtecrav2+PA0qPazha50hrz9GShIDhla070dfpkd4ZKt6HA
         D7adeonhzaVpt3zt173dB5hlFZszdV7PC8TvmEOpovra7jWmRHhK74uqHW3wLIlFYtXa
         ZMPxJbWo8ncaN3YQY2UDX9MoD5oVhL0zmrw9FDePAMyGgvOC9XUkcFTvwsHgn5dgooRh
         SzvYoWqvjw2TG9nfWTTtR7sEzydaEBGoN2IMHQx22B9gd3mM9FtlzUmj2OQqbdRk92gi
         VbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4d99rdcJEhnL7/cP2RgimdrOj1crcG/Foc9CU8wtD1k=;
        b=nEc1TGOmSR2GWL/zA9l53c8Vk2aDcj8x3OspCXg6Ck7skaMilGJjrA63/WJq9s2bny
         gjGvTxQAKUvE2ecnZiD6F8Q3huZ9ZqL1h+rf1RS2vsL59SiIVeR1qmf68wTl//xcN52w
         ycRZDuNCAf9UIX/dBcfF9MfPXdxxZ7I0Sa3o6o6mCLCPxX3rvj1dnHLrucunMn1HLN6B
         pcdq+s9cNflnW36M5LJ1VIDKDyi536zD9wFeUH44L8bF3GMdMUUGNHmWvtZ+DGIh/bDd
         z2OliwWu8ktTrcktZtJcHVxfRmzZc+6g/s6951hUEnokm2Bva74h3Dg+fukmEO5aitsF
         PTBw==
X-Gm-Message-State: APjAAAVfErWmPFACDI9X1h3tXuVeWJx+YdigLVrWKmo2xiNWmhnub5Xb
        Af5RrnJzuQRcPgTd7DYgSJeLvQdgpRqKt8VUzWTIhg==
X-Google-Smtp-Source: APXvYqzynpgzuJtjmR+PATuERJavTs4fetrBQ6lBBZPrhtQ4InueqxV+aBBpY3WxYO48Deo0d9hscE5iMooDcdsA1Y0=
X-Received: by 2002:a92:d609:: with SMTP id w9mr32023842ilm.46.1575929149269;
 Mon, 09 Dec 2019 14:05:49 -0800 (PST)
MIME-Version: 1.0
References: <1575781600.14069.8.camel@HansenPartnership.com> <1575781706.14069.10.camel@HansenPartnership.com>
In-Reply-To: <1575781706.14069.10.camel@HansenPartnership.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 9 Dec 2019 14:05:38 -0800
Message-ID: <CACdnJuuFoOd-fCCFRWHF6b59YJpA2XPwKw35TH-PWUDUO96vTw@mail.gmail.com>
Subject: Re: [PATCH 2/8] lib: add asn.1 encoder
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Dec 7, 2019 at 9:08 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> We have a need in the TPM trusted keys to return the ASN.1 form of the
> TPM key blob so it can be operated on by tools outside of the kernel.
> To do that, we have to be able to read and write the key format.  The
> current ASN.1 decoder does fine for reading, but we need pieces of an
> ASN.1 encoder to return the key blob.

Is there a reason the kernel needs to do this encoding, rather than
having something in userland do the translation?
