Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440291801B5
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2020 16:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgCJPXB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Mar 2020 11:23:01 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45520 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgCJPXB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Mar 2020 11:23:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C119D8EE130;
        Tue, 10 Mar 2020 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583853780;
        bh=Qhp/hn6y0+PPWeQltwAXqcBWh81eIwGg4ZOYwHYMCB4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=awaDYWgp39AUrr/psnWbI5d38DagTcQtRLG2JR9LmTfRALw02A5fIksAzWS4ahDFi
         VPA2BczaiZxaCkZmaxl0bF2GmrG2AUok8dsdzHpJYI1qmsA+o/id84ScK9tUM9+xo9
         IWW3uaqOEAfNPYpOppdnVDRszphSQJ/03/kGIv5M=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PoHMto9_6MhV; Tue, 10 Mar 2020 08:23:00 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 10C5C8EE0E2;
        Tue, 10 Mar 2020 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583853780;
        bh=Qhp/hn6y0+PPWeQltwAXqcBWh81eIwGg4ZOYwHYMCB4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=awaDYWgp39AUrr/psnWbI5d38DagTcQtRLG2JR9LmTfRALw02A5fIksAzWS4ahDFi
         VPA2BczaiZxaCkZmaxl0bF2GmrG2AUok8dsdzHpJYI1qmsA+o/id84ScK9tUM9+xo9
         IWW3uaqOEAfNPYpOppdnVDRszphSQJ/03/kGIv5M=
Message-ID: <1583853778.5686.14.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 1/8] lib: add ASN.1 encoder
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Tue, 10 Mar 2020 08:22:58 -0700
In-Reply-To: <20200310050939.29251-2-James.Bottomley@HansenPartnership.com>
References: <20200310050939.29251-1-James.Bottomley@HansenPartnership.com>
         <20200310050939.29251-2-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-03-09 at 22:09 -0700, James Bottomley wrote:
> We have a need in the TPM2 trusted keys to return the ASN.1 form of
> the TPM key blob so it can be operated on by tools outside of the
> kernel.  The specific tools are the openssl_tpm2_engine, openconnect
> and the Intel tpm2-tss-engine.  To do that, we have to be able to
> read and write the same binary key format the tools use.  The current
> ASN.1 decoder does fine for reading, but we need pieces of an ASN.1
> encoder to write the key blob in binary compatible form.
> 
> For backwards compatibility, the trusted key reader code will still
> accept the two TPM2B quantities that it uses today, but the writer
> will only output the ASN.1 form.
> 
> The current implementation only encodes the ASN.1 bits we actually
> need.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com
> >

Sorry, screwed up on tags here (forgot to add reviewed-by:).  I've
resent the entire patch set here:

https://lore.kernel.org/linux-integrity/20200310051607.30334-1-James.Bottomley@HansenPartnership.com/

James

