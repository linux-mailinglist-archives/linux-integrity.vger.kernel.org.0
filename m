Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636763EC2B0
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Aug 2021 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbhHNMsY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 14 Aug 2021 08:48:24 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:50244 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhHNMsY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Aug 2021 08:48:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EAA90128067B;
        Sat, 14 Aug 2021 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1628945275;
        bh=cgxV7bbPSYfAgzY/AlYMwaADsA0E6EehSBVR1UqWY54=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=kYYINPBsn2p5SInQ7cRu3c5BSttcJyasn4XJ6onLp7ytPLo0g7pmZW3gCt5pufpYl
         NJwjQ+56IFvUS9vCY/2zILEyhTfrSlegyHPVAG5R/wSTudZWKKAHbHY/nnZ9vxERKQ
         vY7545Od8uVe3mSMoU874VMPvmTRjKRPk9/tymCE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BO_pKxiRKFGy; Sat, 14 Aug 2021 05:47:55 -0700 (PDT)
Received: from [172.20.3.52] (unknown [216.54.114.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 31E0E1280658;
        Sat, 14 Aug 2021 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1628945275;
        bh=cgxV7bbPSYfAgzY/AlYMwaADsA0E6EehSBVR1UqWY54=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=kYYINPBsn2p5SInQ7cRu3c5BSttcJyasn4XJ6onLp7ytPLo0g7pmZW3gCt5pufpYl
         NJwjQ+56IFvUS9vCY/2zILEyhTfrSlegyHPVAG5R/wSTudZWKKAHbHY/nnZ9vxERKQ
         vY7545Od8uVe3mSMoU874VMPvmTRjKRPk9/tymCE=
Message-ID: <b86ec24317e4a07901ee5d981d9bcf580c8fd2eb.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/1] ima: check control characters in policy path
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tianxing Zhang <anakinzhang96@gmail.com>, zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 14 Aug 2021 08:47:53 -0400
In-Reply-To: <20210814081356.293-1-anakinzhang96@gmail.com>
References: <20210814081356.293-1-anakinzhang96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-08-14 at 16:13 +0800, Tianxing Zhang wrote:
> Hi,
> 
> IMA policy can be updated with /sys/kernel/security/ima/policy
> interface when CONFIG_IMA_WRITE_POLICY is set. However, kernel does
> not check the file path carefully. It only checks if the path has '/'
> prefix.
> 
> When a policy file path contains control characters like '\r' or
> '\b', invalid error messages can be printed to overwrite system
> messages.

This doesn't sound like a good idea: filesystems accept control
characters in names, so the IMA file policy has to be able to specify
them.  We can debate whether filesystems should do this, but while they
do IMA has to as well.

> For example:
> 
> $ echo -e "/\rtest invalid path: ddddddddddddddddddddd" >
> /sys/kernel/security/ima/policy
> $ dmesg
> test invalid path: ddddddddddddddddddddd (-2) 
> 
> After adding this patch, we'll be able to throw out error message:
> 
> $ echo -e "/\rtest invalid path: ddddddddddddddddddddd" >
> /sys/kernel/security/ima/policy
> -bash: echo: write error: Invalid argument
> $ dmesg
> [   11.684004] ima: invalid path (control characters are not allowed)
> [   11.684071] ima: policy update failed
> 
> Any suggestions would be appreciated, thank you.

I don't quite understand what you think the problem is.  Only root can
write IMA policies so no-one other than a legitimate administrator can
use bogus paths like the above.  If the problem is producing a bogus
log message, we do have several IMA messages that print out
measured/appraised file names ... they would be vulnerable to this
since a generic user could have created them with control character
containg file names, and your proposed patch wouldn't fix that.

Wouldn't a better solution be to have a file name print that expands
the unprintable characters?

James


