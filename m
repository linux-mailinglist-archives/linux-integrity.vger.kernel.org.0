Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6615CA76
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 19:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBMSfK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 13:35:10 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40277 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgBMSfK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 13:35:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so5138368qto.7
        for <linux-integrity@vger.kernel.org>; Thu, 13 Feb 2020 10:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=n4NsWiWBaX8kX/JR0RNwIK0qrtG2HdB1ZigjQrcyG/o=;
        b=YqRNwkihu+iCtxKRmM2E+hXJEe3w2EX+Dn1sOLnZdfdF5TggvyWSUeHmI2CICkWRIC
         M6cNuJnX8k3BsaZCGzoUdGve1KGZB4qOl9O93ZeXCxMpy2Yz5o7EPYEkxNEL73NxpJhK
         h6vH1lnEV70tQgdhlFfAIca7Df93Ap8oXoF1kWy+OMnd48R3AAfToJGKSujw5bEI3+9v
         ouQfZmL6PCe1DlYLAu07HUGRt5V6Bo7lBLQU746esYhkcn5rR4AVCpdoG/znszPWnvva
         34NOL4TihfcychD+jH7vO44UdFEdpHugr3cwzz6GOem2mqjr/W7F37tRkkPkCFd2xxHO
         3w/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n4NsWiWBaX8kX/JR0RNwIK0qrtG2HdB1ZigjQrcyG/o=;
        b=VLTtxkDYzRZpwk8AHuyOgP2ZcFs5Bo3Qv9vXfwfQvRavku2NuTjF/AnihPiegBuiI8
         JMbo8O9VtvBn7OqaHICxwbB69F4wXWYQDqHGEohNrQzfOA/Y1UljnemSjaS0mihljkbN
         vLv1wVGmY8biKIvsA/L7Zn39Givvikb8fFa191DgXE03Hy+AFe5caMljOiej50x3RlMO
         sIah2uIi6xBGj9hzqQReMImropKUNGH0GQSPwqzhCvnxHIMg0a3u6udkN+FbIbPj+nfR
         65bLXURmti/38vbIwBhlkxKNvcIlWOIvnOayIEX4XEj+jAheGUwK3CPHfUDVGK4wrttv
         pdow==
X-Gm-Message-State: APjAAAX2BUu/eobp86tV07+vL39BAlu8VwTo8+UxCvRyjAlzuNsH9VwI
        Mg3oIU24Kw3AchNGdMo06IfTeA==
X-Google-Smtp-Source: APXvYqxHIAXmLwvDLMLSm21f81+KTXJWcj4Fz1dQf2fBQ+dvCiWIwg6v/WhMhKZS/ijw9wqOBnUMEw==
X-Received: by 2002:aed:3302:: with SMTP id u2mr12611299qtd.156.1581618909821;
        Thu, 13 Feb 2020 10:35:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v80sm1719664qka.15.2020.02.13.10.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 10:35:08 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2JKO-00026F-EB; Thu, 13 Feb 2020 14:35:08 -0400
Date:   Thu, 13 Feb 2020 14:35:08 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        gcwilson@linux.ibm.com
Subject: Re: [PATCH 3/3] tpm: ibmvtpm: Add support for TPM 2
Message-ID: <20200213183508.GL31668@ziepe.ca>
References: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
 <20200204132706.3220416-4-stefanb@linux.vnet.ibm.com>
 <a23872ef-aa23-e6b0-4b69-602d79671d4b@linux.vnet.ibm.com>
 <d805c04b-3680-97d5-8ea7-82409c7ef308@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d805c04b-3680-97d5-8ea7-82409c7ef308@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 13, 2020 at 01:20:12PM -0500, Stefan Berger wrote:

> I don't want side effects for the TPM 1.2 case here, so I am only modifying
> the flag for the case where the new TPM 2 is being used.  Here's the code
> where it shows the effect.

I'm surprised this driver is using AUTO_STARTUP, it was intended for
embedded cases where their is no firmware to boot the TPM.

Chips using AUTO_STARTUP are basically useless for PCRs/etc.

I'd expect somthing called vtpm to have been started and PCRs working
before Linux is started??

Jason
