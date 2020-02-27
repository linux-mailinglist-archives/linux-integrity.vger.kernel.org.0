Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A6B1729B1
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 21:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgB0UtZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 15:49:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32923 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0UtZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 15:49:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so309734pgk.0;
        Thu, 27 Feb 2020 12:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iE+0HSEqw566ptrftTKET2CN2Q2Su4g3nio6NsXBTe0=;
        b=TEEIUEQcpRHLkKtqdB6Vi2wq0dyly4Ry5ExVyFrProz/78szjB2mQPWSvkclmIzHGf
         CfVbdUyuvL25wvMpqq8JDT+kjAhuWMhr1O8zMXTLXlE3xzYQkPlMvo7N8jp6Y1RVvoql
         Ndvwu2MTO5U7NjucyMn0uB2k6/7A0XoLP+rD4oPyKA9nsm3MCnhKdrRmrE2UHGWQ76hJ
         lbTllQvDE2hhv2m3es/qlWX1FTKst3FKarmnm27DIlAzgR0s/LutcQwCIVlk9Ep5f4Fd
         aedaazf1bDjk/77nlLnNcFSsClo2oJhOEzyMlwh/YxmFmtAz8rvVfMBE0pzDjv4KuKzV
         bCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iE+0HSEqw566ptrftTKET2CN2Q2Su4g3nio6NsXBTe0=;
        b=et1ER87o7AxKOVAXoF5XVAfXPOt/1vXA2yd0tdkwKqKyLq8ofwidhYx2vl5oDvBi1q
         /ugfz2wHRZgqbAwVWNbtnvHQrZtPqWUzFXRrd10Reh6BpSZk6eSa9ds4RKDFBV3QVTBb
         xTGFIFOganideAgEY/52BccUhgj8P/GOPIAju3/OVCj8B9q1YVxoE6t6jRJ5uhBeeFa/
         Zg6Bpz7A72LToJTuERJGhlODk1BIttQwfv87fYToLLpJyZ78ZT0UCRNoINvMzG4bdNZ4
         dmpg483aWnSjxEzhlCzWOClINBTPNPmaNePlrTr57X/x1Pu5VNvsD5yAVhGVBVmccqts
         atQA==
X-Gm-Message-State: APjAAAWj/NIosl00OmRCLukisy4rsrMfbjkJHBv6+TxBII1ZFeJiwkvP
        xL2Znt20oTXa/gjnzhYzpwzKPELEAqJQPA==
X-Google-Smtp-Source: APXvYqzo1vW4ASGrpvYXNg3TiDL1ANJXugiEemGowi1L1Bn6nLrG39aygbWWAi822mJPiU8s4ALHAA==
X-Received: by 2002:a63:e044:: with SMTP id n4mr1108211pgj.338.1582836564261;
        Thu, 27 Feb 2020 12:49:24 -0800 (PST)
Received: from jprestwo-test.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.googlemail.com with ESMTPSA id n9sm4159107pfq.160.2020.02.27.12.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 12:49:23 -0800 (PST)
Message-ID: <57227f6880c2f33352d8f2228b16413dcf395128.camel@gmail.com>
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Prestwood <prestwoj@gmail.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Thu, 27 Feb 2020 12:44:53 -0800
In-Reply-To: <1582835204.18538.21.camel@HansenPartnership.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
         <1582761736.4245.12.camel@HansenPartnership.com>
         <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
         <1582764844.4245.29.camel@HansenPartnership.com>
         <17e025e222cb6aefb5680d6cdad64a9ecf76fa97.camel@gmail.com>
         <1582834760.18538.15.camel@HansenPartnership.com>
         <1582835204.18538.21.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-02-27 at 12:26 -0800, James Bottomley wrote:
> On Thu, 2020-02-27 at 12:19 -0800, James Bottomley wrote:
> > On Thu, 2020-02-27 at 09:19 -0800, James Prestwood wrote:
> 
> [...]
> > > I think this was all a result of bad packaging on Fedora's part,
> > > but still, the experience didn't sit well with me and I felt it
> > > would be worth while to add support for this in keyctl.
> > 
> > Well there's a list you can report problems to and get help:
> > 
> > openssl-tpm2-engine@groups.io
> > 
> > I've got to confess I develop on openSUSE and debian, so Fedora
> > doesn't get much testing.
> 
> I should add that even though I don't test on fedora, the opensuse
> build service does in my TPM build environment:
> 
> 
https://build.opensuse.org/package/show/home:jejb1:TPM/openssl_tpm2_engine
> 
> It says the builds for Fedora 26, 29 and Rawhide all succeeded.  The
> build service does both building and testing with the swtpm, so the
> engine on fedora gets a pretty extensive workout.

Hmm, ok I will be trying this again then. Thanks.
> 
> James
> 

