Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69780131D01
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2020 02:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgAGBIt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 20:08:49 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60252 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727250AbgAGBIs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 20:08:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 072E08EE105;
        Mon,  6 Jan 2020 17:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578359328;
        bh=MiKKb9bAy7cd3KYj/M73vCh/7WUSkhqCE3VFtr3iQeI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HShLqpD8+hq1MqRfTlErNn86OwtrX2osAfWzNxTksrOO+hJFk4MonR7tT0PvelYTq
         fG+fokyZDUiN5vpuHLBFtSl/ldIJuI0Xyu96qsW/kMQGky+KLKuLty/+W4RtrI0G8c
         zrboOhLbFoWd++ZJYnsmO0d2d2PZn07bswK4P3sQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NF9yxz_fIrbg; Mon,  6 Jan 2020 17:08:39 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 05CD88EE0FC;
        Mon,  6 Jan 2020 17:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578359316;
        bh=MiKKb9bAy7cd3KYj/M73vCh/7WUSkhqCE3VFtr3iQeI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FaVb3PKeE/uI3qy2CFwnkaQSs8SwgVqpIopkKCl4gl/R7RbDQjlOR5AeB8MAeSHtJ
         3l6U3sMdz4wzaOcMG6Gq/fpY9JUb4k4dO/kCYtcWbfE2Uu7NRHDhb7WT8+AUDsu3+z
         lyu2puf46uiWqsp8U7n5T0E5jcRhwE+ql01Lkxgs=
Message-ID: <1578359313.3251.28.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 3/9] security: keys: trusted fix tpm2 authorizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Mon, 06 Jan 2020 17:08:33 -0800
In-Reply-To: <c03eb4a8aa3627f58bc45bbc23a4dcd660dc6e2f.camel@linux.intel.com>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
         <20191230173802.8731-4-James.Bottomley@HansenPartnership.com>
         <c03eb4a8aa3627f58bc45bbc23a4dcd660dc6e2f.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-06 at 23:45 +0200, Jarkko Sakkinen wrote:
> On Mon, 2019-12-30 at 09:37 -0800, James Bottomley wrote:
> > In TPM 1.2 an authorization was a 20 byte number.  The spec
> > actually
> > recommended you to hash variable length passwords and use the sha1
> > hash as the authorization.  Because the spec doesn't require this
> > hashing, the current authorization for trusted keys is a 40 digit
> > hex number.  For TPM 2.0 the spec allows the passing in of variable
> > length passwords and passphrases directly, so we should allow that
> > in trusted keys for ease of use.  Update the 'blobauth' parameter
> > to take this into account, so we can now use plain text passwords
> > for the keys.
> > 
> > so before
> > 
> > keyctl add trusted kmk "new 32
> > blobauth=f572d396fae9206628714fb2ce00f72e94f2258f"
> > 
> > after:
> > 
> > keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"
> > 
> > Note this is both and enhancement and a potential bug fix.  The TPM
> > 2.0 spec requires us to strip leading zeros, meaning empyty
> > authorization is a zero length HMAC whereas we're currently passing
> > in 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but
> > the Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this
> > patch makes the Microsoft TPM emulator work with trusted keys.
> 
> Even if for good reasons, you should be explicit when you make an API
> change that is not backwards compatible.

This change should be backwards compatible.  I've got a set of TPMs,
one of which works both before and after and another which doesn't work
before but does after, so all it does is increase the set of TPMs that
work with the authorizations i.e. if the TPM worked before, it
continues to work after.

I think what happens in the TPMs that work before is that they
explicily remove trailing zeros and ones that don't work before don't. 

Actually, the before form (20 hex bytes) still works in the after case
... I'll make that clear in the commit message.

James

