Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3818BFC5
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 19:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCSS7I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 14:59:08 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40748 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgCSS7I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 14:59:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C5B888EE369;
        Thu, 19 Mar 2020 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584644347;
        bh=uJIoh2jx98mn2qGVUnljTbvG6mLwo6Kq7M1zlhK7W78=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SwlHbIg5v998+4QyMTTcjA7b50KVIb1mWwL2Z3qC0eZ3ouzI3tmXWO0zV0mhQH+01
         2LZdx6QbZe38uyJcRjyzG0QdZjZzuIJpCA+Odocb3J/xb+Z+4mFx8ry2C3L95nno2J
         kh2r+tPcDYCyP7KhkB9TrBQ94/lba6Pe/7WPA9IE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6zgk8J_46sTZ; Thu, 19 Mar 2020 11:59:07 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 29E088EE182;
        Thu, 19 Mar 2020 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584644347;
        bh=uJIoh2jx98mn2qGVUnljTbvG6mLwo6Kq7M1zlhK7W78=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SwlHbIg5v998+4QyMTTcjA7b50KVIb1mWwL2Z3qC0eZ3ouzI3tmXWO0zV0mhQH+01
         2LZdx6QbZe38uyJcRjyzG0QdZjZzuIJpCA+Odocb3J/xb+Z+4mFx8ry2C3L95nno2J
         kh2r+tPcDYCyP7KhkB9TrBQ94/lba6Pe/7WPA9IE=
Message-ID: <1584644346.3610.31.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 6/8] security: keys: trusted: add PCR policy to TPM2
 keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:59:06 -0700
In-Reply-To: <3180901.1584637023@warthog.procyon.org.uk>
References: <20200310051607.30334-7-James.Bottomley@HansenPartnership.com>
         <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
         <3180901.1584637023@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-03-19 at 16:57 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > keyctl new 32 keyhandle=0x81000001 hash=sha1
> > pcrinfo=030000016768033e216468247bd
> > 031a0a2d9876d79818f8f" @u
> 
> I think part of this got lost.  There's only one '"' for a start.

Yes, it's a cut and paste error in the change log.  It was cut out of
the additions to Documentation/security/keys/trusted-encrypted.rst and
should read

keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1 pcrinfo=030000016768033e216468247bd031a0a2d9876d79818f8f" @u

James

